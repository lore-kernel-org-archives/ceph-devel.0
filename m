Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793105105;
	b=WVqyz+XDHi97xY7cQJ5okNmhkyax00Kb1wRsRDgpHYw1fcK1dVvp0JGdPW4eHPllhISp
	 Q+uDExTUEpLSAHswSwe2F5U0NNvMznd2vTWlxn/7uLWSBvshqj1FxKNkJd4BxwCbHLyP9
	 90QY6IGSQkybA1Nd3Z1GRzya5BI25zxJq8ecIyKXUVqkSfPW2h4sj5VYfPDlkD5/jxlD0
	 mIaMD41n4Cgofx4NH1jGyCUFZMke7Jly4E+RPcjVXkpN0Lo2rVKvgregdFQ/X15zTeFRp
	 eZq8tR+76SdRYjkKXWlVh8pIzyDPpH5S6bJvXQqXBLOLr7n1b99gZpE0Buw1CFl/v9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=tp5Z/PycBAJg9TMmmwDWZ/1o8EUvDrLUX04tXR+wyv0=;
	b=OLkyBj5oMYnD1vHJqwT36t6XBbl8uBj8Fqjy25jR9tWHjvyVsElsVFZCLAFX5uOaSjC+
	 rSfTGhTeksdBxLGbl7zlkPOzmwK4yxylk1OYtSaeYxL4QRNAFkk4eZYMDhh7sJ7CFPckJ
	 5paVNY9NhFpZyWryYQatbPW6rLRdflxgxnOxTh1VkR8DIpVL2zb67CN6cv8gMxzU/dmIT
	 xVtOpaCVVjTBg4N+SPnL+ZBZHHbUj9IaeLT9E+CXvix037v4CWx8tVuSJLTcwGCMqavoR
	 rrIFFEt7mdz1d2tEXOPYoeiz6Nyb5W+y32kEwB499GRYCugUu+ql9JuQ1YUjA7DGKSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=fYGlF2xZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65B606A332
	for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 12:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C65B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=fYGlF2xZ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c46d41f6af3so342473466b.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2026 05:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105101; cv=none;
        d=google.com; s=arc-20260327;
        b=bNkx/w0XgvyG0wRQYGJBqTxVIoO4vxmOGbELkCUO9sB2lM25Qpap27xRw2/Sj0Z0Lk
         ySnauWEQvyeyplec0j0MulJ/TgpregQqKoNLNhWeU2wL3GEfe0lKDQeVVfT4TcecN2iC
         m0d9GfwZ10i0V97D80A0PAD/fW+QCmOB2AEY9BWpQKRUP++v1afE6YkHy1H3paa7f7JK
         /F3xjxTkg8IY8JU8A+sB29AdkxHMac/48bcE+2JiKOS2rFCJXt3890k887cU3Wa/UgP/
         EEOjNSDNmv7a/hFwMAZhYGhR6Km21nhvesOJg7GxoNUbw/4Pxe1MQNQHXm2DN5wSlwYs
         75ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tp5Z/PycBAJg9TMmmwDWZ/1o8EUvDrLUX04tXR+wyv0=;
        fh=lTM6j8xanYpWji3WwE6swB4Cu+dc/All91DLtpA1fn8=;
        b=i7h8Ra04OQqRFU9KH2SvCS9gyFPEMf/N1mLCtL4bRiDih8QJyi41YIWXze+oGjRWIX
         O3+FhFOxjeZrn/7wsfMXK1TxZ7+vAm37ODptXPkWmVG3BuJjORXvOnzUDuseQlXR5UD0
         FfrfPA2mJwSvGUvwbvlBgmyWP4N9nc2fgMbuVbzzER7zOX1jkKrS0xyJpPe0B71ulJRl
         YzGN2xCYSGYUEBhgvEM4K9MqED04AN79CDmkHOJ94Lx80P+k7aJ4e0IfZEYCtXxd+z0D
         XtIBu91UftQR/eqrQKVS6SKDgQkdPB7dAAD/1JBD/Sg/G0UfK+al4ZSjOkpHjx1HBSHl
         AMkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1793105101; x=1793709901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tp5Z/PycBAJg9TMmmwDWZ/1o8EUvDrLUX04tXR+wyv0=;
        b=fYGlF2xZvMKZpXD35R3nsX3JNM8VYluoq0Sj5pX1aaLxFpGjyWGA43KLCVb2+L9ohT
         3AEYCqTkA7WblXENEhH2k+nw0OAYFhNUcjuSClCZgJumuylOegdtXosZ4pDVkyS6L1Db
         z/ewE+Sw5R165rqd36h2P2En56J8ih29CGIN6QKqlROosTvZ+ugDhzAA70CDkShIpFoT
         ySjqyqzy7o4YsQx0o9MM6OXqjIM6EX+pi9ZsNDiiF4Sl6l2GlS86ZeN9Ufi1kpsoEsnL
         G0xiTzsEOoMawiz7LwRXR5MsYFw7HUhYbicJXk7PCZJbx8R24ZeZu8BE1lVg3cMMTUKb
         vcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105101; x=1793709901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tp5Z/PycBAJg9TMmmwDWZ/1o8EUvDrLUX04tXR+wyv0=;
        b=cNqOI4S0zkV/Z41/qBiXwysfbL4nCmTVAZKYDQtX6DUNaQh1eA65zMdGW2QkJUmKGT
         NFnbeJ3PjC8QrYgB+KFz/K5UGWIoieaFkXimx9Q+Lpl7Pg5GRX/bevHTH8yMKmALB/oc
         DA68cWNORZ6xhcOV1RDLu2oGDf2/DETfq7vjIMymWyeziy7GNEsY5EfhnEsuoz0hs6oW
         PtFbRs14HdhvyED/fUeyNdPgAFGbtjv9jRS1B0prXOyZCdcbortRqadotw3mcRbJjIuN
         OZMXYYZ0R2aaXqPzzgGpl+pLDyrE9uIBHbYMWZ2UIEtQ0fnpDLK61MBeWH8UbmLPQFap
         WhlA==
X-Gm-Message-State: AFq9FYJJwGcuDrSAkdLAgwKl0VMM916OjRvJE/kWl3//t9UFvBqn/m+q
	E4M3KlcRKa3I+ud7Mz2bx6oNeJsWZe0RNIcdbbyYeMXSTSBwIc8XN/qAegHGpBCR3GoTEBS8EbQ
	XdXktr5EolsH2vk2NppeDoo+5Y5AMSXAe3/J9abyFwA==
X-Gm-Gg: AYBFou2cbdjO/BDKVqtuPxzq8B442AajX7tJS6BGPprKcDZtucuKDDSmVRmDzOi4vHk
	Vp1cOXDawofd6iOR8dGAgjZxnsEYha/ZyDngeaGIquQXLnm5WaT4CTey0Ma+s0j0iwVxsBzYIHt
	Unt2Soo+Bn9/HGZl6SwITa0dJVr8ERj9/tQfJE7k6NY7vN8LQeIWYxGH06M3bgWot6tSYut8G3G
	kIW30poxm7x/p6y6A0J/1F2O+fmYrc9RNAihYipVPN87nRW/bqplcOHocXULuj4cIXV/qpE5v6/
	Hb9GfU1jqaHFbnjEFeE3aGNxjU7xIICCNGXYcgEdO8CMOkesg3Bmp5FtkUzMbf/VEgwnTh5bdQt
	OJrkFlIhFl04hFQDJxgpzU56I/9PamBCnmGO9QhU=
X-Received: by 2002:a17:907:3d56:b0:c46:2987:2156 with SMTP id
 a640c23a62f3a-c46bde530a6mr1170312866b.29.1793105101334; Tue, 27 Oct 2026
 05:45:01 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
In-Reply-To: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 27 Oct 2026 13:44:28 +0100
X-Gm-Features: AclHuK-ojbEjvM3prTzqiHVXlqJdtBT0a5aS99YgrWUgj8YCYdBw1ESDVDxY2OQ
Message-ID: <CAOJNxRKQETQbti6Rgdeekkuo+GAT1xHOvt-G8YvoHsLeDbcP_w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] ceph: support subvolume quarantine
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, slava@dubeyko.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks for v6.  I tested it on a KASAN + lockdep.

What is still slower with no quarantine at all (the MDS supports it, so
quarantine_supported is set):

  1. Non-owner path walks.  Every inode gets ACL_DONT_CACHE, so root,
     other users and group access pay ceph_get_acl() on every path component.
     d48 stat is 47% slower.  See 5/5, acl.c and ceph_set_ino_cb().
  2. Owner path walks.  __ceph_do_getattr() takes i_ceph_lock twice per path
      component.  d48 stat is 9% slower.  See 5/5,
ceph_quarantine_head_cap_valid().
  3. Snapshots outside a subvolume.  Every read() and stat() goes to the
     MDS.  See 5/5, ceph_snapshot_has_path().
  4. Async create is off whenever the inode has an LSM blob.  See 5/5,
     ceph_atomic_open().

All four can be fixed without weakening the quarantine checks.  My
reply to 5/5 has the diffs I tested, each under the code it changes.
"v6+fix" below is v6 5/5 plus those four diffs.  With them, the numbers
are back to base, and my quarantine tests still pass, plus new ones for
each change.

Benchmark method, for every table in this thread:

  - ABBA order, 12 rounds: base v6 fix fix v6 base base v6 fix fix v6
    base.  Each variant runs 4 rounds of 20000 ops, 80000 pooled.
  - One Python process repeats one syscall and times each call with
    perf_counter_ns().  It is pinned with taskset to a vCPU on a P core.
    Without the pinning, the hybrid host gave bimodal results.
  - The VM is rebooted before each campaign, because module reloads
    eventually exhaust lockdep and turn it off mid-run.
  - Paths:
      d48 = /mnt/qa/outside/pb/d1/.../d48   (48 components)
      d5  = /mnt/qa/outside/pb/s1/.../s5
      mount -t ceph admin@<fsid>.a=/ /mnt/qa \
            -o ms_mode=prefer-crc,noshare,nowsync
  - "owner" runs as the uid that created the directories.  "non-owner"
    runs the same loop as root, so acl_permission_check() falls through
    to check_acl().

Non-owner, latency in us:

  test            ops/s   p50    p90    p99   p99.9   max
  d48 stat
    base           7422  140.4  153.0  225.5  2174.8  6176.9
    v6             4909  206.5  216.8  290.3   877.5  2918.2
    v6+fix         8238  141.4  162.6  217.4   718.4  2132.9
  d48 symlink stat
    base           7334  143.3  153.2  190.7   359.2  2450.1
    v6             4968  210.3  221.1  279.6   777.0  4999.7
    v6+fix         7238  145.6  155.4  190.8   463.8  2456.1
  d48 readlink
    base           8482  138.5  148.3  174.6   307.1  1972.1
    v6             5046  205.0  214.8  267.3   389.2  1020.8
    v6+fix         7624  141.0  150.7  184.3   311.5  1233.9
  d48 open+close
    base           3826  257.6  277.1  912.5  1842.6  9565.7
    v6             3026  323.3  346.3  975.5  1721.0  3465.7
    v6+fix         3685  259.6  277.8  926.3  1755.6  2680.5
  d5 stat
    base          59504   15.3   17.6   32.7    51.3   565.1
    v6            30720   42.0   42.9   52.9    78.8   662.5
    v6+fix        48144   15.6   32.6   42.1    54.9   445.7

Owner, latency in us:

  test            ops/s   p50    p90    p99   p99.9   max
  d48 stat
    base           7514  141.7  151.7  195.2   968.1  1719.4
    v6             7393  154.4  164.5  202.9   739.2  1972.5
    v6+fix         7695  143.0  152.8  189.4   809.2  1747.5
  d48 symlink stat
    base           6887  145.2  154.9  200.9   335.3  2198.3
    v6             6409  159.3  169.8  215.4   348.4  2254.7
    v6+fix         6605  147.2  157.2  209.1   331.1  2132.3
  d48 readlink
    base           6907  141.1  151.0  206.8   319.1  3761.8
    v6             6350  154.2  164.3  229.1   373.0  4344.2
    v6+fix         6801  143.0  153.0  207.9   319.2  1511.6
  d5 stat
    base          35110   32.0   32.7   42.8    74.3   926.0
    v6            28277   34.6   37.2   45.7    75.5  1399.8
    v6+fix        30807   32.7   33.8   44.2    87.6  1388.9

pread is unchanged in all variants.  The owner numbers replace the
"symlinks and cached dentry lookups" section of my previous mail.  That
run did not pin the benchmark process, so plain stat looked like noise
there.

Snapshot test (plain directory, not a subvolume; 4M file, 52 entries),
MDS requests counted with kprobe:ceph_mdsc_submit_request:

                         base             v6                 v6+fix
  read4k (x1024)         8 req, 0.14 s    1041 req, 0.91 s     9 req, 0.16 s
  stat x1000             0 req, 0.07 s    6000 req, 4.49 s     0 req, 0.11 s
  ls -l                 59 req, 0.12 s     950 req, 0.74 s    60 req, 0.12 s

Async create, 500 O_CREAT opens on the nowsync mount, counted with
kprobe:try_prep_async_create:

  base: 500    v6: 0    v6+fix: 500


Thanks,
Xiubo

On Sun, 25 Oct 2026 at 19:42, Alex Markuze <amarkuze@redhat.com> wrote:
>
> CephFS subvolume quarantine restricts ordinary access while allowing
> recovery clients with q/Q MDS auth caps to operate. Add client support
> for quarantine notifications and enforce them on cached access paths.
>
> Based on the testing branch of https://github.com/ceph/ceph-client.git,
> commit ed0502cb11f8 ("ceph: validate encoded xattr name lengths").
> The full base is recorded below. The dcache and fscrypt prerequisites
> are included in this five-patch series.
>
> Changes since v5:
> - Describe the dcache export as a prerequisite and remove Reported-by
>   and Closes tags for it.
> - Reject foreign, disconnected and unhashed non-root aliases in ancestry
>   walks while accepting the live, unhashed superblock root.
> - Reset quarantine state only when the lost or reconnecting session is
>   the reporting MDS rank, including when its cap is already absent.
> - Check saved authorization's generation even when no inode is marked.
> - Check snapshot path access and acquire normal wanted caps after
>   quarantine authorization.
> - Clear detached xattr-buffer ownership after releasing its reference.
> - Use synchronous CREATE for new inodes with an LSM security blob,
>   before async preparation, including before feature negotiation.
> - Keep an existing quarantine mark across a zero-error IMPORT while
>   processing imported caps and negative quarantine errors normally.
> - Use the incoming wire cap mask for clear decisions, so PIN-only updates
>   cannot acquire clear authority from capability bits retained in a merge.
> - Update encrypted-symlink and capability comments to match their
>   interfaces.
>
> Validation: GCC x86_64 builds with fscrypt, ACLs and security enabled
> passed W=1 vmlinux/modules for the final tree and the recording patch.
> Twenty-six extracted-code quarantine state tests passed, using mocked
> kernel context. Live cluster, boot, KASAN/lockdep, LSM policy,
> failover, performance and LKMM validation have not been run.
>
> Previous submission:
> https://lore.kernel.org/r/cover.1792527529.git.amarkuze@redhat.com/
>
> Alex Markuze (5):
>   dcache: export d_find_alias_rcu() for modular filesystems
>   fscrypt: allow filesystems to disable symlink target caching
>   ceph: add subvolume quarantine wire definitions
>   ceph: record subvolume quarantine from MDS cap updates
>   ceph: fail quarantined subvolume access with EACCES
>
>  fs/ceph/acl.c                |  33 +-
>  fs/ceph/addr.c               |  72 ++-
>  fs/ceph/caps.c               | 323 +++++++++++-
>  fs/ceph/crypto.c             |   1 +
>  fs/ceph/debugfs.c            |   1 +
>  fs/ceph/dir.c                |  54 +-
>  fs/ceph/file.c               |  82 ++-
>  fs/ceph/inode.c              | 956 ++++++++++++++++++++++++++++++++++-
>  fs/ceph/ioctl.c              |  13 +
>  fs/ceph/mds_client.c         |  26 +-
>  fs/ceph/mds_client.h         |  30 +-
>  fs/ceph/super.c              |   4 +
>  fs/ceph/super.h              | 101 +++-
>  fs/ceph/xattr.c              |  60 ++-
>  fs/crypto/hooks.c            |  28 +-
>  fs/dcache.c                  |   1 +
>  include/linux/ceph/ceph_fs.h |  13 +
>  include/linux/fscrypt.h      |   7 +
>  net/ceph/ceph_common.c       |   2 +
>  19 files changed, 1706 insertions(+), 101 deletions(-)
>
>
> base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
>
