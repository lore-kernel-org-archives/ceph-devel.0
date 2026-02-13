Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0F2E401
	for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009239; cv=none; b=Jczqz3OHqACZwQefA0OTW0nzLCsxnwPMrr1vxn9I/f2/iNjzCUybdh5pf4nx70xqfcjZu84udcl7Tv2oVJSqzDGnEWYp/QPfAX3hO27cCRtTzqb+fpLL2v9Hvk2vgU+3pUJBY8RhcvNd6sRU/TswHntHWxJYw1/XsgWSqoXgjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009239; c=relaxed/simple;
	bh=ONBwyQn5va1xbAtHtgoC5yGtb+S3ojsM6kXRDLgQ1Ek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNvXipS9001wtSseR9WFtZIJF2lPppvS2hScWoQP+XeCNxtM7SLOM9i4dayNOdpGK1ZsE2oS9+ZxHWQMqpnWwI3ZelVEhPU9BzsRzW5VsyO+vtM+lUUQzO+iHKQllq8A9Eb1BjcMPGHpVbHUt+TWbNZGt476wTFy2Tgt34rWB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LToKbEbi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSmi0Qyf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LToKbEbi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSmi0Qyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771009237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7fDH2pAmkBoWhhlSNG0knE2qMaQGN7FqBQLjXzJEJI=;
	b=LToKbEbiBAnQ91MpJrfJfvSywhtYg4KZj3oZj3Zt1kxdJmu9RPwvpYmiKStOR2fqgGfUTy
	Tc5ZaxtivoyiooJcG+NsN9rpRTwAtBAbjJmwou7Vq2Rj5DoacDBUPjR7XWj6HlIKAY38oa
	kcmFumidUVHLcNWir8tsgkIY3SLTApI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-gf2nbSIeMVeVHJ7yUEQmGg-1; Fri, 13 Feb 2026 14:00:35 -0500
X-MC-Unique: gf2nbSIeMVeVHJ7yUEQmGg-1
X-Mimecast-MFC-AGG-ID: gf2nbSIeMVeVHJ7yUEQmGg_1771009235
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-790656ac3faso23247997b3.1
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2026 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771009235; x=1771614035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7fDH2pAmkBoWhhlSNG0knE2qMaQGN7FqBQLjXzJEJI=;
        b=JSmi0QyfLOq5vQp6i1Bfw7XWB+yulJWwA4R9K9eEmRvwlGxelKTpjQruzoGz20Hs6H
         QqXqA7p2B0L/0uWC8L2IghutGiA2DDhgidRUB+Srj4Zq2INOP5Oo/ZsATQGtg+5ZlE4u
         dBgpAx4/18vimyjv2zDHrHg6twT32S60j51uT5ZN/aWPXCWnFAV7aBGiWRMhKXFqqk9h
         z3ew36gxPhZVgRrZnQbFK0vj4RCMcHHQiu21iwGtIiyxujr0e1JpRlSDl5FtH7SgwFvQ
         8BmNBCjKbJvK7bVVhzzC74xE3SpMX1NGx8XRs6dpq+WA1hfzUx8nvArq6vSpYrPNHjfX
         PiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009235; x=1771614035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7fDH2pAmkBoWhhlSNG0knE2qMaQGN7FqBQLjXzJEJI=;
        b=uawjMIYOan3oKtu1O20rfIpsX35sszlO6lDi+OgNxtiXjBjETAQed0PPSB3M79c9iP
         SEOrv6kWcEHncp1aY33SmU8zIKU+gywH2QjBebWixb58Lc8VLSgS1zLmgDI97GNAaxm3
         cYZnzuejqkCIXcqIgLiOi1lBvWGuOXsUh8WuIUyK3uyI3bGHo889KLpZlkjJcj7tIUGh
         y9vWYaKrfR9muj3/ZkXWcmx5rwAvI0zrnR2E1ScZSTsgZJi6U49UUk3C+HPhYFB+rOwf
         VVUXlLy9VRLTYoWH4Z+SOdTA4KCIopalQOB9Zx51PzRuksd7v/OJu3wdkeGn6Y4GxZdb
         n24A==
X-Forwarded-Encrypted: i=1; AJvYcCWOBX3bxDKS2KeAyjK3V5rRJ1Y6vgrh8NQXiSTXi1P2+GU5l8W+t/hsoZjVMEz2iZf6hGSjexz5NM+e@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWEVFs2chpZ61kqv0j94c2WeKeQx1DcazXNRbE7gpGQJDRKas
	yXzAScvGNFHWSYKJEDWViCbaTjiGvPiJwxUXhrEc5P4Ri9Q2PftBpOKNlf3Ccd/mq8J74oNwQK7
	CZXbDBzvW34MtXyHPq7Dl2lHRo1jnnis4hzU1uMKJ3OVZc2OOT71xbtCVV1g8C1o=
X-Gm-Gg: AZuq6aLRV8RCdTXTGahLr2pHOPQeKz/gWBuzuEunMz/3+Jvx8odMfXOzGrCTs3pOmwT
	PvAKcW5/jUMvYHe7co9k7rj3nsQnNPrSYO8GOcTgi8hyV+MKJmJaQlkTdt4Z8QrO9q2p1KH/ZUB
	IVhtRNqvCVQu8e+vMa/jcPu9fTMtXFfIAexy1FqBrWcdU0ftP6sgt5SvZGEqphuXrrw6EIXSxFN
	cd5C0KivczoIb5FPj23RWCxS2iQ1RDA9U0Svl4AxA8Jdi9rSFBCQeE4gR4uxzu0hLNNg44NOew3
	r2CBTTYl4A5AVXfSRm7EIv66lOukTjUAdqCqygabP7Rn0SMnflssSMjCZIzeSaG2JDyfmw193MJ
	UOhMPlznqRX0+BSJJvttyDznw11NgUedBP6PtACyI0gQsgWV/j88x
X-Received: by 2002:a05:690e:d83:b0:64a:ced2:2752 with SMTP id 956f58d0204a3-64c197a3e71mr2252253d50.20.1771009235321;
        Fri, 13 Feb 2026 11:00:35 -0800 (PST)
X-Received: by 2002:a05:690e:d83:b0:64a:ced2:2752 with SMTP id 956f58d0204a3-64c197a3e71mr2252206d50.20.1771009234655;
        Fri, 13 Feb 2026 11:00:34 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc95c8bfsm7692053d50.14.2026.02.13.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:00:33 -0800 (PST)
Message-ID: <ac9de2ac9ae274484c4010b39fc6365957d6ae10.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v6 1/3] ceph: handle InodeStat v8 versioned
 field in reply parsing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Fri, 13 Feb 2026 11:00:31 -0800
In-Reply-To: <20260210090626.1835644-2-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
	 <20260210090626.1835644-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-10 at 09:06 +0000, Alex Markuze wrote:
> Add forward-compatible handling for the new versioned field introduced
> in InodeStat v8. This patch only skips the field without using it,
> preparing for future protocol extensions.
>=20
> The v8 encoding adds a versioned sub-structure that needs to be properly
> decoded and skipped to maintain compatibility with newer MDS versions.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/mds_client.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index c45bd19d4b1c..045e06a1647d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -232,6 +232,26 @@ static int parse_reply_info_in(void **p, void *end,
>  						      info->fscrypt_file_len, bad);
>  			}
>  		}
> +
> +		/*
> +		 * InodeStat encoding versions:
> +		 *   v1-v7: various fields added over time
> +		 *   v8: added optmetadata (versioned sub-structure containing
> +		 *       optional inode metadata like charmap for case-insensitive
> +		 *       filesystems). The kernel client doesn't support
> +		 *       case-insensitive lookups, so we skip this field.
> +		 *   v9: added subvolume_id (parsed below)
> +		 */
> +		if (struct_v >=3D 8) {
> +			u32 v8_struct_len;
> +
> +			/* skip optmetadata versioned sub-structure */
> +			ceph_decode_skip_8(p, end, bad);  /* struct_v */
> +			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
> +			ceph_decode_32_safe(p, end, v8_struct_len, bad);
> +			ceph_decode_skip_n(p, end, v8_struct_len, bad);
> +		}
> +
>  		*p =3D end;
>  	} else {
>  		/* legacy (unversioned) struct */

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

