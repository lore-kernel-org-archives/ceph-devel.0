Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AF30EF68
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2026 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102336; cv=none; b=k7fuWbmi0hJRg6JhSIuRBFM/Dvhthx1fh7m23FEsDFXDS0VOACwqweX5k/GsrK99R3jii5fxNbuJFxLHm1kau1y+Pbn8Y+tQRmDleslvRST4iK4u3wrPfSUZiHvi4w1rMglXBq5CKFVgoI3XZtGYV6MB+F+3uWz18OtNDsLwz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102336; c=relaxed/simple;
	bh=1u1NtmsaEYLuVMoVkP/uqgb7UJCHlWmjT/NLBXYDpbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYhU3bsnRPzflfLEWa9ncIkXHZ2fv7Wwq9pKv8MhDEBjoPc3mePGzzzSeuu9TD5ebeC+LRgjG/BCRO68EQfOaW90+q28+P5OjNSlW1U7C4mj6FS6rady0Y4T40gptTcT/txv8kEJ0R2mdHBXn+JR+Sg+o6t4LzNEmd7UI2lOxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXgArCPj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mM4sLfLb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXgArCPj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mM4sLfLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778102334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xacDOFOjQ9ekVgvkJiHHg7tg2db02oJhTxqXK6zBRi0=;
	b=YXgArCPjJD3E3dpIjfrOuTaJYzGfSIjfBMAZg95zsNL/5EGJBkY70OJTH3nYXU4a+qf2tT
	1E45fdirKtf9T30fM1kvvU9ZK572JXSbY61woa9r8QNGMS4kLS1FeJRHDdGBBw1bcAIq7S
	Fd1uY++7Ap8N76n0bwBWlr1T4NEpZHM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-5mgZPcmnOU24U7A2fpPylA-1; Wed, 06 May 2026 17:18:53 -0400
X-MC-Unique: 5mgZPcmnOU24U7A2fpPylA-1
X-Mimecast-MFC-AGG-ID: 5mgZPcmnOU24U7A2fpPylA_1778102333
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-651c15e69d7so268808d50.0
        for <ceph-devel@vger.kernel.org>; Wed, 06 May 2026 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778102332; x=1778707132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xacDOFOjQ9ekVgvkJiHHg7tg2db02oJhTxqXK6zBRi0=;
        b=mM4sLfLbvP6R73bHaYzHd9lT6aYyFEte0/YlGrpkv44Dl1iIFg+j66EAfDJyJqIFe0
         pljD24qXULpyW4R+y6iudww7EcaPZo9h8/f1HzDJu6dx0orDuDfI4bLOtwLlwil0Fqh3
         P+C5onl08pDXcGO3TUUC3qcB9N0qEzA0DdkSv5AItsZIWd88fHrLmqO6MRKb6HC+eyUE
         QH2Tqhi56K9nFeRjsa+Lms9+dYq2LtkBJRVbXahLH8mhebSZ60/g9A5mv5zYA9sNQJd8
         RdqfZhVJ0ByGCIrvELy8pSD869o318P14NZOOeQJWdoYpaEmlMJLM/Lt5Xwk4FvT9zOt
         RTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102332; x=1778707132;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xacDOFOjQ9ekVgvkJiHHg7tg2db02oJhTxqXK6zBRi0=;
        b=GZr0wGz7WBGSlGlEtYxvJdRsjJJ8VXTMonFyHygkmzkCqQ5Pc/TLQ1NBHPhhkBCaQN
         TgFePGDHetScgzvXn+BMG9ZP9xjsB7tfBVa/JAfyKEosFdbV+WBzQ80HWbVCJgGHbKQp
         8R/YDMqbH1j8IQoRcv4DlpvcTZWX4L7pzSe4PcXbGHX0wxv8DYddM81IF0eNQoLUplRf
         zoF1KSq74DK1d7clTNbEfthl3Mo40PfyXmDGin+fkpS4nbW3NTrVhXPxOSTAzJ94LSHi
         lVRMzgp0zwLjrDdH2RMpEEdtpN/3aFXaqzE7V7WjsUQgw+X1gWUxfmM5vRObUZa24YwC
         SG9w==
X-Gm-Message-State: AOJu0YzBqMpNsFiSB4jyzrsGNrS3oEPeMOj2mQ3HLTr31Av5FHOiKJnp
	Iph2+UgtxqZ+aGtctpJoDcp8tXmOxLCuwSaVOuERF21fP2EFtN+OwaXwbSrJm6tSNJEWovCzkft
	Xj09Rld9bRpqbMJ1IU7NqFlZVduYUY1BeGvFxGGCony13BlvJ5Mcuc2THifnYRCmZZ0YjjyM=
X-Gm-Gg: AeBDietovtSjLgjFzXrJQuxXKgqCdNFIy0mmJEbK+6Pz7IFcbExLqJqU/CQTOofkvkZ
	JfmZ1Z1T3yiCDzhGI/qh/MXBbeNP5v1dq5oXcY/BUQuKcZsjk8Q2Oex1dy6ECkFKUQFtkdRSjvJ
	KkLTvzdRrT17UlFI28Qw9MKeIizkYuTlodZk3w6p4sV182tNWyXKdkPYWoTpSuigzWXcvsBrDKb
	W59pX6drQVJrIau9FBZEOKlepezT0LCHsTBYILrUXQFO9rimKgcG1wNJhK9+k/sIlkhW8enKqE2
	qCIsiGdGOmkOwvVt1ECv303u1uR1myzP05vFUQxct18k93qNkx+7kzNAoycbjczdBud3Pkcmx93
	bBZ2BQ5WrdqKUbJgO98E3ot2ynptFn9+A5q1Qeb4BoUuJ3F7GrWVekJjiQLuAi9A=
X-Received: by 2002:a05:690e:4416:10b0:658:9bfb:602d with SMTP id 956f58d0204a3-65c79d976b3mr4416929d50.38.1778102331993;
        Wed, 06 May 2026 14:18:51 -0700 (PDT)
X-Received: by 2002:a05:690e:4416:10b0:658:9bfb:602d with SMTP id 956f58d0204a3-65c79d976b3mr4416912d50.38.1778102331410;
        Wed, 06 May 2026 14:18:51 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7abf5e11sm1645545d50.0.2026.05.06.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:18:50 -0700 (PDT)
Message-ID: <9638f0d7f5ca4f8afd1b366cfbe0ebec3149aa9c.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 04/11] ceph: add diagnostic timeout loop
 to wait_caps_flush()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	idryomov@gmail.com
Date: Wed, 06 May 2026 14:18:50 -0700
In-Reply-To: <CAO8a2Siu0ukTOap9v19aotjm0fS_=KETttp=W49oh=5-MdzzVw@mail.gmail.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-5-amarkuze@redhat.com>
	 <fbab16663ba7c8b0a1970de7301ae85ea8cb0ca4.camel@redhat.com>
	 <CAO8a2Siu0ukTOap9v19aotjm0fS_=KETttp=W49oh=5-MdzzVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 14:34 +0300, Alex Markuze wrote:
>   Hi Slava,
>=20
>   Integer type for loop counter i
>=20
>   The counter i tracks the number of 60-second timeout iterations. To
> overflow an int it would need roughly 4,000 years of continuous
> waiting. In practice, after CEPH_CAP_FLUSH_MAX_DUMP_COUNT (5)
>   iterations the diagnostics are suppressed and the counter just ticks
> silently; nothing indexes on its value after that point.
>=20
>   I could change it to unsigned int for cleanliness, but it wouldn't
> change behavior. Would you prefer that, or do you have a different
> concern about the counter?
>=20

It is not critical remark. If you believe that we can survive with integer =
type,
then I am OK with it.

Thanks,
Slava.

