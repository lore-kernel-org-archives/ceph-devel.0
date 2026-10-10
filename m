Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C526FD97
	for <ceph-devel@vger.kernel.org>; Sat, 10 Oct 2026 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598440; cv=pass; b=JaLqiv9/0NLmktJrjZXn5hvXFHZtatRF4cr6/vwu9PzrwYNhfJ0+GHIA/CvNwO0FvUZwMZj14wgcP9GmziP0BrU7kVfPRlEnYeBBt4XmvRuKiyF7kzZIjDTlN4zDxk77tq7iZQuj7ZoQGsM96v05l93nMTSfeAtCXZfYWMF0CWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598440; c=relaxed/simple;
	bh=l17CC4YiO7zjfvArwoYXtRZFoP8lMuZfg4QGbI0Xmb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul5rg7rJ/Irf+8zXtsfdDbCQCdFTBKxL7oily+70T3dMbRBZ9Ss5j8mKTOHSU0zBhYjWosd24Cq3aB0G8uszI5WCuiYwddgVWAQcfsi2zo43Py/PJOlodsTuTlDdZXjK06Zu+2N/EoFm5DVrlFyVIgXKFn/jiqvNEnAMVty4Tgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=bwpt3qd5; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="bwpt3qd5"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c31988fc977so65414266b.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 19:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791598435; cv=none;
        d=google.com; s=arc-20260327;
        b=LFFlhAIbc21uit/Xy5Jyaj77YGiQaA6xcBn7XOJs3RLnYv2n5Um+BC5kdArHTkb3H+
         OIDDEvS2Xx/bysbzE47NanQ+Wu1XaMA0RGSCuuFpxDXYlSsOdwCWfvcdCNKA8zIGusy9
         D37dtXHDL/YPAl0JoQ0TvUl9i1eP/5F3XfyJnEgr6d21IpHy9+lTIDxzZU6QkhGPMmWN
         D5lmfA/K63aYFrOTF4y4vd4Ap6aSkzkxnZluH48/rTdDOQ9Dfga8ts18nGAp3ejBMYJ1
         6Ace0iMOIk6EE+CQPLH8tXxxNkECuFgexiunPWofAnxhwR9cEEAErjSqpTJbJTKDjgM3
         pbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zj2k8TMLQD/0gFj6fEeTbzaEgFJhRguWi3NaGdIHbjI=;
        fh=jq5tVypPBANdopmf6bTKTpdcyWkTEoiTaus0TRG6qf0=;
        b=koxpo+wIQ5Gebb/vkeUz+VOi7YXMKYxNI/1pk7+P6wZ3y37qHMprK6/erogn9bEKaF
         Da+KixtjKZ16mEi4wpEVimmnNYWDrQzjMI7ZeakgZHLZfcfnSNnKmkvSu1MGcQNh/4Q7
         1YkXDXWZrZQKynuaD5Ewj/IDptangOnr5bLJtnhn0GgfnsJdqwN92z6M6xeaJ4gocJMn
         oJ61fXU3pG2QZoRXTnyrR4PROiyPj91/W63idi/jcE/VcPFnl4RrMU4VwakED+0FHwQT
         Ov9jhgWAqOXcFNaV2nbKZVUOhheUy35oDHLZOBe1pAZ7KxXwgDyYiZSn9pZXLwQFg68k
         YIYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1791598435; x=1792203235; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj2k8TMLQD/0gFj6fEeTbzaEgFJhRguWi3NaGdIHbjI=;
        b=bwpt3qd5hqfE0bXBSPqCDn2b4XtmBp7kIze1cm998zffPWWVbc/Or3DoRqV5QtR/+b
         hCs+v+uPP+xpjYM84lBg4S9WViC5zOcXPUz5YS39CuxB0VrqkV4SXwHS8gpA+/DpfvN9
         NDiJdfzx1xSAZQClopHNUX09djtxMiG93NIArS7kQccqgXQRdQNkjFpWGeY196L19MeY
         C/wRFqIQt2nbq0eQz2wALZidw8c7I5bYMazKx0Y/2jIQYoK31sloHSHclSGz3kJBbYv/
         XTNnZNE6nNOBR3bMx6MmGMon9NYBWaXxkZV8vINkWgtGfnSP8Cs4CwwzTPcc+IqWmCdz
         f1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791598435; x=1792203235;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zj2k8TMLQD/0gFj6fEeTbzaEgFJhRguWi3NaGdIHbjI=;
        b=u3zZMw4WGcuniNCgLFj+TTUv5HqIdMKllHIQL7sABKdsPN5NHw/SjJT08QFaVlyykt
         1BnLvcEYkYkoNVPHmzG8qXQGoQRupdq+p/l9WzLUw4T4suTWHDSyf7xH8n+wgovxnUNJ
         5pYJ0mJdE0xuskXVb0i5wKP9ogtD2zkRDejLeV+aYi2Jv0QWbzwfdzUR9Y0IZLBv8dQS
         sZthUORdqyiJEvpVqX+PbkviMy+vdEbuzXdJUddvSWlaaIvK6hRB4VJhQKfdSR1OdG8A
         djBWFmIPVvEVnmRuroi/ioIN2tjl9nqYqUySjNJA2U8Te3ljI1Tewao2EZz5XwzX0/nH
         JEHw==
X-Gm-Message-State: AFq9FYI1l1cbKR+mfP6AAIZevsv8EHLl7Db+wPExh6ISoluVkeU/3+m+
	ZBS/P4hxG92v4wjUclztDJ/f0y6vVS5hC7SYdN0IFNtYtGqCf9EniwT+hvdmU/fJS9S90bB4j3J
	F3kmBO9ecHvjiNBNG7/JMGixJd0gIzdy9cjDGhlYEaA==
X-Gm-Gg: AYBFou1q3usGNfB8Yk/efBmB1oopf59p5VsyHT5h30otHncUdq+4gDgTMwBSEiP4D0K
	17+WbbTqlXsMimnfBm0F+199mpS/YuC6odKVcwxkLv8RDaNawYFNP0YC9TccnMqVyTXEwuNXWqA
	FlyhzaVwzrrtdeGym+52YY0Wi0/FrI+CK9I/dLdsYzRiyCsZEFEOYWHvOqexmNuUlBOdeROri1q
	cDWgC8Glikv3djVkIJQA58cOWCPP7lIIgVUBYh7G5NE6PDvo7r/ZHJzHGZaS5UGzJuXrlBIkt5i
	l/D+Z9WKeq4FiT4F79lLopl6JTomjUP+jdKM7doz3M8EBwrX0w1CFCzGZw==
X-Received: by 2002:a17:907:86a4:b0:c29:c07f:c0c8 with SMTP id
 a640c23a62f3a-c31a9a341cfmr347293466b.3.1791598434908; Fri, 09 Oct 2026
 19:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009164245.2483933-1-amarkuze@redhat.com> <20261009164245.2483933-4-amarkuze@redhat.com>
In-Reply-To: <20261009164245.2483933-4-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sat, 10 Oct 2026 04:13:43 +0200
X-Gm-Features: AclHuK-hnsjsM0gpLpNvuCk2afOlDsIwFl-l3PCv3Q00osoRMsIqADYPnH3kCgU
Message-ID: <CAOJNxRKeda4j4-kZAMwS40gA9oLtabgsD_BUZE53uPHMB6SYXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ceph: fail quarantined subvolume access with EACCES
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks for the series. I reviewed it and ran it on a test VM:
a 7.3.0-rc1 kernel with KASAN, lockdep and DEBUG_LIST enabled, and a
vstart cluster built from current ceph main with quarantine support
(1 MON, 3 OSD, 2 MDS with one standby). I also built the base and
patched ceph.ko against the same kernel, so the two could be compared
side by side.

The wire format matches userspace: MClientCaps v13 subvolume_id and
v14 oserrno, MQuarantineDisable, 0x315, EQUARANTINED=1000 and feature
bit 24. Each patch builds cleanly with W=1.

The basic behaviour works:

  - bit 24 is advertised;
  - during quarantine, stat/ls/read/write/create/mkdir/chmod/rename/
    unlink in the subvolume fail with EACCES right away and do not
    hang. This holds for cached inodes, after drop_caches, and for
    reads and writes through already open fds. Paths outside the
    subvolume are not affected;
  - after "quarantine disable", everything works again, fds included;
  - failing over the active MDS while quarantined, then disabling,
    also recovers cleanly;
  - unmounting while quarantined and remounting works;
  - fsstress inside and outside the subvolume, with 10 enable/disable
    cycles, gives a clean dmesg (no KASAN or lockdep reports).

However, I hit two real problems: a file lock leak and a large
performance regression. Details below.

1, File locks leak on the MDS

ceph_mdsc_submit_request() now fails every request that touches a
quarantined inode, including CEPH_MDS_OP_SETFILELOCK unlocks. Both
ceph_flock() and ceph_lock() call try_unlock_file() first, so the local
lock is already gone when the unlock request is refused. The lock
stays on the MDS. The MDS does not run check_access() for setfilelock,
so it would have accepted the unlock; the refusal is purely
client-side.

Reproducer: two kernel mounts with noshare, A and B. The process on A
keeps a second, unlocked fd open on the same file:

  A: flock(fd, LOCK_EX)                  -> OK
  B: flock(LOCK_EX|LOCK_NB)              -> EAGAIN (expected)
  ceph fs subvolume quarantine enable a sv
  A: flock(fd, LOCK_UN)                  -> EACCES
  A: close(fd)          (other fd still open)
  ceph fs subvolume quarantine disable a sv
  B: flock(LOCK_EX|LOCK_NB)              -> EAGAIN   <-- leaked
  B: (30s later)                         -> EAGAIN
  A: close(last fd)
  B: (10s later)                         -> OK

POSIX locks (lockf) behave the same way. The lock is only cleaned up
as a side effect of the cap being released after the last close, so a
long-running process that keeps the file open leaves the lock on the
MDS for good. The interrupt path in ceph_lock_wait_for_completion() also
sends its *_INTR unlock through the same check.

The cover letter says the MDS already returns EACCES to
quarantine-aware clients. So I think the check in
ceph_mdsc_submit_request() should go. If the only goal is to stop
async create/unlink from completing in the cache during the race
window, do the check in try_prep_async_create() and
get_caps_for_async_unlink() instead. Note that once the directory caps
are revoked to PIN, DIR_CREATE and DIR_UNLINK are gone anyway, so the
"would otherwise complete in cache" wording in the commit message only
applies to that window. At the very least, unlock requests must never
be refused locally.

2, The local fail-fast leaves no way to recover

Once an inode is marked, getattr, open, get_caps and every MDS request
on it fail locally, so the client never asks the MDS again. Only two
things can clear the mark: MQuarantineDisable, or a grant above PIN
with errno 0. The MDS only sends such a grant when the client still
wants caps. A cached directory with no wanted caps therefore depends
entirely on the disable message arriving.

In my MDS failover test the message did arrive, so I could not
reproduce a stuck inode. Still, if the message is lost (session
reconnect, client reset, ...), the inode keeps returning EACCES until
it is evicted. The userspace client does not have this problem because
it never fails locally. It would be more robust to:

  - let getattr/lookup on a marked inode go to the MDS (force) instead
    of failing locally;
  - clear the mark in the reply path when caps above PIN are added;
  - reset the state on session reconnect or reset.

3, ceph_inode_is_under_quarantine() is expensive and sits on hot paths
   (patches 2/3)

Each call walks up the ancestors with igrab() + d_find_any_alias()
(which takes i_lock) + dget_parent() + dput()/iput(), up to 256
levels. It is now called:

  - in ceph_try_get_caps() and __ceph_get_caps(), i.e. on every read
    and write, and again on every wakeup inside the wait loop;
  - in __ceph_do_getattr(). ceph_permission() returns -ECHILD for
    MAY_NOT_BLOCK, so ceph path lookups always use ref-walk and call
    getattr for every path component. That makes a path lookup
    O(depth^2);
  - in ceph_mdsc_submit_request(), up to seven walks per request.

This cost is paid even when no quarantine has ever been set. I
measured it without any quarantine, base vs. patched ceph.ko on the
same kernel. Runs alternated base/patched/base/patched, 3 rounds
each; numbers are single-threaded ops/s:

                         base        patched     slowdown
  depth 48  stat        ~12.9k       ~635         ~20x
  depth 48  pread 4K    ~490k        ~16k         ~30x
  depth 48  open+close  ~6.8k        ~575         ~12x
  depth 5   stat        ~73k         ~28k         ~2.6x
  depth 5   pread 4K    ~510k        ~119k        ~4.3x
  depth 5   open+close  ~18k         ~11.7k       ~1.5x

KASAN and lockdep inflate the absolute cost of the locks and refcounts,
but the O(depth) per I/O and O(depth^2) per lookup are inherent to the
design. Suggestions:

  - keep a per-mdsc atomic count of marked inodes, updated with
    test_and_set_bit()/test_and_clear_bit() and on eviction, and return
    false immediately when it is zero;
  - do the parent walk under rcu_read_lock() using
    READ_ONCE(dentry->d_parent) and d_inode_rcu(), without taking any
    references. This also gets rid of the iput() of ancestor
    directories in arbitrary caller contexts, where a concurrent
    rename/unlink can make it the final iput (for example in
    __ceph_do_getattr() with a locked folio).


Thanks
- Xiubo

On Fri, 9 Oct 2026 at 18:42, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Advertise CEPHFS_FEATURE_QUARANTINE (bit 24). The MDS then rejects
> metadata from this client with EACCES instead of parking the request
> until quarantine is lifted. Clients that do not advertise the bit
> still block.
>
> Cached caps can satisfy getattr, open, lookup, and readdir without
> asking the MDS, and file I/O waits in ceph_get_caps() for caps that
> quarantine will not reissue. Fail those paths locally when the inode
> or an ancestor is marked. Async create and unlink take the same check
> in ceph_mdsc_submit_request(), so they cannot complete in the cache.
>
> Recovery clients with q/Q caps are not marked. The MDS sends errno 0
> and full caps, and those operations proceed.
>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/caps.c       | 10 ++++++++++
>  fs/ceph/debugfs.c    |  1 +
>  fs/ceph/dir.c        | 10 ++++++++++
>  fs/ceph/file.c       | 11 +++++++++++
>  fs/ceph/inode.c      |  7 +++++++
>  fs/ceph/mds_client.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.h | 10 +++++++++-
>  7 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 84238da4d75c..3a99107b7567 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3263,6 +3263,9 @@ int ceph_try_get_caps(struct inode *inode, int need, int want,
>                         return ret;
>         }
>
> +       if (ceph_inode_is_under_quarantine(inode))
> +               return -EACCES;
> +
>         flags = get_used_fmode(need | want);
>         if (nonblock)
>                 flags |= NON_BLOCKING;
> @@ -3297,6 +3300,9 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
>         flags = get_used_fmode(need | want);
>
>         while (true) {
> +               if (ceph_inode_is_under_quarantine(inode))
> +                       return -EACCES;
> +
>                 flags &= CEPH_FILE_MODE_MASK;
>                 if (vfs_inode_has_locks(inode))
>                         flags |= CHECK_FILELOCK;
> @@ -3333,6 +3339,10 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
>                                         ret = -ERESTARTSYS;
>                                         break;
>                                 }
> +                               if (ceph_inode_is_under_quarantine(inode)) {
> +                                       ret = -EACCES;
> +                                       break;
> +                               }
>
>                                 /*
>                                  * If a cap update is lost after
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 6a9a5551d9d7..ef10e948a2d3 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -53,6 +53,7 @@ static const struct ceph_session_feature_desc ceph_session_feature_table[] = {
>         { CEPHFS_FEATURE_HAS_OWNER_UIDGID, "HAS_OWNER_UIDGID" },
>         { CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK, "MDS_AUTH_CAPS_CHECK" },
>         { CEPHFS_FEATURE_SUBVOLUME_METRICS, "SUBVOLUME_METRICS" },
> +       { CEPHFS_FEATURE_QUARANTINE, "QUARANTINE" },
>  };
>
>  static int mdsmap_show(struct seq_file *s, void *p)
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 384e9edabe2a..1e214ef65c5d 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -349,6 +349,11 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>
>         ceph_blog_enter(fsc, &__ji);
>
> +       if (ceph_inode_is_under_quarantine(inode)) {
> +               ceph_blog_exit(&__ji);
> +               return -EACCES;
> +       }
> +
>         boutc(cl, "%p %llx.%llx file %p pos %llx\n", inode,
>               ceph_vinop(inode), file, ctx->pos);
>         if (dfi->file_info.flags & CEPH_F_ATEND) {
> @@ -888,6 +893,11 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>                 return ERR_PTR(-ENAMETOOLONG);
>         }
>
> +       if (ceph_inode_is_under_quarantine(dir)) {
> +               ceph_blog_exit(&__ji);
> +               return ERR_PTR(-EACCES);
> +       }
> +
>         if (IS_ENCRYPTED(dir)) {
>                 bool had_key = fscrypt_has_encryption_key(dir);
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 856710c63765..f90c313ef4b2 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -382,6 +382,12 @@ int ceph_open(struct inode *inode, struct file *file)
>                 return 0;
>         }
>
> +       /* Existing caps can satisfy open without an MDS round-trip. */
> +       if (ceph_inode_is_under_quarantine(inode)) {
> +               ceph_blog_exit(&__ji);
> +               return -EACCES;
> +       }
> +
>         /* filter out O_CREAT|O_EXCL; vfs did that already.  yuck. */
>         flags = file->f_flags & ~(O_CREAT|O_EXCL);
>         if (S_ISDIR(inode->i_mode)) {
> @@ -831,6 +837,11 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
>                 return -ENAMETOOLONG;
>         }
>
> +       if (ceph_inode_is_under_quarantine(dir)) {
> +               ceph_blog_exit(&__ji);
> +               return -EACCES;
> +       }
> +
>         err = ceph_wait_on_conflict_unlink(dentry);
>         if (err) {
>                 ceph_blog_exit(&__ji);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 994a0c4f2f4c..40638d7e1522 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -3167,6 +3167,13 @@ int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
>                 return 0;
>         }
>
> +       /*
> +        * Cached caps would otherwise satisfy getattr after the MDS has
> +        * revoked access. Fail before that short-circuit.
> +        */
> +       if (ceph_inode_is_under_quarantine(inode))
> +               return -EACCES;
> +
>         boutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
>               ceph_vinop(inode), ceph_cap_string(mask), inode->i_mode);
>         if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mask, 1))
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 97a0ce4709ca..89d20a42b606 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3983,12 +3983,53 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
>         }
>  }
>
> +static bool ceph_request_targets_quarantine(struct ceph_mds_request *req,
> +                                           struct inode *dir)
> +{
> +       struct inode *inode;
> +
> +       if (dir && ceph_inode_is_under_quarantine(dir))
> +               return true;
> +       if (req->r_inode && ceph_inode_is_under_quarantine(req->r_inode))
> +               return true;
> +       if (req->r_parent && ceph_inode_is_under_quarantine(req->r_parent))
> +               return true;
> +       if (req->r_old_inode && ceph_inode_is_under_quarantine(req->r_old_inode))
> +               return true;
> +       if (req->r_old_dentry_dir &&
> +           ceph_inode_is_under_quarantine(req->r_old_dentry_dir))
> +               return true;
> +       if (req->r_dentry) {
> +               inode = d_inode(req->r_dentry);
> +               if (inode && ceph_inode_is_under_quarantine(inode))
> +                       return true;
> +       }
> +       if (req->r_old_dentry) {
> +               inode = d_inode(req->r_old_dentry);
> +               if (inode && ceph_inode_is_under_quarantine(inode))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
>                               struct ceph_mds_request *req)
>  {
>         struct ceph_client *cl = mdsc->fsc->client;
>         int err = 0;
>
> +       /*
> +        * Quarantine-aware clients fail metadata immediately. The MDS is
> +        * still the authority for clients that have not seen the cap
> +        * update yet; this covers inodes already marked locally, including
> +        * async create/unlink which would otherwise complete in cache.
> +        */
> +       if (ceph_request_targets_quarantine(req, dir)) {
> +               doutc(cl, "request %p op %s denied by subvolume quarantine\n",
> +                     req, ceph_mds_op_name(req->r_op));
> +               return -EACCES;
> +       }
> +
>         /*
>          * If a reset is in progress, wait for it to complete.
>          *
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 863cdb8d588a..157f8933a547 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -39,7 +39,14 @@ enum ceph_feature_type {
>         CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,
>         CEPHFS_FEATURE_SUBVOLUME_METRICS,
>
> -       CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_SUBVOLUME_METRICS,
> +       /*
> +        * Bit 23 is CEPHFS_FEATURE_BLOCKDIFF on the MDS and is not
> +        * advertised here. Bit 24 is subvolume quarantine; it must stay
> +        * aligned with the userspace client.
> +        */
> +       CEPHFS_FEATURE_QUARANTINE = 24,
> +
> +       CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_QUARANTINE,
>  };
>
>  #define CEPHFS_FEATURES_CLIENT_SUPPORTED {     \
> @@ -57,6 +64,7 @@ enum ceph_feature_type {
>         CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
>         CEPHFS_FEATURE_MDS_AUTH_CAPS_CHECK,     \
>         CEPHFS_FEATURE_SUBVOLUME_METRICS,       \
> +       CEPHFS_FEATURE_QUARANTINE,              \
>  }
>
>  /*
> --
> 2.34.1
>
