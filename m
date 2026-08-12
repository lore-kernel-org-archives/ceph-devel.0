Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83D2F3C18
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570981; cv=pass; b=HbH2AK8SwHMtFTDo7Qja+SETY8s5sqsDg97eRjNB3Pm+LAkAHkWVXPs25ujU/WUnuoEMm4oPxYFGxtbnfrZu59StVV7LWMvKwE4Z6HxZJXbzCmqr+eXRaCt6Lwinx+VoPA5mFpFsXjg6trXvZD1jY5q0UMN0Vyz5lFsNIgt2RfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570981; c=relaxed/simple;
	bh=44hRIit9joyn4Pw3FnpRdHMeE6iS4zqnl4px27a21ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUFlcEqwhZV+A5D3QT6BYg1fmPBVGyaEZzEIM9HiX8wE+MjHiHIgSo0QJzGdOGS5jFgMOeeYdRaLM66x+mGXKSkgRcVQ/tWrYGbzhMRa5/sGeKz8DiwtiFNUZ6mIbl7CeTnXNGG6WKHga/3BhjItXWpQhIahFrDLhVNeGupgWTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AR6eZUS2; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AR6eZUS2"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2074710751so16550866b.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 14:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786570978; cv=none;
        d=google.com; s=arc-20260327;
        b=r5WLQGRh9NxZQ058Fm28UBYJBgFgwkMyYJTCoGqfKTHJTvS9kuYemcLrkpwAj3LZXB
         Q0U6FDTGLFsEQRSjCVtaP/yFzJZpgoM96In9Orba1s8vm6o6XWQpGzrwjJC6CE6rzVTv
         SmfO3qv6J9iXzPMF8KItr9b0SrlchV/cq4O5Lb7mHx2jrPHXTkNbJo1uKCJwd0HOHwUI
         tju2YZCxx9TdSuCIG0dXjRsh33QYIEDPruPte/siu/irFIlwbHMq7aVNa/VAy7iWbqZY
         wZtnYruSaH8+RN0wKYmejFi50foo4LiDxJT13/0o0IT9PRa2MhdvMhuqsSmjiR/7GgGV
         7zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+sWA4qLOJiRgfO6AeOwNH6h+5R36KOs4zFglaIq7gOY=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=kCio28ypMS1gDZ/w+dW/3w5dejzHT3SNFyD9lYR9qxwQgOdBK7P8fcSSdKlKVYKIFb
         ZP7wbDMaJEiSpBPsEGVaTyh+5vii+hLzorc+zafbnMUBGVIDe26I6rJ0nPc2ElLHAibH
         mPnV6xpehBRlQFpRJGhgp2GjZMld5TPOrFMA0PufOmGhn6dhkoAWp4mCEUGIYGVx/b6X
         XgUYJZ+gV+dOuCkFBQ8K9f2RKLryRzIjzkIuB8R4NB4O2cNtFLE5BlZdPhBKjY7Qech/
         SP3iV/jb9HM4EavoO+c608K6OCr8txvCODpEXZjJXadT1/aqSW6MuizJsYYGmVXvDmNN
         JHUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786570978; x=1787175778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sWA4qLOJiRgfO6AeOwNH6h+5R36KOs4zFglaIq7gOY=;
        b=AR6eZUS2O8zBCiedAj4bAElSO9/usSSwikatbdFYhoAbW2FLZYHst3cpGjTI2ZOh0K
         tgtgXhjp5SwtYU0I5SLOyvotw9yKIB4Avbd3Nt58KreC372Dxvki+gC/E7wmMu85dL1+
         A9t7GWUtZxH87nUYY9abogwBHDJzbmS5QcU6ero5coX0o49Elfjrrkk6otWv+GJ0BBmd
         BO/f+pDG0hj7+Fjerjpv4T/siAxygmBtG3oLEOcOmZzXjoriN/ujx4gIDpZA5C7D8spc
         V564+JSBa72IqbNNbnUvkcuJ/1+y+f1WxFAQPyw7FmctfhxumkzRcteLG7wlPVxNRGoQ
         sHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570978; x=1787175778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sWA4qLOJiRgfO6AeOwNH6h+5R36KOs4zFglaIq7gOY=;
        b=ZlBDJ9adE0c2u7E7xL6R0CtuE5jQ6n96tpqgcJ0UHY7u14mfcFEEXjhC4eMjKxov76
         LfRVEWD2RF39h7Ouq6Oh2mwGPnYOlloofr81ZibhKE7OUlWwF5cLzQ/j6emhhBsE9Vb5
         w9TTdJNWJQdSos9nh1IfpGib9IJmCgjH7xxLNDcL/UfqBPiyD4HsM6+lmJ8457LxYBMS
         jLHN4I204vXwh6tedEhLP6WAmxUn3/rLTGBX0/iTJspob8n0PxCFA0QQf6qLkF7VL53O
         ABP8CqmvEsIive0k+IAlX9tqWuzYoHJeQHSVzwTL7y/IOF+b4vvFzw+wy6i0Cmle9B5O
         i95Q==
X-Gm-Message-State: AOJu0YyC19eVsLC8OVUu/WF2eN6xrHPBbs4nFCHR6+JqYRsiyX0HoOjY
	GFoiIfTNfXaq4A+Nx35woGWu6igurUjDW6CpAzyPcam7Bv4GZjo1DG9WQlYWgwzoNZDFlUjJtIT
	LYvCMaU4vhtuYjOUB81WLC2sOGaKK/qiUzksnSppb2atlyl6uA5j/rww=
X-Gm-Gg: AR+sD12mXsANiT6rvMShYErPto67JH7rUugqCJ4Js+Qni3eS9VI3CWatjnR4lHA0wBf
	wX6fF6ZZJSM2pomh/UeSg4mfCNC25fr9tgyxxkxEDiYlVpPFUJd+tjQQa4kGElWgLxXURh8CnTo
	UrlKwNsYREDPclFWjjyM4WLmhfoewV0VWSyb1ljWdXOk+V32sUHCM5EL+UOHhHDMEoMI2Sq/v/8
	hVQz8qyA7yGLMZkj2HMkylbtbnKeUuyRjcBo3WlOhLyXqG2tNHT/vbvGPWJ4K1bouwGzv5RgWCw
	GFxRrzkzBXS0i3KCljK7Hg/o4slu/AgJ8T2vTB6yADTeO+dJ73BGZq7BIHkx3NfkzXO8fWQzfao
	z8CLnggrC
X-Received: by 2002:a17:906:4788:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2108f1de3bmr61784366b.9.1786570977843; Wed, 12 Aug 2026
 14:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708203858.263229-1-max.kellermann@ionos.com> <20260811143218.2702177-1-amarkuze@redhat.com>
In-Reply-To: <20260811143218.2702177-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 12 Aug 2026 23:42:46 +0200
X-Gm-Features: AUfX_mz6t6yi7GSkGwdZyy7s5UsSGtmjw02Fpc-A_RzPl8IgdMy0cAwrj48EV1g
Message-ID: <CAKPOu+-oYFT=-q60-92R-6jh9ZiCTxe1SkH090HTeC9HZ+EhPQ@mail.gmail.com>
Subject: Re: [v3] net/ceph/messenger: support IPv6 Link-Local with scope identifier
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:32=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>   1. [critical] messenger.c:1259: scope_id leaks into wire identity, brea=
king handshake
>      `inet_pton_with_scope()` stores the local interface index in

Uh-oh! The Ceph protocol indeed copies struct sockaddr as-is on the
wire. Is that portable?

Any way to work around this mess is ugly. I decided to fix that by
wrapping the memcmp() in a function that clears the scope id. That
requires no extra storage, and it's still possible to see the scope id
in log messages (though ceph_pr_addr() still ignores the scope id
currently).

>   2. [minor] messenger.c:1334: Allocation failure masked by DNS fallback
>      `ceph_pton()` can return `-ENOMEM` from `kstrndup()`, but
>      `ceph_parse_server_name()` treats any non-zero return as "not an IP
>      literal" and falls through to `ceph_dns_resolve_name()`. This
>      silently turns OOM into a spurious DNS lookup.
>      Suggested fix: Fall back to DNS only on `-EINVAL`; propagate
>      `-ENOMEM` directly.
>   3. [nit] messenger.c:1247: GFP_NOFS in non-filesystem context
>      `kstrndup(str, len, GFP_NOFS)` is used during mount option parsing
>      =E2=80=94 process context, no filesystem locks held. `GFP_KERNEL` wo=
uld be
>      more appropriate.

All three fixed in v4.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
