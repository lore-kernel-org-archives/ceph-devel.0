Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EF360EDB
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592191; cv=pass; b=an1d531E91Jeq1PTqKfZr4H9ojNknnu8//iBrNJLezwRIEj+QCWbBjAlntQXErS4zen1CvD2P31KXWDwn+O/eJ8LmYfzbkVcn5+PfOmnqq1A4DTQvuzeIXqSIODlozOw9YyhRf3xtGEgwkb157nyfTGmAvmlIiCc9EWBHgFGUBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592191; c=relaxed/simple;
	bh=oLNne5cobDJZx5zkoUSLGFP9qe8rytYx2dxIodND2sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2BX61ZV9SjeJqmiI67SSAvxL2gy74Gelahiszpeyyi2G7pdc9zUh/BV6mV67OmjyNjK88E30iCWdAAtDJUl//Tcu8mA2iZQaemRJOk2jQ0gb8ggOHq3+K1BZMctAEKEGNVR0CnRbt+3ZsU4G3MEWgAdezDpD8WYw3NLS3wluyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7lItS+f; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7lItS+f"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c20ffb440so760961d50.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 06:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592189; cv=none;
        d=google.com; s=arc-20240605;
        b=kmwPwAh7CZ3thmAJBSLkdwIu2r4B8hLMvruch+sRepdUS1+3ceC4lI5ev///Z8bmft
         iwHPr1EA1VEEUubqE5/d6SuPL2BrfybOslpOXopx29dH5klL81uVTh/8IadM5qIfiUeL
         1QVC6o4v6FhYLqfPttNb552ixhZbGh4hpMj5xIjvmWPz3cMIzrlKamSHkWIjsvhR/JpL
         vtLpRGI9pGggQg8WFy/JouobVfk1GhyCXDa/V9nDW2To9uGlSwGO7ur3Zm9wky8TjhMx
         pZ/J/tBU0rnUuQO65ipT9Ulc1CurisBBvap/1iLxXJQ13BUQrYkw69rzghPg7khMeCP3
         B7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        fh=UyLuugA/zWo6s9OyKmTf8AHkZg8xYdDZhIUrLNdFr8A=;
        b=Di3sLiV0XRjs3dlP9v94VSJmZhozCqO2SkVuKxk7OqxKPTctM1HtIvUlCU+2EkOiuD
         HWI0hIyg3znGODMRkxfAybF4VVepYysibNSJestBGQaKHWoFnUmpg4p1V9wzLSfmZbEJ
         eL2Cx/gkYzvbxJ975WlYWgiDqo7Qtv9qvqr+ecP3wNvOpxTH0XQSclUA1l4b5AKtmIJl
         24OOwuQ33sFSL6cXtF2KPQ36Um6mbLBlsm1eOOtA8mOwognZOCuFIsVFDv/fmIG+5i0e
         s3dPuBiGMRSYZb0tvv+xbZcLRipA++QOgXzjzBdHx0/HE4UohNnZdwB21MhYVWn10kx+
         44Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592189; x=1779196989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        b=N7lItS+f7DWAjNLR2qC5vPqEH5cDwbCGT9nyrQOWTH1ixmkV4xQTwLkaY9wyx95xSH
         G2PlcAa8SGed6AWdVjLSVFUXhDiGBD0W3L1LQ2GwjBXrqYAslVI0bxXOanaCZhQKId/J
         sunNNGoOT3iMg8LJ5DhnZALN3hoY2hQH49KP1pILl1WBWCyYRbFojajJSy/tVPyi5kzX
         faaypv7neCLq73Ve05Y9HC/Zpjcrj2zuC17ExODCQpcNt3zvcajqHQ7kFPNudDuZBcVf
         Fp+Nb7x0Or8CYCJF93b3QE6+v8U50bv41GznUrm/H2FPrnIY+1pXDYFdmd+EQdxQ25RG
         zjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592189; x=1779196989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        b=AVsozxUpMfDEkHeJqh4tE3X3R8W9Yd8r+gp0zbV1ruxQXK4EnuIS4OesTrWOgxqHi7
         2QWxmAfMKQpYiP0teYrqa3lHjj1GEX+ysdD/dlv8jbKlDT1w2Xdkc84KNPGtBmjEnymL
         tmW2ak8uGeO7TNIrus1E22pKyCat+L4Lpd59e3Ig2vQExNsyFaK9CAxBXL0lHH/UkEVp
         EXjb38b16EqLZNQ28/ZgmfNVvsbvUWgSEmTsBWU47GLGLTXbU6HhKAGp+OOcQQkcjoTY
         qp2Neh7FRFT+ew+AvwWBn8R5nDcmXPqOjRwCKlE5v27A9BbO7NYeTXfWuHhqGzQCC4wh
         ajAg==
X-Forwarded-Encrypted: i=1; AFNElJ+45t3aj3XNT27tEZN7FhgLURreKLEobfbcj6fBJL1rg1TmyWU6rwh2urURctM9kAAlZqTW7ewDEzyn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/08UsO9CTcjDfP8N7yT3oZyq9gCVuJLqsDSfhLsBP4NdMzG5
	bTrsI13isg+o5x2QT5KLjEuwvDiEOcuVXwP4i/mxMLobFOhIVguchf/A7Y8k0KRWkbyZUJooy22
	LHcJKaCBzAelSHYKQg/OdMf0zktyhsHE=
X-Gm-Gg: Acq92OFjQYxIWs9VXG7HjJvVC+OxmRDuZJ16gMa68m/pUXX1YEjguIbRA196mjTjWju
	pZiIdsZGSQmSOi0P2tI2Vrm2o8v4V4Etu3KqNYYVV25yuMEv2yaZeQGLWVewi327JafAWRNqHw9
	IxqxPeJU+2I5e2c+un4L3j+GulrG1wHi2a4kAUFRrbU0Aws4/VFDNNQSm10PVZfCoGJ38oyA8ea
	/x9YJ407rA5N9m0vEbZnPCBhYufFih7BG8xZIIfCM9ZJeJi69EiqsndTBKN0ZjHgLXE5ghJj0F+
	DTjRZd+f
X-Received: by 2002:a05:690e:128f:b0:65c:124e:61ce with SMTP id
 956f58d0204a3-65c796f49e5mr19234437d50.0.1778592189338; Tue, 12 May 2026
 06:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512123404.719402-1-dhowells@redhat.com> <20260512123404.719402-9-dhowells@redhat.com>
 <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
In-Reply-To: <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Tue, 12 May 2026 22:22:58 +0900
X-Gm-Features: AVHnY4JVdrnalD3VcY2gJzGM9eUXbqquyOoAkwfHaKwpTwhqh9XLF19h2Tihueg
Message-ID: <CAMrLSE6Ff-_Kuyk44U1kbe6gjaeLuXanXUoBA5As69EYhZzw0g@mail.gmail.com>
Subject: Re: [PATCH v6 08/24] netfs: Fix potential uninitialised var in netfs_extract_user_iter()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David.

Sorry for the confusion. I was looking at the current mainline code,
but after checking
the version with commit 8ef352bc015d, I agree that `ret` needs to be
initialized to 0.

Looks good to me.

Thanks.
DaeMyung

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:07, =
CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, David.
>
> It looks like ret does not need to be initialized to 0, because it is
> only used after being assigned the
> return value of iov_iter_extract_pages(). In the zero-length case, the
> loop is skipped and ret is not used at all.
> What do you think?
>
> Thanks
> DaeMyung
>
> 2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:43,=
 David Howells <dhowells@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > In netfs_extract_user_iter(), if it's given a zero-length iterator, it =
will
> > fall through the loop without setting ret, and so the error handling
> > behaviour will be undefined, depending on whether ret happens to be
> > negative.  The value of ret then propagates back up the callstack.
> >
> > Fix this by presetting ret to 0.
> >
> > Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC =
into a BVEC iterator")
> > Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowell=
s%40redhat.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/iterator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
> > index 154a14bb2d7f..6903028b7162 100644
> > --- a/fs/netfs/iterator.c
> > +++ b/fs/netfs/iterator.c
> > @@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig=
, size_t orig_len,
> >         unsigned int max_pages;
> >         unsigned int npages =3D 0;
> >         unsigned int i;
> > -       ssize_t ret;
> > +       ssize_t ret =3D 0;
> >         size_t count =3D orig_len, offset, len;
> >         size_t bv_size, pg_size;
> >
> >
> >
