<?php
/*
Plugin Name: HMR Injector
Description: Injects script code for hot module reloading.
Version: 1.0
Author: Your Name
*/

function inject_hmr_script() {
    ?>
    <script>
        if ('WebSocket' in window) {
            (function() {
                function refreshCSS() {
                    var sheets = [].slice.call(document.getElementsByTagName("link"));
                    var head = document.getElementsByTagName("head")[0];
                    for (var i = 0; i < sheets.length; ++i) {
                        var elem = sheets[i];
                        var parent = elem.parentElement || head;
                        parent.removeChild(elem);
                        var rel = elem.rel;
                        if (elem.href && (!rel || rel === "stylesheet")) {
                            var url = elem.href.replace(/(&|\?)_cacheOverride=\d+/, '');
                            elem.href = url + (url.indexOf('?') >= 0 ? '&' : '?') + '_cacheOverride=' + (new Date().valueOf());
                        }
                        parent.appendChild(elem);
                    }
                }
                var protocol = window.location.protocol === 'http:' ? 'ws://' : 'wss://';
                var address = protocol + window.location.host + window.location.pathname + '/ws';
                var socket = new WebSocket(address);
                socket.onmessage = function(msg) {
                    if (msg.data === 'reload') window.location.reload();
                    else if (msg.data === 'refreshcss') refreshCSS();
                };
                console.log('WebSocket connection established');
            })();
        }
    </script>
    <?php
}
add_action('wp_footer', 'inject_hmr_script');
