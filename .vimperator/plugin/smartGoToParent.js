var PLUGIN_INFO =
<VimperatorPlugin>
<name>{NAME}</name>
<description>Smart Go Parent</description>
<description lang="ja">賢く上位ディレクトリに移動</description>
<author mail="kei.shiratsuchi@gmail.com" homepage="http://twitter.com/kei_s">kei-s</author>
<version>0.1</version>
<minVersion>2.3</minVersion>
<maxVersion>2.4</maxVersion>
<updateURL>http://gist.github.com/raw/604592/smartGoToParent.js</updateURL>
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
  function getParent(url,count) {
    function getParentPath(path) {
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
    function getParentHost(host) {
      if (!/\./.test(host) || /^[0-9+.:]+$/.test(host)){
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
    let parent = url;
    let regexp = new RegExp('([a-z]+:///?)([^/]*)(/.*)');
    let [,scheme,host,path] = regexp.exec(url);
    path = path.replace(/\/$/,'').replace(/^\/+/,'');
    for (let i = 0; i < count; i++) {
      if (path) {
        if (path = getParentPath(path)) {
          parent = scheme+host+'/'+path;
        }
        else {
          parent = scheme+host+'/';
        }
      }
      else {
        host = getParentHost(host);
        parent = scheme+host+'/';
      }
    }
    return parent;
  }
  commands.addUserCommand(["goParent"], 'Smart Go to parent',
    function(arg){
      let count = arg.count;
      if (count < 1)
        count = 1;
      let url = getParent(buffer.URL,count);;
      if (url == buffer.URL) {
        liberator.beep();
      }
      else
        liberator.open(url);
    },
    { count: true }
  );
})();
