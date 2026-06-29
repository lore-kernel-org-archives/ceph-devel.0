Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C033F0ABB
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751595; cv=none; b=OhD+8r2jlNXLy8TTij516AdM+pLxypwzSAW9Ms+5gl20VzX+K5GM6NG5saCaRIZH8gRQ+/PHSZRgSaT+pRAchIPp+U3TcJW3O617Y3Lj+GAd9dfI1oInexkOK/KGzBRh2giz5GMkolV0cS7cE38zAH3WklFyeN4OX7oZYjwPkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751595; c=relaxed/simple;
	bh=RRqC+Ph4bBm1aYWQykaNZxgVa8282J6c1ExfFnS54v0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcivVJF5ceN8U6KxiXlovrFhr8rHPO93JkDqDI4Lx2RBouREv5uDnl1f4/DfW93dXHdz9CNqhLAFxfMcrYkMal7h5kdf1kgL3G2uYacIC/UPwQPDe9EzZrmcgfz7gFIo1e/IuDJiI38GROHU1zNrBugGxET3BwMpHuP5w7PI1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qkuqUEgD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qkuqUEgD"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664b05d408bso2871197d50.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782751594; x=1783356394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bV+My7RNdZIVHu219fUo5YksonR652Kx9qOtLGckWPs=;
        b=qkuqUEgDAj4Zour+Tsnf3h4lUaxHDCLUZHGJ91UMUyK3z2E8QFiFZ42wwtdwEdShtW
         OoV3OUTsGrdebPJcctkWmC4FZoFbX/PDc2kBMMB4AHVQj84STEl1m3qgJNlPJEY8Cxu/
         IUtEEwkIvProid4NshN9b0GJO7LKMmC0ok5Q4AzLo+jG4AspTlMI3ixvXobKUyYSS+E+
         36qHatFv8wg8YsAbV6/HD2dls9k2K5jaqb9o49RDqF9w2OrKT5GWoSNruzC7Tw4e8itt
         bUJpHR7noQll9zwqrtinQTKH8rq3tGvAYrQbElRzM28APi3u8lAzYUYS9I1Md7iTwZV2
         WUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751594; x=1783356394;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV+My7RNdZIVHu219fUo5YksonR652Kx9qOtLGckWPs=;
        b=bOvfNQcTwRKOokclNUnxL3Da3GaizdsNmsvoKCvYee5khxwajj6zU8E/UECmQptjfa
         SWoEhbqBgaogfXdDUfLAlzKh06BJZHQMH3w6dSVp28HVyFE17+Jp0XCTbpE+Qs5eAgqa
         aMxLZZMuqFBi3CC1bsRbXXTkEh5ihcX1hxnqU3uK7t26FORXrFCOMHNwrACg+OEQmMiR
         VVs5161blFQogTtyt7OhHU9/pkEQuFId6WK4c3VTEiYqlapnIHUMmyNIaf1ygrxtQ2kE
         nNgXDLcDCjQ4/nUXkerrsgPTM3/lJyjbXq042siFjrTvREtwpM7wSSv66ke36stKIPDc
         sphQ==
X-Gm-Message-State: AOJu0Yy14IpW+cxSmYAfA5dd1sZpxuwTDZMCMj8BACUsOgauDisTlK8P
	D4DkNJ66TFmY2EST2KsOwsB1ytDMdmKg5OFIc8iZj0Iu/PjcDQeLCvgRV2V5cw+gQW4=
X-Gm-Gg: AfdE7cnQYV/XojVcGIdD/vLgIOItgiSoCSXP6Y4OTCmL4cmHid5YsZtdAv5nUOfTOb3
	EhvqS5o5CJj9mCT6Rnv7MvbLcgQIHSufdL+to1z/co3Abrxctx223aNg/sNkDKU5CU2y2ZDArB+
	8VZx1DjtNSrjDGP4mH2yG/3BUlayLSW7byEf8hhhgPnUZ5alkHVkCKNGf2Oo1TriHOggceDGylx
	orNQcYfl0oeBBukyjbi5UJJWVnc1npiwcg/BP5V1CgWx2umA8mmxRt5XLSBYhLRrkxi/s2JWnI2
	5Eq8aVOz2q4s6pSlvKPhkYSW8UPaJuVxKp7Rwlyr233NB4FWupEjOEfzwtwzTGGY2pM/SS1Lb1A
	V40zyzMVXiN6cJN7KxBW0gqlNp7hI3q9dkXFMW75XsM1xGvA3FG1SMtORbAYbg7bwZ85RhkXDix
	eWzCR9BWg/l7C0vYMJ1ym61ry6cRQQLw+DdKhcz5uyGwf69FVm1GUnxBtBxKYlx2AManpAPco+m
	pYPIecl0F9059fK3r8+N97UAbr8O+qj1sToIHsXHnwBVh+9lJcSM7uYKBkU8XcIMN+096uPq9hZ
	cET7i/o=
X-Received: by 2002:a53:c3c7:0:b0:664:df69:9945 with SMTP id 956f58d0204a3-664f9a035f8mr279567d50.55.1782751593593;
        Mon, 29 Jun 2026 09:46:33 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f74a3e2sm7320774d50.2.2026.06.29.09.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:46:32 -0700 (PDT)
Message-ID: <3e59de30e28f37adc0f8db40357134abf2cc8572.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Assign requests to homeless osd if calculated
 osd exceeds max_osd
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:46:30 -0700
In-Reply-To: <20260629084231.2892980-1-raphael.zimmer@tu-ilmenau.de>
References: <2e10a5e1-14cc-4f8f-9ef5-76a7f7c0fa9e@tu-ilmenau.de>
	 <20260629084231.2892980-1-raphael.zimmer@tu-ilmenau.de>
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

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-29 at 10:42 +0200, Raphael Zimmer wrote:
> A corrupted osdmap received from a Ceph monitor or OSD may contain
> placement groups with osd indices greater than max_osd. Subsequently,
> this may lead to calc_target() returning such an index as target osd
> for
> a (linger) request. Because the osd_state, osd_weight, and osd_addr
> arrays only contain max_osd entries, this leads to out-of-bounds
> accesses when trying to read values from these arrays.
>=20
> This patch fixes the issue by adding a check to calc_target()
> assigning
> the request to the homeless osd if the target osd index read from the
> osdmap exceeds the maximum index of an osd.
>=20
> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target,
> calc_target()")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osd_client.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a4d3cbfd27a3..3ae7c51e2edc 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1707,6 +1707,12 @@ static enum calc_target_result
> calc_target(struct ceph_osd_client *osdc,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> +	if (t->osd >=3D osdc->osdmap->max_osd) {
> +		t->osd =3D CEPH_HOMELESS_OSD;
> +		ct_res =3D CALC_TARGET_NO_ACTION;
> +		goto out;
> +	}
> +
> =C2=A0	if (unpaused || legacy_change || force_resend || split)
> =C2=A0		ct_res =3D CALC_TARGET_NEED_RESEND;
> =C2=A0	else
