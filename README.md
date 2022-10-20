# mosaic-windows
I have a lot of things to do...

https://user-images.githubusercontent.com/29433103/196655148-45b7c509-99e2-4950-8de7-b0a78b122530.mov

## References

- [macOSで起動中のウィンドウの一覧を列挙する](https://iseebi.hatenablog.com/entry/2022/03/06/221634)

>ただし、このままだとウィンドウのタイトルがほとんど取れない。これはプライバシーの観点で取れないようになっている。
> 取得するためには画面収録のパーミッションが必要で、以下のコードを実行することでパーミッションを得られる。
>`CGRequestScreenCaptureAccess()`

- [\[macOS\]\[Swift4\.1\] すべてのウインドウをキャプチャして一覧表示する方法](https://qiita.com/a_jike/items/eaa93e688e278f0a8a7b)
- [Window List Option Constants](https://developer.apple.com/documentation/coregraphics/quartz_window_services/window_list_option_constants)
- [Quartz Window Services](https://developer.apple.com/documentation/coregraphics/quartz_window_services)
- [kCGWindowIsOnscreen](https://developer.apple.com/documentation/coregraphics/kcgwindowisonscreen)
    - `control + H`で隠したときにfalse
    - 他のウインドウで隠れているだけの場合はtrue
- [Top Window at Point](https://developer.apple.com/forums/thread/19003)
    - `onScreen`という名前のあるものはwindowsが順番に前から後ろの順序で返ってくるとのこと
    - `windows.insert(window, at: windows.endIndex)`のように代入するといい
    - kCGWindowLayerはWindowLevelに相当する。同じ階層にいくつかの値が存在するのでこれだけではZ方向の重なりは決定できない
- [デスクトップ上にあるウインドウの一覧を取得する](https://qiita.com/usagimaru/items/6ffd09c5b27042281108#105%E4%BB%A5%E9%99%8D%E3%81%A7%E3%81%AF%E3%82%A6%E3%82%A4%E3%83%B3%E3%83%89%E3%82%A6%E3%83%AA%E3%82%B9%E3%83%88%E3%81%B8%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%8C%E7%B0%A1%E5%8D%98%E3%81%AB%E3%81%A7%E3%81%8D%E3%82%8B)
- [How can my app detect a change to another app's window?](https://stackoverflow.com/questions/853833/how-can-my-app-detect-a-change-to-another-apps-window)
    - `AXUIElementRef`経由でWindowの変更通知を取得できる…かも
