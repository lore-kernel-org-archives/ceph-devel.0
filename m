Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808372C21F2
	for <ceph-devel@vger.kernel.org>; Wed,  3 Jun 2026 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506046; cv=none; b=N0eG+VPY2athGYQRs7hD+TwonDpA6NRG9oeBofvtGWcJR/xk3G7i2ObBpr+n3fyx0UpLF2FKb0+5pRFHygN2x0Aw8dRlnmbynSRDGYTcSSDWUm7xhatfNcDyu8UFT+zospV8i0CeGaINE0kkz+F1zy/4MToU9yw7l5TZe8/olv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506046; c=relaxed/simple;
	bh=C+atMj8E0VeFS8Jwo86eg+YRLRoqAUV9YsabUhuPPBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aA1Uj5sCWYTkr6CFVvXVR4I9KOD1AHKF5ek4RU9bnKy2m1D07QcAtVTrufXnilRa9Qomz9kNsIS7PVgnjfR1n9Z8ZjGvA4VcE5ykqOvJvY5Zaw++9bG3oSkABCCT5m+4po/4NGTwmTZQT+KOupbsjYZeZBzA/wNlLsTJRUkeAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=sbHvG4Ic; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="sbHvG4Ic"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6d2f297f4so1434368a34.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2026 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780506042; x=1781110842; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8BNbn8Gw6ErCpk7zWof03GfRzDK3VA/rjGXDP/C41+8=;
        b=sbHvG4IcfVxwht39DzOpBoHp3xl3f3VolmILIYYFrenie2UtYcTmT0BCofCVn6gYo3
         xS/QgmwOZBOloGR6vqYzAKuKBt80I0MCP+yTmrKq05xM7NQtA7vB+5K/dMTlFtdS4ocu
         Mme/sCJAY7BuSyCMCQNksXauoZz78WWvn5TPj7J5fnoS0IGxq57IVCYvTub5USk87Vpw
         BDBP5vpSk+8mBDF2Hxgh+NbFUAVXk09wqLGYooP1GFkqY+rm6aAZ5khbQ16gNcwNKeCH
         NVlZlPXhnq6MYS4VyBLhTvJN3j/TUKFsvrZhm5vs4TJKhErOmG2eo3e8KGc3xtqs6G80
         NzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506042; x=1781110842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BNbn8Gw6ErCpk7zWof03GfRzDK3VA/rjGXDP/C41+8=;
        b=sTgzO1Bs5qUWIuaKJW3188oNTQ5folYeGAOsdo/+TUvQxvkF5I6EGytHpAGQvHDUxz
         RK0YEvWEhapyYqHjehqmNmiAUkaE2GXiadKpeAJKu5HjHTT/iQGzfK/YAm6rm5n2xVcF
         3tK35yTy8UvE9WH9qlyDwc3GTcEG4XXrIHSAb9AWqo1qwQ3WPv0mcDSZtqq3vOAnbBMo
         +BGhvU8NfTNbnjsFkT/8yfDxWEYEzrHGKESdnOaduIjxfBis/rHDgj2ym4+zwxWP8NW2
         Ba46NYCENJIIw2bMSVWDAmd2dqWfqC2H0qVhqGStptQ6bemif4u9BxgJL1bcxEC5M3ky
         aQfQ==
X-Gm-Message-State: AOJu0Yyb/7ArEZDfRp3iICqVMUYLTMu15YNx0c7bh9ZI6HinMBt2+ZHc
	A3Iw2fmCKODlqW2S2zMjW8Nzha70nyvxxhbO41dkLcvUUgz0orchzFir3XgqTM7G5Jw=
X-Gm-Gg: Acq92OE9M2bNl3Ypkocm4CLxvU6++yLsufNaULGAnEBhrU0dhAxF79aHKdtuIQOY+Es
	1Pg2JdcZDd8tzLb5iNcYYBTG7iDdV6Dq3afQsmUQdkBJWGgioC1MNaNXlK+/n8TiajMnlRegc5S
	2Epp58izvJMA5UhTnmBBSX2F/Zbu3Z390BDk7ev5/8qEDsGOovYZ/54KD2y3Ri7KnHQhh4ZQZ+G
	CI/1StoungCTH2rHtzzptST4IqX2dfEdEqkJzCxND9VHdLgWAGMdS4yQ/YKaJ3Xzg51dSbhZ8ho
	Y5Sw0VwEoYEUfabBPCKq0QO6YFBsZw9nC2Lvb0QMqVTFkci+HI/izOBrk0pEoy62lrfmkRNOBI8
	S77pE+s9Uq8S40JWeDv3bl5XcJuLtQEuRBBHV4H3iYYuFpfqV9XcTa6I8iXUmwcOmdhJ3NKM226
	1v8kMzDg/E9HyammJY01DnYco9JoILGEqZgVHR/qQ7mGQ+Mto0IfKUFoCNv3uogakZqhSgORVja
	Qo1KWb5yXc7ZrRghetObXEFgPw8MdphTYRM6f5guSVAQodl9N1QiGvK0659MAYgbu75
X-Received: by 2002:a05:6830:628c:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e6e9460e83mr2502186a34.1.1780506041996;
        Wed, 03 Jun 2026 10:00:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9912:77fa:9c5:3949? ([2600:1700:6476:1430:9912:77fa:9c5:3949])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e7f9csm2086785a34.17.2026.06.03.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:00:41 -0700 (PDT)
Message-ID: <f4c297b40c443347dde71e4d7ee3d08b9c95c0be.camel@dubeyko.com>
Subject: Re: [PATCH v3] ceph: fix writeback_count leak in
 write_folio_nounlock()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Wentao Liang <vulab@iscas.ac.cn>, idryomov@gmail.com, amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 03 Jun 2026 10:00:40 -0700
In-Reply-To: <20260603012500.3688976-1-vulab@iscas.ac.cn>
References: <20260603012500.3688976-1-vulab@iscas.ac.cn>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-03 at 01:25 +0000, Wentao Liang wrote:
> write_folio_nounlock() increments fsc->writeback_count to track
> in-flight writeback operations. On several error paths where the
> function returns early (folio lookup failure, snapshot context
> allocation failure, and writepages submission failure), the function
> returns without calling atomic_long_dec_return() to decrement the
> counter.
>=20
> Each leaked increment keeps the counter above zero, which can prevent
> the filesystem from cleanly unmounting or suspending writes.
>=20
> Add atomic_long_dec_return() calls on all error paths that currently
> return without decrementing the counter.
>=20
> Fixes: d55207717ded ("ceph: add encryption support to writepage and
> writepages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>=20
> ---
> Changes in v3:
> - Also clear write_congested flag when decrementing writeback_count
> =C2=A0 on error paths, as suggested by Viacheslav Dubeyko.
> - Fix typo error.
> ---
> =C2=A0fs/ceph/addr.c | 12 +++++++++---
> =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index a606378649c3..7fab73874068 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -790,7 +790,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0				=C2=A0=C2=A0=C2=A0 ceph_wbc.truncate_size, true);
> =C2=A0	if (IS_ERR(req)) {
> =C2=A0		folio_redirty_for_writepage(wbc, folio);
> -		atomic_long_dec(&fsc->writeback_count);

Patch is not correctly prepared. Because, current state of the code
hasn't atomic_long_dec().

Thanks,
Slava.

> +		if (atomic_long_dec_return(&fsc->writeback_count) <
> +				CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +			fsc->write_congested =3D false;
> =C2=A0		return PTR_ERR(req);
> =C2=A0	}
> =C2=A0
> @@ -810,7 +812,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> =C2=A0			ceph_osdc_put_request(req);
> -			atomic_long_dec(&fsc->writeback_count);
> +			if (atomic_long_dec_return(&fsc-
> >writeback_count) <
> +					CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +				fsc->write_congested =3D false;
> =C2=A0			return PTR_ERR(bounce_page);
> =C2=A0		}
> =C2=A0	}
> @@ -849,7 +853,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_vinop(inode), folio);
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> -			atomic_long_dec_return(&fsc-
> >writeback_count);
> +			if (atomic_long_dec_return(&fsc-
> >writeback_count) <
> +					CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +				fsc->write_congested =3D false;
> =C2=A0			return err;
> =C2=A0		}
> =C2=A0		if (err =3D=3D -EBLOCKLISTED)
