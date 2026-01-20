Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1413254AE
	for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952029; cv=none; b=uQf8HjPwQupprVpdElVH7SB3AdEEGf8IT5fZLxNXcN8Istj94tHt3YGQ2rVGud1vUJkFGWK7FkHFyl9av3L3dbgOGMRi4xnNsxDOX0DBT5PV2QK0k8u498AjbxghigA/lEXUNUKFhNa193cX71h25KTtJ2N8oo0F2zCprFz4H30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952029; c=relaxed/simple;
	bh=EsWk2mKZbN6Ckz6hJiKhhckPpT9Wz80tzbr1yst4jkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NCkksS1U8Izkz2AaC/F9bExt2VieKv5cu9yDIVZLcYFa3HVVV9Mrts6wRJWYyiSfPg03xwV+mIw/7g1Nme0E38eBbWh+XFkuwYjF5gUiBpFGuoaML7qJVGVpnByoBpOY0O5mSQxmDWBCu78JlaSvYM4jcahnDggdK+t/BdmscUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCResqxK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uG4Sgw7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCResqxK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uG4Sgw7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768952026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDsXmcpUm6cHCoLqokCAaUaEGs7as9oep4yg59dybrs=;
	b=aCResqxKZlm+rXFmbeVYh8lzdYHO1KM6b+fBTrI9tbsLgHw43QnRQODMMp10vBkiPbiqzm
	00v1oM+9qPe54NK9qtfCNnpkWpCEf+gukyFUhGl8jQ0LJbn/ygb0txPS9JrqYNkzT7uhjK
	s5Nt9qXj1++ChpTU4O49hHGvZM05Bo0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-23CTFnWBNO2xUyLeMx8XQQ-1; Tue, 20 Jan 2026 18:33:45 -0500
X-MC-Unique: 23CTFnWBNO2xUyLeMx8XQQ-1
X-Mimecast-MFC-AGG-ID: 23CTFnWBNO2xUyLeMx8XQQ_1768952025
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79410f1a7f8so14854947b3.3
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768952025; x=1769556825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDsXmcpUm6cHCoLqokCAaUaEGs7as9oep4yg59dybrs=;
        b=uG4Sgw7wE63h7dbx8798y7srpXTaNHdXE/Yv/vMl11/kdeyIyMFGstJIVuExc2Hqce
         yWBO6CI11l6uqGQZUewM3N5W9RUEbKTmINDQaJAjADGMuGQnt3CpkIoxkZCeE1oiPLbG
         lel4lMqVWyB+QRKHhHKWSMA7BdY0i0Qisi7b6jC/heKqAJtK833QjSmFUrPgwyNQDTN/
         jVbAHWuBQSAXM/f+tB3+0CiokIor0akk1OVxWj8Riqx09eKSKBpvqjd+TyeFXHOPK1PY
         1jhe7hY202/Q9tIr/RuBgJL/BHq4ktlt7K9R3LpzZm6FEvGJ5ZhPBQbasB3Biyp7awuH
         BwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768952025; x=1769556825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDsXmcpUm6cHCoLqokCAaUaEGs7as9oep4yg59dybrs=;
        b=GnPCUNumGWh5S/tQIXWC06EtaB0SmYCzIytJ2G7LeC4k/7FapiSUC/p/zqo/hlHZuR
         8zrjvxqEH0cqB00k3HDL7QZACGsuj0RW/jsSLKzCV2gdl2X+ZQtP4maD044wspb0Jrzc
         WR0LitnM/fy7E9uHiBFhnF4z7EB6ImbETKXrCIOY5mXvVYtiAR047X7rAJ70qNQWoNX3
         mzjT+WAmibEJNqnq90B6dccbVvldHvrKLfioJXJfc1ZcQuC4KTojmP1cR2B/V4eYV3RO
         ksdjpNml24zIEOigUMfRwFD47XbN17DVQMNh531IzeF60RtzC422YmijLvccnHAlaEed
         hsxw==
X-Forwarded-Encrypted: i=1; AJvYcCU0uHT0uTTNRAXHHe9ekpL69XLVeEzvw1+OhoQk47egngxYsLNKYGE4rjeX31Em5A5z0dGMyDoUSwi7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iep8XX4lbLrjsWo7B/7wFh9mlgzWOIp6dL6GBH9h9bstj3EV
	X/X5NlGl7N8cIg86wh6D06SD1HIulbeB25wGEiYs9jP5RDRa+J1VCI3P11LBTqfzLROKW9j4roU
	4B4eKqPpGsjpILFqsElyxvBarYOdvNy+y+bSAO0SVXNIGbwHQ8rTaXCPqcVveFEg=
X-Gm-Gg: AZuq6aKQxytwghMzGesS/bgFR3zx48Mj/UXOM4edD45NDoyH6arVZsjtAOJn/lSqzeU
	EBB/HFJ+fPbJm+EnVHoXWwxxrZAD4bK1VoZWmlgA1YkKtdWrZb0j1WGGB8+5k8mkQRijK40lJ36
	ujvFxrezElPujPHbtxkuLFXRFcCC9DRwfZ63+HAs0q3ccsV/ROtL9jVUONBtNDZSxJoOhOv8Thg
	iW7Oj5DLMJNezEcVcrbnQugC5WHtA/+umeN2rufyOvmgmVWCYUFOhF9F/bMg8zEx34Fi3JSz2cQ
	EJgIzDc7ww5KVJP9U/kCil4TOElDRTT7us3goYizuBQmqI9zF1naar915jdM0f4rJXYX1E2PPWC
	Aj8nmag6ShQhpsVNuUtJeyIye1Dl7chvEz34IQZP/
X-Received: by 2002:a05:690c:6:b0:783:7143:d825 with SMTP id 00721157ae682-793c671d3eamr131648717b3.25.1768952024971;
        Tue, 20 Jan 2026 15:33:44 -0800 (PST)
X-Received: by 2002:a05:690c:6:b0:783:7143:d825 with SMTP id 00721157ae682-793c671d3eamr131648477b3.25.1768952024605;
        Tue, 20 Jan 2026 15:33:44 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794153c9a1dsm6580437b3.17.2026.01.20.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 15:33:44 -0800 (PST)
Message-ID: <ee742d795d357f2726518b15d4fb131c0f6627db.camel@redhat.com>
Subject: Re: [PATCH v5 1/3] ceph: handle InodeStat v8 versioned field in
 reply parsing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 15:33:43 -0800
In-Reply-To: <20260118182446.3514417-2-amarkuze@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
	 <20260118182446.3514417-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
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
> index 1740047aef0f..d7d8178e1f9a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -231,6 +231,26 @@ static int parse_reply_info_in(void **p, void *end,
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

Looks good!

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

