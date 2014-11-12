From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 5/6] Rados example application for blkin
Date: Wed, 12 Nov 2014 16:21:11 -0700
Message-ID: <20141112232111.GF6892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34533 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbaKLXVO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 18:21:14 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so13990417pac.30
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 15:21:14 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id d11sm8273755pbu.8.2014.11.12.15.21.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 15:21:13 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This code is Marios', with the following exceptions:
 - split out example from other tracing changes
 - whitespace issues have been fixed
 - Makefile cleans up the new example

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 examples/librados/Makefile      |   5 +-
 examples/librados/hello_world.c | 107 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 examples/librados/hello_world.c

diff --git a/examples/librados/Makefile b/examples/librados/Makefile
index a40051f..c45eb60 100644
--- a/examples/librados/Makefile
+++ b/examples/librados/Makefile
@@ -1,5 +1,6 @@
-all: hello_world.cc
+all: hello_world.cc hello_world.c
+	gcc hello_world.c -o hello -lrados -lblkin-front
 	g++ -g -c hello_world.cc -o hello_world.o
 	g++ -g hello_world.o -lrados -o librados_hello_world
 clean:
-	rm hello_world.o librados_hello_world
\ No newline at end of file
+	rm hello_world.o librados_hello_world hello
diff --git a/examples/librados/hello_world.c b/examples/librados/hello_world.c
new file mode 100644
index 0000000..a826001
--- /dev/null
+++ b/examples/librados/hello_world.c
@@ -0,0 +1,107 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
+// vim: ts=8 sw=2 smarttab
+
+#include <stdio.h>
+#include <rados/librados.h>
+#include <stdlib.h>
+#include <blkin-front.h>
+
+#define POOL "marios"
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

