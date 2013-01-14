import module namespace cb = "http://www.zorba-xquery.com/modules/couchbase";

variable $instance := cb:connect({
  "host": "localhost:8091",
  "username" : null,
  "password" : null,
  "bucket" : "default"});

cb:remove($instance, "view");
cb:put-text($instance, "view", '{ "view" : 1 }', { "wait" : "persist" });

variable $view-name := cb:create-view($instance, "test-view", "test", {"key":"doc.view"});


variable $data := cb:view($instance, $view-name, {"stale" : "false"});
for $d in jn:members($data("rows"))
where $d("key") > 0
return $d

