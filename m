Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2253C3C0E
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716379; cv=pass; b=u9skFMJwLHkHopUY7DHdhuBk0Bl9N4t27uFflpVDwBax5Sj7PgS7XgN36RrBlZM8HNIDXNG3KlxbARP/cAg4PBLq9duzciEcNcOj/KTlx7WwzVZceCrNW2ahWMDoC+d9Lkf8X+J/5CbFc/uK1yEd/WtXlBxrz2dh/WHzEP8Q4BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716379; c=relaxed/simple;
	bh=n6ym533tI9X4A+vTCccKlmH4/q2ObDK27zNE5dOfzKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpfScP7+eyWTq6qznlodsVeW3EfEKJjTqAwhGjxfINPYmJIwHEeTAc6e8ieeknIlnNn5E5RO8aWbKmIJZtrnHVX+eE3E9Oaxad6IAvP3hVpHSa5mklG9ELJuABbeG0aA2rIXd2A+HF3b586uc75qYhqfeICY8+QrI371L0ZPGK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7ffKQy4; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7ffKQy4"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c565476d7so7358702c88.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 13:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776716377; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4eUzLVpc+xgBGZN3I80xR/5dzM9gSN5AVcHbB/nTMIZhphB4t99992Y5JThAWnzEe
         CqV0R5MoAXX5dNyeniSkAoOY2gNyVPoZuKu4TVA5t2mjwEVuyv5PZAMNsMzMXwdvJhkb
         VYhjnSVBLwOh7il9h+Dw2NL54paHsZbKDiTwxkatN1TqSSncwFvgXWY/xQ4To4X1dhkI
         r3mKEcmpzi0Frf3UViQfW5NcZkNkZH4/NRdPGQliotpOgFVeBEHkX0Q3pbshNniffuQp
         ljy0NqPo8GF4jeeqnXtmcWJ6/LepqjWSM+cO2EV1qVUaOc8bznb7rP2ySagrWJi9WsXS
         p0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FDLi2AIEvf/8R/CKyK1q6WR933rqVLVDLFbXt/wFzeE=;
        fh=fTo8iPluxm5Mj2f8vmgktyLRgwhsK59Gb8MrczbkuSg=;
        b=jvX/infkCD7B1lHUApqjN2uPzzbnszdXzgihbOdDZyuwgVXzbAW3HpG6wyjNFMEMMt
         +7VnFkORmKMEkilktBB45ifZLo3tR22UKJ7zYnkcJlaxsQZl0f33p/Tl/o+17wHCsDHC
         pIGlEeOPqWL5YXwSdwV8BJmcEEQbKie71MJuEIpGL+jPq17vWZenA0NDdf1v2ufzFZZc
         P3olzCjQraup4hIx4mWmPxaNSmRTTpF/gnaBwQnCqSPXTkPkAE8Pmp2WmgQ/IWuSe7tb
         jrLOjFCp3mMNmd9rDpU2A8aAdc3wrPVRo5dykk1RT7WEGJ5oAJyH2MGPdbVg/wO65zAV
         3hEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776716377; x=1777321177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDLi2AIEvf/8R/CKyK1q6WR933rqVLVDLFbXt/wFzeE=;
        b=C7ffKQy44m4ZxbpuAU5mPeNwWgUwzmXO7L5cLcQ72XyL9K2REzPgFaZVYwBz+Imo9k
         3kCcUZBLYZVYwZ0E9/DXoRIQelEPss6G9vbrQ70maGYmDmAV/jeFBOwO/SAWgsW2UDO3
         KizEnyRxHU3UiW9Yl3We4RlWSoYWmOSZw9swqb7BTN6SL3t4cHziCSVHbIqA1ALwl6EQ
         m54g8pHAwzMnBIeOfr4ncTtxDIcixXgtbyMx31gyh/9Kd6p5mNlaYIJIQAj0W2YuJpSL
         yquBk+tn17bSblysF2CP3Rly02NFXHdrL2R1Dishkto7BK3XtjmZxKayBx1IxhdEcYWT
         eB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716377; x=1777321177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDLi2AIEvf/8R/CKyK1q6WR933rqVLVDLFbXt/wFzeE=;
        b=MZh0e5/Kq4H+toRalZk2V8dGrWhH7oc4Z0W8i3z+2ZfClvUjOTb4xpmI3PpRl8Oypw
         3Gw0WBJKz8Er8eDU7R98KBUVFqwk8QxsyHH2oc0DXkgj8Exp3z6/01cfjgw8pI3S1nXJ
         s8WBz6mG3Y3H1NWX4IVF1Kyqb3dH8H5VegeeghUo2ejYrO1oXA0xZoVF5pZPPF6qPhCF
         y5Ap2I5OlhPrkCxAqGxNbYB+34OHznisb9cb4Y7oh9A0yYTS3MCsCdeGIf52JDkitogc
         cRB1cW18B1yD8nBdm+M+Emb1hJuXiOvJbYtyTPMmYEgVmp553/XAvLjRhSg6Fq+FuC8X
         ROSA==
X-Forwarded-Encrypted: i=1; AFNElJ9MFgoPPDvhRZnMy8WImdS0gBRBVX9jmG45RsknpweZQ+QGpFqGJLAcprDiPAdIiBUfqvQgdwfzdjf7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmhr8LzDT3UDXfLBFekk8fNLq0/istUiCRgBMahbHku87TbXek
	a4ijqx/NJl9SMueeMvMc4Pc+ECFTOWhTuEbq8E95Qdf3RE+TG7E3BhiNkRxLbhORtDSyndJUSiI
	sPngirY50cAW4rmaSU0VBe0x65NWWAvU4qkBV
X-Gm-Gg: AeBDiesAAZbJy9NC72drjOmpW+I1xU03ClIphgdT0RBJpoC32Wq5ExB9PDtPy6/vYzv
	ZeWkfd2IGei6hXaq9L7jp5ed5f99zPfMsKVBSVIrCFE/FH9LRk6Ssg9bLa9mtuIC/NIAeVZVTEY
	GzBcPIDiSQ4G5xRTe44wmwWQPZog0L/j5Jk5ixVbYvG3aY7Jnyy4odI2hHdAa4PU2UvhxPylKth
	gF8SDRsxePqsJz+LcyGzD5lC1POteAFkPMf5nSph8hyqZ1DPsu7Gr+jZAGdSVEVuaqKErBw1xEk
	e/FSZAHA5MQEStT8cQ==
X-Received: by 2002:a05:7022:388f:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12c73f6d905mr8911688c88.6.1776716376624; Mon, 20 Apr 2026
 13:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419090348.1817082-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260419090348.1817082-1-dawei.feng@seu.edu.cn>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 20 Apr 2026 22:19:24 +0200
X-Gm-Features: AQROBzDaUIcoZgaW9hqmajL0d6VdpXPApMsC-41ShvD5oOsBEcAdne8_Gp_irWE
Message-ID: <CAOi1vP9haWQQ5UAGuz1GrtL68Yc=w_od4a9GV8gfVoqKMyVn3Q@mail.gmail.com>
Subject: Re: [PATCH] rbd: fix null-ptr-deref when device_add_disk() fails
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: axboe@kernel.dk, dongsheng.yang@linux.dev, mcgrof@kernel.org, 
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org, 
	Zilin Guan <zilin@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 11:05=E2=80=AFAM Dawei Feng <dawei.feng@seu.edu.cn>=
 wrote:
>
> do_rbd_add() publishes the device with device_add() before calling
> device_add_disk(). If device_add_disk() fails after device_add()
> succeeds, the error path calls rbd_free_disk() directly and then later
> falls through to rbd_dev_device_release(), which calls rbd_free_disk()
> again. This double teardown can leave blk-mq cleanup operating on
> invalid state and trigger a null-ptr-deref in
> __blk_mq_free_map_and_rqs(), reached from blk_mq_free_tag_set().
>
> Fix this by following the normal remove ordering: call device_del()
> before rbd_dev_device_release() when device_add_disk() fails after
> device_add(). That keeps the teardown sequence consistent and avoids
> re-entering disk cleanup through the wrong path.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available.
>
> We reproduced the bug on v7.0 with a real Ceph backend and a QEMU x86_64
> guest booted with KASAN and CONFIG_FAILSLAB enabled. The reproducer
> confines failslab injections to the __add_disk() range and injects
> fail-nth while mapping an RBD image through
> /sys/bus/rbd/add_single_major.
>
> On the unpatched kernel, fail-nth=3D4 reliably triggered the fault:
>
>         Oops: general protection fault, probably for non-canonical addres=
s 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>         KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000=
0007]
>         CPU: 0 UID: 0 PID: 273 Comm: bash Not tainted 7.0.0-01247-gd60bc1=
401583 #6 PREEMPT(lazy)
>         Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1=
 04/01/2014
>         RIP: 0010:__blk_mq_free_map_and_rqs+0x8c/0x240
>         Code: 00 00 48 8b 6b 60 41 89 f4 49 c1 e4 03 4c 01 e5 45 85 ed 0f=
 85 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 e9 48 c1 e9 03 <80> 3c =
01 00 0f 85 31 01 00 00 4c 8b 6d 00 4d 85 ed 0f 84 e2 00 00
>         RSP: 0018:ff1100000ab0fac8 EFLAGS: 00000246
>         RAX: dffffc0000000000 RBX: ff1100000c4806a0 RCX: 0000000000000000
>         RDX: 0000000000000002 RSI: 0000000000000000 RDI: ff1100000c4806f4
>         RBP: 0000000000000000 R08: 0000000000000001 R09: ffe21c000189001b
>         R10: ff1100000c4800df R11: ff1100006cf37be0 R12: 0000000000000000
>         R13: 0000000000000000 R14: ff1100000c480700 R15: ff1100000c480004
>         FS:  00007f0fbe8fe740(0000) GS:ff110000e5851000(0000) knlGS:00000=
00000000000
>         CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>         CR2: 00007fe53473b2e0 CR3: 0000000012eef000 CR4: 00000000007516f0
>         PKRU: 55555554
>         Call Trace:
>          <TASK>
>          blk_mq_free_tag_set+0x77/0x460
>          do_rbd_add+0x1446/0x2b80
>          ? __pfx_do_rbd_add+0x10/0x10
>          ? lock_acquire+0x18c/0x300
>          ? find_held_lock+0x2b/0x80
>          ? sysfs_file_kobj+0xb6/0x1b0
>          ? __pfx_sysfs_kf_write+0x10/0x10
>          kernfs_fop_write_iter+0x2f4/0x4a0
>          vfs_write+0x98e/0x1000
>          ? expand_files+0x51f/0x850
>          ? __pfx_vfs_write+0x10/0x10
>          ksys_write+0xf2/0x1d0
>          ? __pfx_ksys_write+0x10/0x10
>          do_syscall_64+0x115/0x690
>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>         RIP: 0033:0x7f0fbea15907
>         Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3=
 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d =
00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>         RSP: 002b:00007ffe22346ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00001
>         RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007f0fbea15907
>         RDX: 0000000000000058 RSI: 0000563ace6c0ef0 RDI: 0000000000000001
>         RBP: 0000563ace6c0ef0 R08: 0000563ace6c0ef0 R09: 6b6435726d694141
>         R10: 5250337279762f78 R11: 0000000000000246 R12: 0000000000000058
>         R13: 00007f0fbeb1c780 R14: ff1100000c480700 R15: ff1100000c480004
>          </TASK>
>
> With this fix applied, rerunning the reproducer over fail-nth=3D1..256
> yields no KASAN reports.
>
> Fixes: 27c97abc30e2 ("rbd: add add_disk() error handling")
> Cc: stable@vger.kernel.org # 5.16+
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e7da06200c1e..d92730d8c342 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -7165,7 +7165,7 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
>
>         rc =3D device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
>         if (rc)
> -               goto err_out_cleanup_disk;
> +               goto err_out_device_del;
>
>         spin_lock(&rbd_dev_list_lock);
>         list_add_tail(&rbd_dev->node, &rbd_dev_list);
> @@ -7179,8 +7179,8 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
>         module_put(THIS_MODULE);
>         return rc;
>
> -err_out_cleanup_disk:
> -       rbd_free_disk(rbd_dev);
> +err_out_device_del:
> +       device_del(&rbd_dev->dev);
>  err_out_image_lock:
>         rbd_dev_image_unlock(rbd_dev);
>         rbd_dev_device_release(rbd_dev);
> --
> 2.34.1
>

Applied.

Thanks,

                Ilya
