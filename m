Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652996;
	b=Z/q8ZFtVFA57ox/bqGslel+LZmaZnaH65bl3d0Hbc2w9Lz69WxIflUgx8DJb04uK1mSF
	 DnRAixjsadKYOEH5v6U5bdqQopbcLG/e9DXz150j8yr7DuFgMpVdh8CITRZodVmP+OVEw
	 tBAYUe8jW5QonWT729y4gtDtLdLTCkIR76kVgMSlBKh9XRyidgRqsmJnln9KBdTCPhuz9
	 wP0RD7rasHBbDIHdwDAURzu9g7xD0kj9Ali7PCDzP0LPk+YxcJr67iha30gRQzRtwAakD
	 c9IaCcn9EGd85/mxvX+nrroSoijdWOKo2rZ85pTcvPsdUubtOBT5napnNlzZISfAKKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MuZG+yo1i9wq00dPRZWOVqgpb9Tqvqe/v2iOsNIIXZQ=;
	b=vJzY5TUmgUFGQOIK8uqxadLc7pz95RTWLGJSy0dur6KNux6jNMrarp1MruEsnE+sAf6K
	 gTAIEqTnwGRNvZPoAYq/N2uu+4sQpNsQcqiFk3mzRBirTUChGae/tLntSrDoQwm8DB8J0
	 tIZZ1G841GBTqdQwudh6ajzYBkwa42dcimUXUfPqaSw91TqWwMxYuarGhfY/dEdBJZWZl
	 c5FSyPPox87RWo0VvGoCiTkyYp8yMs9xwXJtGWgkeV3aElr9Ha4quko4ideOMwlgVmlcg
	 s51/8cOh51pCYS7rxFnVIIXjf9ej3kD9vsiY8l8DRJp707efw7Qaz/oUJkCX06e5H9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYkvJHXS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019B606A326
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2026 20:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E019B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYkvJHXS
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c322cbc998so719356137.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 12:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652995; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+P6UANWfptQkZz2lAWDXodWiI82q1u9W+ab64HmjV9FETYFEkbbMmT6pHJczunbHg
         8fCJZeA8b+ksuZNy0+edjx1j5GhADyxJ34MCs0HKKwBPqRdngj60/mfuZQnhzx4jHgdZ
         557LCZD2skYZQOCArbSRfMYlgQ8b9KdyjQ2uGy966Jj8ygsR8XMEZZoTUhQ1hUkoHBEI
         ebAHtjApdawlv7MBrEChJMjzyOKiz9OyeAqt/d9kwvoEpvJ/yoYdfWls5MvgDUg06E9r
         JjLHLtKz3wiHBghXuXPQMMNLqyZR+lOaRZAbv1MDj99efSEGq5Z619oPrDcXVUQsb+Z1
         7j1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MuZG+yo1i9wq00dPRZWOVqgpb9Tqvqe/v2iOsNIIXZQ=;
        fh=ncwOipQor3a4YyShXK94KJBGMJfgy/V8iQuIrfX50j0=;
        b=Wk+BMM+As5jipjBuTu5+hjaOl8VLuOMhdNwFBP4O+4EOYQ6yuvb9H1crID2MKQxstZ
         S8ZSYqmn5XhoG+HEqGH3a2gOBGTseL8kS2ZJwt0mO/Sz031fbFAyG7z4t0pXUU/4BHBp
         xWV/7Uqx+uIe7rlctdkV3e1UhiIy0uBf12ufWraenv3aO943/C5zwES+t0Ejor0SJ8H3
         Lii3cIB1bF/sNLH8gFVtg9ZMzDH/0bLbrWHZOkD+VHyC+o4sgcItvWEzP26t/9M8QSPb
         mEitTKj9YZCW9yWtnQmzl8wN03MsilRSZrdiGroFHalz0iMPXvViMJK1aSivhI+Vopwe
         vlHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793652995; x=1794257795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MuZG+yo1i9wq00dPRZWOVqgpb9Tqvqe/v2iOsNIIXZQ=;
        b=hYkvJHXSoV5q6y8O9WYhV8I2DU4cdS7icGibkw7QpcnRH5M299xUqxmd7OUI/m9w2v
         jqoghhwx3vDfBtv+ksWLV3mnqF09DW/NiM7u1LXK215PzfRRyeFSUKAuCktx8I5hiA+s
         ut8k3BKq8oYRMleYsFT1Gh1wmidLIi+vWt51OYE8Oadx6vLC0PpUidomacJ0XhMbWP7c
         aH30buZ1YVrqVvKQuGCcyzkVeCIbcXGod5KsFY9yaRDnfaD9axP+EMXq3kA/nN0OuvKE
         IvEfygIpM4qH58XfXEMJ1baQ1mddYFsL9GpWCB+PfBRcdMfjf2tiXOsDfOln+zeoeGN7
         GvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652995; x=1794257795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MuZG+yo1i9wq00dPRZWOVqgpb9Tqvqe/v2iOsNIIXZQ=;
        b=evKpXv3nbeILqZnB7tPVmq8ARZbzvVM2noAoHCUu0jIfg2d6cBizuUEL3t850tlhut
         YTMg656MVtpkTk3fUhkf7YJ6KK8CKumXMVxZ3lyjw926px7UyY+KF8K8zwbaAuRFdAhP
         q4lhSH3/pR+D7ef5piYhXBbfjQB+RT0CZRiuYLWevjS7Se0sXduBbO7OkIhr1EALvi5L
         TxHsrpameRHACVHmLxbX9V9+yOLxHY2/XAe6Q2Nh/iT7yopRDV0DpO68xnZaCXierO3v
         4JZrRFPA6VpG/VRQeMYvp3J/wZZUAusqE7WDien0kvD2mOoty8EzbJjHPHmTcwi6p9Bb
         Rwkw==
X-Forwarded-Encrypted: i=1; AKwUvBxG8ev7jecFuTn+N7n52SfgHGDWmIRlWEAYMdOgb8IYP57/nE5m9cRcA38ho643Lk1TtTt85nfRJkm+@vger.kernel.org
X-Gm-Message-State: APuU4Z/9KbVMTSHENpbiE/VsscIMxelL9wdSDmNvytCrDI2EH1X3T33q
	5HOkUXGRJurxjMLWL9dLn344EtgRJxOOuZNM0yxlqlxnbFev38A2vwaNkI9PyGNNDtoZ1u6bhcU
	xh3UTPotYFj9fWpdcxriJYx4SJqH3I3k=
X-Gm-Gg: AYBFou0zrxIxGMHg9Pk3zqzEu4YuYDuLxTDbQbQ/ohKeg7JUfFKbJZ95fSJscCUM+Y+
	1t/01YtX6lgerpn/F2YgayBesNNBiSvJDdnifAjnvLeWM/65PFZDETiStCKdBvvtFS05liRnCEy
	BSeKPnhQ1NI0K6dMRE9c8iAqOkcJGpe7qi3ndATcNB8N6zv8IjwoUIgb1zN5G/Es9giYEvuZpwd
	j/zGsm0Ma3IxFJIjHPuCPbXtm6kqxB3j383MExnebs/qBJGyEtVfIiqhN+lFgnDMhOY4Curb66o
	mnSSh1tbACgeQKxfFM2OW/HVpiUlEduDfoyY+2g4ekEEj6ZVskIKU+jk3/qpYZZ5KrtAq0+LHsu
	rhPuxlOcutdxs9hxGqclPHZIrqAi7QKF/70CVifyz/FZCcLj4IFuBY+0fjsbywHvWuCu0CebSL3
	4AsKygI0qfZQUu2zK5
X-Received: by 2002:a05:6102:358d:b0:7cc:21cd:9b68 with SMTP id
 ada2fe7eead31-7d07267043fmr5737257137.15.1793652994814; Mon, 02 Nov 2026
 12:56:34 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260824184159.240821-1-max.kellermann@ionos.com>
 <20260824184159.240821-8-max.kellermann@ionos.com> <CAOi1vP9nBoxBD9VTmMm5KnWj4zp0mdeXxTkzLR5tdBrmKrQ73w@mail.gmail.com>
 <CAKPOu+9C5rWF4mn6t660C5YxrcGHWvTFFEMkHeXWba0L4Ca=Rg@mail.gmail.com>
In-Reply-To: <CAKPOu+9C5rWF4mn6t660C5YxrcGHWvTFFEMkHeXWba0L4Ca=Rg@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Nov 2026 21:56:22 +0100
X-Gm-Features: AclHuK97uyDQ3RYpQzzUnogBK34y_2RNaw7d0TMM8K1oxMHm0Ojp2qbRWh1Ln94
Message-ID: <CAOi1vP9soGj9zfG4D58+RQHhmZ7F7jXadgudB7+FLra2nBkPpQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] fs/ceph: remove i_truncate_mutex, use
 i_fragtree_mutex for both
To: Max Kellermann <max.kellermann@ionos.com>
Cc: amarkuze@redhat.com, xiubo.li@clyso.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:05=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Mon, Nov 2, 2026 at 6:35=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> =
wrote:
> > Only 8 bytes?  struct mutex has got to be at least two if not three
> > times larger than that.
>
> You're right, it's 32 bytes indeed.

Good, I have tweaked the patch description.

Thanks,

                Ilya
