Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47ED39E16A
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940037; cv=pass; b=uEJXf/KhkObZk5TIdSkZlcHFG22+WClI3lHtdh7DXDAx3KUhEYCYQhHfbMX1OF/CD5U5DblzYNK229+DvZg8ejvo1TOQAahMJVv6H5sNu3Q8oDploFTGDVGPbwF9uhnX8MMLR8jylneNJEjE13Okr/qtu60W2DxrvSYEuWnQDn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940037; c=relaxed/simple;
	bh=jKcgRTI0EmnB2TbudL3QNqoellPrBcwe9LrY2JeSlaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=keO2aOPqoXz3+hDsPMPK7Lh9kBabMb+ugM2XeYJK9QyIDkym86p/1rQ6MHAp9krial/MTmfSNtWVzBt9j7xgyS/m6VtnKJyJ2ay5PiezpmGfXwiZZW0VjijucXIn0PlcFMlLQ/YS2Jp49Ax0dlx56BTQ9UoO0t3ZtswGi8sM9WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WNhq4Ltg; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WNhq4Ltg"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b88593aa4dcso777083266b.3
        for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 05:33:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771940033; cv=none;
        d=google.com; s=arc-20240605;
        b=DGXxxfXUucrW4Tdq+qM9aH5/sZbaKjJCRs7nDMPytXk4Ivh3tRSAJUMgqJ8ZGI6gbX
         OCDxTjw/x4q1uyMHyivS6OK3CWTFK+OOIVzgXtXcVM1zKtENnLbO4Ab2q9d13NX0cs7I
         /orN5oT5xwq8kcsr4NfvPZ11iVHBJPKNPxcp+0206wGHOM3/oJLI+h6d9Z0TXwx2fG/h
         Bc8+siK20FqHzOuMfh2r4f8WZMRPEsFEFgiMSgNwB6MroCzGkQTQnkkB5C5TPJZRD4Jn
         QlH5VHW3nfD05UKI4ll5fYVKoWWso7PDorQ/08ezOQ8SMLZcHXnoJ4RRSYokfo7D7ueh
         5/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQbCTAy731qE2fQysIyFgqODRFmwAQU93PjyPNSpVHc=;
        fh=31nHhF9qKl7pIoUd1pgBa/WYwl6cca9yNbsK+CyyB6s=;
        b=B3b3OOjl5jKhHCPKc0u2FlFqP2Gm1v9qsqZUBJIDkwpFNE5+HQc02ge+NetxmFP+WL
         GLVcWrkiLPquhdEHo1uNZc6P+yvSKp8FYcDalO9jINkDSwTeTdfOccSri0+9cPLk1XXi
         tsyrsD/bT175VTIgDWgHdvJhmHY8qXrJka5//DwgN75qC+SA1AAY1Tne7SLw0R/CoFYM
         F+o8fJN4R/UmaO5/q8g+ospwxbrFPjWEMXrW/hZz2EqnNZDNUGWM3cg0N+I1rvk3miS2
         b121XossKlfmr+9xiSdioh77xNHqBP+zF9pco2A8ihVqQpbU2ZBBaYQ+LpKdRierLdkT
         Ctzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771940033; x=1772544833; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQbCTAy731qE2fQysIyFgqODRFmwAQU93PjyPNSpVHc=;
        b=WNhq4LtgCdc3jap5rcogTYllykYF/L68tzmYpBX1qqypqgRJnFPjupvLOWbdsDywJ5
         CH3y8WDZtY3odADdVlgAkdnH6Xhqx7qg+25TNzBBCCu+Y8/+OLMAyhJEm6JxH9hzw0cv
         ovXT1a7KCeq8i3aaJNrchwVpfgSPFDmllopBnKnVKAYIq7dzFBlQZbdAq35/HViXG3U3
         j7TQwHcd2rCnpi3OcdE/gUh8IDnkEW2pro8KHhQO2vre96R/7VElvEFwH6f2iAdlO3wi
         /XasXjWzfwXps1WQnqPCAz2INRBunjPdmc2lfIh0+Z0P8WlWmbRYCvA4Y1xT7v97s8vO
         dbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940033; x=1772544833;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQbCTAy731qE2fQysIyFgqODRFmwAQU93PjyPNSpVHc=;
        b=Lt9sk9/ioYM6Jp5WsDu1CEi7As9CBOI1h3A7S+7vuqca6AmSTsYbDZtscCfA20VZvK
         wF9gXaoo+G1i+RKIfliQO2jwTZbAbu/yyFPRX9p8GVqF3RM20R0JpQCnQU1yMOUEbvhB
         ocFdMwUtUXBN2HqXghS5C8GK28A4f8cH4OjmE9MsoRPtsWfWh0kUCDfRsZJXXlgvyyN2
         LYjLe9+i0HmCEpASs72dfT3boLyaQNk86dTEOvKZF4TkVCp2IdKo51WAcTPRPzwTQZHS
         SnRAq+GyE4FduNkE9x0fUsTggd4KBSFTTYPfKnpBm4OPZzzUAAnbsFl8L4RDrh8POuOt
         DoLA==
X-Forwarded-Encrypted: i=1; AJvYcCWFJjD/aBImgGyZ+ctt4m9fPpMNzgCc5lhCGir5MlkDMd0j+kDvQ4dDy41y+ahHYnIiczleH2IQmO9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41K0RHye21qOtaxzI3vNboXowaudW6LvEtYAWtH7jvgEMLOJX
	4m8mCd8fvAgi7UMGs+oKe9GQjRh2xpZT8xYi5od4QmOZ+qkbPLQY6JILWkR4FaP2wx7CoRBo3wk
	vlKWsA0ZDq0QCJp6D5ycvSU4n1+BSokdfzT8We/JRgg==
X-Gm-Gg: ATEYQzyuu34B4Aqp8nbCTXpyRGZbIS2IwYqNqsinr3vQ3E9M9fxsRR1Pie9cUiZ6j7U
	jay9iVK8nkrF0X0R4LpkUsJz5kl4h1bZsABsytDV8psvuOk8TwUuS4/gfqtInqQQ29VaudIRXwc
	AZVYQgKo8/iLezRGGsrkDybbamkByMDhOYjry/WKCwFS7EtswjhSlsjpduK5zIhG0j6FUgc39fF
	ap5I+rVxTiODZHxqddBewngyDi0T1IGJIncMV2IwOI+fNzxfbd3qAxnQLlHJiDEPInPFO5EF8qG
	k8FBZg/S5Gu6iRUlsIVbshnh8sWDVTUS8vg=
X-Received: by 2002:a17:907:1c82:b0:b8e:d260:cb32 with SMTP id
 a640c23a62f3a-b9081984f21mr692740466b.1.1771940032973; Tue, 24 Feb 2026
 05:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905211530.43296-1-max.kellermann@ionos.com>
In-Reply-To: <20250905211530.43296-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 24 Feb 2026 14:33:41 +0100
X-Gm-Features: AaiRm53hJgCW9Ce2XGpgvFtjNj7C8EPE2EtDgbCMc0av5AYhBVTR5pi9jSDL-HY
Message-ID: <CAKPOu+_MS5RHVBW6qGZnbiwv+P78o+6fQAQuJdtd_HqoV-yE0g@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/dir: fix `i_nlink` underrun during async unlink
To: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There hasn't been a review of this patch and the bug is still present
in 6.19 / 7.0rc.

On Fri, Sep 5, 2025 at 11:15=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> During async unlink, we drop the `i_nlink` counter before we receive
> the completion (that will eventually update the `i_nlink`) because "we
> assume that the unlink will succeed".  That is not a bad idea, but it
> races against deletions by other clients (or against the completion of
> our own unlink) and can lead to an underrun which emits a WARNING like
> this one:
>
>  WARNING: CPU: 85 PID: 25093 at fs/inode.c:407 drop_nlink+0x50/0x68
>  Modules linked in:
>  CPU: 85 UID: 3221252029 PID: 25093 Comm: php-cgi8.1 Not tainted 6.14.11-=
cm4all1-ampere #655
>  Hardware name: Supermicro ARS-110M-NR/R12SPD-A, BIOS 1.1b 10/17/2023
>  pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : drop_nlink+0x50/0x68
>  lr : ceph_unlink+0x6c4/0x720
>  sp : ffff80012173bc90
>  x29: ffff80012173bc90 x28: ffff086d0a45aaf8 x27: ffff0871d0eb5680
>  x26: ffff087f2a64a718 x25: 0000020000000180 x24: 0000000061c88647
>  x23: 0000000000000002 x22: ffff07ff9236d800 x21: 0000000000001203
>  x20: ffff07ff9237b000 x19: ffff088b8296afc0 x18: 00000000f3c93365
>  x17: 0000000000070000 x16: ffff08faffcbdfe8 x15: ffff08faffcbdfec
>  x14: 0000000000000000 x13: 45445f65645f3037 x12: 34385f6369706f74
>  x11: 0000a2653104bb20 x10: ffffd85f26d73290 x9 : ffffd85f25664f94
>  x8 : 00000000000000c0 x7 : 0000000000000000 x6 : 0000000000000002
>  x5 : 0000000000000081 x4 : 0000000000000481 x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff08727d3f91e8
>  Call trace:
>   drop_nlink+0x50/0x68 (P)
>   vfs_unlink+0xb0/0x2e8
>   do_unlinkat+0x204/0x288
>   __arm64_sys_unlinkat+0x3c/0x80
>   invoke_syscall.constprop.0+0x54/0xe8
>   do_el0_svc+0xa4/0xc8
>   el0_svc+0x18/0x58
>   el0t_64_sync_handler+0x104/0x130
>   el0t_64_sync+0x154/0x158
>
> In ceph_unlink(), a call to ceph_mdsc_submit_request() submits the
> CEPH_MDS_OP_UNLINK to the MDS, but does not wait for completion.
>
> Meanwhile, between this call and the following drop_nlink() call, a
> worker thread may process a CEPH_CAP_OP_IMPORT, CEPH_CAP_OP_GRANT or
> just a CEPH_MSG_CLIENT_REPLY (the latter of which could be our own
> completion).  These will lead to a set_nlink() call, updating the
> `i_nlink` counter to the value received from the MDS.  If that new
> `i_nlink` value happens to be zero, it is illegal to decrement it
> further.  But that is exactly what ceph_unlink() will do then.
>
> The WARNING can be reproduced this way:
>
> 1. Force async unlink; only the async code path is affected.  Having
>    no real clue about Ceph internals, I was unable to find out why the
>    MDS wouldn't give me the "Fxr" capabilities, so I patched
>    get_caps_for_async_unlink() to always succeed.
>
>    (Note that the WARNING dump above was found on an unpatched kernel,
>    without this kludge - this is not a theoretical bug.)
>
> 2. Add a sleep call after ceph_mdsc_submit_request() so the unlink
>    completion gets handled by a worker thread before drop_nlink() is
>    called.  This guarantees that the `i_nlink` is already zero before
>    drop_nlink() runs.
>
> The solution is to skip the counter decrement when it is already zero,
> but doing so without a lock is still racy (TOCTOU).  Since
> ceph_fill_inode() and handle_cap_grant() both hold the
> `ceph_inode_info.i_ceph_lock` spinlock while set_nlink() runs, this
> seems like the proper lock to protect the `i_nlink` updates.
>
> I found prior art in NFS and SMB (using `inode.i_lock`) and AFS (using
> `afs_vnode.cb_lock`).  All three have the zero check as well.
>
> Fixes: 2ccb45462aea ("ceph: perform asynchronous unlink if we have suffic=
ient caps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/dir.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 8478e7e75df6..67f04e23f78a 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1341,6 +1341,7 @@ static int ceph_unlink(struct inode *dir, struct de=
ntry *dentry)
>         struct ceph_client *cl =3D fsc->client;
>         struct ceph_mds_client *mdsc =3D fsc->mdsc;
>         struct inode *inode =3D d_inode(dentry);
> +       struct ceph_inode_info *ci =3D ceph_inode(inode);
>         struct ceph_mds_request *req;
>         bool try_async =3D ceph_test_mount_opt(fsc, ASYNC_DIROPS);
>         struct dentry *dn;
> @@ -1427,7 +1428,19 @@ static int ceph_unlink(struct inode *dir, struct d=
entry *dentry)
>                          * We have enough caps, so we assume that the unl=
ink
>                          * will succeed. Fix up the target inode and dcac=
he.
>                          */
> -                       drop_nlink(inode);
> +
> +                       /*
> +                        * Protect the i_nlink update with i_ceph_lock
> +                        * to precent racing against ceph_fill_inode()
> +                        * handling our completion on a worker thread
> +                        * and don't decrement if i_nlink has already
> +                        * been updated to zero by this completion.
> +                        */
> +                       spin_lock(&ci->i_ceph_lock);
> +                       if (inode->i_nlink > 0)
> +                               drop_nlink(inode);
> +                       spin_unlock(&ci->i_ceph_lock);
> +
>                         d_delete(dentry);
>                 } else {
>                         spin_lock(&fsc->async_unlink_conflict_lock);
> --
> 2.47.2
>


--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
