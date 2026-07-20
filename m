Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC014279F6
	for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559007; cv=pass; b=ehZhnZSoBGB0cM4F21fYYgMVebV0z6qTRvtl0gWU/rYkwPaC+JdgSVG0wQ+kmwSFfh8g0qiIg9OBZOHPgqw68OVmuKsTAYUDwWhnTSbHcMFOtUwA54GVfGEESo7uIiJlvTK4c5FgSgVQC5DnftFRq/fxxO1NUPRObVlxWo52SmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559007; c=relaxed/simple;
	bh=zFS5Dc98TNe5ui2TzC/PPZjHY1cg2yqQMkCFk9Ul0mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/y+z6wS6HuQnpKwF5i3AGAsE2nGE4bPfbxDiAMcTv5VufQN7apjg/a666W7HixLOBM6Kx1aYY49KWIUD6TnBLX5jlr2tnI6MLyRFb9KVEmSt4Q3969vdsnruIlUm8AidPOEuGYtPwM9EZ3SL2QgwxdIn5VHd06ACJfQmnZseR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K4GslwPb; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K4GslwPb"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39669bcaadfso83364901fa.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 07:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784559003; cv=none;
        d=google.com; s=arc-20260327;
        b=e4QTe3DmhwOp3L3m/ueMi06gd9OOfWepSCrLuVnBYxnK1AbqpdMwjkMEp9YcRkDBfM
         m9QFurCa/MlACfx9n9wcXHvzFIGQk6vzT7hhDcr5Ig4RoUH4eu4jb6EPjw5KK5vl2q6R
         yTLfwb6W/zLbs1l0PHiLR5tvMQNXvHop22rWz9l7ZZp4FcjzZJrg62jslfJLeM2GPEU2
         okK6FT0CQpDKzU6trdpbGabBQgxLDfIAjDEEL262epJGORMPlJJEAhQ/lVnWH5FwzcxM
         p3bloPwQxUvbnQfxBQ7C8Y1ccdF9UffNahaVcnPOK5hRVPI7bu0797yh3PzT/0FMKzWD
         bVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zFS5Dc98TNe5ui2TzC/PPZjHY1cg2yqQMkCFk9Ul0mU=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=q55nvEOg1jkr2ap7DBzDQiQLevtJ4YkivC90ZXaE8IwXfcqcopF34pcKWk8kIq2s/l
         TfWIrfaDUccvxnp0w4LCKbRqoCGkyLlUxCWsYrJ8ovNvzPNlTn1nzQhT2Fh1edIbBlqU
         oZXs+2QvLiZhjgodtzi2Q1x1dadY1PSiD1fRiNKW85HtH9G9xVsWCgFUVqpfaWnplVXX
         CFH3VupglpV5i9gsJbGyn4v+9WA5ZvuxlEG2o7nP5VVSeYkNUnCa1Rjqz4uKzcXhoafB
         k+nzoqBxf2iHB3H0MGHeLyqlLKjjwyk/Qog1XWlb1WqboywD1Ph4KnkeAkZ9p2/i412n
         wYJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784559003; x=1785163803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zFS5Dc98TNe5ui2TzC/PPZjHY1cg2yqQMkCFk9Ul0mU=;
        b=K4GslwPbRc4MN1m6PCPwNk65lXP05QhxApU/mKWgYxcsL+uxYstlypUQGm3w/QYWXg
         /vrrSdnFp1lJs6rBkMC0VcguSsBSA9uBhOjDfdNdLsBmmmSYKdNSICOLNALO272tK0N6
         2hLTsUvOIMTmTOh7d4vV30w9i2wsr2QkbMlv1zs+C4msgQjeTN/XZ5rQHUgKtBhgScZ6
         kuDSWhgKkf289RWEslHGUEwOuC+Ye88OaK5+Us3pd5T0il8mi6RbeBlpkB0t5Chw/BLj
         tGtc0739Gu65px8hYBYqBYk/rVooMHb0LWA+C1Q/dxY4QhLiJyJzIExFDoDrvqnTb4Kf
         cCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559003; x=1785163803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFS5Dc98TNe5ui2TzC/PPZjHY1cg2yqQMkCFk9Ul0mU=;
        b=LcUc03MIrY5rx73bQ8I+i4WjKJF+u/BvIWFE50prvuvac/6VUVlHYXibGxURiz+xCX
         fnytl8RvAZ5wkXoy+PrqI8BqIUfrqYBzdSRvh7AnS0jw6YZPNuJ3c83TmgI6BYUiVyyv
         v24/pbJ/RNw2M9JNKsCkkSOrE5uaJ67l7okVgndtEl3bQE5qfB9Jy/tcQjiNv/Qqf1a5
         9xwdVOvrQ642V63bWx08R0CyvqsN1c1tfUZHu5sRs0O4m+s3gkgeuKlGUNtriXBYC0kv
         +kq2pIBCqA0Xs8sRHcRRe9LhyD36D/4E+6vHyQiWwvt0kKSrvvj9KMlLEGe71Ya/A+dg
         g2Aw==
X-Gm-Message-State: AOJu0Yx5a2shyDPM/f2/34pjttpq7AZprt5iJWXhNJoBvM1xv0pMDbJn
	JVMz+xUih7qwm1uccT8EOTaSLFErUYragyL52rCUhDQkGOrxgik+80DnycjJvrec/rhDp2rcCff
	xUeF0oXLU+uSs7piS5JWRtGK4NroGBgj0P3WM7UAw+g==
X-Gm-Gg: AfdE7cmQhdUvAlvbyu9Mv3IeCVkcQa38xEKb4RQCc4fjST9xJ29mYxNehRo09CKLzyg
	dHE1zLWx7cqT69pFlPzjWj2Ppj08ZLJVayoUCsq9EV/CJ2D6R7uI97FD4gY6kuszLUQEY2c1Ifl
	6A+fL11Qr7vyTlgUkvHPfTcRxkiNnGhXQvb/QORHAz8vBTGv32aXuM2X4GfQxmYIcQ+7W+USEiD
	gPM0cKet1Tf00bu3g9vqtiIMaW3gytsqg0isBcpZmcczstIQyMxvxe/u88FhcQoP/NCdBTATfOK
	lIxAt9zxzbxB3MfTkTJOkgpz4j1uxw==
X-Received: by 2002:a05:651c:32cc:b0:39a:fffc:ccac with SMTP id
 38308e7fff4ca-39eb2869079mr19168451fa.35.1784559003221; Mon, 20 Jul 2026
 07:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706160450.370729-1-marco.crivellari@suse.com> <20260707092209.2184748-1-amarkuze@redhat.com>
In-Reply-To: <20260707092209.2184748-1-amarkuze@redhat.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 20 Jul 2026 16:49:51 +0200
X-Gm-Features: AUfX_mz_AD5Dy6y4FSVaTIluVePUQXxtPj0slrfuDrPf9IKaQR2YZrXG7dQy7tw
Message-ID: <CAAofZF4AaKqQUo9bit52cyrAWhgNwaGAkOZBZ7TEfG+dzYPYNQ@mail.gmail.com>
Subject: Re: ceph: Change system_unbound_wq with system_dfl_wq
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Jul 7, 2026 at 11:22=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Marco,
>
> Thanks for the patch.
>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>

Thank you, Alex!

--=20

Marco Crivellari

SUSE Labs
