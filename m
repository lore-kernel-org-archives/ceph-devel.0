From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Mon, 24 May 2010 14:38:06 -0500
Message-ID: <4BFAD59E.2010706@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020902030707050203050708"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <chb@muc.de>
Cc: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Avi Kivity <avi@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--------------020902030707050203050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/24/2010 02:07 PM, Christian Brunner wrote:
> 2010/5/24 MORITA Kazutaka<morita.kazutaka@lab.ntt.co.jp>:
>
>    
>>> However, I don't think nbd would be a good protocol.  My preference
>>> would be for a plugin API, or for a new local protocol that uses
>>> splice() to avoid copies.
>>>
>>>        
>> Both would be okay for Sheepdog.  I want to take a suitable approach
>> for qemu.
>>      
> I think both should be possible:
>
> - Using splice() we would need a daemon that is listening on a control
> socket for
>    requests from qemu-processes or admin commands. When a qemu-process
>    wants to open an image it could call open_image("protocol:imagename") on the
>    controll socket and the daemon has to create a pipe to which the
> image is mapped.
>    (What I'm unsure about, are the security implications. Do we need some kind of
>    authentication for the sockets? What about sVirt?
>    

This is a fairly old patch that I dug out of a backup.  It uses the 9p 
protocol and does proper support for AIO.

At one point in time, I actually implemented splice() support but it 
didn't result in a significant improvement in benchmarks.

> - Building a plugin API seems a bit simpler to me, although I'm to
> sure if I'd get the
>    idea correctly:
>    The block layer has already some kind of api (.bdrv_file_open, .bdrv_read). We
>    could simply compile the block-drivers as shared objects and create a method
>    for loading the necessary modules at runtime.
>    

That approach would be a recipe for disaster.   We would have to 
introduce a new, reduced functionality block API that was supported for 
plugins.  Otherwise, the only way a plugin could keep up with our API 
changes would be if it was in tree which defeats the purpose of having 
plugins.

Regards,

Anthony Liguori

> Are you planing to use this for all block drivers?
>
> Regards,
> Christian
>    


--------------020902030707050203050708
Content-Type: text/plain;
 name="block-9p.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="block-9p.patch"

diff --git a/Makefile b/Makefile
index 4f7a55a..541b26a 100644
--- a/Makefile
+++ b/Makefile
@@ -53,7 +53,7 @@ BLOCK_OBJS=cutils.o qemu-malloc.o
 BLOCK_OBJS+=block-cow.o block-qcow.o aes.o block-vmdk.o block-cloop.o
 BLOCK_OBJS+=block-dmg.o block-bochs.o block-vpc.o block-vvfat.o
 BLOCK_OBJS+=block-qcow2.o block-parallels.o block-nbd.o
-BLOCK_OBJS+=nbd.o block.o aio.o
+BLOCK_OBJS+=nbd.o block.o aio.o block-9p.o p9.o p9c.o
 
 ifdef CONFIG_WIN32
 BLOCK_OBJS += block-raw-win32.o
diff --git a/block-9p.c b/block-9p.c
new file mode 100644
index 0000000..5570f37
--- /dev/null
+++ b/block-9p.c
@@ -0,0 +1,573 @@
+/*
+ * 9p based block driver for QEMU
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu-common.h"
+#include "block_int.h"
+#include "p9c.h"
+#include "qemu_socket.h"
+
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+
+//#define DEBUG_BLOCK_9P
+
+#ifdef DEBUG_BLOCK_9P
+#define dprintf(fmt, ...) \
+    do { printf("block-9p: " fmt, ## __VA_ARGS__); } while (0)
+#define _dprintf(fmt, ...) \
+    do { printf(fmt, ## __VA_ARGS__); } while (0)
+#else
+#define dprintf(fmt, ...) \
+    do { } while (0)
+#define _dprintf(fmt, ...) \
+    do { } while (0)
+#endif
+
+typedef struct BDRV9pState {
+    P9IOState iops;
+    BlockDriverState *bs;
+    P9ClientState *client_state;
+    int fd;
+    char filename[1024];
+    int nwnames;
+    const char *wnames[256];
+    int do_loop;
+    int64_t length;
+    int32_t msize;
+    int count;
+} BDRV9pState;
+
+typedef struct P9AIOCB {
+    BlockDriverAIOCB common;
+    BDRV9pState *s;
+    int64_t offset;
+    size_t size;
+    void *buf;
+} P9AIOCB;
+
+static void p9_recv_notify(void *opaque)
+{
+    BDRV9pState *s = opaque;
+    p9c_notify_can_recv(s->client_state);
+}
+
+static void p9_send_notify(void *opaque)
+{
+    BDRV9pState *s = opaque;
+    p9c_notify_can_send(s->client_state);
+}
+
+static BDRV9pState *to_bs(P9IOState *iops)
+{
+    return container_of(iops, BDRV9pState, iops);
+}
+
+static ssize_t p9_send(P9IOState *iops, const void *data, size_t size)
+{
+    BDRV9pState *s = to_bs(iops);
+    ssize_t len;
+    len = send(s->fd, data, size, 0);
+    if (len == -1)
+        errno = socket_error();
+    return len;
+}
+
+static ssize_t p9_recv(P9IOState *iops, void *data, size_t size)
+{
+    BDRV9pState *s = to_bs(iops);
+    ssize_t len;
+    len = recv(s->fd, data, size, 0);
+    if (len == -1)
+        errno = socket_error();
+    return len;
+}
+
+static int p9_flush(void *opaque)
+{
+    BDRV9pState *s = opaque;
+    return !!s->count || s->do_loop;
+}
+
+static void p9_set_send_notify(P9IOState *iops, int enable)
+{
+    BDRV9pState *s = to_bs(iops);
+
+    if (enable)
+        qemu_aio_set_fd_handler(s->fd, p9_recv_notify, p9_send_notify, p9_flush, s);
+    else 
+        qemu_aio_set_fd_handler(s->fd, p9_recv_notify, NULL, p9_flush, s);
+}
+
+static int p9_open_cb(void *opaque, int ret, const P9QID *qid, int32_t iounit)
+{
+    BDRV9pState *s = opaque;
+
+    if (ret) {
+        dprintf("Rerror: %s\n", strerror(ret));
+        s->do_loop = 0;
+        return -ret;
+    }
+
+    dprintf("Ropen(qid={type=%d, version=%d, path=%" PRId64 "}, iounit=%d)\n",
+            qid->type, qid->version, qid->path, iounit);
+
+    s->do_loop = 0;
+
+    return 0;
+}
+
+static int p9_stat_cb(void *opaque, int ret, const P9Stat *stbuf)
+{
+    BDRV9pState *s = opaque;
+
+    if (ret) {
+        dprintf("Rstat error: %s\n", strerror(ret));
+        s->do_loop = 0;
+        return -ret;
+    }
+
+    dprintf("Rstat(size=%d, type=%d, dev=%d, "
+            "qid={type=%d, version=%d, path=%" PRId64 "}, "
+            "mode=%d, atime=%d, mtime=%d, length=%" PRId64 ", name=%s, uid=%s, "
+            "gid=%s, muid=%s, extension=%s, nuid=%d, ngid=%d, nmuid=%d)\n",
+            stbuf->size, stbuf->type, stbuf->dev, stbuf->qid.type,
+            stbuf->qid.version, stbuf->qid.path, stbuf->mode, stbuf->atime,
+            stbuf->mtime, stbuf->length, stbuf->name, stbuf->uid, stbuf->gid,
+            stbuf->muid, stbuf->extension, stbuf->n_uid, stbuf->n_gid,
+            stbuf->n_muid);
+
+    s->length = stbuf->length;
+
+    if (p9c_open(s->client_state, 1, P9_O_RDWR, p9_open_cb, s) < 0) {
+        dprintf("Topen failed\n");
+        s->do_loop = 0;
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int p9_walk_cb(void *opaque, int ret, int16_t nwqid, const P9QID *wqids)
+{
+    BDRV9pState *s = opaque;
+    int i;
+
+    if (ret) {
+        dprintf("Rerror: %s\n", strerror(ret));
+        s->do_loop = 0;
+        return -ret;
+    }
+
+    dprintf("Rwalk(nwqid=%d, wqids={");
+    for (i = 0; i < nwqid; i++) {
+        if (i)
+            _dprintf(", ");
+        _dprintf("{type=%d, version=%d, path=%" PRId64 "}",
+                 wqids[i].type, wqids[i].version, wqids[i].path);
+    }
+    _dprintf("})\n");
+
+    if (p9c_stat(s->client_state, 1, p9_stat_cb, s) < 0) {
+        dprintf("Tstat failed\n");
+        s->do_loop = 0;
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int p9_attach_cb(void *opaque, int ret, const P9QID *qid)
+{
+    BDRV9pState *s = opaque;
+
+    if (ret) {
+        dprintf("Rerror: %s\n", strerror(ret));
+        s->do_loop = 0;
+        return -ret;
+    }
+
+    dprintf("Rattach(qid={type=%d, version=%d, path=%" PRId64 "})\n",
+            qid->type, qid->version, qid->path);
+
+    if (p9c_walk(s->client_state, 0, 1, s->nwnames, s->wnames,
+                 p9_walk_cb, s) < 0) {
+        dprintf("Twalk failed\n");
+        s->do_loop = 0;
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int p9_version_cb(void *opaque, int ret, int32_t msize,
+                         const char *version)
+{
+    BDRV9pState *s = opaque;
+
+    if (ret) {
+        dprintf("Rerror: %s\n", strerror(ret));
+        s->do_loop = 0;
+        return -ret;
+
+    }
+
+    s->msize = msize;
+
+    dprintf("Rversion(msize=%d, version=%s)\n", msize, version);
+
+    /* FIXME get username */
+    if (p9c_attach(s->client_state, 0, -1, "anthony", NULL, 200,
+                   p9_attach_cb, s) < 0) {
+        dprintf("Tattach failed\n");
+        s->do_loop = 0;
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int p9dial_outgoing_unix(const char *path)
+{
+    int s;
+    struct sockaddr_un addr;
+
+    s = socket(PF_UNIX, SOCK_STREAM, 0);
+    if (s == -1)
+        return -1;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.sun_family = AF_UNIX;
+    snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", path);
+
+    if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) == -1)
+        goto error;
+
+    return s;
+error:
+    close(s);
+    return -1;
+}
+
+static int p9dial_outgoing_tcp(const char *hostname, const char *service)
+{
+    int s;
+    struct in_addr in;
+    struct sockaddr_in addr;
+    uint16_t port;
+    char *endptr;
+
+    s = socket(PF_INET, SOCK_STREAM, 0);
+    if (s == -1)
+        return -1;
+
+    if (inet_aton(hostname, &in) == 0) {
+        struct hostent *ent;
+
+        ent = gethostbyname(hostname);
+        if (ent == NULL)
+            goto error;
+
+        memcpy(&in, ent->h_addr, sizeof(in));
+    }
+
+    port = strtol(service, &endptr, 10);
+    if (endptr && *endptr) {
+	struct servent *ent;
+
+	ent = getservbyname(service, "tcp");
+	if (ent == NULL)
+	    goto error;
+
+	port = ent->s_port;
+    }
+
+    addr.sin_family = AF_INET;
+    addr.sin_port = htons(port);
+    memcpy(&addr.sin_addr.s_addr, &in, sizeof(in));
+
+    if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) == -1)
+        goto error;
+
+    return s;
+error:
+    close(s);
+    return -1;
+}
+
+static int p9dial(const char *path)
+{
+    int fd = -1;
+    const char *p;
+
+    if (strstart(path, "tcp!", &p)) {
+	char hostname[1024];
+	char *service;
+	size_t len;
+
+	service = strchr(p, '!');
+	if (!service) {
+	    errno = EINVAL;
+	    goto out;
+	}
+
+	len = MIN(sizeof(hostname) - 1, service - p);
+	memcpy(hostname, p, len);
+	hostname[len] = 0;
+
+	fd = p9dial_outgoing_tcp(hostname, service + 1);
+    } else if (strstart(path, "unix!", &p)) {
+	fd = p9dial_outgoing_unix(p);
+    } else
+	errno = EINVAL;
+
+    out:
+    return fd;
+}
+
+static int p9_open(BlockDriverState *bs, const char *filename, int flags)
+{
+    BDRV9pState *s = bs->opaque;
+    const char *p;
+    char *file, *ptr;
+    char host[1024];
+    int len;
+
+    if (!strstart(filename, "9p:", &p))
+        return -EINVAL;
+
+    /* FIXME handle quoting */
+
+    file = strchr(p, ':');
+    if (file == NULL)
+        return -EINVAL;
+
+    snprintf(s->filename, sizeof(s->filename), "%s", file + 1);
+
+    /* FIXME be dynamic */
+
+    s->nwnames = 0;
+    ptr = s->filename;
+    while (ptr && s->nwnames < 256) {
+        s->wnames[s->nwnames++] = ptr;
+        ptr = strchr(ptr, '/');
+        if (ptr) {
+            *ptr = 0;
+            ptr++;
+        }
+    }
+
+    s->count = 0;
+
+    len = MIN(file - p, sizeof(host) - 1);
+    memcpy(host, p, len);
+    host[len] = 0;
+
+    s->fd = p9dial(host);
+
+    socket_set_nonblock(s->fd);
+
+    qemu_aio_set_fd_handler(s->fd, p9_recv_notify, NULL, p9_flush, s);
+
+    /* FIXME better cleanup */
+
+    s->iops.send = p9_send;
+    s->iops.recv = p9_recv;
+    s->iops.set_send_notify = p9_set_send_notify;
+
+    s->client_state = p9c_init(&s->iops);
+    if (s->client_state == NULL) {
+        dprintf("p9c_init failed\n");
+        return -EINVAL;
+    }
+
+    if (p9c_version(s->client_state, p9_version_cb, s) < 0) {
+        dprintf("Tversion failed\n");
+        return -EINVAL;
+    }
+
+    dprintf("Entering wait loop\n");
+    s->do_loop = 1;
+    while (s->do_loop)
+        qemu_aio_wait();
+    dprintf("Left wait loop\n");
+    
+    return 0;
+}
+
+static int p9c_read_cb(void *opaque, int ret, int32_t count, const void *data)
+{
+    P9AIOCB *aiocb = opaque;
+    BDRV9pState *s = aiocb->s;
+
+    s->count--;
+
+    if (ret) {
+        dprintf("Rerror: %s\n", strerror(ret));
+        aiocb->common.cb(aiocb->common.opaque, ret);
+        qemu_aio_release(aiocb);
+        return -ret;
+    }
+
+    memcpy(aiocb->buf, data, count);
+    aiocb->buf += count;
+    aiocb->offset += count;
+    aiocb->size -= count;
+
+    dprintf("Rread(count=%d, data=...)\n", count);
+
+    if (aiocb->size) {
+        s->count++;
+        if (p9c_read(aiocb->s->client_state, 1, aiocb->offset,
+                     MIN(aiocb->size, aiocb->s->msize - 24),
+                     p9c_read_cb, aiocb) < 0) {
+            dprintf("Tread failed\n");
+            return -1;
+        }
+    } else {
+        aiocb->common.cb(aiocb->common.opaque, 0);
+        qemu_aio_release(aiocb);
+    }
+
+    return 0;
+}
+
+static BlockDriverAIOCB *p9_aio_read(BlockDriverState *bs, int64_t sector_num,
+                                     uint8_t *buf, int nb_sectors,
+                                     BlockDriverCompletionFunc *cb,
+                                     void *opaque)
+{
+    BDRV9pState *s = bs->opaque;
+    P9AIOCB *aiocb;
+
+    dprintf("aio_read(sector_num=%" PRId64 ", nb_sectors=%d)\n",
+            sector_num, nb_sectors);
+
+    aiocb = qemu_aio_get(bs, cb, opaque);
+    if (aiocb == NULL)
+        return NULL;
+
+    aiocb->s = s;
+    aiocb->offset = sector_num * 512;
+    aiocb->size = nb_sectors * 512;
+    aiocb->buf = buf;
+
+    s->count++;
+    if (p9c_read(aiocb->s->client_state, 1, aiocb->offset,
+                 MIN(aiocb->size, s->msize - 24),
+                 p9c_read_cb, aiocb) < 0) {
+        dprintf("Tread failed\n");
+        return NULL;
+    }
+
+    return &aiocb->common;
+}
+
+static int p9c_write_cb(void *opaque, int ret, int32_t count)
+{
+    P9AIOCB *aiocb = opaque;
+    BDRV9pState *s = aiocb->s;
+
+    s->count--;
+
+    if (ret) {
+        dprintf("Rerror: %s\n", strerror(ret));
+        aiocb->common.cb(aiocb->common.opaque, ret);
+        qemu_aio_release(aiocb);
+        return -ret;
+    }
+
+    aiocb->buf += count;
+    aiocb->offset += count;
+    aiocb->size -= count;
+
+    dprintf("Rwrite(count=%d)\n", count);
+
+    if (aiocb->size) {
+        s->count++;
+        if (p9c_write(aiocb->s->client_state, 1, aiocb->offset,
+                      MIN(aiocb->size, aiocb->s->msize - 24),
+                      aiocb->buf, p9c_write_cb, aiocb) < 0) {
+            dprintf("Twrite failed\n");
+            return -1;
+        }
+    } else {
+        aiocb->common.cb(aiocb->common.opaque, 0);
+        qemu_aio_release(aiocb);
+    }
+
+    return 0;
+}
+
+static BlockDriverAIOCB *p9_aio_write(BlockDriverState *bs, int64_t sector_num,
+                                      const uint8_t *buf, int nb_sectors,
+                                      BlockDriverCompletionFunc *cb,
+                                      void *opaque)
+{
+    BDRV9pState *s = bs->opaque;
+    P9AIOCB *aiocb;
+
+    dprintf("aio_write(sector_num=%" PRId64 ", nb_sectors=%d)\n",
+            sector_num, nb_sectors);
+
+    aiocb = qemu_aio_get(bs, cb, opaque);
+    if (aiocb == NULL)
+        return NULL;
+
+    aiocb->s = s;
+    aiocb->offset = sector_num * 512;
+    aiocb->size = nb_sectors * 512;
+    aiocb->buf = (void *)buf;
+
+    s->count++;
+    if (p9c_write(aiocb->s->client_state, 1, aiocb->offset,
+                  MIN(aiocb->size, s->msize - 24),
+                  aiocb->buf,
+                  p9c_write_cb, aiocb) < 0) {
+        dprintf("Twrite failed\n");
+        return NULL;
+    }
+
+    return &aiocb->common;
+}
+
+static void p9_close(BlockDriverState *bs)
+{
+    BDRV9pState *s = bs->opaque;
+
+    dprintf("Closing\n");
+
+    /* FIXME should I clunk? */
+    qemu_aio_set_fd_handler(s->fd, NULL, NULL, NULL, NULL);
+    closesocket(s->fd);
+    p9c_free(s->client_state);
+}
+
+static int64_t p9_getlength(BlockDriverState *bs)
+{
+    BDRV9pState *s = bs->opaque;
+    return s->length;
+}
+
+BlockDriver bdrv_9p = {
+    .format_name = "9p",
+    .instance_size = sizeof(BDRV9pState),
+    .bdrv_open = p9_open,
+    .bdrv_aio_read = p9_aio_read,
+    .bdrv_aio_write = p9_aio_write,
+    .aiocb_size = sizeof(P9AIOCB),
+    .bdrv_close = p9_close,
+    .bdrv_getlength = p9_getlength,
+    .protocol_name = "9p",
+};
+
diff --git a/block.c b/block.c
index 7c744c7..7bb4f98 100644
--- a/block.c
+++ b/block.c
@@ -1535,6 +1535,7 @@ void bdrv_init(void)
     bdrv_register(&bdrv_qcow2);
     bdrv_register(&bdrv_parallels);
     bdrv_register(&bdrv_nbd);
+    bdrv_register(&bdrv_9p);
 }
 
 void *qemu_aio_get(BlockDriverState *bs, BlockDriverCompletionFunc *cb,
diff --git a/block.h b/block.h
index e1927dd..bcde8e0 100644
--- a/block.h
+++ b/block.h
@@ -20,6 +20,7 @@ extern BlockDriver bdrv_vvfat;
 extern BlockDriver bdrv_qcow2;
 extern BlockDriver bdrv_parallels;
 extern BlockDriver bdrv_nbd;
+extern BlockDriver bdrv_9p;
 
 typedef struct BlockDriverInfo {
     /* in bytes, 0 if irrelevant */
diff --git a/p9.c b/p9.c
new file mode 100644
index 0000000..4e151a5
--- /dev/null
+++ b/p9.c
@@ -0,0 +1,637 @@
+#include <string.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <stdlib.h>
+
+#include "sys-queue.h"
+
+#include "p9.h"
+
+#define cpu_to_le8(val) (val)
+#define cpu_to_le16(val) (val)
+#define cpu_to_le32(val) (val)
+#define cpu_to_le64(val) (val)
+
+#define BUG() do { abort(); } while (0)
+
+typedef struct _P9PDU
+{
+    P9PDU pdu;
+    TAILQ_ENTRY(_P9PDU) node;
+} _P9PDU;
+
+struct P9State
+{
+    int32_t msize;
+
+    size_t active_tx_offset;
+    P9PDU *active_tx;
+    TAILQ_HEAD(, _P9PDU) tx_queue;
+
+    P9PDU *active_rx;
+
+    P9IOState *iops;
+    P9PDUState *pduops;
+};
+
+static size_t pdu_read(P9PDU *pdu, void *data, size_t size)
+{
+    size_t len = MIN(pdu->size - pdu->offset, size);
+    memcpy(data, &pdu->buffer[pdu->offset], len);
+    pdu->offset += len;
+    return size - len;
+}
+
+static size_t pdu_write(P9PDU *pdu, const void *data, size_t size)
+{
+    size_t len = MIN(pdu->capacity - pdu->size, size);
+    memcpy(&pdu->buffer[pdu->size], data, len);
+    pdu->size += len;
+    return size - len;
+}
+
+/* b - int8_t
+   w - int16_t
+   d - int32_t
+   q - int64_t
+   s - string
+   S - stat
+   Q - qid
+   D - data blob (int32_t size followed by void *, the results are not freed)
+   T - array of strings (int16_t count, followed by strings)
+   R - array of qids (int16_t count, followed by qids)
+   ? - if optional = 1, continue parsing
+*/
+
+int p9pdu_vreadf(P9PDU *pdu, int optional, const char *fmt, va_list ap)
+{
+    const char *ptr;
+    int errcode = 0;
+
+    for (ptr = fmt; *ptr; ptr++) {
+        switch (*ptr) {
+        case 'b': {
+            int8_t *val = va_arg(ap, int8_t *);
+            if (pdu_read(pdu, val, sizeof(*val))) {
+                errcode = -EFAULT;
+                break;
+            }
+            *val = cpu_to_le8(*val);
+        }   break;
+        case 'w': {
+            int16_t *val = va_arg(ap, int16_t *);
+            if (pdu_read(pdu, val, sizeof(*val))) {
+                errcode = -EFAULT;
+                break;
+            }
+            *val = cpu_to_le16(*val);
+        }   break;
+        case 'd': {
+            int32_t *val = va_arg(ap, int32_t *);
+            if (pdu_read(pdu, val, sizeof(*val))) {
+                errcode = -EFAULT;
+                break;
+            }
+            *val = cpu_to_le32(*val);
+        }   break;
+        case 'q': {
+            int64_t *val = va_arg(ap, int64_t *);
+            if (pdu_read(pdu, val, sizeof(*val))) {
+                errcode = -EFAULT;
+                break;
+            }
+            *val = cpu_to_le64(*val);
+        }   break;
+        case 's': {
+            char **ptr = va_arg(ap, char **);
+            int16_t len;
+            int size;
+
+            errcode = p9pdu_readf(pdu, optional, "w", &len);
+            if (errcode)
+                break;
+
+            size = MAX(len, 0);
+
+            *ptr = malloc(size + 1);
+            if (*ptr == NULL) {
+                errcode = -EFAULT;
+                break;
+            }
+            if (pdu_read(pdu, *ptr, size)) {
+                errcode = -EFAULT;
+                free(*ptr);
+                *ptr = NULL;
+            } else
+                (*ptr)[size] = 0;
+        }   break;
+        case 'Q': {
+            P9QID *qid = va_arg(ap, P9QID *);
+
+            errcode = p9pdu_readf(pdu, optional, "bdq",
+                                  &qid->type, &qid->version, &qid->path);
+        }   break;
+        case 'S': {
+            P9Stat *stbuf = va_arg(ap, P9Stat *);
+
+            stbuf->extension = NULL;
+            stbuf->n_uid = stbuf->n_gid = stbuf->n_muid = -1;
+
+            errcode = p9pdu_readf(pdu, optional, "wwdQdddqssss?sddd",
+                                  &stbuf->size, &stbuf->type,
+                                  &stbuf->dev, &stbuf->qid,
+                                  &stbuf->mode, &stbuf->atime,
+                                  &stbuf->mtime, &stbuf->length,
+                                  &stbuf->name, &stbuf->uid,
+                                  &stbuf->gid, &stbuf->muid,
+                                  &stbuf->extension, &stbuf->n_uid,
+                                  &stbuf->n_gid, &stbuf->n_muid);
+            if (errcode)
+                p9stat_free(stbuf);
+        }   break;
+        case 'D': {
+            int32_t *count = va_arg(ap, int32_t *);
+            void **data = va_arg(ap, void **);
+
+            errcode = p9pdu_readf(pdu, optional, "d", count);
+            if (!errcode) {
+                *count = MIN(*count, pdu->size - pdu->offset);
+                *data = &pdu->buffer[pdu->offset];
+            }
+        }   break;
+        case 'T': {
+            int16_t *nwname = va_arg(ap, int16_t *);
+            char ***wnames = va_arg(ap, char ***);
+
+            errcode = p9pdu_readf(pdu, optional, "w", nwname);
+            if (!errcode) {
+                *wnames = malloc(sizeof(char *) * *nwname);
+                if (!*wnames)
+                    errcode = -ENOMEM;
+            }
+
+            if (!errcode) {
+                int i;
+
+                for (i = 0; i < *nwname; i++) {
+                    errcode = p9pdu_readf(pdu, optional, "s", &(*wnames)[i]);
+                    if (errcode)
+                        break;
+                }
+            }
+
+            if (errcode) {
+                if (*wnames) {
+                    int i;
+
+                    for (i = 0 ; i < *nwname; i++)
+                        free((*wnames)[i]);
+                }
+                free(*wnames);
+                *wnames = NULL;
+            }
+        }   break;
+        case 'R': {
+            int16_t *nwqid = va_arg(ap, int16_t *);
+            P9QID **wqids = va_arg(ap, P9QID **);
+
+            *wqids = NULL;
+
+            errcode = p9pdu_readf(pdu, optional, "w", nwqid);
+            if (!errcode) {
+                *wqids = malloc(*nwqid * sizeof(P9QID));
+                if (*wqids == NULL)
+                    errcode = -ENOMEM;
+            }
+
+            if (!errcode) {
+                int i;
+
+                for (i = 0; i < *nwqid; i++) {
+                    errcode = p9pdu_readf(pdu, optional, "Q", &(*wqids)[i]);
+                    if (errcode)
+                        break;
+                }
+            }
+
+            if (errcode) {
+                free(*wqids);
+                *wqids = NULL;
+            }
+        }   break;
+        case '?':
+            if (!optional)
+                return 0;
+            break;
+        default:
+            BUG();
+            break;
+        }
+
+        if (errcode)
+            break;
+    }
+
+    return errcode;
+}
+
+int p9pdu_vwritef(P9PDU *pdu, int optional, const char *fmt, va_list ap)
+{
+    const char *ptr;
+    int errcode = 0;
+
+    for (ptr = fmt; *ptr; ptr++) {
+        switch (*ptr) {
+        case 'b': {
+            int8_t val = va_arg(ap, int);
+            if (pdu_write(pdu, &val, sizeof(val)))
+                errcode = -EFAULT;
+        }   break;
+        case 'w': {
+            int16_t val = va_arg(ap, int);
+            if (pdu_write(pdu, &val, sizeof(val)))
+                errcode = -EFAULT;
+        }   break;
+        case 'd': {
+            int32_t val = va_arg(ap, int32_t);
+            if (pdu_write(pdu, &val, sizeof(val)))
+                errcode = -EFAULT;
+        }   break;
+        case 'q': {
+            int64_t val = va_arg(ap, int64_t);
+            if (pdu_write(pdu, &val, sizeof(val)))
+                errcode = -EFAULT;
+        }   break;
+        case 's': {
+            const char *ptr = va_arg(ap, const char *);
+            int16_t len = 0;
+
+            if (ptr)
+                len = MIN(strlen(ptr), INT16_MAX);
+
+            errcode = p9pdu_writef(pdu, optional, "w", len);
+            if (!errcode && pdu_write(pdu, ptr, len))
+                errcode = -EFAULT;
+        }   break;
+        case 'Q': {
+            const P9QID *qid = va_arg(ap, const P9QID *);
+            errcode = p9pdu_writef(pdu, optional, "bdq",
+                                   qid->type, qid->version, qid->path);
+        }   break;
+        case 'S': {
+            const P9Stat *stbuf = va_arg(ap, const P9Stat *);
+            errcode = p9pdu_writef(pdu, optional, "wwdQdddqssss?sddd",
+                                   stbuf->size, stbuf->type,
+                                   stbuf->dev, stbuf->qid,
+                                   stbuf->mode, stbuf->atime,
+                                   stbuf->mtime, stbuf->length,
+                                   stbuf->name, stbuf->uid,
+                                   stbuf->gid, stbuf->muid,
+                                   stbuf->extension, stbuf->n_uid,
+                                   stbuf->n_gid, stbuf->n_muid);
+        }   break;
+        case 'D': {
+            int32_t count = va_arg(ap, int32_t);
+            const void *data = va_arg(ap, const void *);
+
+            errcode = p9pdu_writef(pdu, optional, "d", count);
+            if (!errcode && pdu_write(pdu, data, count))
+                errcode = -EFAULT;
+        }   break;
+        case 'T': {
+            int16_t nwname = va_arg(ap, int);
+            const char **wnames = va_arg(ap, const char **);
+
+            errcode = p9pdu_writef(pdu, optional, "w", nwname);
+            if (!errcode) {
+                int i;
+
+                for (i = 0; i < nwname; i++) {
+                    errcode = p9pdu_writef(pdu, optional, "s", wnames[i]);
+                    if (errcode)
+                        break;
+                }
+            }
+        }   break;
+        case 'R': {
+            int16_t nwqid = va_arg(ap, int);
+            P9QID *wqids = va_arg(ap, P9QID *);
+
+            errcode = p9pdu_writef(pdu, optional, "w", nwqid);
+            if (!errcode) {
+                int i;
+
+                for (i = 0; i < nwqid; i++) {
+                    errcode = p9pdu_writef(pdu, optional, "Q", &wqids[i]);
+                    if (errcode)
+                        break;
+                }
+            }
+        }   break;
+        case '?':
+            if (!optional)
+                return 0;
+            break;
+        default:
+            BUG();
+            break;
+        }
+
+        if (errcode)
+            break;
+    }
+
+    return errcode;
+}
+
+int p9pdu_readf(P9PDU *pdu, int optional, const char *fmt, ...)
+{
+    va_list ap;
+    int ret;
+
+    va_start(ap, fmt);
+    ret = p9pdu_vreadf(pdu, optional, fmt, ap);
+    va_end(ap);
+
+    return ret;
+}
+
+int p9pdu_writef(P9PDU *pdu, int optional, const char *fmt, ...)
+{
+    va_list ap;
+    int ret;
+
+    va_start(ap, fmt);
+    ret = p9pdu_vwritef(pdu, optional, fmt, ap);
+    va_end(ap);
+
+    return ret;
+}
+
+void p9stat_free(P9Stat *stbuf)
+{
+    free(stbuf->name);
+    free(stbuf->uid);
+    free(stbuf->gid);
+    free(stbuf->muid);
+    free(stbuf->extension);
+}
+
+static P9PDU *p9pdu_get(P9State *s)
+{
+    _P9PDU *pdu;
+
+    pdu = malloc(sizeof(*pdu) + s->msize);
+    if (pdu == NULL)
+        return NULL;
+
+    pdu->pdu.offset = 0;
+    pdu->pdu.size = 0;
+    pdu->pdu.capacity = s->msize;
+    pdu->pdu.buffer = (uint8_t *)pdu + sizeof(*pdu);
+
+    return &pdu->pdu;
+}
+
+static void p9pdu_put(P9State *s, P9PDU *pdu)
+{
+    _P9PDU *_pdu = container_of(pdu, _P9PDU, pdu);
+    free(_pdu);
+}
+
+#include <stdio.h>
+
+static int p9_try_to_tx(P9State *s)
+{
+    ssize_t ret;
+
+    do {
+        P9PDU *pdu;
+        size_t len;
+
+        if (!s->active_tx) {
+            _P9PDU *_pdu;
+
+            if (TAILQ_EMPTY(&s->tx_queue))
+                break;
+
+            _pdu = TAILQ_FIRST(&s->tx_queue);
+            TAILQ_REMOVE(&s->tx_queue, _pdu, node);
+            s->active_tx_offset = 0;
+            s->active_tx = &_pdu->pdu;
+        }
+
+        pdu = s->active_tx;
+
+        len = pdu->size - s->active_tx_offset;
+
+        ret = s->iops->send(s->iops, pdu->buffer + s->active_tx_offset, len);
+        if (ret == -1) {
+            if (errno == EINTR)
+                continue;
+            if (errno == EAGAIN) {
+                s->iops->set_send_notify(s->iops, 1);
+                break;
+            }
+            return -errno;
+        } else if (ret == 0)
+            return -EPIPE;
+
+        s->active_tx_offset += ret;
+        if (s->active_tx_offset == pdu->size) {
+            p9pdu_put(s, pdu);
+            s->active_tx = NULL;
+            s->active_tx_offset = 0;
+        }
+    } while (ret > 0);
+
+    return 0;
+}
+
+int p9_notify_can_send(P9State *s)
+{
+    s->iops->set_send_notify(s->iops, 0);
+
+    return p9_try_to_tx(s);
+}
+
+int p9_notify_can_recv(P9State *s)
+{
+    P9PDU *rx;
+    int ret;
+
+    while (1) {
+        int32_t size;
+
+        if (s->active_rx == NULL)
+            s->active_rx = p9pdu_get(s);
+
+        rx = s->active_rx;
+
+        while (rx->size < 7) {
+            ssize_t len;
+
+            len = s->iops->recv(s->iops, rx->buffer + rx->size, 7 - rx->size);
+            if (len == -1 && errno == EINTR)
+                continue;
+            else if (len == -1 && errno == EAGAIN)
+                return 0;
+            else if (len == 0) {
+                ret = -EPIPE;
+                goto err;
+            } else if (len == -1) {
+                ret = -errno;
+                goto err;
+            }
+
+            rx->size += len;
+        }
+
+        memcpy(&size, rx->buffer, 4);
+        size = cpu_to_le32(size);
+        if (size < 0 || size < 7) {
+            ret = -EFAULT;
+            goto err;
+        }
+
+        /* Our packet size is greater than msize, FIXME we should drain this
+         * many bytes from the socket in order to allow us to continue */
+        if (size > rx->capacity) {
+            ret = -EFAULT;
+            goto err;
+        }
+    
+        while (rx->size < size) {
+            ssize_t len;
+            
+            len = s->iops->recv(s->iops, rx->buffer + rx->size, size - rx->size);
+            if (len == -1 && errno == EINTR)
+                continue;
+            else if (len == -1 && errno == EAGAIN)
+                return 0;
+            else if (len == 0) {
+                ret = -EPIPE;
+                goto err;
+            } else if (len == -1) {
+                ret = -errno;
+                goto err;
+            }
+
+            rx->size += len;
+        }
+
+        ret = s->pduops->dispatch_pdu(s->pduops, rx);
+        if (ret)
+            goto err;
+
+        p9pdu_put(s, rx);
+        s->active_rx = NULL;
+    }
+
+    return 0;
+
+err:
+    p9pdu_put(s, rx);
+    s->active_rx = NULL;
+    return ret;
+}
+
+int p9_set_msize(P9State *s, int32_t msize)
+{
+    if (msize < 7)
+        return -EINVAL;
+
+    s->msize = msize;
+
+    return 0;
+}
+
+int p9_send_pdu(P9State *s, P9PDU *pdu)
+{
+    _P9PDU *_pdu = container_of(pdu, _P9PDU, pdu);
+
+    TAILQ_INSERT_TAIL(&s->tx_queue, _pdu, node);
+
+    return p9_try_to_tx(s);
+}
+
+int p9_send_vpduf(P9State *s, int optional, int16_t tag, int8_t type, const char *fmt, va_list ap)
+{
+    P9PDU *pdu;
+    int32_t size;
+    int errcode;
+
+    pdu = p9pdu_get(s);
+    if (pdu == NULL)
+        return -ENOMEM;
+
+    pdu->size = 7;
+    errcode = p9pdu_vwritef(pdu, optional, fmt, ap);
+
+    if (errcode) {
+        p9pdu_put(s, pdu);
+        return errcode;
+    }
+
+    /* FIXME endianness */
+    size = pdu->size;
+    memcpy(pdu->buffer + 0, &size, 4);
+    pdu->buffer[4] = type;
+    memcpy(pdu->buffer + 5, &tag, 2);
+
+    return p9_send_pdu(s, pdu);
+}
+
+int p9_send_pduf(P9State *s, int optional, int16_t tag, int8_t type, const char *fmt, ...)
+{
+    int errcode;
+    va_list ap;
+
+    va_start(ap, fmt);
+    errcode = p9_send_vpduf(s, optional, tag, type, fmt, ap);
+    va_end(ap);
+
+    return errcode;
+}
+
+P9State *p9_init(P9IOState *iops, P9PDUState *pduops)
+{
+    P9State *s;
+
+    s = malloc(sizeof(*s));
+    if (s == NULL)
+        return NULL;
+
+    s->msize = 4096;
+
+    s->active_tx_offset = 0;
+    s->active_tx = NULL;
+    TAILQ_INIT(&s->tx_queue);
+
+    s->active_rx = NULL;
+
+    s->iops = iops;
+    s->pduops = pduops;
+
+    return s;
+}
+
+void p9_free(P9State *s)
+{
+    if (s->active_rx)
+        p9pdu_put(s, s->active_rx);
+    if (s->active_tx)
+        p9pdu_put(s, s->active_tx);
+
+    while (!TAILQ_EMPTY(&s->tx_queue)) {
+        _P9PDU *_pdu;
+
+        _pdu = TAILQ_FIRST(&s->tx_queue);
+        TAILQ_REMOVE(&s->tx_queue, _pdu, node);
+        p9pdu_put(s, &_pdu->pdu);
+    }
+
+    free(s);
+}
diff --git a/p9.h b/p9.h
new file mode 100644
index 0000000..f63e424
--- /dev/null
+++ b/p9.h
@@ -0,0 +1,163 @@
+/*
+ * 9p client library
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef LIBP9_H
+#define LIBP9_H
+
+#include <sys/types.h>
+#include <inttypes.h>
+#include <stdarg.h>
+
+#include "sys-queue.h"
+
+#ifndef MIN
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
+
+#ifndef MAX
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
+#endif
+
+#ifndef offset_of
+#define offset_of(type, memb) \
+    ((unsigned long)(&((type *)0)->memb))
+#endif
+#ifndef container_of
+#define container_of(obj, type, memb) \
+    ((type *)(((char *)obj) - offset_of(type, memb)))
+#endif
+
+#define P9_VERSION	100
+#define P9_AUTH		102
+#define P9_ATTACH	104
+#define P9_ERROR	106
+#define P9_FLUSH	108
+#define P9_WALK		110
+#define P9_OPEN		112
+#define P9_CREATE	114
+#define P9_READ		116
+#define P9_WRITE	118
+#define P9_CLUNK	120
+#define P9_REMOVE	122
+#define P9_STAT		124
+#define P9_WSTAT	126
+
+#define P9_O_READ	0x00
+#define P9_O_WRITE	0x01
+#define P9_O_RDWR	0x02
+#define P9_O_EXEC	0x03
+#define P9_O_EXCL	0x04
+#define P9_O_TRUNC	0x10
+#define P9_O_REXEC	0x20
+#define P9_O_RCLOSE	0x40
+#define P9_O_APPEND	0x80
+
+#define P9_STAT_MODE_DIR	0x80000000
+#define P9_STAT_MODE_APPEND	0x40000000
+#define P9_STAT_MODE_EXCL	0x20000000
+#define P9_STAT_MODE_MOUNT	0x10000000
+#define P9_STAT_MODE_AUTH	0x08000000
+#define P9_STAT_MODE_TMP	0x04000000
+#define P9_STAT_MODE_SYMLINK	0x02000000
+#define P9_STAT_MODE_LINK	0x01000000
+#define P9_STAT_MODE_DEVICE	0x00800000
+#define P9_STAT_MODE_NAMED_PIPE	0x00200000
+#define P9_STAT_MODE_SOCKET	0x00100000
+#define P9_STAT_MODE_SETUID	0x00080000
+#define P9_STAT_MODE_SETGID	0x00040000
+#define P9_STAT_MODE_SETVTX	0x00010000
+
+#define P9_STAT_MODE_SPECIAL	(P9_STAT_MODE_NAMED_PIPE | \
+				 P9_STAT_MODE_SYMLINK | \
+				 P9_STAT_MODE_LINK | \
+				 P9_STAT_MODE_DEVICE)
+
+
+#define P9_QID_TYPE_DIR		0x80
+#define P9_QID_TYPE_SYMLINK	0x02
+
+typedef struct P9PDU
+{
+    size_t offset;
+    size_t size;
+    size_t capacity;
+    uint8_t *buffer;
+} P9PDU;
+
+typedef struct P9QID
+{
+    int8_t type;
+    int32_t version;
+    int64_t path;
+} P9QID;
+
+typedef struct P9Stat
+{
+    int16_t size;
+    int16_t type;
+    int32_t dev;
+    P9QID qid;
+    int32_t mode;
+    int32_t atime;
+    int32_t mtime;
+    int64_t length;
+    char *name;
+    char *uid;
+    char *gid;
+    char *muid;
+    char *extension;
+    int32_t n_uid;
+    int32_t n_gid;
+    int32_t n_muid;
+} P9Stat;
+
+typedef struct P9State P9State;
+
+typedef struct P9IOState P9IOState;
+
+struct P9IOState
+{
+    /* IO helpers */
+    ssize_t (*send)(P9IOState *s, const void *data, size_t size);
+    ssize_t (*recv)(P9IOState *s, void *data, size_t size);
+    void (*set_send_notify)(P9IOState *s, int enable);
+};
+
+typedef struct P9PDUState P9PDUState;
+
+struct P9PDUState
+{
+    int (*dispatch_pdu)(P9PDUState *s, P9PDU *pdu);
+};
+
+P9State *p9_init(P9IOState *iops, P9PDUState *pduops);
+
+void p9_free(P9State *s);
+
+int p9_set_msize(P9State *s, int32_t msize);
+
+int p9_send_vpduf(P9State *s, int optional, int16_t tag, int8_t type, const char *fmt, va_list ap);
+int p9_send_pduf(P9State *s, int optional, int16_t tag, int8_t type, const char *fmt, ...);
+
+int p9_notify_can_send(P9State *s);
+int p9_notify_can_recv(P9State *s);
+
+int p9pdu_vreadf(P9PDU *pdu, int optional, const char *fmt, va_list ap);
+int p9pdu_vwritef(P9PDU *pdu, int optional, const char *fmt, va_list ap);
+
+int p9pdu_readf(P9PDU *pdu, int optional, const char *fmt, ...);
+int p9pdu_writef(P9PDU *pdu, int optional, const char *fmt, ...);
+
+void p9stat_free(P9Stat *stbuf);
+
+#endif
diff --git a/p9c.c b/p9c.c
new file mode 100644
index 0000000..3e4d8be
--- /dev/null
+++ b/p9c.c
@@ -0,0 +1,437 @@
+/*
+ * 9p client library
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <string.h>
+#include <errno.h>
+#include <malloc.h>
+#include <stdbool.h>
+
+#include "p9c.h"
+#include "sys-queue.h"
+
+#define P9_MSIZE	(64 << 10)
+
+typedef struct P9Tag {
+    int8_t type;
+    int16_t tag;
+    union {
+        P9VersionFunc *version;
+        P9AuthFunc *auth;
+        P9AttachFunc *attach;
+        P9WalkFunc *walk;
+        P9OpenFunc *open;
+        P9CreateFunc *create;
+        P9StatFunc *stat;
+        P9WStatFunc *wstat;
+        P9WriteFunc *write;
+        P9ReadFunc *read;
+        P9FlushFunc *flush;
+        P9ClunkFunc *clunk;
+        void *generic;
+    } cb;
+    void *opaque;
+    TAILQ_ENTRY(P9Tag) node;
+} P9Tag;
+
+struct P9ClientState
+{
+    P9State *p9_state;
+    P9PDUState pdu_state;
+
+    bool dotu;
+
+    int max_tag;
+
+    TAILQ_HEAD(, P9Tag) inflight_requests;
+    TAILQ_HEAD(, P9Tag) tag_pool;
+};
+
+static P9Tag *p9c_alloc_tag(P9ClientState *s, int8_t type, void *cb, void *opaque)
+{
+    P9Tag *tag;
+
+    if (TAILQ_EMPTY(&s->tag_pool)) {
+        tag = malloc(sizeof(*tag));
+        if (tag == NULL)
+            return NULL;
+
+        if (s->max_tag == (1 << 16))
+            return NULL;
+
+        tag->tag = s->max_tag++;
+    } else {
+        tag = TAILQ_FIRST(&s->tag_pool);
+        TAILQ_REMOVE(&s->tag_pool, tag, node);
+    }
+
+    tag->type = type;
+    tag->cb.generic = cb;
+    tag->opaque = opaque;
+
+    return tag;
+}
+
+static P9Tag *p9c_find_tag(P9ClientState *s, int16_t tag)
+{
+    P9Tag *i;
+
+    TAILQ_FOREACH(i, &s->inflight_requests, node) {
+        if (i->tag == tag)
+            break;
+    }
+
+    if (i)
+        TAILQ_REMOVE(&s->inflight_requests, i, node);
+
+    return i;
+}
+
+static void p9c_dispatch_error(P9Tag *tag, const char *ename, int32_t ecode)
+{
+    switch (tag->type) {
+    case P9_VERSION:
+        tag->cb.version(tag->opaque, ecode, 0, NULL);
+        break;
+    case P9_AUTH:
+        tag->cb.auth(tag->opaque, ecode, NULL);
+        break;
+    case P9_ATTACH:
+        tag->cb.attach(tag->opaque, ecode, NULL);
+        break;
+    case P9_WALK:
+        tag->cb.walk(tag->opaque, ecode, 0, NULL);
+        break;
+    case P9_OPEN:
+        tag->cb.open(tag->opaque, ecode, NULL, 0);
+        break;
+    case P9_CREATE:
+        tag->cb.create(tag->opaque, ecode, NULL, 0);
+        break;
+    case P9_STAT:
+        tag->cb.stat(tag->opaque, ecode, NULL);
+        break;
+    case P9_WSTAT:
+        tag->cb.wstat(tag->opaque, ecode);
+        break;
+    case P9_WRITE:
+        tag->cb.write(tag->opaque, ecode, 0);
+        break;
+    case P9_READ:
+        tag->cb.read(tag->opaque, ecode, 0, NULL);
+        break;
+    case P9_FLUSH:
+        tag->cb.flush(tag->opaque, ecode);
+        break;
+    case P9_CLUNK:
+        tag->cb.clunk(tag->opaque, ecode);
+        break;
+    }
+}
+
+static int p9c_dispatch_pdu(P9PDUState *pdu_state, P9PDU *pdu)
+{
+    P9ClientState *s = container_of(pdu_state, P9ClientState, pdu_state);
+    int32_t size;
+    int8_t type;
+    int16_t ntag;
+    P9Tag *tag;
+    int errcode;
+
+    errcode = p9pdu_readf(pdu, s->dotu, "dbw", &size, &type, &ntag);
+    if (errcode)
+        return errcode;
+
+    tag = p9c_find_tag(s, ntag);
+    if (tag == NULL)
+        return -EFAULT;
+
+    switch (type - 1) {
+    case P9_VERSION: {
+        int32_t msize;
+        char *version = NULL;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "ds", &msize, &version);
+        if (!errcode) {
+            if (strcmp(version, "9P2000.u") == 0)
+                s->dotu = true;
+            else if (strcmp(version, "9P2000") == 0)
+                s->dotu = false;
+            else
+                errcode = -EINVAL;
+        }
+
+        if (!errcode) {
+            if (msize > 24)
+                errcode = p9_set_msize(s->p9_state, msize);
+            else
+                errcode = -EFAULT;
+        }
+
+        if (!errcode)
+            errcode = tag->cb.version(tag->opaque, 0, msize, version);
+
+        free(version);
+    }   break;
+    case P9_AUTH: {
+        P9QID qid;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "Q", &qid);
+        if (!errcode)
+            errcode = tag->cb.auth(tag->opaque, 0, &qid);
+    }   break;
+    case P9_ATTACH: {
+        P9QID qid;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "Q", &qid);
+        if (!errcode)
+            errcode = tag->cb.attach(tag->opaque, 0, &qid);
+    }   break;
+    case P9_WALK: {
+        P9QID *wqids = NULL;
+        int16_t nwqid;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "R", &nwqid, &wqids);
+        if (!errcode)
+            errcode = tag->cb.walk(tag->opaque, 0, nwqid, wqids);
+
+        free(wqids);
+    }   break;
+    case P9_OPEN: {
+        P9QID qid;
+        int32_t iounit;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "Qd", &qid, &iounit);
+        if (!errcode)
+            errcode = tag->cb.open(tag->opaque, 0, &qid, iounit);
+    }   break;
+    case P9_CREATE: {
+        P9QID qid;
+        int32_t iounit;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "Qd", &qid, &iounit);
+        if (!errcode)
+            errcode = tag->cb.create(tag->opaque, 0, &qid, iounit);
+    }   break;
+    case P9_STAT: {
+        P9Stat stbuf;
+
+        memset(&stbuf, 0, sizeof(stbuf));
+
+        errcode = p9pdu_readf(pdu, s->dotu, "S", &stbuf);
+        if (!errcode)
+            errcode = tag->cb.stat(tag->opaque, 0, &stbuf);
+
+        p9stat_free(&stbuf);
+    }   break;
+    case P9_WSTAT:
+        tag->cb.wstat(tag->opaque, 0);
+        break;
+    case P9_WRITE: {
+        int32_t count;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "d", &count);
+        if (!errcode)
+            errcode = tag->cb.write(tag->opaque, 0, count);
+    }   break;
+    case P9_READ: {
+        int32_t count;
+        const void *data = NULL;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "D", &count, &data);
+        if (!errcode)
+            errcode = tag->cb.read(tag->opaque, 0, count, data);
+    }   break;
+    case P9_FLUSH:
+        tag->cb.flush(tag->opaque, 0);
+        break;
+    case P9_CLUNK:
+        tag->cb.clunk(tag->opaque, 0);
+        break;
+    case P9_ERROR: {
+        char *ename = NULL;
+        int32_t ecode = -1;
+
+        errcode = p9pdu_readf(pdu, s->dotu, "s?d", &ename, &ecode);
+        if (!errcode)
+            p9c_dispatch_error(tag, ename, ecode);
+
+        free(ename);
+    }   break;
+    default:
+        break;
+    }
+
+    TAILQ_INSERT_HEAD(&s->tag_pool, tag, node);
+
+    return errcode;
+}
+
+void p9c_notify_can_recv(P9ClientState *s)
+{
+    p9_notify_can_recv(s->p9_state);
+}
+
+void p9c_notify_can_send(P9ClientState *s)
+{
+    p9_notify_can_send(s->p9_state);
+}
+
+P9ClientState *p9c_init(P9IOState *iops)
+{
+    P9ClientState *s;
+
+    s = malloc(sizeof(*s));
+    if (s == NULL)
+        return NULL;
+
+    s->pdu_state.dispatch_pdu = p9c_dispatch_pdu;
+    s->p9_state = p9_init(iops, &s->pdu_state);
+    if (s->p9_state == NULL) {
+        free(s);
+        return NULL;
+    }
+
+    s->dotu = false;
+    s->max_tag = 0;
+
+    TAILQ_INIT(&s->inflight_requests);
+    TAILQ_INIT(&s->tag_pool);
+
+    return s;
+}
+
+void p9c_free(P9ClientState *s)
+{
+    p9_free(s->p9_state);
+
+    while (!TAILQ_EMPTY(&s->inflight_requests)) {
+        P9Tag *node;
+        node = TAILQ_FIRST(&s->inflight_requests);
+        TAILQ_REMOVE(&s->inflight_requests, node, node);
+        p9c_dispatch_error(node, "Interrupted", EINTR);
+        free(node);
+    }
+
+    while (!TAILQ_EMPTY(&s->tag_pool)) {
+        P9Tag *node;
+        node = TAILQ_FIRST(&s->tag_pool);
+        TAILQ_REMOVE(&s->tag_pool, node, node);
+        free(node);
+    }
+
+    free(s);
+}
+
+static int p9c_send_pduf(P9ClientState *s, int8_t type,
+                         void *cb, void *opaque,
+                         const char *fmt, ...)
+{
+    P9Tag *tag;
+    int errcode;
+    va_list ap;
+
+    tag = p9c_alloc_tag(s, type, cb, opaque);
+    if (tag == NULL)
+        return -ENOMEM;
+
+    va_start(ap, fmt);
+    errcode = p9_send_vpduf(s->p9_state, s->dotu, tag->tag, type, fmt, ap);
+    va_end(ap);
+
+    if (errcode)
+        TAILQ_INSERT_HEAD(&s->tag_pool, tag, node);
+    else
+        TAILQ_INSERT_HEAD(&s->inflight_requests, tag, node);
+
+    return errcode;
+}
+
+int p9c_version(P9ClientState *s, P9VersionFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_VERSION, cb, opaque,
+                         "ds", P9_MSIZE, "9P2000.u");
+}
+
+int p9c_auth(P9ClientState *s, int32_t afid, const char *uname,
+             const char *aname, int32_t n_uname, P9AuthFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_AUTH, cb, opaque,
+                         "dss?d", afid, uname, aname, n_uname);
+}
+
+int p9c_attach(P9ClientState *s, int32_t fid, int32_t afid,
+               const char *uname, const char *aname, int32_t n_uname,
+               P9AttachFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_ATTACH, cb, opaque,
+                         "ddss?d", fid, afid, uname, aname, n_uname);
+}
+
+int p9c_walk(P9ClientState *s, int32_t fid, int32_t newfid,
+             int16_t nwname, const char **wnames,
+             P9WalkFunc *cb, void *opaque)
+{
+    return  p9c_send_pduf(s, P9_WALK, cb, opaque, 
+                          "ddT", fid, newfid, nwname, wnames);
+}
+
+int p9c_open(P9ClientState *s, int32_t fid, int8_t mode,
+             P9OpenFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_OPEN, cb, opaque,
+                         "db", fid, mode);
+}
+
+int p9c_create(P9ClientState *s, int32_t fid, const char *name, int32_t perm,
+               int8_t mode, const char *extension, P9OpenFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_CREATE, cb, opaque,
+                         "dsdb?s", fid, name, perm, mode, extension);
+}
+
+int p9c_stat(P9ClientState *s, int32_t fid, P9StatFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_STAT, cb, opaque, "d", fid);
+}
+
+int p9c_wstat(P9ClientState *s, int32_t fid, const P9Stat *stbuf,
+              P9StatFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_WSTAT, cb, opaque,
+                         "dwS", fid, 0, stbuf);
+}
+
+int p9c_write(P9ClientState *s, int32_t fid, int64_t offset,
+              int32_t count, const void *data,
+              P9WriteFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_WRITE, cb, opaque,
+                         "dqD", fid, offset, count, data);
+}
+
+int p9c_read(P9ClientState *s, int32_t fid, int64_t offset,
+             int32_t count, P9ReadFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_READ, cb, opaque,
+                         "dqd", fid, offset, count);
+}
+
+int p9c_flush(P9ClientState *s, int16_t oldtag, P9FlushFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_FLUSH, cb, opaque, "d", oldtag);
+}
+
+int p9c_clunk(P9ClientState *s, int32_t fid, P9ClunkFunc *cb, void *opaque)
+{
+    return p9c_send_pduf(s, P9_CLUNK, cb, opaque, "d", fid);
+}
diff --git a/p9c.h b/p9c.h
new file mode 100644
index 0000000..32a805f
--- /dev/null
+++ b/p9c.h
@@ -0,0 +1,81 @@
+/*
+ * 9p client library
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef P9C_H
+#define P9C_H
+
+#include "p9.h"
+
+typedef struct P9ClientState P9ClientState;
+
+typedef int (P9VersionFunc)(void *opaque, int ret, int32_t msize,
+                            const char *version);
+typedef int (P9AuthFunc)(void *opaque, int ret, const P9QID *qid);
+typedef int (P9AttachFunc)(void *opaque, int ret, const P9QID *qid);
+typedef int (P9WalkFunc)(void *opaque, int ret, int16_t nwqid,
+                         const P9QID *wqids);
+typedef int (P9OpenFunc)(void *opaque, int ret, const P9QID *qid,
+                         int32_t iounit);
+typedef int (P9CreateFunc)(void *opaque, int ret, const P9QID *qid,
+                           int32_t iounit);
+typedef int (P9StatFunc)(void *opaque, int ret, const P9Stat *stbuf);
+typedef int (P9WStatFunc)(void *opaque, int ret);
+typedef int (P9WriteFunc)(void *opaque, int ret, int32_t count);
+typedef int (P9ReadFunc)(void *opaque, int ret, int32_t count,
+                         const void *data);
+typedef int (P9FlushFunc)(void *opaque, int ret);
+typedef int (P9ClunkFunc)(void *opaque, int ret);
+
+P9ClientState *p9c_init(P9IOState *ops);
+
+void p9c_notify_can_send(P9ClientState *s);
+
+void p9c_notify_can_recv(P9ClientState *s);
+
+void p9c_free(P9ClientState *s);
+
+/* client messages */
+
+int p9c_version(P9ClientState *s, P9VersionFunc *cb, void *opaque);
+
+int p9c_auth(P9ClientState *s, int32_t afid, const char *uname,
+             const char *aname, int32_t n_uname, P9AuthFunc *cb, void *opaque);
+
+int p9c_attach(P9ClientState *s, int32_t fid, int32_t afid, const char *uname,
+               const char *aname, int32_t n_uname, P9AttachFunc *cb, void *opaque);
+
+int p9c_walk(P9ClientState *s, int32_t fid, int32_t newfid, int16_t nwname,
+             const char **wnames, P9WalkFunc *cb, void *opaque);
+
+int p9c_open(P9ClientState *s, int32_t fid, int8_t mode,
+             P9OpenFunc *cb, void *opaque);
+
+int p9c_create(P9ClientState *s, int32_t fid, const char *name, int32_t perm,
+               int8_t mode, const char *extension, P9OpenFunc *cb, void *opaque);
+
+int p9c_stat(P9ClientState *s, int32_t fid, P9StatFunc *cb, void *opaque);
+
+int p9c_wstat(P9ClientState *s, int32_t fid, const P9Stat *stbuf,
+              P9StatFunc *cb, void *opaque);
+
+int p9c_write(P9ClientState *s, int32_t fid, int64_t offset, int32_t count,
+              const void *data, P9WriteFunc *cb, void *opaque);
+
+int p9c_read(P9ClientState *s, int32_t fid, int64_t offset, int32_t count,
+             P9ReadFunc *cb, void *opaque);
+
+int p9c_flush(P9ClientState *s, int16_t oldtag, P9FlushFunc *cb, void *opaque);
+
+int p9c_clunk(P9ClientState *s, int32_t fid, P9ClunkFunc *cb, void *opaque);
+
+#endif

--------------020902030707050203050708--
