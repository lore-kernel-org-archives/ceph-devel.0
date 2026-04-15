Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9A3E8C72
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273405; cv=pass; b=A8+tNeqSn50OxFocO91wKw35XZjrc18H96N+rq85nPzC/9VKLBt0ugqtBQC7yb601/NkKhXfVxmXgpqF7ueihHocBJaXcat79kd3lcopN5/OjRo6Fc4TBkcVcNWEqpWMF74ZwNJw1I9+lYSGiN80Oj8g2LgkdbQxKaoij5j1GZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273405; c=relaxed/simple;
	bh=QWAUcQc0qJBh6920IbbO3/kNnwD9XxBJza6Fy4+GVhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWhyr77QybVZ+nPXyzIjMyxC7gFRIV4iKkj5LD7GvFwBeGCvjPNU5AJ272eygigxpVXTRNTCm2Wve0E5M9d5F1o9EKCsoy2efEImKSt8KZbEJeVzN8CBoAxR5dCMbEiB9kvdNOvlYVegMgeZRDw19q2Fe0geV8NG4A9CmYIr2ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF1YYl0u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o044Ynfv; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF1YYl0u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o044Ynfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776273400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgmBGQrjLYib2UHPFN4qv/nktVSw6tKmvZ/b10M6ye8=;
	b=RF1YYl0uR3LZqnhr2Zcv/HsHvEoznmahzOOngoe2cvB7+A/qrOpsdoLCPJZGDL/6Mxa2L+
	vZ9nMhncLR5w7zyPeHMiavDoCQ/Ac6ABKFu7+D8POjvpbR10UWOyQ8sUKy21l8dtdBZwO3
	79EkpRgx+C5XJavWCEuglnNDV/V8REY=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-bJlZYBNkP0O3niG2GEhaHQ-1; Wed, 15 Apr 2026 13:16:39 -0400
X-MC-Unique: bJlZYBNkP0O3niG2GEhaHQ-1
X-Mimecast-MFC-AGG-ID: bJlZYBNkP0O3niG2GEhaHQ_1776273399
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f60dde1d6so3451191e0c.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776273399; cv=none;
        d=google.com; s=arc-20240605;
        b=kgJhXdAmRyrkOaJghvTKRvaS8ZzRAumlK6VaAwNo4IKuQ0TjHZrH5/nZ2XXErWV9xL
         v0e7sml3H6PXz27J92m/WgVUCCe0DZO4qVt62EjRLszQy+SepxUE2Qs0wVF5swalhfx1
         uiM99/cisdw6SHm7OoTYkUXoYTJFRktAV8LSbdaDVdY9kifFsVz1PuzatT4WNb0mm9ov
         tPzppGnAOlBzT4WI2RWcDlcGSqOzsqI/M/byE1RERcFfWP+adXPmMzN/j3+MV3kI2pyb
         RvUnMepzE4jcbi42kC7rGgyeBVMwXua5pB/sWwM6mbdrzAGWZUD9rT8yh1FFbo329Tmg
         mJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wgmBGQrjLYib2UHPFN4qv/nktVSw6tKmvZ/b10M6ye8=;
        fh=VziYrT7s5A2unEluGFxahwhENDdf6KgUsRfQWeM6IeE=;
        b=cnfqiDunoHSWJ+O77MGqsj0UMATFD7Cz2rvYzShHxadfJA9CQny3SYuicG4bMmyqDm
         Cwp9cPFdBFQYuESvzqiSbB+tlXiuV9dhkd8+snlYr9gC4+ytkJhekjmlvdbqnA9ljs2E
         ASQ/LTnlbjUYaUAQpve268Ad0Dpu/oKWGPKeDKdNif9oezdpHhdDuGQSSr+/zlht2VaI
         qQ4Q/qoP0I4gchw/wHlV5kEL7ugJZXaGAjjeDDz42Kog7eB8EhEBAHGUnXZFB9rn9iOg
         hWUjXjs3yqw/sCJWICs5JF310117wlF/HP4dvl0mCOphZkqHWILGCjYD3tHTjIbAZzX9
         5qFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776273399; x=1776878199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgmBGQrjLYib2UHPFN4qv/nktVSw6tKmvZ/b10M6ye8=;
        b=o044YnfvVXB7KjCR1ZnCLoRuMWI3A2OApNwkRGlau1brsz9DQjMPG9lZxhXv2WDHjk
         fuOh1+pe/jDXd3/8Q6o+EGlCYiLR6L/lVnrjJoMqQ4zS++SNnRgl8oEok58sEniaDJuq
         vGk+41g5p/nSrbns96CevBSoUOrA3W3HEEpW3F/NR7vQJKyDUUhEvBzjxaNDMz08gHCA
         6q136nso6lsy563LlT3m/An8F/CYROj/03Kr/Kmvq9MMpKmdqrsnZ8hOvLy6sTO1mWKz
         1KdEQaJChscwmVWAWFJjwfiMBFSYDYrjbVbtAoktmGGo43AOSy0fGyeDuPaIxZbL59DD
         UWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273399; x=1776878199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgmBGQrjLYib2UHPFN4qv/nktVSw6tKmvZ/b10M6ye8=;
        b=FmvMUCL+UrEbGtQWFEoCLDaoBv9s8Yi0HnsdIBAoZb+xnfHp9moGwAs4dOYaDFSPzq
         rZ8K+fXFbAEIs2EdFlsVnPP0cEezp5Zs3vWIl6VfWwyWzW3L6UGcvcEz/PttpYDHUwNw
         FdFP+zeXQsznlkzG9+MSatZ50gpp3pXvX7vLb+Yf6h08Yo3aSH5sXU4HcOLGbv7Bj/x9
         /G4PFQxadg4R39JODlwtJcJGYhm4RLZ/YbLfA3fGfjGq9nHNL0cqhfCKZAF6MHqRzq9A
         tQnDpwBs+mF3kdd88fUHvRDy4jox8VPwQsgIkJv2BNCVggzQwKAud/RJK9Ni1cHDRWuX
         kczw==
X-Forwarded-Encrypted: i=1; AFNElJ9Pux+Jzqhqt/zPFSPw9ast3ruTF6fEhkK49FrvbGkVLfjlZi+eFnLsabL4j9A0mXRO7bJhPWJ293Zl@vger.kernel.org
X-Gm-Message-State: AOJu0YzwK2DJe3YZavsSXsjG/cNwCNMx3dKJwkps/DIxTaNRjdruX5LM
	UnZy17HnqD+IQtL4CYyBsXlgBlmZUgAGDvAR5lT2c2Ockj+7iErx9D2JrpajXVrDIriT8DO0+8i
	Z0oxiYxyWAHo3/dAChr+GEKA8XnL8LBIf/Wi8LEeDZFNl7zg3CA58qcj4xoXufCambJ15Im+M5D
	pkUjdF67TlvfV4qqF4notK9e4Y41mtC5HHShrsxg==
X-Gm-Gg: AeBDieus5CBknY+NvG7MruTdaLa5UDSbRTpGdHgyN3cs+Bi3WahdlpQLAYR5rot1mYB
	wRE0jrslNVbYfy2So/yhXHIhBI82H3BdAdWExlvGM30t1xv/k9a9xjndOvd8y7COJzBfLRfON1G
	nhr0m6GwudvEVBIu4ihmlip0t3d1JOMPN922HX/3rvnsme525OIlpRz+BSUkTOaHy6MpZkabzSy
	NilqwAD60Cjd4PN
X-Received: by 2002:a05:6122:322c:b0:566:2711:d8ab with SMTP id 71dfb90a1353d-56f3bc521a8mr10936595e0c.6.1776273398725;
        Wed, 15 Apr 2026 10:16:38 -0700 (PDT)
X-Received: by 2002:a05:6122:322c:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56f3bc521a8mr10936515e0c.6.1776273398185; Wed, 15 Apr 2026
 10:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415034020.11530-1-CFSworks@gmail.com>
In-Reply-To: <20260415034020.11530-1-CFSworks@gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 15 Apr 2026 20:16:27 +0300
X-Gm-Features: AQROBzCpBFUtPiVTyJVQ6YVeZkSPkso5-AFkhdGsfuLauxhzpg6iaBCDEt6SyaM
Message-ID: <CAO8a2SjHobzPFQYe2YSx119pcepKm_ECUkYQ6=t_i_ZcCbRu1g@mail.gmail.com>
Subject: Re: [RFC/BUG] Use a bounce buffer for mds client decryption
To: Sam Edwards <cfsworks@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Nice find. The diagnosis is correct and I like the bounce buffer approach.

A few things for v2:

1. Typo in the comment: "fscript_str" should be "fscrypt_str".

2. The assignment-in-if is nice but limits readability:

```c
if ((err =3D ceph_fname_alloc_buffer(inode, &bname)))
```

Split it:

```c
err =3D ceph_fname_alloc_buffer(inode, &bname);
if (err)
        goto out_bad;
```

3. The `BUG_ON(oname.len > bname.len)` should be a `WARN_ON_ONCE` with
an error return instead. New `BUG_ON`s in data-dependent paths are
unlikely to pass review.

4. The copy-back block is correct but not obvious at a glance. A short
comment explaining why you need to copy back out of the bounce buffer
(rde->name must point into the long-lived front buffer) would help.

5. `parse_reply_info_trace()` has the same latent bug. It stores
`info->dname` and `info->altname` as raw pointers into the front
buffer. When the LOOKUPNAME path in `ceph_fill_inode()` later passes
`fname.ctext =3D rinfo->altname` to `ceph_fname_to_usr()`, that pointer
hits `sg_init_one()` in `fname_decrypt()` as the source scatterlist.
The output buffer is separately allocated so it's fine, but the input is no=
t.
6. Also, let's add an `unlikely` on the is_vmalloc_addr

Thanks,

On Wed, Apr 15, 2026 at 6:40=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> Hi Ceph list,
>
> This is a combination RFC and bug report. I'm holding off cleaning up the=
 patch
> until I get confirmation that this is the right approach. There are some =
edge
> cases stemming from complexities in ceph_fname_to_usr(), making this patc=
h into
> more of a shotgun bugfix than I'd like.
>
> I have thoroughly tested this patch: In my live (AArch64) environment, ce=
rtain
> workloads would trigger this particular oops->panic 3-5 times per day. Si=
nce I
> applied this patch ~2 weeks ago, I get no further panics. I do not think =
my MDS
> contains any base64-only dentries, however.
>
> Bug description
> ---------------
>
> On architectures that implement flush_dcache_page() (most of the non-x86 =
ones),
> scatterwalk_done_dst() will attempt to flush each page of the destination=
 when
> a skcipher decryption completes. If passed a destination buffer that isn'=
t in
> the linear region, virt_to_page() yields a bogus `struct page *`, leading=
 to a
> kernel oops/panic.
>
> For this reason, sg_set_buf() requires a linear buffer (and will assert i=
t with
> BUG_ON, if the kernel is built with CONFIG_DEBUG_SG). By extension, that =
means
> `fscrypt_str`s must only point to kmalloc() buffers.
>
> The MDS client's parse_reply_info_readdir() invokes fscrypt in-place, reu=
sing
> the message's `front` buffer. However, ceph_msg_new2() allocates the `fro=
nt`
> buffer with kvmalloc(), which attempts kmalloc() (linear region) allocati=
on
> first, then falls back to vmalloc() (vmalloc region) if that fails.
>
> This means that: when physical memory is fragmented, fscrypt is enabled, =
MDS
> responses are rather large, and the host architecture implements
> flush_dcache_page(), the CephFS client will oops/panic.
>
> Reproduction steps
> ------------------
>
> 1. Build the kernel with the following configs enabled:
> - CONFIG_DEBUG_SG
>   - This enables a BUG_ON() to confirm that only linear virt addresses ar=
e
>     passed to sg_set_buf(); this is necessary to see the issue on x86
>     (on ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE archs like arm/64, MIPS, RISC-V=
, etc.
>      the oops will happen on flush)
> - CONFIG_FAULT_INJECTION
> - CONFIG_FAILSLAB
> - CONFIG_FAULT_INJECTION_DEBUG_FS
>
> 2. Create a directory in CephFS, encrypt it with fscrypt, and populate it=
 with
>    10 files:
> ```
> cd /path/to/cephfs
> mkdir fscrypted
> fscrypt encrypt fscrypted
> seq 1 10 | while read i; do touch fscrypted/file$i; done
> ```
>
> 3. Enable fault injection on kmalloc, so that 1% of kvmalloc() attempts u=
se the
>    vmalloc() fallback:
> ```
> echo -1 > /sys/kernel/debug/failslab/times
> echo 0 > /sys/kernel/debug/failslab/interval
> echo 1 > /sys/kernel/debug/failslab/probability
> ```
>
> 4. Repeatedly retrieve/decrypt the directory listing:
> while true; do ls fscrypted >/dev/null; sysctl -q vm.drop_caches=3D1; don=
e
>
> 5. Within 3-10 seconds, expect an oops like:
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 1474 Comm: kworker/0:2 Not tainted 7.0.0-rc6 #79 PREEM=
PT(lazy)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_=
120124-localhost 04/01/2014
> Workqueue: ceph-msgr ceph_con_workfn
> RIP: 0010:sg_init_one+0x88/0xa0
> Code: [[[SNIP SNIP]]]
> RSP: 0018:ffffbb730042f618 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffbb73001591b7 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000020 R08: ffffbb73001591b7 R09: ffffbb730042f638
> R10: ffff97e7c42cc630 R11: 0000000000000000 R12: ffffbb730042f638
> R13: ffff97e7c42cc630 R14: ffffbb730042f658 R15: ffff97e7c3937000
> FS:  0000000000000000(0000) GS:ffff97e865a61000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe46ff2f000 CR3: 0000000003bb9000 CR4: 0000000000350eb0
> Call Trace:
>  <TASK>
>  fname_decrypt+0x10b/0x1b0
>  fscrypt_fname_disk_to_usr+0x14d/0x1b0
>  ceph_fname_to_usr+0x1df/0x2f0
>  ? __pfx_crypto_cbc_encrypt+0x10/0x10
>  ? crypto_lskcipher_crypt_sg+0xf7/0x140
>  ? ceph_aes_crypt+0x1d7/0x2b0
>  ? __kmalloc_noprof+0x19c/0x570
>  ? ceph_decode_copy+0x13/0x30
>  parse_reply_info+0x49d/0x9c0
>  mds_dispatch+0x890/0x2000
>  ceph_con_process_message+0x72/0x140
>  ceph_con_v1_try_read+0xaf9/0x1cc0
>  ? put_prev_task_fair+0x1d/0x40
>  ? finish_task_switch.isra.0+0x90/0x2c0
>  ceph_con_workfn+0x2e0/0x6e0
>  process_one_work+0x192/0x3a0
>  worker_thread+0x1aa/0x330
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xde/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d7/0x360
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
>
> 6. If unable to repro with 10 files, try again with 5, 15, and 20. The md=
s
>    readdir reply's front section needs to be a particular size: if it's o=
ne
>    page or smaller, kvmalloc() does not attempt the vmalloc() fallback; i=
f it's
>    larger than KMALLOC_MAX_CACHE_SIZE (2 pages), kmalloc() doesn't respec=
t
>    failslab (this is apparently an oversight in failslab).
>
> Summery of changes
> ------------------
>
> All changes are in parse_reply_info_readdir():
>
> - Move the `inode`/`ci` declaration/initialization out of the loop; they =
are
>   loop-invariant anyway, and we need the directory's inode before enterin=
g the
>   loop.
>
> - Add a `struct fscrypt_str bname` to serve as a bounce buffer.
>
> - Any time *p is in the vmalloc region, call ceph_fname_alloc_buffer() to
>   attempt to allocate the bounce buffer. This is very rare (it only happe=
ns if
>   kmalloc() fails) and only does anything if the directory has encryption
>   enabled. The bounce buffer is reused for all filenames in the readdir
>   response, therefore I allocate it only once, before entering the loop.
>
> - Let oname/ctext/tname be initialized normally, but if the bounce buffer=
 is
>   active (indicating it *must* be used):
>   a) If there is an `altname`, then this is a binary blob of the cipherte=
xt,
>      and ceph_fname_to_usr() will use it directly; copy it into the bounc=
e
>      buffer.
>   b) If there is no `altname`, then ceph_fname_to_usr() will perform base=
64
>      decoding on `name` into `tname`. The bounce buffer need not be
>      initialized, but it's easy enough to have the memcpy() in there
>      unconditionally.
>
> - Redirect all potentially-crypted pointers into the bounce buffer. The u=
nused
>   ones are ignored by ceph_fname_to_usr():
>   - fname.ctext (ciphertext if `altname` is present)
>   - tname.name (ciphertext if `altname` is absent; base64 decoder buffer)
>   - oname.name (output for the plaintext filename)
>
> - After calling ceph_fname_to_usr(), if it chose to keep `oname.name` poi=
nted
>   at the bounce buffer:
>   - Restore `oname.name` to point to its original location in the `front`
>     buffer (which survives past the end of this function)
>   - Copy the plaintext back out of the bounce buffer to the long-lived bu=
ffer
>
> - Finally, free the bounce buffer with ceph_fname_free_buffer(), which is=
 a
>   no-op if the buffer was never allocated.
> ---
>  fs/ceph/mds_client.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b1746273f186..a583032c0041 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -414,6 +414,9 @@ static int parse_reply_info_readdir(void **p, void *e=
nd,
>  {
>         struct ceph_mds_reply_info_parsed *info =3D &req->r_reply_info;
>         struct ceph_client *cl =3D req->r_mdsc->fsc->client;
> +       struct fscrypt_str bname =3D FSTR_INIT(NULL, 0);
> +       struct inode *inode =3D d_inode(req->r_dentry);
> +       struct ceph_inode_info *ci =3D ceph_inode(inode);
>         u32 num, i =3D 0;
>         int err;
>
> @@ -441,10 +444,18 @@ static int parse_reply_info_readdir(void **p, void =
*end,
>                 goto bad;
>         }
>
> +       /*
> +        * `p` points into the message's `front` buffer, which ceph_msg_n=
ew2()
> +        * allocates using kvmalloc(), so the buffer may end up outside o=
f the
> +        * kmalloc() region -- but fscript_str.name must be in that regio=
n, so
> +        * use a bounce buffer in that case
> +        */
> +       if (unlikely(is_vmalloc_addr(*p)))
> +               if ((err =3D ceph_fname_alloc_buffer(inode, &bname)))
> +                       goto out_bad;
> +
>         info->dir_nr =3D num;
>         while (num) {
> -               struct inode *inode =3D d_inode(req->r_dentry);
> -               struct ceph_inode_info *ci =3D ceph_inode(inode);
>                 struct ceph_mds_reply_dir_entry *rde =3D info->dir_entrie=
s + i;
>                 struct fscrypt_str tname =3D FSTR_INIT(NULL, 0);
>                 struct fscrypt_str oname =3D FSTR_INIT(NULL, 0);
> @@ -514,6 +525,13 @@ static int parse_reply_info_readdir(void **p, void *=
end,
>                         oname.name =3D altname;
>                         oname.len =3D altname_len;
>                 }
> +
> +               if (bname.name) {
> +                       BUG_ON(oname.len > bname.len);
> +                       memcpy(bname.name, oname.name, oname.len);
> +                       fname.ctext =3D tname.name =3D oname.name =3D bna=
me.name;
> +               }
> +
>                 rde->is_nokey =3D false;
>                 err =3D ceph_fname_to_usr(&fname, &tname, &oname, &rde->i=
s_nokey);
>                 if (err) {
> @@ -521,6 +539,12 @@ static int parse_reply_info_readdir(void **p, void *=
end,
>                                       _name_len, _name, err);
>                         goto out_bad;
>                 }
> +
> +               if (unlikely(oname.name =3D=3D bname.name)) {
> +                       oname.name =3D (altname_len =3D=3D 0) ? _name : a=
ltname;
> +                       memcpy(oname.name, bname.name, oname.len);
> +               }
> +
>                 rde->name =3D oname.name;
>                 rde->name_len =3D oname.len;
>
> @@ -537,12 +561,14 @@ static int parse_reply_info_readdir(void **p, void =
*end,
>  done:
>         /* Skip over any unrecognized fields */
>         *p =3D end;
> +       ceph_fname_free_buffer(inode, &bname);
>         return 0;
>
>  bad:
>         err =3D -EIO;
>  out_bad:
>         pr_err_client(cl, "problem parsing dir contents %d\n", err);
> +       ceph_fname_free_buffer(inode, &bname);
>         return err;
>  }
>
> --
> 2.52.0
>

