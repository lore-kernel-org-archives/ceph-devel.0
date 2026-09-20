Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFC45C719
	for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921940; cv=pass; b=EjcSZMwJFSaeTLESYTifwvT+vZDCgFOU5vgd2YaSEPYVLnPUSfPd4S7+ma8bOWYM95dIHRbSpYOlIlxiYwePH7efgfb74y4FRBXfA7f3NSYfJTvZSbaxYnhgxavaOE4rilPEeVpI3iFv9Yo8jBxzB67p7194KQAfqNtNPBVjCIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921940; c=relaxed/simple;
	bh=+4YERuX/Tm4BEarMicY7oOWvS+xS/CmiXnLfQ+itnn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/Azl0pfymwso8O4Wx2JlKbaSFtoljI2r0dO9P4wLb4CR8p0BtFNO2JFAmQhBet9UX36CxkiK/F3dWh/5nWS3xupDnmJR774fgok9hNxse8iu2JvoE96ayNMH6vdt1qlv1KBft1wo90rSd5qfk3IBASDR2UPIN8OmyQlbaoFNNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NE+s2rF9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2Zrr29N; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NE+s2rF9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2Zrr29N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789921934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
	b=NE+s2rF9rmHr7RWbmayfgzY6aMLiVodPbc77lnIvK+GiQDyryLQ/wrygrOum698e6IUG9T
	2EI6PmA97MB99dMuHzzEWZigEUmMKzgDerBu+E2UTx2qyw4fdkfyygTZQ8kqJm/vgrcxpf
	5E/sehzlNwTqljoW1/imgtpQf8q9pEY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-d2A9MMWJNpqgPGs_7AmbWg-1; Sun, 20 Sep 2026 12:32:12 -0400
X-MC-Unique: d2A9MMWJNpqgPGs_7AmbWg-1
X-Mimecast-MFC-AGG-ID: d2A9MMWJNpqgPGs_7AmbWg_1789921932
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6716c35e36dso3385042d50.3
        for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2026 09:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789921932; cv=none;
        d=google.com; s=arc-20260327;
        b=p9lybI+Mxn3WtExxvIHo1RgY2omPdOrEyEgC595lu5sDOQsqxUjuwlSpiFlAJmJVJm
         hgkRxOz8Zvpv+YMY/qGPUQQcuD9s/DZKT4pKScaxGL6G945mngZ/DU6GNWSh0S86AwST
         hUAR+KTh0UolilUoFRCWJzdZFfdLpv66i2u+1of/xtv/TaF1cU86K2ov2+ZSvC9YCQan
         gllyeNhwtkaq1M1CbOeDdy3iqrEjY+Nhu7b71/OVr5o3BHj9fe2Be8x7Ig/tDsfzqbxj
         Q+LrGMRTp+PyjwTHC4kc3fHyhlY7VVyWkwODq5oh+UK+EdOVOBeONrntlSuKQ6duaWfy
         OFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        fh=iRYIlSpBmEDXc70dvcNF2cBKcYedFL3x1xmrYKgCkQw=;
        b=hD27lUBHhYkdEsvgwO5gWsAB0pJ0i9PlBNwGTH1L0jPIPz0LHAFb7J6dS+MkDT2iP5
         z1kZcmnxFlmOh0JLrsOi5gH60Dp+IzGw2LDAE9lc1x4/4NTTfCroFdFQuJyuBrS1Nyup
         mghyKaFuQ2zFEz6Vkgk+c0Xto7BKMP0hUOpGpO2roHlZiZJo7XchrEtlJj6zMZAR1v5k
         HzslWiwRQl/m4nKYCHvtjAZO9zMFoFfDnZWKbcq8RjhTTwRQC7WzXQJHKY+LIGP55L17
         XDoHmdFxHxKf0A4TFCyfRdFAj86r/6waZE9xyP/T/W+NzSx+55WVpOUMBXVXihjUJP4d
         G+gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789921932; x=1790526732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        b=O2Zrr29NPOW53WilSxjiGi5+GUNvcBVvdOoqH73SkdEdUiROaNcUr/Dadgv5HRQK5S
         5SohqF3YNLsUhWrHOtO3hDALjesXlygri5dK03KUhIieVN3sd/R9gCZqM285mVAkkhSO
         +eCemdvwbh99xjp00OjVgcow4v3enfWfjUWx3UPKM7+p9xcABOtqk9+quAtR6yiQevRE
         Pp9/kavNr2iMDdp8J2+ssCMO+kFuzKCkCXRvpHRP1Bb80K7ygFIvx1ywjX2h1ZZ6Kvd+
         K0KmEy87O5P2mJ9RdpedP4huuujk4F2y/CyHDRTDF5v8GBCOGDpjxyjqYIsYaBPnBFSH
         YbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921932; x=1790526732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        b=Ej2EkqRyp4dqqXT602vTBpJPo1y8IQGwAdwQ16bq6Q4AhDZV/YBDcT7jQCV02ttF1g
         Atttj1hR74MLJMzgtgVPDBk0G6OMqaALr2Frl0ekUR+FFucT2zKpZlKY4NcDcwTYmsde
         UhtasBkL/HNTsVgKxdcLn0XSW1y49M4kIWegmi0D2Fei1RmzDqWKzBnRZE541BmLjUw0
         l19u/gRdnn5XBiGDOzdTLFPNRbgJaBrRXXu5pCGhr4c0w7qCcGhfYND6zdVnYNf5VNEJ
         tclxY680r4BrqCVmjLWHvgUvKbOY8EPZ2OZeOcgw/IY6KdWUlCaCL5BwK9T2XDyTvOC+
         7qwg==
X-Forwarded-Encrypted: i=1; AKwUvBzzW47y+nLjlf1Wb5z9gwF1EppTqmysIqUrz8eC9+jElm4Tcif+CZc8w9SN/QVlediNUbPBUW46hAV7@vger.kernel.org
X-Gm-Message-State: AFuF++mq08h2V8fWDzILPNan0ZhFWWSI4V6u4hJPW1ELa6nQoALfT9K9
	0xBz8RNT23aQPN/TB3IjmBN6T1OSQeNS74l8iQrtpo1jECzG88Y0BbOFRCRnM4MBWdpmCj1keAX
	gPt38qctqgPwvRMzC7PHzRPXxHybg/ABoxozNVEKPlX6vwkKGEQXIfLd90YaJWv1oSwmRcJqh8E
	W07AEWJiqtzoIqnQJdAMWGy1wQEYxtg8c4vvKP/Q==
X-Gm-Gg: AYBFou3VXpX20U9jahn3zbIXB3uvnZmXXaO0K9vhjKsrYkQwbKlm4+LsYLKSJEJ1Ugf
	DHS9MBPcdQ+tt0hpve5vU3osBXOrgpGbDmU0mTft39YJ6PYZ0z5rXDcQMbGX4ofgMnGSot3vZw6
	Wk6C1s7/yTX76k7duMoYMvg01KPt0RC+OUtZjVLTtV1xXQFkOBC0plsJNyBK6CVDsr7JdioB6eV
	1BOgxUcc0x9ZjOUBejH3vv5Fyo8o8nkKh1VAOrD/kGAaw==
X-Received: by 2002:a05:690e:1348:b0:671:50b8:aee4 with SMTP id 956f58d0204a3-6717fdf7f42mr2684438d50.77.1789921931936;
        Sun, 20 Sep 2026 09:32:11 -0700 (PDT)
X-Received: by 2002:a05:690e:1348:b0:671:50b8:aee4 with SMTP id
 956f58d0204a3-6717fdf7f42mr2684413d50.77.1789921931459; Sun, 20 Sep 2026
 09:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919022441.3305170-1-neilb@ownmail.net> <20260919022441.3305170-4-neilb@ownmail.net>
 <CAHc6FU4M59nodfn+NCDsr81Wdmvd1Ubw712FF56ekVWfe1+Nuw@mail.gmail.com> <178985655280.37859.6894749467886035489@noble.neil.brown.name>
In-Reply-To: <178985655280.37859.6894749467886035489@noble.neil.brown.name>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 20 Sep 2026 18:31:59 +0200
X-Gm-Features: AcwNN1WDWK2kuJ9juQym02aIIB-Y-9YWAPGC_3VkH8hMthBmOzCWtJtaHEAolhI
Message-ID: <CAHc6FU4cD3fb13LE1-HOEnOoUNVdW1N3e892r7rFE9HJfztvhg@mail.gmail.com>
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

On Sun, Sep 20, 2026 at 12:22=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
> On Sun, 20 Sep 2026, Andreas Gruenbacher wrote:
> > Neil,
> >
> > On Sat, Sep 19, 2026 at 4:31=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > > From: NeilBrown <neil@brown.name>
> > >
> > > gfs2 incorrectly returns -EFTYPE for any non-regular when __O_REGULAR=
 is
> > > in force.  A symlink might not be an error, and nfsd needs to know if=
 a
> > > directory was found.
> > >
> > > Neither this check, or the following check for a directory is needed.
> > > Both cases are handled correctly by instantiating the dentry and pass=
ing
> > > it to finish_no_open() - the caller will interpret the type.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/gfs2/inode.c | 17 ++++-------------
> > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > index f361876c5583..7aa92bb31cf4 100644
> > > --- a/fs/gfs2/inode.c
> > > +++ b/fs/gfs2/inode.c
> > > @@ -738,19 +738,10 @@ static int gfs2_create_inode(struct inode *dir,=
 struct dentry *dentry,
> > >         inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode=
) || excl);
> > >         error =3D PTR_ERR(inode);
> > >         if (!IS_ERR(inode)) {
> > > -               if (file && (file->f_flags & __O_REGULAR) &&
> > > -                   !S_ISREG(inode->i_mode)) {
> > > -                       iput(inode);
> > > -                       inode =3D NULL;
> > > -                       error =3D -EFTYPE;
> > > -                       goto fail_gunlock;
> > > -               }
> > > -               if (S_ISDIR(inode->i_mode)) {
> > > -                       iput(inode);
> > > -                       inode =3D NULL;
> > > -                       error =3D -EISDIR;
> > > -                       goto fail_gunlock;
> > > -               }
> >
> > as you note below, when the inode exists but it isn't a regular file,
> > we won't even get here (gfs2_dir_search() will have returned
> > ERR_PTR(-EEXIST)). So the above two if statements are dead code, which
> > contradicts the patch description. Could you please fix that?
>
> There are two different modes here: the "mode" that was requested and
> the "inode->i_mode" that was found.
> This branch will only be taken if "mode" is "S_IFREG", but the inode
> that is found could be anything.

Ah right, we could be looking for a regular inode non-exclusively and
get back any inode type.

> >
> > > +               /*
> > > +                * This can only happen if "S_ISREG(mode) && !excl" s=
o "file"
> > > +                * cannot be NULL.
> > > +                */
> >
> > Is that comment useful without removing the below NULL check for file?
>
> Fair point.  I'll remove the NULL check.
>
> I'd feel more comfortable if gfs2_symlink(), gfs2_mkdir(), and
> gfs2_mknod() all passed "1" (or "true") for the "excl" arg.
> Then it would be even more obvious that we don't need to test
> for NULL, as all callers that pass a NULL file, pass a true excl.
> (you could remove the "!S_ISREG(mode) ||" which would make the code
> look cleaner).
>
> But that is beyond the scope of this patch.

Yes, makes sense. I'll happily clean that up.

In fact, could just remove the two if statements in this patch queue?
We can then clean up the rest on gfs2 for-next without causing a merge
conflict.

Feel free to send a cleanup, or let me know if I should write that.

> hmm... you could even pass "!file || excl" to gfs2_dir_search() to make
> it impossible to use file if it were NULL :-)

Right.

Thanks,
Andreas

