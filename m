Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792458814;
	b=EKXb2VA2W6yPvHsSstwOlVPoMbAcVXu2lKzd//jMTHJcUK7+zK62U8vIiugkRefOScTk
	 sYULyC2ocNyMd56i8hb4V42qY5/jJAeApSGqWnmy6Rj8s9Krvm92K74KZbufxxC/FyF6L
	 ZRFNTIdERn6RrxSWhf4piibUyyCQxe24O6FEtNEDwNTkfwketW9BDzUbH0ikOVwIwAinG
	 R0Q+mKJdN5/cUeB6MwhG1fxzwd/r76Fe3L2aT3cGmDyji1VcDh083djBcdAbB5etRw2He
	 VqoezIk7ItwJ5F+FXtZg2gebUxCfMS9XTfsYTFFXR9tFe+xw2yFAObj+Acn4V9v1jPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=vWohrLddgFMPiQASzL2j5mITQ0vuQuNAeviubWyE310=;
	b=K0/qUc7LUIa90ZRMbfD1Y+zxG1Lv+CUHoKMrEzDipHEqPtseSkCYIf+twNw+Bt1HwSfh
	 ov0x06n46yJC9VUauBdaBcgWLWNYJ4BcFCG32UmmuGxZXFRXNEaeofy7tb/pk0yW6ud0Y
	 TT5pP6UExjtDZ0cAn8uPnW9WwuyvV3IKV53hrAFGv3r/Sl5xJroG3Q7+1NN4IeSl7/NOb
	 MO8fh4/RWXq3mxOLJFR4hNJWETzPlLcLz8vTDTJMaAT05/pgWwG1j/Qhkit+r4RguP22r
	 QmgXjupqf1aPODyS/KD+CNsKSrAuzeATqlTbd/CxygSOqpNRHxTKESmpQzo1dW4fgfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=MPVnEsyY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBD606A31D
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 01:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BBBD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=MPVnEsyY
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c418e215671so339065766b.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 18:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792458811; cv=none;
        d=google.com; s=arc-20260327;
        b=m7jHhUhCV/1c5EFlOIirg9WMm94fgBcPRK6OXGMSM68Q56ccex4j0X0/oJbNeGkMrh
         iMPI7uv7ifhYKL+/ZkoKyxF3pVcz8u8txvET137pJpXJ/97mm3OCIX+WnlGuBD0tFsTO
         sAfaAn3TE+1Krs5TN4VwcNl8/SnXLE6ix1GtLmivWtSpbFOJ8jNHUL+msRBe3B1NmISY
         BaewEUqtj1DEUHpxysNS0ek9cYLkQWiF2PCdVlLRWYwrBhz97v+2wTuQjXYau96rsNCS
         AHlvHBwpNW9RgjHWadLvFVEnNn21TpoGqg2qVWuBIqANGbC4Jfl0gXs5wv3O69Rqifm2
         YUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vWohrLddgFMPiQASzL2j5mITQ0vuQuNAeviubWyE310=;
        fh=NjpkRfX1l+6WiKyk+yRnxfsfLumJxqwaleIFiUlIXpg=;
        b=aJVNSew8UePapgGOrRJt+VIcfnj81zSPtxmbuHe4HWOyAt0IIIU8dlfkIjWJUb/ryD
         4wqaZU4hF4qI5SfN+WgszJ5UZZh/g0PRmG5FLAGhhmErJBT7qED3xYy0g4nuZwATzO21
         1n1kVS8x6sdq/IutYXuS3ptxCjIzSe7vqUYeyuE8cFEAPm2kM30xNnQ+BHO/R6LmNIgj
         pbCbMkq8kkkf4c4NMsSWdPPGk87xRp3voH8K3SkMdg8BM+M20h4rSo5eK0HotAEP7uYt
         6q2v3loC0kZUh2J7Cv5e3fRCsoWBidTEhusx1JF6IiB3e9dvabyzq/bQ9P21JRJPGWbL
         rNKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792458811; x=1793063611; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWohrLddgFMPiQASzL2j5mITQ0vuQuNAeviubWyE310=;
        b=MPVnEsyY+0yt8UETjEM4y5xC4f0Pr2RaqDBM4rw2SpMfOyvdSTNu/TUNTcGowQrb8u
         ufz+Cl6YvwM7hxJn5m7om2ACEfpmJSMpUW54U8Sb4YNX3Ssdr4QEvQLrBYp7eNvKEPpp
         Kuh+ni52jhurssSMvYmMOJdi8ufM2OjAnYVFbDwnwqMXA0WWiMIuPNLCIoXvF5ekKSuP
         AN2bze9u+lH7OpPIUDz7GjEunvKzgYeiveJSuGzeMFphoJue9mr8XMWwb84CnDvc/KYN
         pWI5rIpg/U/uYacpfRR0U9pL9cVL0j5S4SunKRy3V+6t9XqaXbuH33j7NOy9T7yKL+Ne
         6Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792458811; x=1793063611;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vWohrLddgFMPiQASzL2j5mITQ0vuQuNAeviubWyE310=;
        b=zEK1LXH6jutPNolP5OZNe6tu1k8fLJ6MTEA2UtYB5kqEIS/3qWP8E66ub25Zme3PEe
         /s5k1mX9jXy6xFS+TI01oyUrQKM97iNSlE7lxguuSEPHVcWPLMQQyM9I5ROeTcpkaD/E
         +EDSKCV6t9hZKqx6nMB7LakTEWdpoWgY8T0Oa/JYAk8uzrV+QVPVeSA8hpfhSfRujZCe
         VfHnmMAd5rksY0BVLaNdVxvgub1fF/8ascDol+dIr4+Mpysb2UhhlmWoznmZhBmct21a
         VuvMt39OniU2a7MlmXOFuYA4gSnxpinKBVj+gFgkmyK8IzAwg2gzC2vyBUomKzCwqCBO
         tLsg==
X-Gm-Message-State: AFq9FYKDqh+v3s59MGp000p6z0tFX4msFRalyPfVXTSR3vWdeFaEYQF7
	cmMvt08SklgufaHogBi52GmYq2ElrwnGTX9Qh33+zqqiCyRsL0znlBJw9gYS5nZ0YiVfx7ovBWq
	rjWdSZsbZaMKJbgCz138n/u3AAl2/2acKgfRgy8UJiA==
X-Gm-Gg: AYBFou0Nx0Z3r47JPrHXF2cLPXCsNXEDG1yY0WfDDhJltknzy173QkIioWJz+wkCzaM
	/r1WRJ4kCha4S1upvMUfOqddcC8VIpgYvM7bkMdBPf72J05sj9xQx24pVssljwoaUeIAI4i6jRv
	gxKbbXpdmakRtqTSCL33PmmF6b/Oum8PWvuPqy07JYXbtobmAL1pb6MAVZzpAQtazLjW7LmO/Rl
	NPt79dXV3IgTOE30C08b1N9mAg9NgBVMRiO5RS8Z67YBT0HxRLWe68jZq3vwawP5PK23ufTkdKr
	I3fCGK54XLS5/pAk97jlXbxcnuM23RvwMzesgNJqD32/oiqSJmPzag57RV1JHQLPEXiX
X-Received: by 2002:a17:906:1001:10b0:c41:cf68:bbcf with SMTP id
 a640c23a62f3a-c41cf68f4a9mr393810066b.32.1792458811453; Mon, 19 Oct 2026
 18:13:31 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
In-Reply-To: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 20 Oct 2026 03:13:20 +0200
X-Gm-Features: AclHuK8xRQ60_Sp6jEhfID8fqxoZeEsaAEzn1rhM-0x8VxJDaK0vnKxbNIyNoxo
Message-ID: <CAOJNxRL5ZV6c-eR8f4XNwV8ehmtV-Mgknou=FqPTGMH7hbFqWw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ceph: support subvolume quarantine
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, slava@dubeyko.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 17, 2026 at 01:40:12PM +0000, Alex Markuze wrote:
> CephFS subvolume quarantine isolates a subvolume while allowing access
> by recovery clients with q/Q MDS auth caps.

Hi Alex,

I tested v3 on a KASAN/lockdep kernel against a vstart cluster with
MDS quarantine support.  Basic quarantine, held fds, disable/recovery,
MDS failover, umount while quarantined and fsstress with quarantine
cycling all behave as expected, with clean dmesg.  The v1 flock leak is
fixed.  A recovery client with "allow rwq path=<subvol>" works, and a
read-only "rq" client can read but not write.  I saw no hot-path
regression on unrelated directories, with or without a quarantine
active.

Problems:

1) Snapshot access now costs an MDS round trip per operation, even
   when no subvolume is quarantined.  __ceph_do_getattr() forces
   snapshot inodes, the snapdir path does a forced getattr on the
   parent, and __ceph_get_caps() calls ceph_snapshot_read_auth() on
   every acquisition.  Compared with the base modules:

     1000 x stat() of a file under .snap:    0.20s -> 20.07s,
                                             0 -> 6000 MDS requests
     1024 x 4k read() of a snapshot file:     0.51s -> 3.93s,
                                             8 -> 1041 MDS requests
     ls -l of a 52-entry snapshot dir:        0.64s -> 3.62s

   Backup workloads that read from .snap will notice.  Can this be
   limited to clients that actually have quarantined state, or driven
   by an MDS notification instead of per-operation requests?

2) Blocking read() and getdents() can fail with EAGAIN.  With one
   subvolume quarantined, a file outside it at depth 300 gave 24 EAGAIN
   out of 20000 preads and 16 out of 20000 listdirs, while another task
   was creating, renaming and listing files on the same mount.  The
   ancestry walk stops at 256 levels, the result is CEPH_Q_UNKNOWN, and
   ceph_quarantine_revalidate() returns -EAGAIN when a splice is in
   progress, the epoch is odd, or after three requests.  Callers pass
   that straight to userspace.  Disconnected aliases (NFS re-export,
   open_by_handle_at) should hit the same path.  These calls should
   wait or retry rather than fail.

3) Some changes apply to every mount whether or not the MDS supports
   quarantine: ACL_DONT_CACHE on all inodes, and quarantine_lock plus
   two atomics on every d_splice_alias()/d_instantiate()/cross-directory
   d_move().  Please gate them on the feature.


For reference, overlapping grants such as "allow rw fsname=a, allow rwq
fsname=a path=<subvol>" (in either order) deny quarantined access with
both the kernel client and ceph-fuse, so that one is on the MDS side,
as the cover letter says.

Thanks,
Xiubo

On Sat, 17 Oct 2026 at 16:48, Alex Markuze <amarkuze@redhat.com> wrote:
>
> CephFS subvolume quarantine isolates a subvolume while allowing access
> by recovery clients with q/Q MDS auth caps. The kernel client currently
> does not advertise quarantine support, so the MDS can hold its requests
> until quarantine is lifted.
>
> This series handles MClientCaps v14 quarantine notifications, checks
> cached data and metadata access, and handles disable notifications.
> Fresh MDS replies allow recovery after a lost disable. It applies directly
> to the base below and has no fscrypt prerequisite.
>
> The first patch exports d_find_alias_rcu() to GPL modules. The remaining
> three patches add the wire definitions, record quarantine state and
> ancestry generations, then install the access checks before advertising
> the session feature.
>
> Changes since v2:
> - Add the VFS export prerequisite to fix the undefined d_find_alias_rcu
>   symbol reported by the kernel test robot with CONFIG_CEPH_FS=m.
>   The fix carries Reported-by and Closes tags.
> - Keep all three Ceph patches unchanged from v2.
> - Replace object-only compile validation with a complete W=1 kernel and
>   module build using GCC 14.2.0 and the robot's x86_64-rhel-9.4 config.
>
> Validation:
> A complete W=1 build with the kernel.org GCC 14.2.0 toolchain and the
> robot's x86_64-rhel-9.4 config after olddefconfig passes. It produces
> vmlinux, bzImage and all 2,233 configured modules, including ceph.ko and
> libceph.ko. MODPOST succeeds, and Module.symvers contains the GPL export
> of d_find_alias_rcu. Configuration changes are limited to olddefconfig's
> toolchain capability normalization; there are no manual config changes.
> W=1 warnings remain elsewhere in the kernel; none come from Ceph or
> dcache.c.
> All four patches pass strict checkpatch and apply in order to reproduce
> the tested source tree. Seven deterministic source-extraction regression
> runners pass; the ASan/UBSan/LSan VFS runner also demonstrates the remaining
> cached encrypted-readlink bypass.
>
> Known limitation: cached encrypted symlink targets can bypass quarantine
> checks. fscrypt populates inode->i_link, which the VFS can use for readlink
> or symlink traversal without calling Ceph's get_link operation. Uncached
> encrypted targets and plaintext symlinks still pass through Ceph's checks.
> Closing the encrypted-target cache gap needs the separate fscrypt support
> and Ceph opt-in follow-up.
>
> Live cluster, KASAN/lockdep, multi-MDS recovery and depth benchmarks have
> not been run for this version. Existing snapshot mappings need server
> notifications to revoke already installed PTEs. Disable messages carry
> no generation, so same-rank ordering relies on ordered MDS delivery.
> Recovery assumes the intended rwq/rwQ delegation; overlapping ordinary
> rw and read-only q/Q grants still need server-side cap filtering.
>
> v2: https://lore.kernel.org/r/cover.1792074165.git.amarkuze@redhat.com
> Robot report:
> https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
>
> Alex Markuze (4):
>   dcache: export d_find_alias_rcu() for modular filesystems
>   ceph: add subvolume quarantine wire definitions
>   ceph: record subvolume quarantine from MDS cap updates
>   ceph: fail quarantined subvolume access with EACCES
>
>  fs/ceph/acl.c                |  28 +-
>  fs/ceph/addr.c               |  72 ++-
>  fs/ceph/caps.c               | 291 +++++++++++-
>  fs/ceph/debugfs.c            |   1 +
>  fs/ceph/dir.c                |  51 ++-
>  fs/ceph/file.c               | 117 +++--
>  fs/ceph/inode.c              | 841 ++++++++++++++++++++++++++++++++++-
>  fs/ceph/ioctl.c              |  13 +
>  fs/ceph/mds_client.c         |  23 +-
>  fs/ceph/mds_client.h         |  26 +-
>  fs/ceph/super.c              |   2 +
>  fs/ceph/super.h              |  80 +++-
>  fs/ceph/xattr.c              |  54 ++-
>  fs/dcache.c                  |   1 +
>  include/linux/ceph/ceph_fs.h |  13 +
>  net/ceph/ceph_common.c       |   2 +
>  16 files changed, 1482 insertions(+), 133 deletions(-)
>
>
> base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
> --
> 2.34.1
>
