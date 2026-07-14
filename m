Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EE223707
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000742; cv=pass; b=MVeOtmCaUoP/EuZLtGKP/OVEvJfLxAsIIt4xANsB2Dmf5YdpJteaER+vBi5aycHAAFzDk9y4ESZpvEhU2hXmvmbAQvDBh62y+sxM9sF1GDKE31YGrix5ulYZ0yxRO90/mm4BimHfq8hUqhQhsWkoSwRoqxD2VNmlW/yicObhhqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000742; c=relaxed/simple;
	bh=fcZrkBeof9TpXVPQEyvtcMEm4cRLNYMqYdOmuCcMd0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l13Ar9dFfjGSyoNDFdjSfq/RdKrDI66rJEl/qUwnY4FMOGXfpfnf9M9L6I7J6CeysHir2GxuD0GLwXnxoFpT/lLK7jFxxcb7lobzwvj1JIrUKbkZSC22+cjKtt2uajepGKPn0msABQ5IJPeZF4Dm9gmWA0nTPeZmdm9l2fq7JCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=A8LeGzK7; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="A8LeGzK7"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c165a41a52bso110787866b.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 20:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784000738; cv=none;
        d=google.com; s=arc-20260327;
        b=ZK28YZGcUsO/kocVhiKjBimToHURHgn1La51vEsZ9AUob/qFxbPRFXVMVRbQOm/uYp
         5jUZJ3+KwfrTjw/45v8YQIZGs6BG+db0PJU16SzNiBbj/UyQh5q93wYaivrCvO02cnzV
         LrJYx8ajOACiG7vqz0SSqJw05IW6HbZkdIc0Po+wQKEkOgfQ8xeyHqG1+zcLt+RlLVvb
         7Yc0R8ymml8Cc2lIcTfXaUkjP/bW7wpAbSK0FFg4N8EBRvL3/ELKk48ab7rNYM2NZ/Qs
         SURIMV5vgF6v/gGXHJEaJfKxJspsS9zNqHXUyDc5YZBN422+a5HtbSxzfvuOtb/jATTl
         C2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P2wJalT5NoWAaDPg81hyWRcv08HRVj1DzDRyhb4A7zU=;
        fh=QakNoIeExC3YD1Mwx7BqTBiwNoySi6Sh1/4FibovBYw=;
        b=jyKZ53SR4Sy32k+K9ejLv1DVbq0BzoEjYVpCox5K3B6hDSbeALtUaffWvpUbifZEeQ
         wq9aH//uFNegXwn6+kW2rptqytcC9twutxs9Yky1JT8qsNI/m2auswFJqUMOl7rDexXp
         4kUsOMouF0F7D8AlIxYyI/Fe99QpQ/BvJRNpXXCJf4mXto7OgZHNvoKk15YsFk3VrsSL
         R5D42523E7yZAaSl1jRqiUs/o+2VJZXQP3khFpP6ddHWJPtKVk3fEHKEsaSs1pjna4Tj
         nWb2KWd85ZMmnH+ayE9nJgB8HLk7JXnRXVldW1Fsz7fC52aR+3GlMZmk07r6HSGwDtdl
         GOSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784000738; x=1784605538; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2wJalT5NoWAaDPg81hyWRcv08HRVj1DzDRyhb4A7zU=;
        b=A8LeGzK7iHqp+a3+d6v9OkVbPZfq02vFQL38B70afmx7yZVxxetT2Ggppagr6YzhvO
         UrrH/jijuGU/puPw82jRktQ3f9f2EhM5lgtz0HDG6NgDB0W5gpK2jPBYFTIQ5XgUYVa2
         VyWIpq1Kep/2841y/jtz3WvKymif6yB7VvgObh/HlBmG5XDMY1Dl6DjkVUcB2RsAT6Jd
         kUi6OrAAITq3d5L4pu5TJLyLudX9wBuLvh28OY0yPtFQCrlkCjs64aigTUibgmFCN5Gc
         XSEieJaROw0uCj3+j5XwOWNVzKmpEzDWMuN2xZbILXTOPYl8ySD0/Qf5rcG5MNZlHUAe
         LIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000738; x=1784605538;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P2wJalT5NoWAaDPg81hyWRcv08HRVj1DzDRyhb4A7zU=;
        b=RfkMlJh4KzkCk2xEHQJWYvejkr1c/z6wlvTPvYtuRwAclPi6pDFIHuDMuY4VVeE7NU
         +ZDcfcfbQ3lYEYIgLYHFQlG38zdMjnQFv4bzCTNJI2/C80tnTu/nh/7gD4eMF4b7Jru7
         JPqICTvdlYgQGYK45eBuqPK+xNGxfz7w87YEy2MpbAPJc0ZoK+RIcOzsd7Wj9mcucRxe
         PqsbEn6TAFyvQv6t52EQI248iGUtWU2z5XVmar9cMvYIQLHNasD6T/WcLwTMSswRLhuL
         HPywoI/NVjhmb2DugiFrIksEOmvA9yZhMW7uPbpvp5eUMI+kBuxWfTtrZQryeAFITZtF
         XuaA==
X-Gm-Message-State: AOJu0YzFKOnsJulcBSr61hNvicGZPONVjPmy+PzuQlv8HeD/ks9KUFYx
	yw8yJP1XCAsavHO+7T8FXEb1/KcddCKz87S7kNiNOoPVMjypjh1x8wD/qblINUrM4r5AorylZj6
	JnY880zY9vzYkFv3PvAoYG1kEHgMFpxx9uY4s2ypVWg==
X-Gm-Gg: AfdE7clK2dWlRAy1kvBBAXwSa1ivSi4Yn4I2jDBQszU9A9K/ekBMN2eXtWnsKybXkQp
	lOz3CxLcdyvIjfdm3kQEZ4s0YRtZ8sIiXieSM1yhm/3mQfjaSJTzmnR40GfxBYJYVcZb5nwdK0h
	XVUEvpru5yY/iifGN0hIOhY82bCu0SJD6M7QMVlEOyM22YpqhJSnFDXZ5iMMe1RryM81duqfXh7
	z7rRU4dGwW+CUsBdnq6qhBxlpYkmSwlj/gH8L1r8swTRkcPQozfuhFsljRecHMQLWz58A==
X-Received: by 2002:a17:907:9721:b0:c15:bd3c:5bda with SMTP id
 a640c23a62f3a-c16678c8f3amr21753566b.13.1784000738548; Mon, 13 Jul 2026
 20:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143843.1980879-1-amarkuze@redhat.com> <20260706143843.1980879-3-amarkuze@redhat.com>
In-Reply-To: <20260706143843.1980879-3-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 14 Jul 2026 11:45:26 +0800
X-Gm-Features: AUfX_mxJZNLghQmHjTJl0j-xnCCZuP_0KaRaoE3IEz75t2GcK2KvVGJ75twmGVw
Message-ID: <CAOJNxRKg+PKtX=WKUDyQ1E+E+Sk9LtGcpLQOWfVzuSZDiRu5tw@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] ceph: add BLOG deserialization support
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 22:38, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Add blog_des.c implementing the binary record deserialization engine
> used by the debugfs read paths.  Supports %d, %i, %u, %o, %x, %X,
> %s, %p, %c, and length modifiers (l, ll, h, hh, z).
>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/blog_des.c | 332 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 332 insertions(+)
>  create mode 100644 fs/ceph/blog_des.c
>
> diff --git a/fs/ceph/blog_des.c b/fs/ceph/blog_des.c
> new file mode 100644
> index 000000000000..e84ca3fa156c
> --- /dev/null
> +++ b/fs/ceph/blog_des.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Binary Logging Deserialization
> + */
> +

[......]

> +               case 'p': {
> +                       void *ptr;
> +
> +                       if (buf_ptr + sizeof(void *) > buf_end)
> +                               return -EBADMSG;
> +
> +                       ptr = (void *)(unsigned long)get_unaligned((unsigned long *)buf_ptr);
> +                       buf_ptr += sizeof(void *);
> +
> +                       /*
> +                        * Skip kernel %p sub-specifiers (U, I, d, D, etc.).
> +                        * bout/boutc do not support %p extensions; call sites
> +                        * must pre-format them with snprintf and pass %s.
> +                        */
> +                       while (fmt_ptr[1] && isalpha(fmt_ptr[1]))

s/isalpha()/isalnum()/ ?

Because %p can also include numbers, likes:

sprintf(tbuf, "%pI4", n->key);  <<== For IPv4 address

> +                               fmt_ptr++;
> +
> +                       ret = snprintf(out_ptr, remaining, "%p", ptr);
[......]
