Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837053;
	b=1/sxz9X2ZFEvoiUmcU2mM1E39CF50OYVbMI9RQ4cVdBClubOcxlzn6n7USzBDgHN6hpK
	 ZwfzRW7X3czCdrY60xhJZxGvK78sD9Cce/xTMqcIYwelkN2NI0PNM5lgTQq+D11pKKPAE
	 WbTZmpv8d/A2n1BPDVN20CjnmiXkaV78hKF/Cvn9eaaToQ9H0nuA4DnviQXgAF8QnW/ba
	 rk5J9d/HIIK1QFe1zNsdpgxDZCzFvz/3SSIgs1j7N4azc9H6xQoS6J0JqIIbnuO5pKQCf
	 13eg+9fy/So3Kl3a3SCAqxTvpBSINkh9+AHkSlLGN7INKdkdAtlx11X1QdCdIpVsw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837053;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZJ3f/c+Ynbwt3ZLJiLRg3XHmZVqWxpmwljKPHigcLUU=;
	b=Osd+RYLvp7VzQEuC74cg2aedmkrLko2e4AnvV8rwcRhY8x90FMgELJMKDmdeupHwY1tk
	 XP006xBf0lr749ywb3O/9Y3Eco8Uv4KCH9QWhWk8PEryMGbF6GjwI2i+/9ddzTTBgY2yx
	 b9ax1nPpVIIwCHsEdqJnqqcWsVe324nAc1MhVAwFj+HsffpyVFZzGUkMhMxzqZqzCqW9E
	 9kVc8qaPr5zf5omY4ywSC89fO6BtnxuMBEIlxi52Ma2vF59jXItVuCs0L0kczz27zBFAu
	 YaGV1X8Tj36s81XgBD7ZxsSS0PxQCmeHySdYCJNE5K6SbWFHuyZ2ZY/KNZ4r1LULQTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL02PyLJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF514606A328
	for <ceph-devel@vger.kernel.org>; Thu,  5 Nov 2026 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL02PyLJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591611F000C1
	for <ceph-devel@vger.kernel.org>; Thu,  5 Nov 2026 00:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837052;
	bh=ZJ3f/c+Ynbwt3ZLJiLRg3XHmZVqWxpmwljKPHigcLUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EL02PyLJy7Yq1gcA8XPahgOiAl6LDBuNDLxmtkXo4QcWPDCpjVYYy2HlDG8iphhjL
	 p7AO49YJZmRCnY/d0yeg2YW33ESpy5NMFxR2qREF9+iQ3Zs44ivmCE3zKnBqdWycgC
	 HOS2v7CTPNI0M/cMezpNSCtahbx13MtdkLvWh1EcpkvXLOZMQWKpPqhQFyrfuPzhBY
	 szBNmJfSfR8ZeAs4lnVZS/0ZFBCnKS04xq0HBoFLD948byJJLB198tUArnyeD0ZJ95
	 qv3i/kg7LMobeSwnhT8Kh26mERuk4o5QXdflTd/+ZOVyp8Dpq+n/NUzJUtO/KfcVPj
	 h6GmPPLagc7jA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso1094771e87.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2026 16:04:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx6OHGAKpUjHg7lQNnFH7HMWF5hbvutCRNmS4+PKFfsq41M2IiZtbjY5qwSG5cr+0MFRalV3EHQCqUb@vger.kernel.org
X-Gm-Message-State: APuU4Z+QE0mSGVkQ6hLZw1thtbl7Nsqj9vLjzMtC1lFmN7ClOC+YFdmd
	LREASBcZnrqFYh43NVsVhMhfFpMvNOD3R2tY4hIWhVRgr+ynj1lfXhAHTz5qpGbXsxT35lG7eh9
	2uy9cjoDCVx/Cmp7YFwa43Er8NjTLE6E=
X-Received: by 2002:a05:6512:118d:b0:5bf:fa79:986c with SMTP id
 2adb3069b0e04-5bffa7999f3mr183010e87.6.1793837051141; Wed, 04 Nov 2026
 16:04:11 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260911185244.1420485-1-max.kellermann@ionos.com>
 <20260914053353.132489-1-amarkuze@redhat.com> <CAKPOu+8SiwxT_44e63-EZ4T_4d-tGjwmk_Lx8i4KgZOL5JnMtQ@mail.gmail.com>
In-Reply-To: <CAKPOu+8SiwxT_44e63-EZ4T_4d-tGjwmk_Lx8i4KgZOL5JnMtQ@mail.gmail.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 5 Nov 2026 01:03:59 +0100
X-Gmail-Original-Message-ID: <CAOuZWzygoHT3reSEMbuAWY_KqzEzCLyAo=WTOHrU3-ig5q+5uA@mail.gmail.com>
X-Gm-Features: AclHuK8rAbgSNhiUJUbAj9mCCUMW34TY3Y4LxiqlY_aQ4Y305Kf_49u5sAMLGtE
Message-ID: <CAOuZWzygoHT3reSEMbuAWY_KqzEzCLyAo=WTOHrU3-ig5q+5uA@mail.gmail.com>
Subject: Re: ceph: acquire write lock only if snap trace has really changed
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E8=BF=99=E6=98=AF=E6=94=B9=E5=A5=BD=E7=9A=84=E5=AE=8C=E6=95=B4=E5=9B=9E=E5=
=A4=8D=EF=BC=8C=E8=8B=B1=E6=96=87=E5=8E=9F=E7=A8=BF=E5=9C=A8=E5=89=8D=EF=BC=
=8C=E4=B8=AD=E6=96=87=E5=AF=B9=E7=85=A7=E5=9C=A8=E5=90=8E=EF=BC=9A

On Mon, Sep 14, 2026 at 8:08 AM Max Kellermann wrote:
> True, this is a mistake in my patch submission, sorry. My patch is
> correct (and is extremely effective - reducing write contention by a
> factor of 678), but depends on other patches I submitted long ago
> which were never merged. It seems the official Ceph kclient is lagging
> behind our Linux kernel fork too much now; ensuring compatiblity is
> difficult. It doesn't make sense for me to submit more Ceph patches
> until you have caught up. And then a v2 of this patch isn't necessary
> - it's correct already.

Hi Max,

This patch is worth having upstream on its own, without any of the
other patches.  We applied it to a kernel that has none of them, and
with only Alex's one-line change on top it removes the snap_rwsem
contention as you describe.

Alex's change is all that is missing.  The MDS builds a snap trace as
the realm followed by its parent's trace (SnapRealm::build_snap_trace()
appends parent->get_snap_trace()), so every trace ends with the global
realm, whose parent ino is 0.  Comparing realm->parent_ino with
ri->parent, as adjust_snap_realm_parent() does, lets that realm take
the fast path:

-               if (!realm || !realm->parent ||
-                   realm->parent->ino !=3D le64_to_cpu(ri->parent) ||
+               if (!realm ||
+                   realm->parent_ino !=3D le64_to_cpu(ri->parent) ||

parent_ino is only written together with ->parent under the write
lock, so reading it under the read lock is fine.

Our numbers, from a 3-MDS cluster: one client walks a 2.8M-entry
directory while 16 other walkers read large directories.

                           without the patch   with the patch
  snap_rwsem sleep in the
  MDS connection workers        23.2 s               0 s
  directory walk              44-48 s              35-38 s

A full IO500 run (ABBA, 2 runs each) shows no regression in any phase.

So I would like to see a v2 with Alex's change folded in.  Would you
mind sending one?

Thanks,
Xiubo

Max Kellermann <max.kellermann@ionos.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=881=
4=E6=97=A5=E5=91=A8=E4=B8=80 08:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 14, 2026 at 7:34=E2=80=AFAM Alex Markuze <amarkuze@redhat.com=
> wrote:
> >   1. fs/ceph/snap.c:963: Fast path rejects the global realm, so the wri=
te lock is never skipped
> >      `get_snap_trace_if_unmodified()` treats a NULL `realm->parent` as
> >      "must update".
> >      Match `adjust_snap_realm_parent()` and compare `realm->parent_ino`
> >      to `ri->parent`.
>
> True, this is a mistake in my patch submission, sorry. My patch is
> correct (and is extremely effective - reducing write contention by a
> factor of 678), but depends on other patches I submitted long ago
> which were never merged. It seems the official Ceph kclient is lagging
> behind our Linux kernel fork too much now; ensuring compatiblity is
> difficult. It doesn't make sense for me to submit more Ceph patches
> until you have caught up. And then a v2 of this patch isn't necessary
> - it's correct already.
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
>
