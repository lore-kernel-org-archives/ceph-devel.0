From: Christian Brunner <chb@muc.de>
Subject: [PATCH] qemu-kvm/rbd: small fixes and cosmetics
Date: Wed, 14 Apr 2010 22:49:07 +0200
Message-ID: <20100414204907.GA976@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:65393 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756687Ab0DNUzt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Apr 2010 16:55:49 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Attached is a patch with small fixes and cosmetics for the qemu-kvm/rbd 
driver:

- conditional linking of librados
- reduced header size
- followed the variable names of the kernel driver

Could you put it in the git repository, please?

Christian
---
 Makefile    |    2 ++
 block/rbd.c |   56 ++++++++++++++++++++++++++++----------------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index 6280193..b96743d 100644
--- a/Makefile
+++ b/Makefile
@@ -27,7 +27,9 @@ configure: ;
 $(call set-vpath, $(SRC_PATH):$(SRC_PATH)/hw)
 
 LIBS+=-lz $(LIBS_TOOLS)
+ifdef CONFIG_RBD
 LIBS+=-lrados
+endif
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-tech.html qemu.1 qemu-img.1 qemu-nbd.8
diff --git a/block/rbd.c b/block/rbd.c
index 3513e48..9127bfa 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -46,14 +46,14 @@
 
 #define OBJ_DEFAULT_ORDER 22	// 22 Bit = 4MB (as default)
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_ORDER)
+#define RBD_MAX_OBJ_NAME_SIZE   96
+#define RBD_MAX_SEG_NAME_SIZE   128
 
-#define MAX_NAME 128 		// Maximum size of the poolname plus objectname
-#define MAX_SNAPS 4096		// Maximum number of snapshots (unsupported at
-				// the moment)
+#define RBD_SUFFIX ".rbd"
 
 typedef struct RBDRVRBDState {
 	rados_pool_t pool;
-	char name[MAX_NAME];
+	char name[RBD_MAX_OBJ_NAME_SIZE];
 	int name_len;
 	uint64_t size;
 	uint64_t objsize;
@@ -70,13 +70,13 @@ typedef struct {
 	char text[64];
 	char signature[4];
 	char version[8];
-	uint64_t imagesize;
-	uint8_t objorder;
+	uint64_t image_size;
+	uint8_t obj_order;
 	uint8_t crypt_type;
 	uint8_t comp_type;			// unsupported at the moment
 	uint64_t snap_seq;			// unsupported at the moment
 	uint16_t snap_count;			// unsupported at the moment
-	uint64_t snap_id[MAX_SNAPS];	// unsupported at the moment
+	uint64_t snap_id[0];			// unsupported at the moment
 } __attribute__((packed)) RbdHeader1;
 
 static int rbd_parsename(const char *filename, char *pool, char *name) {
@@ -88,7 +88,7 @@ static int rbd_parsename(const char *filename, char *pool, char *name) {
 		return -EINVAL;
 	}
 		
-	pstrcpy(pool, MAX_NAME, rbdname);
+	pstrcpy(pool, 2*RBD_MAX_SEG_NAME_SIZE, rbdname);
 	p = strchr(pool, '/');
 	if (p == NULL) {
 		return -EINVAL;
@@ -99,7 +99,7 @@ static int rbd_parsename(const char *filename, char *pool, char *name) {
 
 	l = strlen(n);
 
-	if (l > MAX_NAME-14) {
+	if (l > RBD_MAX_OBJ_NAME_SIZE) {
 		fprintf(stderr, "object name to long\n");
 		return -EINVAL;
 	} else if (l <= 0) {
@@ -115,10 +115,10 @@ static int rbd_parsename(const char *filename, char *pool, char *name) {
 static int rbd_create(const char *filename, QEMUOptionParameter *options) {
 	int64_t bytes = 0;
 	int64_t objsize;
-	uint8_t objorder = OBJ_DEFAULT_ORDER;
-	char pool[MAX_NAME];
-	char n[MAX_NAME];
-	char name[MAX_NAME];
+	uint8_t obj_order = OBJ_DEFAULT_ORDER;
+	char pool[RBD_MAX_SEG_NAME_SIZE];
+	char n[RBD_MAX_SEG_NAME_SIZE];
+	char name[RBD_MAX_SEG_NAME_SIZE];
 	RbdHeader1 header;
 	rados_pool_t p;
 	int name_len;
@@ -127,7 +127,7 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options) {
 		return -EINVAL;
 	}
 
-	snprintf(n, MAX_NAME, "%s.rbd", name);
+	snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_SUFFIX);
 
 	/* Read out options */
 	while (options && options->name) {
@@ -145,7 +145,7 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options) {
 					return -EINVAL;
 				}
 
-				for (objorder=0; objorder<64; objorder++) {
+				for (obj_order=0; obj_order<64; obj_order++) {
 					if (objsize == 1)
 						break;
 					objsize >>= 1;
@@ -159,9 +159,9 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options) {
 	pstrcpy(header.text, sizeof(header.text), RBD_TEXT);
 	pstrcpy(header.signature, sizeof(header.signature), RBD_SIGNATURE);
 	pstrcpy(header.version, sizeof(header.version), RBD_VERSION1);
-	header.imagesize = bytes;
-	cpu_to_le64s(&header.imagesize);
-	header.objorder = objorder;
+	header.image_size = bytes;
+	cpu_to_le64s(&header.image_size);
+	header.obj_order = obj_order;
 	header.crypt_type = CRYPT_NONE;
 	header.comp_type = COMP_NONE;
 	header.snap_seq = 0;
@@ -190,14 +190,14 @@ static int rbd_create(const char *filename, QEMUOptionParameter *options) {
 
 static int rbd_open(BlockDriverState *bs, const char *filename, int flags) {
 	RBDRVRBDState *s = bs->opaque;
-	char pool[MAX_NAME];
-	char n[MAX_NAME];
+	char pool[RBD_MAX_SEG_NAME_SIZE];
+	char n[RBD_MAX_SEG_NAME_SIZE];
 	char hbuf[4096];
 
 	if ((s->name_len = rbd_parsename(filename, pool, s->name)) < 0) {
 		return -EINVAL;
 	}
-	snprintf(n, MAX_NAME, "%s.rbd", s->name);
+	snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RBD_SUFFIX);
 	
         if (rados_initialize(0, NULL) < 0) {
                 fprintf(stderr, "error initializing\n");
@@ -218,9 +218,9 @@ static int rbd_open(BlockDriverState *bs, const char *filename, int flags) {
 			RbdHeader1 *header;
 
 			header = (RbdHeader1 *) hbuf;
-			le64_to_cpus(&header->imagesize);
-			s->size = header->imagesize;
-			s->objsize = 1 << header->objorder;
+			le64_to_cpus(&header->image_size);
+			s->size = header->image_size;
+			s->objsize = 1 << header->obj_order;
 		} else {
                 	fprintf(stderr, "Unknown image version %s\n", hbuf+68);
 			return -EIO;
@@ -243,7 +243,7 @@ static void rbd_close(BlockDriverState *bs) {
 static int rbd_write(BlockDriverState *bs, int64_t sector_num, 
 		const uint8_t *buf, int nb_sectors) {
 	RBDRVRBDState *s = bs->opaque;
-	char n[MAX_NAME];
+	char n[RBD_MAX_SEG_NAME_SIZE];
 
 	int64_t segnr, segoffs, segsize;
 	int64_t off, size;
@@ -259,7 +259,7 @@ static int rbd_write(BlockDriverState *bs, int64_t sector_num,
 			segsize = size;
 		}
 
-		snprintf(n, MAX_NAME, "%s.%012llx", s->name, (long long unsigned int) segnr);
+		snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name, (long long unsigned int) segnr);
 
 		if (rados_write(s->pool, n, segoffs, (const char *) buf, segsize) < 0) {
 			return -errno;
@@ -278,7 +278,7 @@ static int rbd_write(BlockDriverState *bs, int64_t sector_num,
 static int rbd_read(BlockDriverState *bs, int64_t sector_num, 
 		uint8_t *buf, int nb_sectors) {
 	RBDRVRBDState *s = bs->opaque;
-	char n[MAX_NAME];
+	char n[RBD_MAX_SEG_NAME_SIZE];
 
 	int64_t segnr, segoffs, segsize, r;
 	int64_t off, size;
@@ -294,7 +294,7 @@ static int rbd_read(BlockDriverState *bs, int64_t sector_num,
 			segsize = size;
 		}
 
-		snprintf(n, MAX_NAME, "%s.%012llx", s->name, (long long unsigned int) segnr);
+		snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name, (long long unsigned int) segnr);
 
 		r = rados_read(s->pool, n, segoffs, (char *) buf, segsize);
 		if (r < 0) {
-- 
1.6.6.1



-- 
Christian Brunner                              MUC.DE e.V.
                                               Joseph-Dollinger-Bogen 14
                                               D-80807 Muenchen
