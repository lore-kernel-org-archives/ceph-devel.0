From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V5 6/6] Rados example for blkin (LTTng + Zipkin) tracing
Date: Mon,  2 Mar 2015 16:35:15 -0800
Message-ID: <1425342915-12553-7-git-send-email-agshew@gmail.com>
References: <1425342915-12553-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42725 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbbCCAfQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 19:35:16 -0500
Received: by pdbfl12 with SMTP id fl12so12550218pdb.9
        for <ceph-devel@vger.kernel.org>; Mon, 02 Mar 2015 16:35:15 -0800 (PST)
In-Reply-To: <1425342915-12553-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

This code is Marios', with the following exceptions:
 * split out example from other tracing changes
 * changed name of example
 * whitespace issues have been fixed
 * Makefile cleans up the new example

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 examples/librados/Makefile      |   9 ++++
 examples/librados/hello_blkin.c | 107 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 examples/librados/hello_blkin.c

diff --git a/examples/librados/Makefile b/examples/librados/Makefile
index 190cca2..f8d8e1d 100644
--- a/examples/librados/Makefile
+++ b/examples/librados/Makefile
@@ -1,4 +1,8 @@
+ifdef WITH_BLKIN
+all: librados_hello_world librados_hello_world_c librados_hello_blkin
+else
 all: librados_hello_world librados_hello_world_c
+endif
 
 librados_hello_world: hello_world.cc
 	g++ -g -c hello_world.cc -o hello_world.o $(CFLAGS)
@@ -8,6 +12,11 @@ librados_hello_world_c: hello_world_c.c
 	cc -g -c hello_world_c.c -o hello_world_c.o $(CFLAGS)
 	cc -g hello_world_c.o -lrados -o librados_hello_world_c $(LDFLAGS)
 
+librados_hello_blkin: hello_blkin.c
+	cc -g -c hello_blkin.c -o hello_blkin.o $(CFLAGS)
+	cc -g hello_blkin.o -lrados -lblkin-front -o librados_hello_blkin $(LDFLAGS)
+
 clean:
 	rm hello_world.o librados_hello_world
 	rm hello_world_c.o librados_hello_world_c
+	rm hello_blkin.o librados_hello_blkin
diff --git a/examples/librados/hello_blkin.c b/examples/librados/hello_blkin.c
new file mode 100644
index 0000000..1bc1c50
--- /dev/null
+++ b/examples/librados/hello_blkin.c
@@ -0,0 +1,107 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
+// vim: ts=8 sw=2 smarttab
+
+#include <stdio.h>
+#include <rados/librados.h>
+#include <stdlib.h>
+#include <blkin-front.h>
+
+#define POOL "data"
+
+const char *object_name = "hello_world_object";
+const char *object_val = "hello world!";
+
+rados_ioctx_t *connect_to_rados()
+{
+  rados_t rados;
+  rados_ioctx_t *ioctx = malloc(sizeof(rados_ioctx_t));
+
+  if (rados_create(&rados, NULL) < 0) {
+    return NULL;
+  }
+  if (rados_conf_read_file(rados, NULL) < 0){
+    return NULL;
+  }
+  if (rados_connect(rados) < 0) {
+    printf("Could not connect\n");
+    rados_shutdown(rados);
+    return NULL;
+  }
+  if (rados_pool_lookup(rados, POOL) < 0) {
+    printf("Could not find pool\n");
+    rados_shutdown(rados);
+    return NULL;
+  }
+  if (rados_ioctx_create(rados, POOL, ioctx) < 0){
+    rados_shutdown(rados);
+    return NULL;
+  }
+  return ioctx;
+}
+
+void end_read(rados_completion_t c, void *arg)
+{
+  fprintf(stderr, "just read\n");
+}
+
+void end_write(rados_completion_t c, void *arg)
+{
+  fprintf(stderr, "just wrote\n");
+}
+
+int main()
+{
+  int r, i;
+  char temp[12];
+  rados_completion_t compl;
+  rados_ioctx_t *rados_ctx;
+  /*initialize lib*/
+  r = blkin_init();
+  if (r < 0) {
+    fprintf(stderr, "Could not initialize blkin\n");
+    exit(1);
+  }
+  /*initialize endpoint*/
+  struct blkin_endpoint endp;
+  blkin_init_endpoint(&endp, "10.0.0.1", 5000, "rados client");
+  struct blkin_trace trace;
+  blkin_init_new_trace(&trace, "client", &endp);
+  BLKIN_TIMESTAMP(&trace, &endp, "start");
+
+  //connect
+  rados_ctx = connect_to_rados();
+  if (rados_ctx == NULL){
+    printf("Connect return NULL\n");
+    exit(1);
+  }
+  printf("connected\n");
+
+  //write an object
+  r = rados_aio_create_completion(NULL, end_write, end_write, &compl);
+  if (r<0) {
+    printf("could not create completion\n");
+    exit(1);
+  }
+  printf("created completion\n");
+  r = rados_aio_write_traced(*rados_ctx, object_name, compl, object_val, 12,
+      0, &trace.info);
+
+  rados_aio_wait_for_complete(compl);
+  printf("completed\n");
+
+  //read an object
+  r = rados_aio_create_completion(NULL, end_read, end_read, &compl);
+  if (r<0) {
+    printf("could not create completion\n");
+    exit(1);
+  }
+  printf("created completion\n");
+  r = rados_aio_read_traced(*rados_ctx, object_name, compl, temp, 12, 0,
+      &trace.info);
+  rados_aio_wait_for_complete(compl);
+  printf("I read:\n");
+  for (i=0;i<12;i++)
+    printf("%c",temp[i]);
+  printf("completed\n");
+  BLKIN_TIMESTAMP(&trace, &endp, "Span ended");
+}
-- 
2.1.0

