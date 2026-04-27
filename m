Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46F37AA9D
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290769; cv=pass; b=uW6/v1/vcbBq1cHMLP2WFIssNT+2FX4k4ztMAPBTDp/zbOZ5D1hdONduLW/RvffnGXzUs5ipwdmGgU6fxcPf+eSdmVHowNihA7FBj4g7+kAEDAxnuE4TBwCi2aBiO/RmyokF1LJvh6cXyhT2IHiDErjgJS6rTeZz8g3plS/xk6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290769; c=relaxed/simple;
	bh=mW6xfD51fISefd74AaAVXg24MMunDfcHV6tMjic8yZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPUPH7AYAVBH6r23Nx1OtNeilvOaoanlj+36w6pfcO3VmygEtjIfRH1AhYcnT7JDUdVP6NhxTExYdWDwKQEDfqJClnYi1MOr0V0ryQl+0N1xVoeDditS3cUfrGwplZz1QyuSsGD9teB1mi/iZmlrHNIFCE6yngzJENlkIKh8rKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzvLeAO8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eic3kLTZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzvLeAO8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eic3kLTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777290763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35yQ1ZXrLseNUvPdD9JBLV9Gu1c3gObu9vcLmsz8Vt4=;
	b=AzvLeAO84jgIDB/RqnBh0H/kIMGbQ7gHuzJACeQHoRL6FMmK9dG7QLnIGosC7TyI/PptWX
	7oDRUhOdJZLkTdNDoSJIpA11A4VrHYptYL/lKCmX5UFTMThSQ3dWa/SDJFZwRkBtwoPaqe
	UOZqHbZBYmZSoJixXVWqa5LH/rxZHg8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-rpgI0IsvMX6gZ40_1qOWvg-1; Mon, 27 Apr 2026 07:52:42 -0400
X-MC-Unique: rpgI0IsvMX6gZ40_1qOWvg-1
X-Mimecast-MFC-AGG-ID: rpgI0IsvMX6gZ40_1qOWvg_1777290762
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-953e9d7ba08so4381736241.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 04:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777290761; cv=none;
        d=google.com; s=arc-20240605;
        b=ALad1lR1wOxN8Wom0EaoVeQI3F+rc9hr6NIYVByN6aWRyO1OzS5ikMY6YxMUXGSdrN
         DULwuYZxClQHb2vnnUtcQsNHsaj1BkitTOyTjg+CxBeilH0XwF/XZQefWwMFoc3CQ3wM
         sVb5oJsVxY4IhHXLy+JViy2izay4pNrejZLaL2mTX/JYDiUyf0uqqOdEKGoX0tSTX/aW
         7h/bpHZMWSg2pDN0oDg7YkD7H2t34m6g+eqiqiVDfjBP0tZsLEqarsyBvtjyHLoHWThU
         WBG/xGmM9SW/7C2jRSxsKzO1Koo9CeqlDCwrhl5m/THvrHPxSF2WiF41RbnAhjfHCexC
         e42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=35yQ1ZXrLseNUvPdD9JBLV9Gu1c3gObu9vcLmsz8Vt4=;
        fh=4sJrSkY7V8JT6AvZB1ZW0rR3MBJS7LN5g3XPU6S/PJI=;
        b=GTU2FQXpnJjK6Q3gG0mUwajVPZ5o+AIVLIBLi2hP/QQ5CqWi860KIDN2bQ3uWouZs/
         UpSlHqJJsQ6Ac2UretHy3GGmLK58HQfOUQ7O9mAkjj6BQFhJfOqBTUZhq98F07Ze6U5X
         /lk8QWeNtMGIkcKsmfCL72XWXt+BgdHJTDXEu/eHH0TAUohv1bwkYcX8d0EKrZkbNPkx
         Te1nqO1Q1Uaef13fJyKhK/pYU9rxFluEBjUlFIo9fc8vTrZIXXGy/emiOwPBMzVqRrOO
         tK0UNoflEA8VkkLvq8FFrx409NrMC0ktblTDX+707RpT15mB4TWw/SkruNQxvnuwoi0k
         pX2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777290761; x=1777895561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35yQ1ZXrLseNUvPdD9JBLV9Gu1c3gObu9vcLmsz8Vt4=;
        b=eic3kLTZI/pE+ig664+IZiovFQZlfYV5EhZ7/6N+U+LfNwbeHLCIgbBAM3Drv6iQzj
         TFKwo8BSP8RfpV0qX9nWw/FKWQg2+JpB4+FKWJ2Dd3StizW17KGRpV04nOD2liMe49Qw
         qNiXRMLvgWz0jig1pfhDEHxbfOMRYsI+hJu0FmKhOk8jMjtnM1xRpctW5hz1HGYbnm9I
         v84zZRsH6e+zZJGKzUNANDcuTNsD8XqobrQJCZTqcdmnPDjeYitkBmGEu1Q0c/6fkA/u
         zjeD6gT54gSjFgbcqmSH45t9Xg57QD5EZXeaUDwE32nBOyxV5EZ91CEUKyxKbqXmxmMZ
         3WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290761; x=1777895561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=35yQ1ZXrLseNUvPdD9JBLV9Gu1c3gObu9vcLmsz8Vt4=;
        b=Buwzzc5KuEnIYq5nKguopw/19TjtP4YrK4C0wYRc1cTOwrr0jjRh+eRtoj21w3RcZp
         fM9wsj+1ACJgWn/74bkJ6sKuOBI6P22GC0dlU7EAGkZRuMsd2Jif/QyBBus8kh7M0LK9
         rr+VHpjIUEfD/V06UWnWk19bQU7TpsahaPbtziU67jBqSEpMFdsHDJ9eif/hB2YMtoC1
         sXZ89AMtfBIbcPXeFk7L9NkqUgMQXT/bDpavrXbe3QWUgaMeECnQSh33q1o3UcEj732M
         OljPfcZRAo3EIWlC8U26/MZDH4eQfUUz1cwsqo38n8GJoaDN0I03fKZfSp7LQHp7i4Il
         4l0w==
X-Gm-Message-State: AOJu0YyqqUsKx3JLXzCiwSy158zfkEmSILpG+9/veBJkSGp2G4X9Y1XI
	bdBH7e3Hklymn+AhAQ/iLTJ94q38u8K6Tr3urWJ4YBWJQvAQn/iW30+OdCuGhqd0CtKaawB2GEq
	vO2L8DLbxIZyWBUe8CeiDN6/AfvJM3NIAvaHnBcoT4ZeQK7mhTnFMUYiMvrBokPruZRyIX6JfBn
	WnXL6glLtgAiURXjPyHP0uvnjOk/Sf2eMVaNN6Fw==
X-Gm-Gg: AeBDiesAtad2ORWv0nPSCmczZzvkIu0viPQoxppQPNpzOs5yLwFjrL9APWvGxHY7/Jc
	GYSykTVCH0oxH05VUpQvSs4jnKcKPNc9MwSM7J2IF/okkklBW1S/1sI43DhP3Zr8st+fRJYTkDo
	gLYpmBdpvK/AjyLO+Wm+X0chB2iNWqaxd/66Qi+b1UG4B0SMR2fKRqpZuyEz4Ay90gDwpWmWQtx
	qjqLYcd88sUx4M=
X-Received: by 2002:a05:6102:8547:20b0:61c:5310:e9d5 with SMTP id ada2fe7eead31-61c5310ed40mr8624254137.20.1777290761567;
        Mon, 27 Apr 2026 04:52:41 -0700 (PDT)
X-Received: by 2002:a05:6102:8547:20b0:61c:5310:e9d5 with SMTP id
 ada2fe7eead31-61c5310ed40mr8624242137.20.1777290761114; Mon, 27 Apr 2026
 04:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409200158.318567-2-slava@dubeyko.com>
In-Reply-To: <20260409200158.318567-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 14:52:30 +0300
X-Gm-Features: AVHnY4Kh-FaSVSdOgzo_TbYeTU0emEn26bVZMgokMIqeTgeTxafcpLpyoqSGBNY
Message-ID: <CAO8a2Sgov04JScA4FvXP4cXrTKLbAXqowC9dDsUOxJJzRL2KDg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to
 stale blob size
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Apr 9, 2026 at 11:02=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The generic/642 test-case can reproduce the kernel crash:
>
> [40243.605254] ------------[ cut here ]------------
> [40243.605956] kernel BUG at fs/ceph/xattr.c:918!
> [40243.607142] Oops: invalid opcode: 0000 [#1] SMP PTI
> [40243.608067] CPU: 7 UID: 0 PID: 498762 Comm: kworker/7:1 Not tainted 7.=
0.0-rc7+ #3 PREEMPT(full)
> [40243.609700] Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 1=
0.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [40243.611820] Workqueue: ceph-msgr ceph_con_workfn
> [40243.612715] RIP: 0010:__ceph_build_xattrs_blob+0x1b8/0x1e0
> [40243.613731] Code: 0f 84 82 fe ff ff e9 cf 8e 56 ff 48 8d 65 e8 31 c0 5=
b 41 5c 41 5d 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc cc cc <=
0f> 0b 4c 8b 62 08 41 8b 85 24 07 00 00 49 83 c4 04 41 89 44 24 fc
> [40243.616888] RSP: 0018:ffffcc80c4d4b688 EFLAGS: 00010287
> [40243.617773] RAX: 0000000000010026 RBX: 0000000000000001 RCX: 000000000=
0000000
> [40243.618928] RDX: ffff8a773798dee0 RSI: 0000000000000000 RDI: 000000000=
0000000
> [40243.620158] RBP: ffffcc80c4d4b6a0 R08: 0000000000000000 R09: 000000000=
0000000
> [40243.621573] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a75f=
3b58000
> [40243.622907] R13: ffff8a75f3b58000 R14: 0000000000000080 R15: 000000000=
000bffd
> [40243.624054] FS:  0000000000000000(0000) GS:ffff8a787d1b4000(0000) knlG=
S:0000000000000000
> [40243.625331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [40243.626269] CR2: 000072f390b623c0 CR3: 000000011c02a003 CR4: 000000000=
0372ef0
> [40243.627408] Call Trace:
> [40243.627839]  <TASK>
> [40243.628188]  __prep_cap+0x3fd/0x4a0
> [40243.628789]  ? do_raw_spin_unlock+0x4e/0xe0
> [40243.629474]  ceph_check_caps+0x46a/0xc80
> [40243.630094]  ? __lock_acquire+0x4a2/0x2650
> [40243.630773]  ? find_held_lock+0x31/0x90
> [40243.631347]  ? handle_cap_grant+0x79f/0x1060
> [40243.632068]  ? lock_release+0xd9/0x300
> [40243.632696]  ? __mutex_unlock_slowpath+0x3e/0x340
> [40243.633429]  ? lock_release+0xd9/0x300
> [40243.634052]  handle_cap_grant+0xcf6/0x1060
> [40243.634745]  ceph_handle_caps+0x122b/0x2110
> [40243.635415]  mds_dispatch+0x5bd/0x2160
> [40243.636034]  ? ceph_con_process_message+0x65/0x190
> [40243.636828]  ? lock_release+0xd9/0x300
> [40243.637431]  ceph_con_process_message+0x7a/0x190
> [40243.638184]  ? kfree+0x311/0x4f0
> [40243.638749]  ? kfree+0x311/0x4f0
> [40243.639268]  process_message+0x16/0x1a0
> [40243.639915]  ? sg_free_table+0x39/0x90
> [40243.640572]  ceph_con_v2_try_read+0xf58/0x2120
> [40243.641255]  ? lock_acquire+0xc8/0x300
> [40243.641863]  ceph_con_workfn+0x151/0x820
> [40243.642493]  process_one_work+0x22f/0x630
> [40243.643093]  ? process_one_work+0x254/0x630
> [40243.643770]  worker_thread+0x1e2/0x400
> [40243.644332]  ? __pfx_worker_thread+0x10/0x10
> [40243.645020]  kthread+0x109/0x140
> [40243.645560]  ? __pfx_kthread+0x10/0x10
> [40243.646125]  ret_from_fork+0x3f8/0x480
> [40243.646752]  ? __pfx_kthread+0x10/0x10
> [40243.647316]  ? __pfx_kthread+0x10/0x10
> [40243.647919]  ret_from_fork_asm+0x1a/0x30
> [40243.648556]  </TASK>
> [40243.648902] Modules linked in: overlay hctr2 libpolyval chacha libchac=
ha adiantum libnh libpoly1305 essiv intel_rapl_msr intel_rapl_common intel_=
uncore_frequency_common skx_edac_common nfit kvm_intel kvm irqbypass joydev=
 ghash_clmulni_intel aesni_intel rapl input_leds mac_hid psmouse vga16fb se=
rio_raw vgastate floppy i2c_piix4 pata_acpi bochs qemu_fw_cfg i2c_smbus sch=
_fq_codel rbd dm_crypt msr parport_pc ppdev lp parport efi_pstore
> [40243.654766] ---[ end trace 0000000000000000 ]---
>
> Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
> maximum xattr size") moved the required_blob_size computation to before
> the __build_xattrs() call, introducing a race.
>
> __build_xattrs() releases and reacquires i_ceph_lock during execution.
> In that window, handle_cap_grant() may update i_xattrs.blob with a
> newer MDS-provided blob and bump i_xattrs.version.  When
> __build_xattrs() detects that index_version < version, it destroys and
> rebuilds the entire xattr rb-tree from the new blob, potentially
> increasing count, names_size, and vals_size.
>
> The prealloc_blob size check that follows still uses the stale
> required_blob_size computed before the rebuild, so it passes even when
> prealloc_blob is too small for the now-larger tree. After __set_xattr()
> adds one more xattr on top, __ceph_build_xattrs_blob() is called from
> the cap flush path and hits:
>
>     BUG_ON(need > ci->i_xattrs.prealloc_blob->alloc_len);
>
> Fix this by recomputing required_blob_size after __build_xattrs()
> returns, using the current tree state. Also re-validate against
> m_max_xattr_size to fall back to the sync path if the rebuilt tree now
> exceeds the MDS limit.
>
> Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maxim=
um xattr size")
> Link: https://tracker.ceph.com/issues/55725
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/xattr.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 5f87f62091a1..31de29629ba8 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1254,6 +1254,22 @@ int __ceph_setxattr(struct inode *inode, const cha=
r *name,
>               ceph_vinop(inode), name, ceph_cap_string(issued));
>         __build_xattrs(inode);
>
> +       /*
> +        * __build_xattrs() may have released and reacquired i_ceph_lock,
> +        * during which handle_cap_grant() could have replaced i_xattrs.b=
lob
> +        * with a newer MDS-provided blob and bumped i_xattrs.version. If=
 that
> +        * caused __build_xattrs() to rebuild the rb-tree from the new bl=
ob,
> +        * count/names_size/vals_size may now be larger than when
> +        * required_blob_size was computed above. Recompute it here so th=
e
> +        * prealloc_blob size check below reflects the current tree state=
.
> +        */
> +       required_blob_size =3D __get_required_blob_size(ci, name_len, val=
_len);
> +       if (required_blob_size > mdsc->mdsmap->m_max_xattr_size) {
> +               doutc(cl, "sync (size too large): %d > %llu\n",
> +                     required_blob_size, mdsc->mdsmap->m_max_xattr_size)=
;
> +               goto do_sync;
> +       }
> +
>         if (!ci->i_xattrs.prealloc_blob ||
>             required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>                 struct ceph_buffer *blob;
> --
> 2.53.0
>

