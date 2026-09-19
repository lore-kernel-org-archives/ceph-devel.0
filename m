Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086D2EBB8C
	for <ceph-devel@vger.kernel.org>; Sat, 19 Sep 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836607; cv=pass; b=lwtSuhWFFC7+qsvS2Sdp17iyE+AZvV8C7Cxf6CdpuHXP7qM63/aWZ8ZR2gk/04UFvh7M4gKciBNX7SDPoT+WwvrYqZtUVcif0XHXN4lVQWZSeNaiQ1/K3AtomEYze98gYsp9TvcNfB2Kl8UH8kerLrIt3uwvtOJB7QoAEDF8mlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836607; c=relaxed/simple;
	bh=1oY3+giPHWz0CdoUqh5D52C+UH9EYo6twKyaCtg0Fhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmQQre5K0HrezlHZ362m4yhlTD8TMT2bwxWkKIkT6D2NpNddDQq88dRgQV+3ha75Eo/dBlt4wK4ZLXTGcAB9IFVyz8kjEXfUTx3nWPAWmw2/TXFj+YEkHbfeLI5EUhqdG0m8NFTjRcJVxEKq/CSy2AzsPB3R3L6AQBWup9ejt1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWti0NO7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOlsh8sf; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWti0NO7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOlsh8sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789836603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw2O3A+XY8Iwe+GQb7YOsi3YCIQxb8QR4CEhrrgc/KM=;
	b=DWti0NO7M5GOzv/mHpgKY7UUb1RPOxRK5G127tf2lGulceXlG6XYU69GMR7w/OPZ9+T+KO
	kzW6H8FIgbITCEo+v0MjlobWJnxdmRumGfH/AyDFxDWu5aVRLuoWk4YryYdNLvAJRkkE0C
	YML6lGp5qXAAAph75VxXcxwzrPsIiEc=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-UYuzcwzdOKK_zjoC5PFOrQ-1; Sat, 19 Sep 2026 12:50:01 -0400
X-MC-Unique: UYuzcwzdOKK_zjoC5PFOrQ-1
X-Mimecast-MFC-AGG-ID: UYuzcwzdOKK_zjoC5PFOrQ_1789836601
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66fb71198e9so2860592d50.0
        for <ceph-devel@vger.kernel.org>; Sat, 19 Sep 2026 09:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789836601; cv=none;
        d=google.com; s=arc-20260327;
        b=Jn/sQgdw95fjEzQVkWJP1LvEQZ3XWbdE7KKVg5mT0tz3u+z7sFraV7bW/YCiuR3FBc
         Zznnl8cq1mDwD/0mfry6qIKQpV3iih6EDmEpqKgVE91eeOalbehRe4OWHnhLxt+kMBLS
         i532/6p4eyQunbrhSothqyjZX7KawxGHyaZAPdDlr8iRFphq4SHPWpZWEDv8tyw4RPDW
         KkDSLofd/UQmmkm4tUSLLQXVjSHmfcspX6GE+QrLNLbv8S7a+1PDTmd30Hu67TtcHqTt
         cPXH+gMzBVttlnIXWg8pJFRW4YcpuWxBh7/vlpdyiNFL9RyBDJq31PtFtFBZ9za/Gfs1
         F1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sw2O3A+XY8Iwe+GQb7YOsi3YCIQxb8QR4CEhrrgc/KM=;
        fh=ROdRZriKyj5ct+j0jxRqOLLErX1UYRMrmkpWJkMovcY=;
        b=miGU8znX+t0oDgtVkeehSMQVjuOIK8FK2kL3dIfq64InemPTpK1WeDfzZ/PUO4gXcF
         mlLqDdzjZxvLsaTWUc/VbFMt9Fz8isRbL4pMFGpx6XkhKWgLRA/PgGdPZHo2Z5Fs3HY8
         5LAflxwofBVUujmQQQNMrX+26zsQdvKsm1j5kocKd8UhIJVW0bIqm1xjWIyDoGvtiUSR
         c9v4MMFxXB3PrUQdn+PK0Yt77P+2xNr8TiBksHyoQRSnktS7AVfLyPUtfIbgCdAfwfz6
         OW/sEIm+ZQGa6b18Xdvsoyc3IkjJYA0pSFIkdZ6LIJ4AmU+Xm0o/QDXDFYAqWBOVTmRe
         frBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789836601; x=1790441401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sw2O3A+XY8Iwe+GQb7YOsi3YCIQxb8QR4CEhrrgc/KM=;
        b=DOlsh8sf0D+rrt+7UyCzUPdYC7BMH+oM+23q306qKZXtI7Nfv1mGPjyFaBvudVWFum
         uJ0tIxPtSudxVkrKoE3C0Q4YKlzQESbumFk/0jGlg18Ezu0S3dGI1N0j8I+xpVCV1PUR
         HgPsr/aC//nPdKWGMEejG+ve1o16krxaPV0oGlnUxGLRF1V4/e90xgaDm6g8gBl7OZH1
         OhMuVgoiie0dRLBMNHyn9w1RmR7TBTsZJ9y2CO47tXyfC+cfT9GPkYe+Dbhg9puFZ22d
         37/+HXlnon8cp/rAUzQpLD/04EuOW35vF4Uq/T5y78jGcaD9pnzmSdn1OW/NQ1UVzHIR
         CItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789836601; x=1790441401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw2O3A+XY8Iwe+GQb7YOsi3YCIQxb8QR4CEhrrgc/KM=;
        b=2fRpqfl+a5qaL3jNeAx4UktLWortpkzhu0fp02RUuUiwAKFL7x4ozUhawIwaOgLBp7
         UGUWx32zEHsoHWFmFJZxPGiDHwowRO1YznCfnVxNN/X64K6LsP+PwSCNY5Z+0N+hLv6B
         9gR93eFNb+kfX9fgCXhU3eOo2wFYzlAaFjo37baFH9le7tihnOR7bhXvncVqjI1IaAuT
         gafPgGjW+byaF7yACuw266d3fcUMD5ahu0SCNuIERfKEKtM4N+HzAG7P9RTHAUYLLuii
         Gco9NaChgZ3+cniGmnsT38PKxzhnDctZ3LIjb1hsrS7WhkSdC6hFzx6aypjrHmdMXjGQ
         DT7w==
X-Forwarded-Encrypted: i=1; AKwUvBxuSW47N3FuyuzvJJB00n5pGtojcKqUh4nsjCPSWlxQrw/dPvAnSMsCB7YGUMSq02zh8S5QjVrWYzUy@vger.kernel.org
X-Gm-Message-State: AFuF++mPEhauATYOFTdKgxNCiAQBt/mh8RuJ6DdzUld7j2uru9ZlxeaK
	4ud3bl6sEeU7n1sxffniwdwdNzBFq2wId64YKTYTkWM7uPZ1g3ZG0bozXTHTEoMSlemJDsEANje
	P2nSTglkGyk2cuIlNBBjHJWhpng7EOuLiqbLWEIV9MsFpegzKV4vuMiRdz+qRM57pqYXx7Pbkc0
	Mj+2vE4NvS6MDmMjCJKWdoqeFVqYnf8ZxRlBYrVA==
X-Gm-Gg: AYBFou0dxutBzkgT9Ko3YuTioBnLGIuEzYAh0fkSYsASx3qFAOhlsjh9RRpS2BUhmsW
	PntZys93yb+ZSRYtw4BD0uvfdnmWyHG4pwNjDAcwpEth43hhbfZygqRtQG6o28+HBpoeV8JnvG2
	wuvRC46T2XMuOFz1La8ww2YrdC13jb9oeo4sj1AGT8K1M1owXtUtTVZnWIw8d3YI+WL7LSMyMik
	QOHkad+F/MntfKvnurQ8WkQkXm7csb1bjjN2vhfQQLN8g==
X-Received: by 2002:a05:690e:e8a:b0:66e:5f08:82c0 with SMTP id 956f58d0204a3-67170436567mr2947642d50.26.1789836600932;
        Sat, 19 Sep 2026 09:50:00 -0700 (PDT)
X-Received: by 2002:a05:690e:e8a:b0:66e:5f08:82c0 with SMTP id
 956f58d0204a3-67170436567mr2947628d50.26.1789836600531; Sat, 19 Sep 2026
 09:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919022441.3305170-1-neilb@ownmail.net> <20260919022441.3305170-4-neilb@ownmail.net>
In-Reply-To: <20260919022441.3305170-4-neilb@ownmail.net>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 19 Sep 2026 18:49:49 +0200
X-Gm-Features: AcwNN1Wzd3VwqVBZ8pDu1K46iGkfuTMoHWQj0DdBgADN8jcfrMQo_vnTAv0UsKA
Message-ID: <CAHc6FU4M59nodfn+NCDsr81Wdmvd1Ubw712FF56ekVWfe1+Nuw@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] gfs2: simplify atomic_open handling.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Mateusz Guzik <mjguzik@gmail.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, gfs2@lists.linux.dev, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neil,

On Sat, Sep 19, 2026 at 4:31=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
> From: NeilBrown <neil@brown.name>
>
> gfs2 incorrectly returns -EFTYPE for any non-regular when __O_REGULAR is
> in force.  A symlink might not be an error, and nfsd needs to know if a
> directory was found.
>
> Neither this check, or the following check for a directory is needed.
> Both cases are handled correctly by instantiating the dentry and passing
> it to finish_no_open() - the caller will interpret the type.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/gfs2/inode.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index f361876c5583..7aa92bb31cf4 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -738,19 +738,10 @@ static int gfs2_create_inode(struct inode *dir, str=
uct dentry *dentry,
>         inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) ||=
 excl);
>         error =3D PTR_ERR(inode);
>         if (!IS_ERR(inode)) {
> -               if (file && (file->f_flags & __O_REGULAR) &&
> -                   !S_ISREG(inode->i_mode)) {
> -                       iput(inode);
> -                       inode =3D NULL;
> -                       error =3D -EFTYPE;
> -                       goto fail_gunlock;
> -               }
> -               if (S_ISDIR(inode->i_mode)) {
> -                       iput(inode);
> -                       inode =3D NULL;
> -                       error =3D -EISDIR;
> -                       goto fail_gunlock;
> -               }

as you note below, when the inode exists but it isn't a regular file,
we won't even get here (gfs2_dir_search() will have returned
ERR_PTR(-EEXIST)). So the above two if statements are dead code, which
contradicts the patch description. Could you please fix that?

> +               /*
> +                * This can only happen if "S_ISREG(mode) && !excl" so "f=
ile"
> +                * cannot be NULL.
> +                */

Is that comment useful without removing the below NULL check for file?

>                 d_instantiate(dentry, inode);
>                 error =3D 0;
>                 if (file) {
> --
> 2.50.0.107.gf914562f5916.dirty
>

Thanks,
Andreas

