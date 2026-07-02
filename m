Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B337474E
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783034111; cv=none; b=TnWp9ew7s+hLpV09lXEbArmFOkGQcFuJY1QxxeVlgTrD891ozQq1+BHBP87a9q773I+kDsQ9tgzn1YcvZUsorS/sZ0aCqNGClLVJ0W5QvpGibMKJET9WXhFOYJo6Jr4Db7MGr4mxrk4hRvoGZciZ3AwPU1JN0ja5Jn3xmU+oNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783034111; c=relaxed/simple;
	bh=FxN9MKFE9G6S/0pUf7cU6gMyCoAGerIFtDX1GLgipPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJ28GAvgnw00+tzriq0x5FGSoZSdidVpKOB1A7v+2NQ5PROqQu7WIIaVG+anTKql+AWAOBkTBhdmrVTsnBXghv+kFbjBBp7s0ciLoQmZOVkIYDsFxXfJJwEbh4a+KtRqzcY+iiM1m0O6sHwoWFIyRIT+rZkLYdGt6h9zb9mc4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bodfKZHy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYXtj7zU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bodfKZHy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYXtj7zU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783034108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxynEdwivVSa9jNAl/NTfWuTeJyUnj54Lpwmoa0rHOs=;
	b=bodfKZHy14s/xs6K4XENA52+BIeacB4wxCDu1Qcg/1lwfNH2WGLhK03FA/Pqzk1TxZh8JI
	as1/vDDcP+23gMfOQdTmEigYuF4FQGU65KMhE5pQGjqHU1HJMYAz2UbYLZ5RlOGRSHySSo
	k8AUq2iOnBnDG5QvaXhSpfrYDhDzk6Y=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-qY_M69aDNiiwEWcVCOYkPw-1; Thu, 02 Jul 2026 19:15:07 -0400
X-MC-Unique: qY_M69aDNiiwEWcVCOYkPw-1
X-Mimecast-MFC-AGG-ID: qY_M69aDNiiwEWcVCOYkPw_1783034106
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6650f57ffa8so1756778d50.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783034106; x=1783638906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxynEdwivVSa9jNAl/NTfWuTeJyUnj54Lpwmoa0rHOs=;
        b=LYXtj7zU7cOSQfSpD7mnrgSWME9MY+tosyfsLZ1gPMud2jPRgJ4UhH+ObBdMYLnDft
         QbQ+U7Snv/G0rGvTlSjnCW51h68U7lJlGa9wXXyhu9qhiTOTB2e3cE9/oDxGJD628C2C
         LBcL865GQAwNSPc93gC22z7XalJAQuDP8TY3HdeOrBJgfXhrVn0tCp6FUAnk7RMZDmHq
         c9yHR518bJn0bTPct57VrrKO7AoyFd8EZEnURUNmhxvEAyOiUtukAI5Pak+rll6djobl
         YL7BYDEgdgoczUjIFmZOX44OMNzal9C0Hj6WQxUQjzE7BUlnki+xCsTfKmJqo+cSbzOs
         1iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783034106; x=1783638906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxynEdwivVSa9jNAl/NTfWuTeJyUnj54Lpwmoa0rHOs=;
        b=QNo3fSBA4JoYfv4FaD/EYABfN3m04uO83BMqLjgHh15R4YYNjy0l5DjLJHLN+1MHT0
         dJn2jOnl5GPDowOW+gX6945g2+JbADWwhDhLRMcLVAl1NqANQZF1b/eWNiGx8RmtQZfE
         d/JRT9UxP59mu/BhPobS4TBdtm8N205BAX361q/WS0x6V//REVYpW4Pz+x9I18RewHYf
         E4ZyjOgYZceL/bsTs/t+Y9cam5Ym+syenvw3LmGb8ZTK3/W0wNvhEPLhF6wPNhIdPm4P
         48jsKvq3T3LfqrEBQz+GC+LrkHFDbhhyi3OT7L0tHg6sMSKv08Re6AKOcPaTE6ibhqT4
         XwyA==
X-Gm-Message-State: AOJu0YwYwj6efM0nCkr+zCpfkubQjSEPyj3tMC2VCwv9GrMZq5TtgNIq
	VCdZiUY6e7Ui4gdFvWC77xPZwtHLSU8HPnMj1r39sN3FsWJq4xhTpPr9C5u6hpVRY1RqZxvBaU/
	uiSpJwM6ll3H8EjFYQ8JLjU1qwGy8jwN46UBdU38EY7YDh9qCRIaelgt8SojamP8=
X-Gm-Gg: AfdE7ckaNyiwuGXJFTY/5SAlnQbVZ8EtcY5T2YnA9xECl2aAl3PkgVatimgaUJJa5ZF
	NggbcXynrQpfDB7gQwYNP5vwfKd85mdrV3NwNlHLjXpQBxiMI5bLpXGr28r+etZvx762I3Eeznl
	APWbuI0+/NNICM1P0rnafCI04h/108/2vwHY8eOhVN/DJL3lvCb/SSObfO2SxAd0DCv9aHQCFOc
	gchg9N+JYdWnnVnxXY/yQ1UiM3yZFjyq/TfWUrc0460PHBfHjm1ShDxc8RdfmRye/PTewK3ypyq
	gxFMzTLsz71tsk6iQOVF6UccFCOm3Xjbi5URNTXNNQ++/B4yW58CiYLDbxApdIZI7YEZGxcmEg7
	WuOyqw/o8eSg6Dps34V2Xu06uEJKBuhL8PI2h100wRA==
X-Received: by 2002:a05:690e:1446:b0:666:3330:3d8f with SMTP id 956f58d0204a3-66633307353mr2166130d50.51.1783034106266;
        Thu, 02 Jul 2026 16:15:06 -0700 (PDT)
X-Received: by 2002:a05:690e:1446:b0:666:3330:3d8f with SMTP id 956f58d0204a3-66633307353mr2166106d50.51.1783034105625;
        Thu, 02 Jul 2026 16:15:05 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-666240ccb3asm1708341d50.17.2026.07.02.16.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:15:04 -0700 (PDT)
Message-ID: <d9fdb097c86a3b66d5b19f502f7b01c74a03db11.camel@redhat.com>
Subject: Re: ceph: fix denial of service issue in ceph_update_snap_trace()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Date: Thu, 02 Jul 2026 16:15:03 -0700
In-Reply-To: <20260630175050.446307-1-amarkuze@redhat.com>
References: <20260520214700.1265095-2-slava@dubeyko.com>
	 <20260630175050.446307-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-30 at 17:50 +0000, Alex Markuze wrote:
> Hi Slava,
>=20
> This looks like the right direction to me, but I have a couple of comment=
s.
>=20
> The Fixes tag seems to point at the later debug-log formatting change. Th=
e
> WARN/remount path looks like it was introduced by:
>=20
>   a68e564adcaa ("ceph: blocklist the kclient when receiving corrupted sna=
p trace")
>=20
> so I think that is the better Fixes target.
>=20
> Also, since `cl` is already in scope here, could you use
> `pr_warn_ratelimited_client()` instead of open-coding the `[client.%lld]`
> prefix? That keeps the log format consistent with the adjacent
> `pr_err_client()` and preserves the fsid in the message.

Yes, I can rework the patch. Let me spend some time on this.

Thanks,
Slava.

