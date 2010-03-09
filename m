From: Christian Brunner <chb@muc.de>
Subject: Re: kvm driver
Date: Tue, 9 Mar 2010 23:31:15 +0100
Message-ID: <20100309223114.GA50990@ncolin.muc.de>
References: <20100308054150.GA40223@ncolin.muc.de>
	<Pine.LNX.4.64.1003081402260.15770@cobra.newdream.net>
	<20100309210038.GA50616@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20100309210038.GA50616@ncolin.muc.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > Yehuda is taking a look at it now.  The signals are used to wake up 
> > blocking read()/write()/connect(), but we should be able to use poll() or 
> > select() instead (and clean things up in the process).
> 
> Great! - That was really a quick response. I will check out the current
> git version tomorrow and will give it a try.

I couldn't resist to try it today. I had to make a minor change regarding
pthread handling. Now everything seems to work well. An updated patch
is attached. - Thanks for the quick solution.

I haven't changed the naming scheme yet. I will do this in a few days.

Christian

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qemu-kvm-0.12.3-rbd-20100309.patch"

--- qemu-kvm-0.12.3/Makefile.orig	2010-03-07 20:57:16.801084128 +0100
+++ qemu-kvm-0.12.3/Makefile	2010-03-07 20:57:44.688209374 +0100
@@ -28,6 +28,7 @@
 VPATH=$(SRC_PATH):$(SRC_PATH)/hw
 
 LIBS+=-lz $(LIBS_TOOLS)
+LIBS+=-lrados
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-tech.html qemu.1 qemu-img.1 qemu-nbd.8
@@ -110,7 +111,7 @@
 
 block-nested-y += cow.o qcow.o vdi.o vmdk.o cloop.o dmg.o bochs.o vpc.o vvfat.o
 block-nested-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o
-block-nested-y += parallels.o nbd.o
+block-nested-y += parallels.o nbd.o rbd.o
 block-nested-$(CONFIG_WIN32) += raw-win32.o
 block-nested-$(CONFIG_POSIX) += raw-posix.o
 block-nested-$(CONFIG_CURL) += curl.o
--- qemu-kvm-0.12.3/Makefile.target.orig	2010-03-07 20:59:23.464084413 +0100
+++ qemu-kvm-0.12.3/Makefile.target	2010-03-07 20:59:45.927084228 +0100
@@ -27,6 +27,7 @@
 PROGS=$(QEMU_PROG)
 
 LIBS+=-lm
+LIBS+=-lrados
 
 kvm.o kvm-all.o: QEMU_CFLAGS+=$(KVM_CFLAGS)
 
--- qemu-kvm-0.12.3/block/rbd.c.orig	1970-01-01 01:00:00.000000000 +0100
+++ qemu-kvm-0.12.3/block/rbd.c	2010-03-07 20:56:42.480711441 +0100
@@ -0,0 +1,344 @@
+/*
+ * QEMU Block driver for RADOS (Ceph)
+ *
+ * Copyright (C) 2010 Christian Brunner <chb@muc.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu-common.h"
+#include <sys/types.h>
+#include <stdbool.h>
+
+#include <qemu-common.h>
+
+//#include "rbd.h"
+#include "module.h"
+#include "block_int.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <rados/librados.h>
+
+#include <signal.h>
+
+/*
+ * When specifying the image filename use:
+ *
+ * rbd:poolname/devicename
+ *
+ * poolname must be the name of an existing rados pool
+ *
+ * devicename is the basename for all objects used to
+ * emulate the raw device. It may have a maximum length
+ * of 12 characters.
+ *
+ * The raw device is split into 4MB sized objects. Each
+ * object has a 20 bythe long name in the format
+ *
+ * devicename..AAAAAAAA
+ *
+ * where AAAAAAAA is a base64 encoded segment number. If
+ * the devicename is shorter than 12 bytes the gap between
+ * the devicename and the segment number is filled with
+ * dots. Note that a modified URL and filename safe alphabet
+ * is used for encoding (RFC4648 - Chapter 5).
+ *
+ * To store metadata information (image size, ...) a special 
+ * object without segment numer is created ("devicename..........").
+ *
+ */
+
+#define OBJ_MAX_SIZE 22 	// 22 Bit = 4MB
+#define OBJ_NAME_SIZE 21	// maximum size of the object name (including trailing \0)
+
+#define RBD_READ 1
+#define RBD_WRITE 2
+
+typedef struct RBDRVRBDState {
+	rados_pool_t pool;
+	char name[OBJ_NAME_SIZE];
+	off_t size;
+	size_t blocksize;
+} RBDRVRBDState;
+	
+#define RBD_TEXT "<<< Rados Block Device Image >>>\n"
+#define RBD_SIGNATURE "RBD"
+#define RBD_VERSION1 "000.001"
+
+typedef struct {
+	char text[64];
+	char signature[4];
+	char version[8];
+	uint64_t image_size;
+	uint32_t block_size;
+} RbdHeader1;
+
+static int my64enc(int64_t n, char *b) {
+	static const char cb64[]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
+
+	b[0] = cb64[ (n >> 42) & 0x3f ];
+	b[1] = cb64[ (n >> 36) & 0x3f ];
+	b[2] = cb64[ (n >> 30) & 0x3f ];
+	b[3] = cb64[ (n >> 24) & 0x3f ];
+	b[4] = cb64[ (n >> 18) & 0x3f ];
+	b[5] = cb64[ (n >> 12) & 0x3f ];
+	b[6] = cb64[ (n >>  6) & 0x3f ];
+	b[7] = cb64[ n & 0x3f ];
+
+	return(0);
+}	
+
+static int rbd_parsename(const char *filename, char *pool, char *name) {
+	const char *rbdname;
+	char *p, *n;
+	int l;
+
+	if(!strstart(filename, "rbd:", &rbdname)) {
+		return -EINVAL;
+	}
+		
+	pstrcpy(pool, 128, rbdname);
+	p = strchr(pool, '/');
+	if (p == NULL) {
+		return -EINVAL;
+	}
+
+	*p = '\0';
+	n = ++p;
+
+	l = strlen(n);
+
+	if (l > OBJ_NAME_SIZE-9) {
+		fprintf(stderr, "object name to long\n");
+		return -EINVAL;
+	}
+
+	strcpy(name, "....................");
+	memcpy(name, n, l);
+
+	return 0;
+}
+
+static int rbd_create(const char *filename, QEMUOptionParameter *options) {
+	int64_t bytes = 0;
+	char pool[128];
+	char name[128];
+	RbdHeader1 header;
+	rados_pool_t p;
+
+	fprintf(stderr, "rbd_create\n");
+	if (rbd_parsename(filename, pool, name)) {
+		return -EINVAL;
+	}
+
+	/* Read out options */
+	while (options && options->name) {
+		if (!strcmp(options->name, BLOCK_OPT_SIZE)) {
+			bytes = options->value.n;
+		}
+		options++;
+	}
+
+	memset(&header, 0, sizeof(header));
+	pstrcpy(header.text, sizeof(header.text), RBD_TEXT);
+	pstrcpy(header.signature, sizeof(header.signature), RBD_SIGNATURE);
+	pstrcpy(header.version, sizeof(header.version), RBD_VERSION1);
+	header.image_size = bytes;
+	cpu_to_le64s(&header.image_size);
+	header.block_size = 1024;
+	cpu_to_le32s(&header.block_size);
+
+        if (rados_initialize(0, NULL) < 0) {
+                fprintf(stderr, "error initializing\n");
+		return -EIO;
+        }
+
+	if (rados_open_pool(pool, &p)) {
+                fprintf(stderr, "error opening pool %s\n", pool);
+		return -EIO;
+	}
+
+	if (rados_write(p, name, 0, (const char *) &header, sizeof(header)) < 0) {
+		return -errno;
+	}
+
+	rados_close_pool(p);
+	rados_deinitialize();
+
+	return 0;
+}
+
+static int rbd_open(BlockDriverState *bs, const char *filename, int flags) {
+	RBDRVRBDState *s = bs->opaque;
+	char pool[128];
+	char hbuf[4096];
+
+	if (rbd_parsename(filename, pool, s->name)) {
+		return -EINVAL;
+	}
+	
+	/* Make sure potential threads created by librados don't hog signals. 
+	 * see also audio/sdlaudio.c or
+	 * http://lists.gnu.org/archive/html/qemu-devel/2007-04/msg00090.html
+	 */
+	
+	sigset_t new, old;
+	sigfillset (&new);
+	pthread_sigmask (SIG_BLOCK, &new, &old);
+
+        if (rados_initialize(0, NULL) < 0) {
+                fprintf(stderr, "error initializing\n");
+		return -EIO;
+        }
+
+	if (rados_open_pool(pool, &s->pool)) {
+                fprintf(stderr, "error opening pool %s\n", pool);
+		return -EIO;
+	}
+
+	if (rados_read(s->pool, s->name, 0, hbuf, 4096) < 0) {
+                fprintf(stderr, "error reading header from %s\n", s->name);
+		return -EIO;
+	}
+	if (!strncmp(hbuf+64, RBD_SIGNATURE, 4)) {
+		if(!strncmp(hbuf+68, RBD_VERSION1, 8)) {
+			RbdHeader1 *header;
+
+			header = (RbdHeader1 *) hbuf;
+			le64_to_cpus(&header->image_size);
+			s->size = header->image_size;
+			le32_to_cpus(&header->block_size);
+			s->blocksize = header->block_size;
+		} else {
+                	fprintf(stderr, "Unknown image version %s\n", hbuf+68);
+			return -EIO;
+		}
+	} else {
+                fprintf(stderr, "Invalid header signature %s\n", hbuf+64);
+		return -EIO;
+	}
+
+	pthread_sigmask (SIG_SETMASK, &old, 0);
+
+	return 0;
+}
+
+static void rbd_close(BlockDriverState *bs) {
+	RBDRVRBDState *s = bs->opaque;
+
+	rados_close_pool(s->pool);
+	rados_deinitialize();
+}
+
+static int rbd_write(BlockDriverState *bs, int64_t sector_num, 
+		const uint8_t *buf, int nb_sectors) {
+	RBDRVRBDState *s = bs->opaque;
+	char *n = s->name;
+
+	int64_t segnr, segoffs, segsize;
+	int64_t off, size;
+
+	off = sector_num * 512;
+	size = nb_sectors * 512;
+	segnr = (int64_t) (off >> OBJ_MAX_SIZE);
+	segoffs = (int64_t) (off & ((1 << OBJ_MAX_SIZE) - 1));
+	segsize  = (int64_t) ((1 << OBJ_MAX_SIZE) - segoffs);
+
+	while (size > 0) {
+		if (size < segsize) {
+			segsize = size;
+		}
+
+		my64enc(segnr,n+OBJ_NAME_SIZE-9);
+
+		if (rados_write(s->pool, n, segoffs, (const char *) buf, segsize) < 0) {
+			return -errno;
+		}
+
+		buf += segsize;
+		size -= segsize;
+		segoffs = 0;
+		segsize = (1 << OBJ_MAX_SIZE);
+		segnr++;
+	}
+
+	return(0);
+}
+
+static int rbd_read(BlockDriverState *bs, int64_t sector_num, 
+		uint8_t *buf, int nb_sectors) {
+	RBDRVRBDState *s = bs->opaque;
+	char *n = s->name;
+
+	int64_t segnr, segoffs, segsize, r;
+	int64_t off, size;
+
+	off = sector_num * 512;
+	size = nb_sectors * 512;
+	segnr = (int64_t) (off >> OBJ_MAX_SIZE);
+	segoffs = (int64_t) (off & ((1 << OBJ_MAX_SIZE) - 1));
+	segsize  = (int64_t) ((1 << OBJ_MAX_SIZE) - segoffs);
+
+	while (size > 0) {
+		if (size < segsize) {
+			segsize = size;
+		}
+
+		my64enc(segnr,n+OBJ_NAME_SIZE-9);
+
+		r = rados_read(s->pool, n, segoffs, (char *) buf, segsize);
+		if (r < 0) {
+			memset(buf, 0, segsize);
+		} else if (r < segsize) {
+			memset(buf+r, 0, segsize-r);
+		}
+
+		buf += segsize;
+		size -= segsize;
+		segoffs = 0;
+		segsize = (1 << OBJ_MAX_SIZE);
+		segnr++;
+	}
+
+	return(0);
+}
+
+static int64_t rbd_getlength(BlockDriverState *bs) {
+	RBDRVRBDState *s = bs->opaque;
+
+	return s->size;
+}
+
+
+static QEMUOptionParameter rbd_create_options[] = {
+    {
+        .name = BLOCK_OPT_SIZE,
+        .type = OPT_SIZE,
+        .help = "Virtual disk size"
+    },
+    { NULL }
+};
+
+static BlockDriver bdrv_rbd = {
+	.format_name	= "rbd",
+	.instance_size	= sizeof(RBDRVRBDState),
+	.bdrv_open	= rbd_open,
+	.bdrv_read 	= rbd_read,
+	.bdrv_write	= rbd_write,
+	.bdrv_close	= rbd_close,
+	.bdrv_create	= rbd_create,
+	.create_options = rbd_create_options,
+	.bdrv_getlength	= rbd_getlength,
+	.protocol_name	= "rbd",
+};
+
+static void bdrv_rbd_init(void) {
+	bdrv_register(&bdrv_rbd);
+}
+
+block_init(bdrv_rbd_init);
+
+

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--BXVAT5kNtrzKuDFl--
