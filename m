Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA043AD526
	for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086468; cv=none; b=Hoqreb95OJuo+DkeBWzpzgUKrfNj4l2xRdLljegX9OXypT/D5nvGRIB0F4cO4zIQ1RKR8jKhKqUWYcoXxGs3vXC3sH0gOHw8556J0zodjMMI8bjljp2jm5JSMpDeC1rDSdyyoVGIF5XU1dlc8RHs6drXObBz5O10/Eor8LXtRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086468; c=relaxed/simple;
	bh=YL769Dp4EJvQcoijd2QNl8MO6JjlivXP4fyd2fErQQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhSEduFrItl1ZhRZDnnSBJCETRi3+w8dQrmgkQlW0AlSgXfgLdSKviU1PpUpHPNApkprJCsrErxGM2EItQBZM26Q+FG8vN4ivrfiTMuCIUFhDvdelOKnLfn/W0wBLAX8Z4bmwsYh1iWnIb5tlNNoWsMJi1cvdy8zyFQXzf2CZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcXQO3wb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbAyPQxB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcXQO3wb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbAyPQxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780086465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gcc44Gkor0z/Bk/Pi/IAB+Tei7N2SYV31tTxy8zFSs=;
	b=BcXQO3wb8wIQIWdGJuGOaGfsrjhV+EKKmTxL3QwSHAUw12LyTg9Cby933sHFOeunUjbG1a
	EmNaBL9WlONZqAaq8rMxbWX69MTYb+/kuGtpYeyePkWOX5xgc+AyIf60Nd2Mj/6cnMcoXQ
	YXEQi8R1WHM8dOGw530jwlJDOoXXVKQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-isorN87LP4C_BohspEKWMA-1; Fri, 29 May 2026 16:27:42 -0400
X-MC-Unique: isorN87LP4C_BohspEKWMA-1
X-Mimecast-MFC-AGG-ID: isorN87LP4C_BohspEKWMA_1780086461
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69d6b83becaso10754148eaf.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780086461; x=1780691261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Gcc44Gkor0z/Bk/Pi/IAB+Tei7N2SYV31tTxy8zFSs=;
        b=cbAyPQxBSsiZK4lJfrvMppPP1tJcC2ACs5+P8jXiMeW0+wlW/OkG02lZ+prUMIoqlD
         PCL40H3LGV4WBqQISD4ok4Lh6skhNHNxccu6HRleemlE7gjzNcZ+yiSHROGGGumULnQS
         fuTcHCIyNl5SySna8xkCUKS+deSgfshPOimmASPX9eeNNT1mZskKoE1UM5VLAnM6A7J4
         V5gE2cD74jUUkSOLaKTx9gmS3kJYoNUlbwQWIZYTowJTBuhwMakLvYjPZdylQC1PsOSN
         cgbKyFQIxgCuYBwHtbSfD3oax4opE5hEv9fWQw2VRJByoSscS0P3ewHLVeuucpbXQeM6
         pAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086461; x=1780691261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gcc44Gkor0z/Bk/Pi/IAB+Tei7N2SYV31tTxy8zFSs=;
        b=GXktFip4xIYDORb632QghMgyER2v9k6SwO2OhMIkbCmRDHM4dUX3JkbvCl63P5P964
         3FNpYcl/bq2zUy3WZKJqdYl/upHTMsrf4GxZ6nHOiHzN/Gpn9DCQ344cPmbYY873LrIR
         744vfButcYwFRCtzVmii6fk88CXRGk5jjjIoJWueQT9s2UK2VNze+Webr3YKHHAf7QNs
         z8a8dcAEhtKahn0sZhchfrxfEAssbV3GQURjiEQKQVeDCfn5G7OU0XSID7Fmrkyqny05
         63Cja8LBYITrwNku1NGVmkYgBUJtR6xTykBS2rIRj3zkKyrJu8XMgMWSo82xAMVUkDLM
         IjSw==
X-Gm-Message-State: AOJu0YyZEhOqt3ourr7k8L8YQ6/GLJJhs7M4QqZYxtvwit03TclQ3C4T
	FXET6nyev/B50AJ4M4naY6hKWwPEU4kWmchoHxzly6q8Pophe3xr25sVBfFVAHjqq9zNZQEW/ha
	PoclgSsaMfpiZ5c+5ilDROCOZy1+itmVmIjEPuf2//hEGVT4IPxgXrBBlmVYd9h4=
X-Gm-Gg: Acq92OF4Wd/UVivlM4i7YbuiVJV2oT7kQCrqsGdZvpJjZJb5IxxTHeZ8sQcjfnGQplC
	nsoTEdbPaZJP6VuV1pQ0Afc0giOaIz6mDsmrS3/A64q9wr2cINS2GErjyYJckWsWbEdDqQTE9oG
	+jcIn+eoXtCVXLLOW7RL7B6uhkWjT+bsSuu5UsUqenoal+Y5q/Sq85RezwyYGi9WWa7s1nVeBf3
	K8T3P/KU5GhtLJpTFiXhTDKncVD5b+iFaP1y+1qaLBVWU2eeEqRx890jWXDWo16DQpp74gaUdJM
	rgutxm+CQ76XHIVhGMf34+A22Grt2HpFqQCggj6pMIt+kt2J735WxIUI77JE23BpgwqwxIf0bOD
	y4UvNIej3mlnHRpmjPqMJ90jlIez5YIyrTPk+i/YppIu94cztreMvFQr0fo21Yj4=
X-Received: by 2002:a05:6820:174c:b0:694:a339:43af with SMTP id 006d021491bc7-69e103c21e3mr449807eaf.28.1780086461364;
        Fri, 29 May 2026 13:27:41 -0700 (PDT)
X-Received: by 2002:a05:6820:174c:b0:694:a339:43af with SMTP id 006d021491bc7-69e103c21e3mr449799eaf.28.1780086460977;
        Fri, 29 May 2026 13:27:40 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e0677130fsm1718693eaf.2.2026.05.29.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:27:40 -0700 (PDT)
Message-ID: <224e4614325032a60e00a8eff308fe45d6e8cb2d.camel@redhat.com>
Subject: Re: [PATCH v3] libceph: Reject monmaps advertising zero monitors
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov	
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Viacheslav
 Dubeyko	 <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Date: Fri, 29 May 2026 13:27:39 -0700
In-Reply-To: <20260529074257.3707361-1-raphael.zimmer@tu-ilmenau.de>
References: <20260529074257.3707361-1-raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 09:42 +0200, Raphael Zimmer wrote:
> A message of type CEPH_MSG_MON_MAP contains a monmap that is sent from a
> monitor to the client. This monmap contains information about the
> existing monitors in the cluster. Currently, a monmap indicating that
> there are zero monitors in the cluster is treated as valid. However, it
> is impossible to have zero monitors in the cluster and still receive a
> valid monmap from a monitor. Therefore, such a monmap must be corrupted
> and should be treated as invalid. Furthermore, a monmap with a monitor
> count of zero can subsequently crash the client when attempting to open
> a session with a monitor in __open_session(). This happens because the
> "BUG_ON(monc->monmap->num_mon < 1)" assertion in pick_new_mon() is
> triggered.
>=20
> This patch extends a check in ceph_monmap_decode() to also reject
> arriving mon_maps with num_mon =3D=3D 0 rather than only with
> num_mon > CEPH_MAX_MON. Additionally, a log output is added for unusual
> values of num_mon.
>=20
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/mon_client.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index d2cdc8ee3155..33eb4baa5a10 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -114,9 +114,13 @@ static struct ceph_monmap *ceph_monmap_decode(void *=
*p, void *end, bool msgr2)
> =20
>  	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
>  	     num_mon);
> -	if (num_mon > CEPH_MAX_MON)
> +	if (num_mon =3D=3D 0 || num_mon > CEPH_MAX_MON)
>  		goto e_inval;
> =20
> +	if (num_mon =3D=3D 1 || (num_mon & 1) =3D=3D 0)
> +		pr_notice_ratelimited("received monmap with unusual num_mon %u\n",
> +				      num_mon);
> +
>  	monmap =3D kmalloc_flex(*monmap, mon_inst, num_mon, GFP_NOIO);
>  	if (!monmap) {
>  		ret =3D -ENOMEM;

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

