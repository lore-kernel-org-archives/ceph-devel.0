Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854D370AD7
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833066; cv=none; b=JxwO6w6mwbSfhfWfMPPV+oEufGugBO7S6TjIPn0v448VVUiUwWJZysUlAVXdRF9EyukpW1uE6FLqleO7Xk4qiGhfDpY/+8jKPdnRTwbGgzeK6jsIgxdcqb3qhLClq1h7Im27joe2ECV0F6NE6Mm81ErYGrXH3+kgpDdb05UsDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833066; c=relaxed/simple;
	bh=5GtU4WYiYBPgWmy0sALfNvxHO2WBJavQ9v0P15Vx2Pw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8lYtRGcmv03LSdP9qWkYA71K24wg8dhUt52BMcCdLq9baf1W3/gloGcg1RpOeRUJuNFNe30KqMFixrr3qsuwK4JM0ErkAepzfDsfFBHPvXrHwHnwFXIPoh01baX0mdMLGxhLsPnSbgDmmFc/7/e96qePPYEZzCDCQo54ff75NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=f2EtArx5; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="f2EtArx5"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7fe36f1be74so54099647b3.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782833063; x=1783437863; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVwjFvH8o9VT7zZUNF3zH+2OYgwOPccRECvn9rYDk/I=;
        b=f2EtArx5rB9u7yT6XQIOLP/QjE7TKehUDSnO9eYDbo4vGu1ZF8wRhEE/9gng4zx/e/
         IGpZaahO2rz+/ygCQT5zbskL+1fcx+dR2hafTJZiMf7LQBlJ5RDr9mX6vl0cLMELQkwl
         DxJoJvXJjtj1tWOHIoQhKILlpIloLyxt5q9Yl4ro4shhpYthHrfmyigNECKI0P+3P5PT
         Bu15gAJlA75IFM+j5LNPcKl+Tqe4WOTUY4bI7BwWHaURwgoDNyTzX01SmsnsU8TSmSn3
         CCxA29EFv+xNqI3Wv79NIY9WwfmPJNXPHSOwsuTCe0kaq+JCDufq2pDyvRdAws9YvXBz
         S05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833063; x=1783437863;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVwjFvH8o9VT7zZUNF3zH+2OYgwOPccRECvn9rYDk/I=;
        b=aCFjp2rxqfTZOsMAjLsjCx9mjZmWVsiXqtVmAUAAyKrY3jWZCxnQYp70edzWkT0vRB
         702Xlys1wZKoSsIgqFipzDWaxJZ7tJNW8uFN0tsB0br72JQfpSuuTh+zIoet0AQSIFdX
         zTXnVOAyL2XTdn+wnd5K88ip2pudKkVisBejzLvu8tkuSgjC3+FaO1moMGMHllBHhqud
         dV9WrWuVu9llmftSNEOMWeymesVHHUXRHswYAJpfKT+EyEa3NFQg5HAWcF+MmZAz5yD6
         CD1cDDGvt8d5opCXBXrlwyac3LJN+FPisKnQDNVG1BzGUSVJODNx8HnjaHI7vhyV7hQD
         uB9A==
X-Gm-Message-State: AOJu0Yzm7vESA1n4bVcbBgOUMqUNOjCbO5F/Z/YRuiH9Vw7iO/3aRiQS
	e+/Ta3Cv2IxYOlsOxENLrxAL8PGtBLjGmN/IVrOt9/0CwWDpZv1rOx2TWoXaHNoZmcY=
X-Gm-Gg: AfdE7ck40TgB4WrX2ENQ4ZnGG5B5AcE0RGIWMltM0SiYFZ2ISkYVXbFIvpdTDtsHeNH
	VQsXNfan9+08jKPwlU65XdnEpAUuk7m5g0yuNafs7Ugf0Qxp7hzZOFnavUbroUWxrutrb34dyG+
	7V6a5WlGB7FE8P2ZPG5qJxjqs2AlVRQ3C/1oyILcBI4I4xumCjJoIsxN1S2W2fnClybhaOYbhYB
	zxHg6QlaUlEEfDxmgMnVzU4+RuGXISMos3sCcDw2By6hcL2ijqjiOTmnHSd3vh6mgzCF/nNJT2B
	InoQfqXYbwxBeVXtfMSJZUe1e2sfuMCGpMLg616lhiSHv8WYiQTb4E8v7RcBRzG2thWYx27ektE
	E2jhd/KpGtcon/1pXuZ8e4sm2Ibx/Zgr7WCLkFKcw8HZXxtMQW0ax7Jklewb/B4mFogX2o1lT33
	Jl89SR1IRVQ3sia8KqkD+70e16QE2dx9Dh0DEIyhtfgl2UDrW42W2IuLWMKpjkqalbeQ4l1ot2X
	PKsIyBKviCNlDIo0u6l88snBJWmWottVbkK8zg1wkYFSSkgkGbhL0zuJl0EFHMpbFDeF3inFK3Y
	QWRPJ+c=
X-Received: by 2002:a05:690c:4c09:b0:80d:66b2:850 with SMTP id 00721157ae682-810da60ee08mr42764477b3.42.1782833063270;
        Tue, 30 Jun 2026 08:24:23 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e728a009sm12720597b3.5.2026.06.30.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:24:22 -0700 (PDT)
Message-ID: <231812ddcf4ecf2c3df63880b821173185420b16.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: fix refcount leak in write_folio_nounlock()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: WenTao Liang <vulab@iscas.ac.cn>, idryomov@gmail.com, amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 30 Jun 2026 08:24:21 -0700
In-Reply-To: <20260611143404.88190-1-vulab@iscas.ac.cn>
References: <20260611143404.88190-1-vulab@iscas.ac.cn>
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

On Thu, 2026-06-11 at 22:34 +0800, WenTao Liang wrote:
> write_folio_nounlock() unconditionally increments
> fsc->writeback_count before allocating an OSD request.=C2=A0 If an
> early error causes the function to return without queuing an
> active write, the counter is never decremented, leaking a
> reference and making the filesystem appear permanently
> congested.=C2=A0 Three such paths exist:
>=20
> - ceph_osdc_new_request() fails: the folio is redirtied, but
> =C2=A0 writeback_count remains incremented.
>=20
> - After the request is allocated, the fscrypt bounce page
> =C2=A0 allocation fails.=C2=A0 The function ends writeback on the folio
> =C2=A0 and releases the request, but does not drop the
> =C2=A0 writeback_count reference.
>=20
> - The write is interrupted by a signal (e.g. -ERESTARTSYS).
> =C2=A0 The folio is redirtied and writeback is ended, yet again the
> =C2=A0 counter is left elevated.
>=20
> Fix the leaks by adding an atomic_long_dec() in each of these
> early return paths, balancing the initial inc.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 6390987f2f4c ("ceph: fold ceph_sync_writepages into
> writepage_nounlock")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0fs/ceph/addr.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 0a86f672cc09..dac2b0ae7d37 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -790,6 +790,7 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0				=C2=A0=C2=A0=C2=A0 ceph_wbc.truncate_size, true);
> =C2=A0	if (IS_ERR(req)) {
> =C2=A0		folio_redirty_for_writepage(wbc, folio);
> +		atomic_long_dec(&fsc->writeback_count);
> =C2=A0		return PTR_ERR(req);
> =C2=A0	}
> =C2=A0
> @@ -809,6 +810,7 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> =C2=A0			ceph_osdc_put_request(req);
> +			atomic_long_dec(&fsc->writeback_count);
> =C2=A0			return PTR_ERR(bounce_page);
> =C2=A0		}
> =C2=A0	}
> @@ -847,6 +849,7 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_vinop(inode), folio);
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> +			atomic_long_dec(&fsc->writeback_count);
> =C2=A0			return err;
> =C2=A0		}
> =C2=A0		if (err =3D=3D -EBLOCKLISTED)

Maybe, I am missing something. But I have the feeling that we already
received likewise patch and we've discussed this solution. As I
remember correctly, I recommended to use this pattern:

	if (atomic_long_dec_return(&fsc->writeback_count) <
	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
		fsc->write_congested =3D false;

Thanks,
Slava.
