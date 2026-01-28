Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3132E15F
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620548; cv=pass; b=gcAFnRK1BSaAgSQFLoz3utpLCqCIlRvXnow+jKKZHDaw3tOfu1iGR7/aYrl8PxDxyasSlLRNbG1xq0qsNtGbNaXVXgUMxrOh+F2ULA1MeGV3D5OlQ2BcMIEo4PrpZh0Odcz9Ha1pYvqF0Odw6k1o48LXR+MGna53kcZ/yyLzm6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620548; c=relaxed/simple;
	bh=ozzCNthC9ZT9opoN0bPVJ8O6Pkhz3Qxn/xVikU9Uqyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj1J4AWUm5e5js7/tE9E5Ih5Bisa9L0lMBJSiTYwY9mDgmfcdYlMoK7vy0DExT+Dvs22C0aD25WaMcDBc2YSb9+gCEBd1KsrUuJj8FWksIQDlqwaAYeGqtEW5RewkTuN6fk0uv1FzzoI8SJ+a/7gv8E6bYR8fm+H+iMkaKHYit4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SD5BuJZ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCErpRI/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD5BuJZ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCErpRI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769620545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
	b=SD5BuJZ6nHEPK1vszPCE/y5RnlcXtZVOi96CY7P26cnew96PLimrnLdRRa6swq/t3jBuh7
	wdNNBPE7u2SEbE/wMlPXR/BqQQ+GNwu3n2b0r2Q6lleYCO28mYXZUMKz6dPfJJg2TYRN1m
	/mBUYKuEuJOXkR8fcjZssg9N2oF+Pz0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-lTfCNyLRN6CaRr_OwkIedg-1; Wed, 28 Jan 2026 12:15:44 -0500
X-MC-Unique: lTfCNyLRN6CaRr_OwkIedg-1
X-Mimecast-MFC-AGG-ID: lTfCNyLRN6CaRr_OwkIedg_1769620544
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502a35b12ceso621801cf.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 09:15:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620543; cv=none;
        d=google.com; s=arc-20240605;
        b=HBeJgPyqehthQEsBCVTn8/Rt7Uszc1NhV4GQD7ssdWwr+iZJ7LHKUDuIQDJj4EjdtM
         oFLRDRMb4yLG+wt8rsj+1qR/riNhzomPcS65fW7wZdXE+WBUUzm4HQ0kb5UBHEuQJ/cj
         Xe/wgAUplLeORdAe0An//lfY9Zt0BMmx3c03PVTmVKd5ckEB/92U/NHBmKvzcEpifvQ/
         UCOrY3d3aTNXKZOv7fBHKMGT7vC/f2rV4VGdfGVmIHWv9EczMsRb4VVMNvYyckvokffh
         IER8Jh+K4WG3i9MqsWUJpWB1sI1aaZaFySRUmxWOO7iU8yvCqmFNGmRoqbR+I/b/AxEJ
         ZyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
        fh=WpF2KSegHckOCI2UgRx0P49iPAD21XIk96wc2PG0rXo=;
        b=ayhQ6leUbeyZSH+kqkYEfwCp8GmRXkowrYa/DIUKfQWcezkHkQ1Ne4+4Vgo95zYhWK
         RJichSw4JFdvDEemJ4VyW9h3GNZ56VT1YWispoM1UvQYW3F3Vqp8q1sbryVlk097gyHE
         ng8m6k3Hhw2hsIMJpVLHVgz6kF7dN78ftTNOvIO1KqlKCMWegD/5SS0jRUsAgCF9RRRl
         NI87yhuhPg5RNgmhUpSG5X99kKKsSXrfg3i81hePbuIITuudc/6B7kAQCBSG/PgkIlUB
         Jlu3LN7yQYWIYbHed2stpHJe+3prtyEK4xP2/tWqX1OyYsM9mWb0r+HHybjoZp+iPP4n
         3BvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769620543; x=1770225343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
        b=iCErpRI/HR9hKrmrm5wExZkwHRpx3CN1IARPpHmuCM18qsmyQNWKdyU/LoIdmecINx
         ioHKJKgSba0ZDHe0FPf95kj4o20flv4O1Al1R9zFCqarEoAymFAJWsTtSltHzJvPIAN3
         FZeTM41f8GuQQ9y3C3Bt9QKyaAWAPXiQOAXqTdoBNSJP3TqIEuTps+QN6iJGWazqucNG
         ayk3ANQS6kXDE8FPdkM3wat4O0iCKA2IYEFI73Kwq1T7J6I+swbAgm/pM7F6a3O2qRtt
         4RvczvUJtFepkZLd4y4uGTOcItoQxbylcLY5AtaqbhxCYpPd23espFK0HL17XmwhYfBj
         00QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620543; x=1770225343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAqniIgPFIzJFrM2PeTRXeg9D8CzK5RsdNaDEumqRgM=;
        b=sra3FwOJK/J1gA8gGBAkIVCEkpKwti4gBPcQOmmagptTV+uq0ORAn3gIXXqSKZUxxk
         +DZXGZWf2rLD1JpmJvBcSq9ZZe90DV0AG5+WfAjnSG7Qk9DTfinTpJ/NTagf42WczT88
         KSNu/bLC3Y2rDhs+3Q3ArEjRT1ge47Ih8UqhsJ9jRkkG0CFkCoK99GnHrR5GyikV41nI
         6ZSDcVIUkUZlO5zCAo7K225ZOyVXs9XVGB9q5EmM5mKUHfikHYuMLR4q5bMnnfuS88uv
         M+eKaBiuBYbVXMVpkRmREe4RklsWp3d14i2222Shd8d+eR9Y1U9gjiUyipuFub+GJt4I
         QEnA==
X-Forwarded-Encrypted: i=1; AJvYcCUxgRRjJxazxXWysIvTvNpLfNjP0vT/n+09q482iSnTjM0AWkQB3bo664rmw4gUqLdKXGer0pQNknly@vger.kernel.org
X-Gm-Message-State: AOJu0YykMpe/pAB0sfuOBPXpDN5hnZwC1Si8v2O9QgE8gxNbVqCBNWAc
	JrT4o9qSdpRt5M5f0X+Qx4hs4BNOuGH0CdxHZBz8crGqMjxh8oC1TWkRUHWqkwH645+eldcSQ1E
	LDX238oS+qW+GY3tagZGthXvqMULUdajT22xXLamOywSno9412m3Vx+p1NNuAZ9Yr6B5Q3WmgTw
	WYEeDJxRFQ2WG5IMFfgXduiffUQcIxY9MOaQYEtjzACA4bkA==
X-Gm-Gg: AZuq6aJGx0i744ql0O2bvUYafGDlXn3EfleYQnxn4xFI0mriGWcQdSvXmR5DLxV3EVu
	7VymEo/9yPRIkuuh8lpDAwRknoUTML3oiY8HmvEpqB0iFJcaTyfXFmAft4LqkNjRItbRB9na7XE
	+KGljZkKgLGe6fYcm2nFFmRR0L9c52l5CBjmnOqLpVmr6WKH35yejJXcRXaWYZQh3JCstNbEC7x
	UZMXkYgCbfx37u9NdXCzGiOYw==
X-Received: by 2002:a05:622a:14b:b0:4f1:dddb:db6c with SMTP id d75a77b69052e-5032f76fc40mr72501381cf.17.1769620543604;
        Wed, 28 Jan 2026 09:15:43 -0800 (PST)
X-Received: by 2002:a05:622a:14b:b0:4f1:dddb:db6c with SMTP id
 d75a77b69052e-5032f76fc40mr72500821cf.17.1769620543126; Wed, 28 Jan 2026
 09:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
In-Reply-To: <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 12:15:16 -0500
X-Gm-Features: AZwV_Qh1D9HTxJTZ2ETbSTxP8Wo-ChUJ-aostCjWfCpYhDfIOBZuVWfVdl4_WW0
Message-ID: <CA+2bHPa+NK1eBo56ryJ-_4=FK-xRRcbyGsEUOE09wb6U8muVRQ@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 7:36=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Hi Slava,
>
> How was this tested?  In particular, do you have a test case covering
> an MDS auth cap that specifies a particular fs_name (i.e. one where
> auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
>
> I'm asking because it looks like ceph_namespace_match() would always
> declare a mismatch in that scenario due to the fact that NAME_MAX is
> passed for target_len and
>
>     if (strlen(pattern) !=3D target_len)
>             return false;
>
> condition inside of ceph_namespace_match().

Yes, passing NAME_MAX looks like a bug. Is this parameter even useful?
Why not just rely on string comparisons without any length
restrictions?

>This in turn means that
> ceph_mds_check_access() would disregard the respective cap and might
> allow access where it's supposed to be denied.

From what I can tell, it will always consider the cap invalid for the
fsname. So it's the reverse?


--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

