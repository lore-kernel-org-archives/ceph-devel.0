Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C093806B5
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835698; cv=none; b=nlAzBdoziNDUcOD8tg1XLUrF0avL1oWXhtH0xZXaKmApdujKicmxocpXWPctxp9qavmfkt22gxGmtzbKN6TCyGwpKsxVgEp+3D3IXnmbkgxpWsP79TodofeVhdR+UMlJgUGOdcK5lJwwfRgk9BnMayqcGn2g6mSsfDn4oiUiQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835698; c=relaxed/simple;
	bh=NYDrxf2hpzw52Q1bh3Lx71Cxd5pqkHeyJ9tZKFuIdDo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BP3RnvxPyAGc3LisfKTeDxD3EQjX1KNEu7BNTMWFXnddvuDmBn5ElkiZHkvRCtgqTnaHbux0TIuENJr1erzfcyVFTUaSAK0EqoDWCOS8/2oVKEN56duBmwcTzz39MFkGIocAjM7MvvTdxw6MrOfV1lrOE5qhDbMmXDC5nAWIbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=sKyAlzoS; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="sKyAlzoS"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30b9e755555so998341eec.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782835697; x=1783440497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6sW81JwyohYJbc45LZMggU0k4JdK8RzbFbaQXjXnC8=;
        b=sKyAlzoSp72Or8jN+ZLJz0XO7L9YUFcI2yU8cCrkM5iPPVag3kVc1G9P9bEL/HhY6Y
         j6yWddFljY7o1q4cmPzQofwFykW1/T4oXu1Le+zSsbPB3z/+ax/YnsHpk7BxQjOC3PEs
         jVvFMMVN8ubeyS9b0nCJw9wjf/Neq933iZwJTjj7Vm7TFQzRoDFJdkPR76tc6rknDvOk
         cjdtDYXt6UxKHy/i/2CgWn95AXQ5CMNsF2ECZJdJcCnOoR7ULNUSklE964n9VDsZEcds
         xnHNBP8NQ4QnOlRgXGk0zBkebOYFr0NgJ9wMt9KBqAkA75q0SP7P3WKoAd0ASqBWLrKQ
         Nuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835697; x=1783440497;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6sW81JwyohYJbc45LZMggU0k4JdK8RzbFbaQXjXnC8=;
        b=R3hknW2x8kIXEhcEs4mRVFdv7TgY2Rb4KSWpuLSzOWe1EGQRicnTqq+xW6VHQJjvUE
         vxyci8HXneRWjRq6d1Ip7tYo/AMRJ6c6NwxzI/mbf1SLNpa8ksGtmdQ0yjeKGUkiJQNC
         EVqoYRyLORxmrFppg2183cVAJoxl1v9Hu/S2sG2V38t2RwRYBcYNboDqhNLt4tsEH+DY
         p6De9V0+nxkiTEW0Od0ERsZNCXN199JYUW/AD3Pw5Mfo/aNCaSvujSaU/lSGlYHyNu/m
         l3qSTi5I6fKS9/BvqxB193IMfzLk6C5WmNKAObJnTVKhkMp9ldNoRSjIowwEGrqUu16T
         nOgg==
X-Forwarded-Encrypted: i=1; AHgh+RrELHRV4nJJbfyYRWrloiTm5QECrDffeRA/xWagJZTPhIVVs7vnE5DzDjTN82CksBWSx4Vcogr0NB6R@vger.kernel.org
X-Gm-Message-State: AOJu0YykwRUc+n3AX5Q1KEw7KB+GGQaB0gQqNvZWM7fAMlNYEl5TwOKk
	kes1F0qBNU3Di61IEaGn1Yweh73rWMkKxSDemfwAeJMcsMcy9hvLVZsgty3ljfU+uO0=
X-Gm-Gg: AfdE7ckTZ5eSON48bYKlg+UhaXBx9PEP4UC9CLrLp1OVqLjFJxkyJMQ+2Uxb0HMoCx+
	RtRmgeFwp1etycsEjqKjoSqJBUycVTyQyRosqkl+vid9TQd7JMnc7qalUvtWPRH8E/LMMZIbe6r
	hE+553BtA9T5gvfU89/UCvkgUVO4CdcXC0k/YrCcrvPDHp5c7kXYhXx59jeVSAKO7re9q2TCjjl
	xLOmld+RwYRiw+r0xz6brFBmsVrVUcT3J2yRXz0StyGGTMTq4t5m4hd+sQHvYDxQ0XbCVn7/sdl
	G3falE9jrYDLoMWpEznr4qrpF/GdkTQLy7jSmKvKz6igowigToRshUfojbkNRj1Mgj71mn0doNG
	biBPlXWHpp0BUKFpEJU2WbSQjXx8A5RTIvpwCYzMi5HwEsxdG9EZYc3Nezu+y/chhQ2QGL8x1Z5
	VAqDpNdzd/W/DVTkiFnf7rSTiEg6xd23NuT5TRNek6dXIgsGvYMUpDcFgHZ16cL2SAy+yG2aJbG
	tPB3tChaUFoRBmrs55E4ICYXA/sLbYcaA5NivY8fxglZN7DELKCYq+54ZuslToDNtfmM4H6r95+
	nrApez/n0Oowp5JdgA==
X-Received: by 2002:a05:7300:cc0b:b0:30c:f84c:b299 with SMTP id 5a478bee46e88-30ef092bcccmr762785eec.24.1782835696761;
        Tue, 30 Jun 2026 09:08:16 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm10338792eec.31.2026.06.30.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:08:16 -0700 (PDT)
Message-ID: <0486cc931c4792481d052d11f9077b07820a38a9.camel@dubeyko.com>
Subject: Re: [PATCH 04/12] fs/ceph/super.h: convert ceph_inode_xattr fields
 to `bool`
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 09:08:13 -0700
In-Reply-To: <20260612165204.86137-5-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
	 <20260612165204.86137-5-max.kellermann@ionos.com>
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

On Fri, 2026-06-12 at 18:51 +0200, Max Kellermann wrote:
> This reduces the size of `struct ceph_inode_xattr` by 8 bytes.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/super.h | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index f0f03aeb5b19..18960a9e735a 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -318,10 +318,10 @@ struct ceph_inode_xattr {
> =C2=A0	int name_len;
> =C2=A0	const char *val;
> =C2=A0	int val_len;
> -	int dirty;
> +	bool dirty;
> =C2=A0
> -	int should_free_name;
> -	int should_free_val;
> +	bool should_free_name;
> +	bool should_free_val;
> =C2=A0};
> =C2=A0
> =C2=A0/*

To use the bool instead of int data type looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
