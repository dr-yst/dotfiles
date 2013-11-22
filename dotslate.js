S.log('[SLATE] ----------- Start Loading Config -----------');

// アプリ立ち上げる関数
var launch_and_focus = function (target) {
    return function (win) {
        var apps = [];
        S.eachApp(function (app) { apps.push(app.name()); });
        if (! _.find(apps, function (name) { return name === target; })) {
            win.doOperation(
                S.operation('shell', {
                    command: "/usr/bin/open -a " + target,
                    waithFoeExit: true
                })
            );
        }
        win.doOperation(S.operation('focus', { app: target }));
    };
};
S.bind('t:alt,cmd', launch_and_focus('iTerm'));
S.bind('e:alt,cmd', launch_and_focus('Emacs'));
S.bind('b:alt,cmd', launch_and_focus('Firefox'));
S.bind('f:alt,cmd', launch_and_focus('Finder'));
S.bind('d:alt,cmd', launch_and_focus('Dictionary'));
S.bind('i:alt,cmd', launch_and_focus('iTunes'));
S.bind('space:alt,cmd', launch_and_focus('Found'));
S.bind('p:alt,cmd', launch_and_focus('Preview'));
S.bind('m:alt,cmd', launch_and_focus('Mjograph'));

S.log('[SLATE] ----------- Finished Loading Config -----------');
