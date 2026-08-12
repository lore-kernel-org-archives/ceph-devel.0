Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FF2E03F1
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514340; cv=pass; b=SHMfm48t4Ttsq/mVktpnmT5LcIyQsKuqpjPfxQdgv/45TZWApGPSwzHJ/ZcnH3aZqk+rARuuvFox1a1qbLtAxgk1+RlB97BQZVdb6kgtPwqj+uEW/u1oVNlWq7sNJMvcUQov636HWz5pFWBb74dW8G7JlQTvomMoL/8dPRyHMHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514340; c=relaxed/simple;
	bh=vVFkqrZtbm/FO0DBf+QPYOYp0TMDPq/+weEhU0+K+FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIopiCVc3igfFaiXS7dXFDe+ncnIrzBloMszXCnGQ4Jifo9zOzLxMP/h1IgJr3hlN1126utPmsIXcEEHhAhgr2/QFyayXFOa4edoWWZpDqKEFuVzioGbvLU1QxeKHY4nQEUNB9Ns/SItAAMjESMPrIbdEnuIu29gjDW9OSi3EL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=i4QqwCcI; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="i4QqwCcI"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c207cb16cf5so84294266b.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 22:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786514336; cv=none;
        d=google.com; s=arc-20260327;
        b=hB93daPfn41PYFYqV0vBi9K1VfuYUTO0/OBo3tCjFnBAmg1ZxLBgPzb68PWa2wfcUy
         4VDtvggrg9pMW8fDyyF52lemVHnqEFtdizR2dS6/J3P9Ww18zEJvvtCpJPGRCS27RTX1
         OVzhxoGHEXSrPa30MP+UKtFwAV35GsfUecH+xRDBt/Pqtg9R2oyiqjxR+DR9ZEjxLdL3
         Nf90aE42Xi+IzfEEITpyPicfpjBPAJ5mtZFzulTJk8TQVWrkFdYSgfGn9zhNHzKzhDUf
         pSFZVrGCtBoh1y+YwIKKj9iRy56z7m+PJKcUGFVwUfivw6x9MbgSSDeJit6hkB2nhoms
         v4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vVFkqrZtbm/FO0DBf+QPYOYp0TMDPq/+weEhU0+K+FA=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=JE9vwA/U0MLA5a246Gw29CDKBGefLN2YeDo7nLbgRc8+zTrtpvv94gk022624E1Ja5
         j77oIktNIARp9RttPtrgxEymtzdCLY6hVS5nVdO14sGnx5rcZJDbGhYXcDb+yIqX22gb
         XyKwwP0xuIzlTk/JoMrqqANv3vEBB+NzoaCSDE4Bu+Hv9TqKKY2Hbg697Sa4Irn+6NkW
         bCmY3tstovAM496fOx5nHRhZAKU1xfwitej9gA+6e+x5IBAo6BhYZdZsDFO4fFb9Abo6
         zxAs0+bYCC9dPBO5LKILVtMl0SKoBf0fSvEYROAWxmI6x7NyC3cTSkIiLIHIXmBqwXan
         CtCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786514336; x=1787119136; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVFkqrZtbm/FO0DBf+QPYOYp0TMDPq/+weEhU0+K+FA=;
        b=i4QqwCcIx0OFaNy3M8nrdbo1kOuU1C+k9El09dxr1hYmL7gHM3le9ant8ZNY1WNU4u
         M39l5jWghDNDnQoevJVDMO5PHqcsPlAI72uNQpmIg5ED1yyQDzDRnMc9Nw/tYJw4+Y5V
         +RlkpKChxKX1qgHxhAABv0yA8hIaVLjQkMKmuyZWtiXgHRTSRNjNlmB4TJZXu3KRQBLF
         bL/mwN/UNywSs0v+2hydrqz4ShOFOvZgqx2PqMV/XMLw3KpQzCeJHx1LshjH5MnbNfY9
         hUSQ2ArEUc46fGDfO+eklAuoGcVRLt/RC2QopqqHe/67GU0BUp9EvHopaQiSoz+oHCKS
         vYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514336; x=1787119136;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vVFkqrZtbm/FO0DBf+QPYOYp0TMDPq/+weEhU0+K+FA=;
        b=m+nS7PLETPq94ArYbCREHu+D1tzG3F9j+1fc+rFAjVeRvc/9u8FHezOjhiALgOhSNf
         TiL7DW4/WXhxeZ8RGWAWD+nfO2/3reYtI2/cmZdbfU3O2VO8hKIspLMgEt1FDnX2tqNp
         Qt2ItCmUsrjPUjVLSuoo5whhcym+b3whpQuKE/jL+5UHEWGlhKj916uOiiNLjcyHu8w0
         QVK5hi3YcqgMLtUhZh796rzXg93eioA4KizTMOQw15wIxOeObFqCS2p6KGT8XDSzaH4b
         jb6NFsHyBVLo0qO7ZnoovzULdqGW20lmdbu+oYV4wB340DantfykvM0nl6I/Fn+avjZG
         gexw==
X-Gm-Message-State: AOJu0YxfQEeUnbYNP1GdJLG6ia+DJSdBx9IO5O9A+26l2+D7sY/mqUU8
	YStO2LxyCbjwP0Y7+pVp4tXrzORsTYm6z2NVlS+J0JqB0MgPF6xOKA75qRMFawgt+wGHbc9X0O1
	bC3pviZyEGv3tie6YbhpqyaOnzoj0rwR9nZ5JWyWYCQ==
X-Gm-Gg: AR+sD13aEX/OKacv+/CWARDmI6G7i/kFKXqNCDSkaMMIwmJWCgYP5cLYBULCsIB1Dd2
	iwXdJJktDmT/CqGHs1cXGFquScl0BUSu6z5xHd140mpTHLYdSbCb6sizZVeWCh2t4uPLiJtn8OC
	xabzDdTByptuN1dPL+AAzzk+1d2gD8Ef8v2FI+4kzQz9talHVhx+yWZ/FY+zBXikNAjCkI1UfIK
	OiPkholly8GlL9hFrSuQ9VNGzBN1wZn2TeAQ1UBQnuC7CsG75ENYJbhpsTSDYY35NiWlGA6jv7Y
	v6UTUwWeDAK0F1x8qIt1hYf8KJNVqdvyeEK1W5koAXOzwQ==
X-Received: by 2002:a17:907:987:b0:c12:8cbe:b897 with SMTP id
 a640c23a62f3a-c20f302644emr126326866b.15.1786514336321; Tue, 11 Aug 2026
 22:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ceph-mdsc-mutex-optimization-v3-2-d031114419f4@clyso.com>
 <20260811134101.2689120-1-amarkuze@redhat.com>
In-Reply-To: <20260811134101.2689120-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 13:58:44 +0800
X-Gm-Features: AUfX_mxvULXzwZfun0OWOkE93Fco4SjmfcDaa8Du3Rs8UqqAExsYwAdtK7ojuBU
Message-ID: <CAOJNxRJWOqGTGEb0hsm5OQB_jbQE_0zWrFp3-E_FP5eecZ+O0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] ceph: replace the request_tree rbtree with an
 xarray keyed by r_tid
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Good catch. Let me fix it. Thanks

- Xiubo Li

On Tue, 11 Aug 2026 at 06:41, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> In __register_request(), ceph_mdsc_get_request(req) bumps the refcount
> before xa_store(). If xa_store() fails, the function sets r_err = -ENOMEM
> and returns without dropping the extra reference. Since the request never
> enters the xarray, __unregister_request() is never called to balance
> the get, so the ref leaks permanently.
>
> Adding ceph_mdsc_put_request(req) in the xa_store error path should
> fix it.
>
> --
> Alex Markuze
>
