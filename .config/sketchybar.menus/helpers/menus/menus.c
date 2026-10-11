#include <Carbon/Carbon.h>

void ax_init() {
  const void *keys[] = { kAXTrustedCheckOptionPrompt };
  const void *values[] = { kCFBooleanTrue };

  CFDictionaryRef options;
  options = CFDictionaryCreate(kCFAllocatorDefault,
                               keys,
                               values,
                               sizeof(keys) / sizeof(*keys),
                               &kCFCopyStringDictionaryKeyCallBacks,
                               &kCFTypeDictionaryValueCallBacks     );

  bool trusted = AXIsProcessTrustedWithOptions(options);
  CFRelease(options);
  if (!trusted) exit(1);
}

void ax_perform_click(AXUIElementRef element) {
  if (!element) return;
  AXUIElementPerformAction(element, kAXCancelAction);
  usleep(150000);
  AXUIElementPerformAction(element, kAXPressAction);
}

void ax_perform_press(AXUIElementRef element) {
  if (!element) return;
  AXUIElementPerformAction(element, kAXPressAction);
}

void ax_perform_cancel(AXUIElementRef element) {
  if (!element) return;
  AXUIElementPerformAction(element, kAXCancelAction);
}

CFStringRef ax_get_title(AXUIElementRef element) {
  CFTypeRef title = NULL;
  AXError error = AXUIElementCopyAttributeValue(element,
                                                kAXTitleAttribute,
                                                &title            );

  if (error != kAXErrorSuccess) return NULL;
  return title;
}

bool ax_is_enabled(AXUIElementRef element) {
  CFTypeRef enabled = NULL;
  AXError error = AXUIElementCopyAttributeValue(element,
                                                kAXEnabledAttribute,
                                                &enabled            );
  if (error != kAXErrorSuccess) return true; // assume enabled if we can't check
  bool result = CFBooleanGetValue(enabled);
  CFRelease(enabled);
  return result;
}

void ax_select_menu_option(AXUIElementRef app, int id) {
  AXUIElementRef menubars_ref = NULL;
  CFArrayRef children_ref = NULL;

  AXError error = AXUIElementCopyAttributeValue(app,
                                                kAXMenuBarAttribute,
                                                (CFTypeRef*)&menubars_ref);
  if (error == kAXErrorSuccess) {
    error = AXUIElementCopyAttributeValue(menubars_ref,
                                          kAXVisibleChildrenAttribute,
                                          (CFTypeRef*)&children_ref   );

    if (error == kAXErrorSuccess) {
      uint32_t count = CFArrayGetCount(children_ref);
      if (id < count) {
        AXUIElementRef item = CFArrayGetValueAtIndex(children_ref, id);
        ax_perform_click(item);
      }
      if (children_ref) CFRelease(children_ref);
    }
    if (menubars_ref) CFRelease(menubars_ref);
  }
}

void ax_print_menu_options(AXUIElementRef app) {
  AXUIElementRef menubars_ref = NULL;
  CFTypeRef menubar = NULL;
  CFArrayRef children_ref = NULL;

  AXError error = AXUIElementCopyAttributeValue(app,
                                                kAXMenuBarAttribute,
                                                (CFTypeRef*)&menubars_ref);
  if (error == kAXErrorSuccess) {
    error = AXUIElementCopyAttributeValue(menubars_ref,
                                          kAXVisibleChildrenAttribute,
                                          (CFTypeRef*)&children_ref   );

    if (error == kAXErrorSuccess) {
      uint32_t count = CFArrayGetCount(children_ref);

      for (int i = 1; i < count; i++) {
        AXUIElementRef item = CFArrayGetValueAtIndex(children_ref, i);
        CFTypeRef title = ax_get_title(item);

        if (title) {
          uint32_t buffer_len = 2*CFStringGetLength(title);
          char buffer[2*CFStringGetLength(title)];
          CFStringGetCString(title, buffer, buffer_len, kCFStringEncodingUTF8);
          printf("%s\n", buffer);
          CFRelease(title);
        }
      }
    }
    if (menubars_ref) CFRelease(menubars_ref);
    if (children_ref) CFRelease(children_ref);
  }
}

// Print submenu items for a specific menu
// Output format: one item per line
// Empty line = separator
// [disabled] prefix = disabled item
void ax_print_submenu_options(AXUIElementRef app, int menu_id) {
  AXUIElementRef menubars_ref = NULL;
  CFArrayRef menubar_children = NULL;

  AXError error = AXUIElementCopyAttributeValue(app,
                                                kAXMenuBarAttribute,
                                                (CFTypeRef*)&menubars_ref);
  if (error != kAXErrorSuccess) return;

  error = AXUIElementCopyAttributeValue(menubars_ref,
                                        kAXVisibleChildrenAttribute,
                                        (CFTypeRef*)&menubar_children);
  if (error != kAXErrorSuccess) {
    CFRelease(menubars_ref);
    return;
  }

  uint32_t menubar_count = CFArrayGetCount(menubar_children);
  if (menu_id >= menubar_count) {
    CFRelease(menubar_children);
    CFRelease(menubars_ref);
    return;
  }

  // Get the menu bar item (e.g., "File")
  AXUIElementRef menu_bar_item = CFArrayGetValueAtIndex(menubar_children, menu_id);
  
  // Get the menu (dropdown) from the menu bar item
  CFArrayRef menu_children = NULL;
  error = AXUIElementCopyAttributeValue(menu_bar_item,
                                        kAXChildrenAttribute,
                                        (CFTypeRef*)&menu_children);
  if (error != kAXErrorSuccess || !menu_children || CFArrayGetCount(menu_children) == 0) {
    if (menu_children) CFRelease(menu_children);
    CFRelease(menubar_children);
    CFRelease(menubars_ref);
    return;
  }

  // The first child is the actual menu
  AXUIElementRef menu = CFArrayGetValueAtIndex(menu_children, 0);
  
  // Get the menu items
  CFArrayRef menu_items = NULL;
  error = AXUIElementCopyAttributeValue(menu,
                                        kAXChildrenAttribute,
                                        (CFTypeRef*)&menu_items);
  if (error != kAXErrorSuccess || !menu_items) {
    CFRelease(menu_children);
    CFRelease(menubar_children);
    CFRelease(menubars_ref);
    return;
  }

  uint32_t item_count = CFArrayGetCount(menu_items);
  for (uint32_t i = 0; i < item_count; i++) {
    AXUIElementRef item = CFArrayGetValueAtIndex(menu_items, i);
    CFTypeRef title = ax_get_title(item);
    
    if (title) {
      uint32_t buffer_len = 2 * CFStringGetLength(title) + 1;
      char buffer[buffer_len];
      CFStringGetCString(title, buffer, buffer_len, kCFStringEncodingUTF8);
      
      // Check if it's a separator (empty title or just whitespace)
      if (strlen(buffer) == 0) {
        printf("\n"); // Empty line for separator
      } else {
        bool enabled = ax_is_enabled(item);
        if (!enabled) {
          printf("[disabled]%s\n", buffer);
        } else {
          printf("%s\n", buffer);
        }
      }
      CFRelease(title);
    } else {
      // No title means it's likely a separator
      printf("\n");
    }
  }

  CFRelease(menu_items);
  CFRelease(menu_children);
  CFRelease(menubar_children);
  CFRelease(menubars_ref);
}

// Click a specific submenu item
void ax_click_submenu_item(AXUIElementRef app, int menu_id, int item_id) {
  AXUIElementRef menubars_ref = NULL;
  CFArrayRef menubar_children = NULL;

  AXError error = AXUIElementCopyAttributeValue(app,
                                                kAXMenuBarAttribute,
                                                (CFTypeRef*)&menubars_ref);
  if (error != kAXErrorSuccess) return;

  error = AXUIElementCopyAttributeValue(menubars_ref,
                                        kAXVisibleChildrenAttribute,
                                        (CFTypeRef*)&menubar_children);
  if (error != kAXErrorSuccess) {
    CFRelease(menubars_ref);
    return;
  }

  uint32_t menubar_count = CFArrayGetCount(menubar_children);
  if (menu_id >= menubar_count) {
    CFRelease(menubar_children);
    CFRelease(menubars_ref);
    return;
  }

  // Get the menu bar item and open it
  AXUIElementRef menu_bar_item = CFArrayGetValueAtIndex(menubar_children, menu_id);
  ax_perform_press(menu_bar_item);
  usleep(100000); // Wait for menu to open

  // Get the menu (dropdown) from the menu bar item
  CFArrayRef menu_children = NULL;
  error = AXUIElementCopyAttributeValue(menu_bar_item,
                                        kAXChildrenAttribute,
                                        (CFTypeRef*)&menu_children);
  if (error != kAXErrorSuccess || !menu_children || CFArrayGetCount(menu_children) == 0) {
    ax_perform_cancel(menu_bar_item);
    if (menu_children) CFRelease(menu_children);
    CFRelease(menubar_children);
    CFRelease(menubars_ref);
    return;
  }

  // The first child is the actual menu
  AXUIElementRef menu = CFArrayGetValueAtIndex(menu_children, 0);
  
  // Get the menu items
  CFArrayRef menu_items = NULL;
  error = AXUIElementCopyAttributeValue(menu,
                                        kAXChildrenAttribute,
                                        (CFTypeRef*)&menu_items);
  if (error != kAXErrorSuccess || !menu_items) {
    ax_perform_cancel(menu_bar_item);
    CFRelease(menu_children);
    CFRelease(menubar_children);
    CFRelease(menubars_ref);
    return;
  }

  uint32_t item_count = CFArrayGetCount(menu_items);
  if (item_id < item_count) {
    AXUIElementRef item = CFArrayGetValueAtIndex(menu_items, item_id);
    ax_perform_press(item);
  } else {
    ax_perform_cancel(menu_bar_item);
  }

  CFRelease(menu_items);
  CFRelease(menu_children);
  CFRelease(menubar_children);
  CFRelease(menubars_ref);
}

AXUIElementRef ax_get_extra_menu_item(char* alias) {
  pid_t pid = 0;
  CGRect bounds = CGRectNull;
  CFArrayRef window_list = CGWindowListCopyWindowInfo(kCGWindowListOptionAll,
                                                      kCGNullWindowID        );
  char owner_buffer[256];
  char name_buffer[256];
  char buffer[512];
  int window_count = CFArrayGetCount(window_list);
  for (int i = 0; i < window_count; ++i) {
    CFDictionaryRef dictionary = CFArrayGetValueAtIndex(window_list, i);
    if (!dictionary) continue;

    CFStringRef owner_ref = CFDictionaryGetValue(dictionary,
                                                 kCGWindowOwnerName);

    CFNumberRef owner_pid_ref = CFDictionaryGetValue(dictionary,
                                                     kCGWindowOwnerPID);

    CFStringRef name_ref = CFDictionaryGetValue(dictionary, kCGWindowName);
    CFNumberRef layer_ref = CFDictionaryGetValue(dictionary, kCGWindowLayer);
    CFDictionaryRef bounds_ref = CFDictionaryGetValue(dictionary,
                                                      kCGWindowBounds);

    if (!name_ref || !owner_ref || !owner_pid_ref || !layer_ref || !bounds_ref)
      continue;

    long long int layer = 0;
    CFNumberGetValue(layer_ref, CFNumberGetType(layer_ref), &layer);
    uint64_t owner_pid = 0;
    CFNumberGetValue(owner_pid_ref,
                     CFNumberGetType(owner_pid_ref),
                     &owner_pid                     );

    if (layer != 0x19) continue;
    bounds = CGRectNull;
    if (!CGRectMakeWithDictionaryRepresentation(bounds_ref, &bounds)) continue;
    CFStringGetCString(owner_ref,
                       owner_buffer,
                       sizeof(owner_buffer),
                       kCFStringEncodingUTF8);

    CFStringGetCString(name_ref,
                       name_buffer,
                       sizeof(name_buffer),
                       kCFStringEncodingUTF8);
    snprintf(buffer, sizeof(buffer), "%s,%s", owner_buffer, name_buffer);

    if (strcmp(buffer, alias) == 0) {
      pid = owner_pid;
      break;
    }
  }
  CFRelease(window_list);
  if (!pid) return NULL;

  AXUIElementRef app = AXUIElementCreateApplication(pid);
  if (!app) return NULL;
  AXUIElementRef result = NULL;
  CFTypeRef extras = NULL;
  CFArrayRef children_ref = NULL;
  AXError error = AXUIElementCopyAttributeValue(app,
                                                kAXExtrasMenuBarAttribute,
                                                &extras                   );
  if (error == kAXErrorSuccess) {
    error = AXUIElementCopyAttributeValue(extras,
                                          kAXVisibleChildrenAttribute,
                                          (CFTypeRef*)&children_ref   );

    if (error == kAXErrorSuccess) {
      uint32_t count = CFArrayGetCount(children_ref);
      for (uint32_t i = 0; i < count; i++) {
        AXUIElementRef item = CFArrayGetValueAtIndex(children_ref, i);
        CFTypeRef position_ref = NULL;
        CFTypeRef size_ref = NULL;
        AXUIElementCopyAttributeValue(item, kAXPositionAttribute,
                                            &position_ref        );
        AXUIElementCopyAttributeValue(item, kAXSizeAttribute,
                                            &size_ref        );
        if (!position_ref || !size_ref) continue;

        CGPoint position = CGPointZero;
        AXValueGetValue(position_ref, kAXValueCGPointType, &position);
        CGSize size = CGSizeZero;
        AXValueGetValue(size_ref, kAXValueCGSizeType, &size);
        CFRelease(position_ref);
        CFRelease(size_ref);
        // The offset is exactly 8 on macOS Sonoma...
        // printf("%f %f\n", position.x, bounds.origin.x);
        if (error == kAXErrorSuccess
            && fabs(position.x - bounds.origin.x) <= 10) {
          result = item;
          break;
        }
      }
    }
  }

  CFRelease(app);
  return result;
}

extern int SLSMainConnectionID();
extern void SLSSetMenuBarVisibilityOverrideOnDisplay(int cid, int did, bool enabled);
extern void SLSSetMenuBarVisibilityOverrideOnDisplay(int cid, int did, bool enabled);
extern void SLSSetMenuBarInsetAndAlpha(int cid, double u1, double u2, float alpha);
void ax_select_menu_extra(char* alias) {
  AXUIElementRef item = ax_get_extra_menu_item(alias);
  if (!item) return;
  SLSSetMenuBarInsetAndAlpha(SLSMainConnectionID(), 0, 1, 0.0);
  SLSSetMenuBarVisibilityOverrideOnDisplay(SLSMainConnectionID(), 0, true);
  SLSSetMenuBarInsetAndAlpha(SLSMainConnectionID(), 0, 1, 0.0);
  ax_perform_click(item);
  SLSSetMenuBarVisibilityOverrideOnDisplay(SLSMainConnectionID(), 0, false);
  SLSSetMenuBarInsetAndAlpha(SLSMainConnectionID(), 0, 1, 1.0);
  CFRelease(item);
}

extern void _SLPSGetFrontProcess(ProcessSerialNumber* psn);
extern void SLSGetConnectionIDForPSN(int cid, ProcessSerialNumber* psn, int* cid_out);
extern void SLSConnectionGetPID(int cid, pid_t* pid_out);
AXUIElementRef ax_get_front_app() {
  ProcessSerialNumber psn;
  _SLPSGetFrontProcess(&psn);
  int target_cid;
  SLSGetConnectionIDForPSN(SLSMainConnectionID(), &psn, &target_cid);

  pid_t pid;
  SLSConnectionGetPID(target_cid, &pid);
  return AXUIElementCreateApplication(pid);
}

int main (int argc, char **argv) {
  if (argc == 1) {
    printf("Usage: %s [-l [menu_id] | -s menu_id [item_id] ]\n", argv[0]);
    printf("  -l          List top-level menu names\n");
    printf("  -l <id>     List submenu items for menu at index\n");
    printf("  -s <id>     Click/open menu at index\n");
    printf("  -s <id> <i> Click submenu item i within menu id\n");
    exit(0);
  }
  ax_init();
  
  if (strcmp(argv[1], "-l") == 0) {
    AXUIElementRef app = ax_get_front_app();
    if (!app) return 1;
    
    if (argc == 2) {
      // List top-level menus
      ax_print_menu_options(app);
    } else if (argc == 3) {
      // List submenu items for specific menu
      int menu_id = 0;
      if (sscanf(argv[2], "%d", &menu_id) == 1) {
        ax_print_submenu_options(app, menu_id);
      }
    }
    CFRelease(app);
  } else if (strcmp(argv[1], "-s") == 0 && argc >= 3) {
    int menu_id = 0;
    if (sscanf(argv[2], "%d", &menu_id) == 1) {
      AXUIElementRef app = ax_get_front_app();
      if (!app) return 1;
      
      if (argc == 3) {
        // Click top-level menu
        ax_select_menu_option(app, menu_id);
      } else if (argc == 4) {
        // Click submenu item
        int item_id = 0;
        if (sscanf(argv[3], "%d", &item_id) == 1) {
          ax_click_submenu_item(app, menu_id, item_id);
        }
      }
      CFRelease(app);
    } else {
      // It's an alias for menu extra
      ax_select_menu_extra(argv[2]);
    }
  }
  return 0;
}
