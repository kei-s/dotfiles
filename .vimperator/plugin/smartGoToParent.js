var PLUGIN_INFO =
<VimperatorPlugin>
<name>{NAME}</name>
<description>Smart Go Parent</description>
<description lang="ja">賢く上位ディレクトリに移動</description>
<author mail="kei.shiratsuchi@gmail.com" homepage="http://twitter.com/kei_s">kei-s</author>
<version>0.1</version>
<minVersion>2.3</minVersion>
<maxVersion>2.4</maxVersion>
<updateURL></updateURL>
<detail lang="ja"><![CDATA[
Uppity風に賢く上位ディレクトリに移動するプラグイン
== Command ==

:goParent
    賢く上位ディレクトリに移動します

== Sample ==
:goParent を実行するごとに下記のように移動します
  - http://www.example.com/path/to/file.txt?query=value#anchor
  - http://www.example.com/path/to/file.txt?query=value
  - http://www.example.com/path/to/file.txt
  - http://www.example.com/path/to/
  - http://www.example.com/path/
  - http://www.example.com/
  - http://example.com/
挙動はUppity( http://trac.arantius.com/wiki/Extensions/Uppity )を参考にしています

== mapping例 ==
gu を置き換える例
>||
javascript <<EOF
mappings.addUserMap([modes.NORMAL],["gu"],'Smart Go to Parent',
  function(count){
    liberator.execute(':'+(count?count:'')+'goParent');
  },
  { count: true }
);
EOF
||<

]]></detail>
</VimperatorPlugin>;
(function(){
  // thanks to http://trac.arantius.com/browser/extension/uppity/content/uppity.js
  let regexp = new RegExp('([a-z]+://)([^/]*)(/.*)');
  let goUpPath = function(path) {
    if (!path) return;
    path = path.replace(/\/$/,'').replace(/^\/+/,'');
    if (path.indexOf('#')>0) {
      return path.replace(/#.*/,'');
    }
    if (path.indexOf('?')>0) {
      return path.replace(/\?.*/,'');
    }
    path = path.replace(/\/+$/,'');
    if (path.indexOf('/')>0) {
      return path.replace(/\/[^\/]*$/,'/');
    }
  }
  let goUpHost = function(host) {
    if (/^[0-9+.:]+$/.test(host)){
      return host;
    }
    let hostSuffix='';
    let x=host.lastIndexOf(':');
    if (x>0) {
      hostSuffix = host.substr(x);
      host = host.substr(0,x);
    }
    hostSuffix = host.substr(host.length-6)+hostSuffix;
    host = host.substr(0,host.length-6);
    return host.replace(/[^.]*\./,'')+hostSuffix;
  }
  commands.addUserCommand(["goParent"], 'Smart Go to parent',
    function(arg){
      let count = arg.count;
      if (count < 1)
        count = 1;
      let url = buffer.URL;
      let [all,scheme,host,path] = regexp.exec(url);
      path = path.replace(/\/$/,'').replace(/^\/+/,'');
      for (let i = 0; i < count; i++) {
        if (path) {
          if (path = goUpPath(path)) {
            url = scheme+host+'/'+path;
          }
          else {
            url = scheme+host+'/';
          }
        }
        else {
          host = goUpHost(host);
          url = scheme+host+'/';
        }
      }
      if (url == buffer.URL) {
        liberator.beep();
      }
      else
        liberator.open(url);
    },
    { count: true }
  );
})();
