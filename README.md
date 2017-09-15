# PWFNotification
Because of the crash in using of Apple's NSNotification without removing the observer in 'dealloc' function, I develop the `PWFNotification`.There is no need to remove observer for using `PWFNotification`.

### Usage   
Anyone who wants to use `PWFNotification` can use:
    
    pod 'PWFNotification'
    
in your podfile.You can use:
    
    - (void)pwf_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
    
to register to `PWFNotificationCenter`.And also you maybe use:
    
    - (void)pwf_postNotificationName:(NSString *)aName object:(id)object userInfo:(NSDictionary *)aUserInfo;
    
    - (void)pwf_postNotificationName:(NSString *)aName object:(id)object;
    
    - (void)pwf_postNotificationName:(NSString *)aName;
    
to post the `PWFNotification` to the observers.

If you want to post the `PWFNotification` in the main thread,you can set:

    [PWFNotificationCenter defaultCenter].postNotificationInMainThread = YES;
    
If you don't do this, the `PWFNotification` will be posted in the current thread.

When the App that uses the `PWFNotification` receives the memory warning, the `PWFNotificationCenter` will elimate the invalid observers.
   
### Support
Any issue in using `PWFNotification`, you can send email to 674423263@qq.com.

### Licence
`PWFNotification` is released under the MIT license. See LICENSE for details.


