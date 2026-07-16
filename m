Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9D27F19F
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784175662; cv=pass; b=YP+Ww7iwWUvNYhV5yOZEpaElIpbHqRqRZbFAct5x7Hv5zRnEL6kOS/xrZPpd2HHo5ExlXrw47msZIMQX+wq3HwiPMfQ7y+G1yfCVAtkyVw5zwHSjE6KXGxDPLSTIVvxEHDW5JZ4GtnXnmYLeIR+NqVCsiEYdOZXEJVdAS3YfHxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784175662; c=relaxed/simple;
	bh=+W6KkyUey+5xqFJ+7T3eXwRg1XRy6ZFOPhEKlS8ne+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJCehEOf8Z4+Q6KYGcL50GO1YiDBkd1HNrCYdy80ERDp6wx/oBg44iTErA/o9EXRbVHhAmIbm/7C6N4LfGrQ2DDtkH5G1aavbxXnzW6+qFBEunKMTh+ZyibFaVAKfSgSPi0hnaJs4qqjWDmQYVILORTWEvScR5li/LJ5S/cX3XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=hXKEGX92; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="hXKEGX92"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so5099346a12.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 21:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784175658; cv=none;
        d=google.com; s=arc-20260327;
        b=f32wkv2Ye/xJFnOCmxe1VszFKFYLdo5e6OoewC3t5RESxmFFOWNsuv8+vDC7Rs3UD6
         pZik/QwmJV/pjJWUnzJJA9qYy8DetxbzmlG87DnQUK5MQaiXhBtEM7LoncpLttUmRHiH
         YMwJMqrLgWz1HiAVIgAeeggf4x6jCsNb1B0plej5+GXxwBHrdgfi2okPYzqsJgkAX/Bc
         7DciFmNBBVoTlsFFs3NLA0sKBhubQJMalezgUNRMVBaJUr6dulxudVUP2ksALjVDOLJ2
         YaV+bYaSDu2VAaXqZzc6UUhifUu4qreFJLlgdRAZD/7KzVYK5TH4Oe3VovmES6c+Wsdp
         smUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O8UKg64MkCUjGKc7lZfwbfHgFNh1cKCLNYBmGjyMvhA=;
        fh=iKReDzcW9zd4b40OCFcIuE297jQrE5ZoGcrVf1s/cH8=;
        b=Sy0vh2JzAS+rXZkBX+zMX/E+L/cRDaxnRjQop1ltDW5GH36WPeSYyQrBqeG2/r7E6S
         wDDUjShFrPA19oappBwR+kkTSJGAeswYBrxNfNn8K7bevesClBIkQzjfYDKbDcFlm/K/
         5qY5AWHkaMf/Xf7ihyzel5eRQTb2oqa+uWFJvFLFAmqCazjFZ0ftdX/wkwx4Odm/vHpZ
         rqTqGMcublkdb1h+yUteHWXD26TdhKdc9UidFgPoF1HaXkbs1BfI4C92OxTlKHqSSavo
         ZCWWfQOz0a2BXESaO9dsxNz4cZn5aMaoDsiW0Gfr7P7H/UELZijSWo2tVrKRwGio4MbE
         6Qbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784175658; x=1784780458; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8UKg64MkCUjGKc7lZfwbfHgFNh1cKCLNYBmGjyMvhA=;
        b=hXKEGX92oRt+jijMEoDkBwq2fFuk4NTgxnizB33wcPJl2i4KVDI3idkpAucjsdy2I0
         7kQTkh51DZEMOHZ5fuB98SedKNFKhvD1iUWjLITAoMItfSI6LucEWFY5geTEiD17hf6g
         4pinkP01q+up5rh9PZqBYGS7aM8ZjcW0KuAASyJ+i11AGvKMcKV9AR3/mhwP7ijolZ8+
         4k0ewjwPO19MQTLQUWc+/S+qYT8Q47fpDd8TE2BtY+b07Luurgqd4610gQaA0SghoqsE
         2+3k5Z9REqefuMmjvqrrxOzIJUGptboSfaiCnyeVYtwW18ignPFEEbVkHUmytUp/0aP9
         /alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784175658; x=1784780458;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O8UKg64MkCUjGKc7lZfwbfHgFNh1cKCLNYBmGjyMvhA=;
        b=nFL0H/yL8JtfpekHZd3plKIMxSagzxjSaMmzRVueutK+wJDGu3lmVQ8lHzIQ5wrIWK
         8bkZW9isAtG6NxG6SU3p2ye/w73tWjMSaRSaxyD4w4Pm5o6nh90dRv/yR2rhtX0n4oZ6
         igZOnQ3OqmoixsgAA2lvpgjPgDD4ZGNf2UNhzSE6MVCPXLwMw71WtAwCBocNALiYoBWe
         nIUcITzANYl+e1A30G1StnMGtJvWu7gwGUXvaLwuAG640NCnY9tWttkaXq73ko5RiXoI
         U505OuY3IOYax4SFTnxOGRRqoEzpZnLaElWDwHaIthgn6No1Je+X0DQ+AN4aZlLKu5sp
         EdlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTjiOTBfeVFL62bPNE3Q8ccnLslt4IcxXtLoUQL9WBGLQ0wH7S6Vv/+vR+0MYu2OYSrey3xfHRsts5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0LuGRaQeJ+h2ScFV7Q5lHV8P7b5PZ6DkpxlUWblAivGgn0cI
	SRH8R9JnJ15AVgbIy4/1rvi1Aa4ANzunOGN4jb6x6gbSE9vxEioyuY6yANuKUhPxJG3Eg6hJUSY
	YPjFCSdvICaQx2a2EBOer4M5ObTHd+uNFqeFcLio8P1l3t1B7bRMKwJE=
X-Gm-Gg: AfdE7clwNxq8yBf3GwieD2VywaSljrPg23hPzKrJ8KqZYql5dgBCxhr1wuHE7nQKlhF
	KIPvL/BEBHiU3xAilGCf0XZ+56lxCu2sxcHfHOtCPOJh/ADz7n+4CRERmHMRzuHsibK1YtPxaTu
	9aMljkB0C/r0N80TdMzLk+z+C2wbRKcuvmRJMd0Xa22XoBKBpTSM8GwRy4zZ9I9mGX8m9vk7PuB
	a7VuvydGS2q57K0IOj8UOGvnxTqwPmnaw24a44vVgifMeBF31A80CEVIAg=
X-Received: by 2002:a17:906:398b:b0:c0b:e9c1:93a7 with SMTP id
 a640c23a62f3a-c161ea7c914mr775567166b.29.1784175657839; Wed, 15 Jul 2026
 21:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
 <20260715-ceph-mdsc-mutex-optimization-v2-2-90e81b726724@clyso.com> <4bbb0109d2d37a17c9a9bfcadf52923609115c35.camel@dubeyko.com>
In-Reply-To: <4bbb0109d2d37a17c9a9bfcadf52923609115c35.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 12:20:47 +0800
X-Gm-Features: AUfX_mzWbnsnSTuTCCdkQkhgkyMUMyCuhw8aRkong7FP2GxAmcjHG6G6KOAbv5E
Message-ID: <CAOJNxR+Yq9wPE-Wo_3ZYFTs366Hjuc=dbA_eB9bATB-nAvaVgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ceph: replace the request_tree rbtree with an
 xarray keyed by r_tid.
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 02:25, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-15 at 11:58 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > The xarray gives O(1) lookups by tid (vs O(log N) rbtree) and
> > uses internal RCU-based locking, eliminating mdsc->mutex as a
> > precondition for tree access and paving the way for lockless
> > xa_load() in the future. In practise this yields a 13x reduction
> > of handle_reply mutex hold time, from 51-416us down to 10-32us,
> > due to parse_reply_info() no longer being protected by the global
> > mutex.
> >
> > Check xa_store() for allocation failure, which would otherwise be
> > silent, and skip __do_request() in the submit path if registration
> > failed.
> >
> > On 32-bit architectures xarray silently truncates u64 keys because
> > its index type is unsigned long.  Guard the entire conversion by
> > BITS_PER_LONG==64 and fall back to the original rbtree on 32-bit
> > so there is no regression from the current code.
[......]
> > @@ -1195,7 +1197,11 @@ lookup_get_request(struct ceph_mds_client
> > *mdsc, u64 tid)
> >  {
> >       struct ceph_mds_request *req;
> >
> > +#if BITS_PER_LONG == 64
> > +     req = xa_load(&mdsc->request_tree, tid);
> > +#else
> >       req = lookup_request(&mdsc->request_tree, tid);
> > +#endif
> >       if (req)
> >               ceph_mdsc_get_request(req);
> >
> > @@ -1229,7 +1235,17 @@ static void __register_request(struct
> > ceph_mds_client *mdsc,
> >       }
> >       doutc(cl, "%p tid %lld\n", req, req->r_tid);
> >       ceph_mdsc_get_request(req);
>
> It looks like we get request before failure check. And the failure path
> returns without undoing it. I believe we have issue here.
>
Good catch. Let me fix it.

Thanks
Xiubo

> Thanks,
> Slava.
[......]
