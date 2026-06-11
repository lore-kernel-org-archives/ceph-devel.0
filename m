Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6333BBBD
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781151152; cv=none; b=VYBN4AEXpNWhRCspvG2AaFJzDNM3+RX8n47vd6zGyY1OTHKY7zm3tayMQO8YWunwvu8qDdBDc8FfPVkAEcckRdl2ctbPS+epQ4xTVL7qxSYkyDeyDIm8SSIfzOK5ETvcnJ2eq48CNpJRjrRPEc9LNRL+grhU/LJVIKmIuhhv4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781151152; c=relaxed/simple;
	bh=ufqFUV9Xdt6ow5slz+iWVtRsppCeGGtT9THaiu0eapc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2P3HRPWZgIYyHzCbUkawc23cKuADrAELe0TAyFcdEswQ5odTFbd6tsTL564ANXKzLF3lMIIdExGgl3TZzcxV1V0+msPq7tDVLn5qKJB2bWonapeFzhNP7t+au1lyoLnhSWfGJWE7DZZKEH+2WczVfgNyCOEwDFaXk0o+npWSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=z1Tmpjvh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="z1Tmpjvh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa7a7c9711so657220e87.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781151149; x=1781755949; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y1m4bi292raPcTDzHTYidOLGPiObt+TJFVNzKvrWNzQ=;
        b=z1Tmpjvh50Ufvx3zVMa1MW1nhWBbIT6rB8tQofpqQ67Co0f5qxefzlYHzhbQNDodbH
         f1ACrHnrKiFuDP5tBbqxU6WK8lxBOCzlsPHjQqIuHJ9Pw8KyJgVgyO1Jspkv3m0SqC0X
         9MfGRBFAjSq/ptmqFUddiurb9bu6HMoSb4SmHR+b2m9bRSPTCClK5y8UfdBUIi3SXL0m
         Y5TfIhEknYNfRJXbov+mF7bWRRR42hFopF8qfJq2M7SfrbqtCU5DnfgIxeY5KTLZRL2N
         xoYS45JuwVx5OoThuKuGZ3okXlTIQeJquZ0znnhFkg5zz4l4Zc2jg93lHB8ot1JEzw+d
         pDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781151149; x=1781755949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1m4bi292raPcTDzHTYidOLGPiObt+TJFVNzKvrWNzQ=;
        b=HqYtY4NzuyD7MvfIyZl+uq7YFsatCAE+3OWkT5psZID1wjDEJgEeNn4CrVWS/LbLTF
         a/sD3oTJhPp7g4gFg7TA65XSJ+XVWGwsLdWWxat+WCET2jjOvMrSgI3bNmCO75NKd95s
         8OlS4cWC9QlQQoa1IvOcb18iSXXWs6RKrP3wnTqHDQrwVnPgS8UWqv5QHvRo8LKap0MG
         dHEwGReJt/at9vQbdlFOnyvHq/0wdIDFJPsYsLv0GVO5+ts7ro/3S9bVu35kT/zf0SFg
         UzSfE/NhCNWJyOk715NpVIxBcwh2OsMKTfMac7/fzELm1ZgKiMSKjKNuBswvSLg5LGBn
         pbWQ==
X-Gm-Message-State: AOJu0Yx+IESMfmcRRdKPriRL04ME+AWO7wWoTnxCqsyVpnZNX7Jqpu8c
	2x4rwbmE1/8lb+JWrOZ5Qqj7npo+ib3xXDr6TVwlzY/TNan1ADhDDA2E2yXdVsjuJbg=
X-Gm-Gg: Acq92OFUEzXOrI9xgLPpwiH2Ey2yyNz2o/1Z3tw6El1ZisF+tGOgIJHnbJUKzvYZilL
	7qtLgJa6Pv3+9+T54GvpSy/oEtmfKkVfjYl4hgAXpxvDC9/979kxAnzNuuvUw5U4Oivt/ntpZE4
	v8aONX8qjZD/gh54tC3uy/3qymkvKwdVn4Q0nJPHBi94h3r6B+rNHY9sbulmAaXnoeVkbJbNpk+
	jCJw9ZDo6JCnS7OnpFu0iGFW6GmiEmyg/CaKfov7HHRUPV0tcS5NhD++lMTVGpdTlaHexOOLSDj
	//A/zjW7IXtQA1Sb1vhoSGSm0/LOoM+VbjfEkb/VnAjY9kY0Fb8oKG/l/S0ZqN1tiT73H0e+xwJ
	7tKUDuQXYzbtpdGW7JJ353hsglcN9gMxX0vVez1Ne415xfaK+fphpxgNmkxEeLrBZlMAknF6opJ
	WzlEEmgEEZ4x995C7cmCKn/vBv7grSm3x9mRZKM9HRBfGMtSQ478YoRrVbV9dTkMjRUitm3JpEH
	PYGE6kEcAIXvQIPltjRmANBY282Uqa08BT5tAbkgpfbEMAcQyGywO997AJ3HH9fuXM=
X-Received: by 2002:a05:6512:3e05:b0:5aa:5bb9:1994 with SMTP id 2adb3069b0e04-5ad286112cemr179748e87.18.1781151148686;
        Wed, 10 Jun 2026 21:12:28 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbcdesm5977632e87.21.2026.06.10.21.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:12:28 -0700 (PDT)
Message-ID: <d7a8bbac7078b9056cae17a658b3fc07c5934ced.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in
 reopen_osd()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 10 Jun 2026 21:12:25 -0700
In-Reply-To: <814a43e4110884c2e45074cd0601c8063e1a8226.camel@dubeyko.com>
References: <f26c5b29-f72d-4c7f-a87a-0aa5e53cbfbc@tu-ilmenau.de>
		 <20260608084618.966702-1-raphael.zimmer@tu-ilmenau.de>
	 <814a43e4110884c2e45074cd0601c8063e1a8226.camel@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 20:54 -0700, Viacheslav Dubeyko wrote:
> CC: ceph-devel@vger.kernel.org
>=20
> On Mon, 2026-06-08 at 10:46 +0200, Raphael Zimmer wrote:
> > If a connection fault occurs on an OSD connection, reopen_osd is
> > called.
> > If there are still pending requests for this OSD, an attempt is
> > made
> > to read its address from the osd_addr array in the current osdmap.
> > An
> > osdmap contains information about the OSDs in the cluster. The
> > value
> > max_osd represents the highest index of an OSD. If an osdmap has
> > previously been received with a max_osd value smaller than the
> > index
> > of
> > the OSD to which a connection fault occurred, an out-of-bounds
> > access
> > can occur when trying to read its address.
> >=20
> > This patch fixes the issue by adding a check that verifies whether
> > the
> > OSD exists in the osdmap and closes it without further attempting
> > to
> > read its address if it doesn't.
> >=20
> > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > ---
> > =C2=A0net/ceph/osd_client.c | 5 +++++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 1b31e2d50ec6..5fc79c29aab0 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -1388,6 +1388,11 @@ static int reopen_osd(struct ceph_osd *osd)
> > =C2=A0		return -ENODEV;
> > =C2=A0	}
> > =C2=A0
> > +	if (!ceph_osd_exists(osd->o_osdc->osdmap, osd->o_osd)) {
> > +		close_osd(osd);
> > +		return -ENODEV;
> > +	}
> > +
> > =C2=A0	peer_addr =3D &osd->o_osdc->osdmap->osd_addr[osd->o_osd];
> > =C2=A0	if (!memcmp(peer_addr, &osd->o_con.peer_addr, sizeof
> > (*peer_addr)) &&
> > =C2=A0			!ceph_con_opened(&osd->o_con)) {

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
