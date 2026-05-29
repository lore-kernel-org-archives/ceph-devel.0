Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67325CC79
	for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087291; cv=none; b=iU2nGaTbleOZHohtM6xHmfynz/LnxfmGm6M+eJV5/5L/tNVs5kYEqLo1AhGisYuxDAMFNYbi7VeVE85rSKe8FxKWgYp9bhdNtc92AXXPiJCYeCD5cRU55G1DffpSIlq50NS5ucVkMP1VoAtEWdmEj1SRvGtV3+0oY8/SoS2OURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087291; c=relaxed/simple;
	bh=CZJie8istppNpGqajDzlmdniDP+tWLzYh6O3GNnBn4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmqL+O5zT1/yYJQb74AE1DCw/MM6nZXhcQsfROg4KcslKDU40kcm7tEeMG3WSQiPu10i8SHDPgB7B4ZZgZ09mZIpimlQwO1SgA3luTDnF4FerhCc9tRbhTYEXeZS8KNfWQSrAw/AtiV64lsTSU0V+iTNBBPp75ARUZ38ij30PX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2ju8Zbb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTnpqD5f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2ju8Zbb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTnpqD5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780087288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zhv62YbTyOMG4g+DPkoPYSi1XVuNs+wFTtglo6+oyVw=;
	b=G2ju8ZbbC+3iWPMqNQSDcuMerlO0P4Yhr15qK+TYAlx5IC7WbM0osSnSrdYBDqwa90F6Fx
	PIS/zA+uvpBm97BryItXZuaVUmH3NKrwnN9nqUxF1Cas8e1zL4czTSHr2ISYDSl018t/WC
	Nr4T74/LT8SWwiv+ovZemxo/VzPJl/8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-nOTp4YWHPT-0Koc-h9tYqQ-1; Fri, 29 May 2026 16:41:26 -0400
X-MC-Unique: nOTp4YWHPT-0Koc-h9tYqQ-1
X-Mimecast-MFC-AGG-ID: nOTp4YWHPT-0Koc-h9tYqQ_1780087286
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e606551a79so8288370a34.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780087286; x=1780692086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zhv62YbTyOMG4g+DPkoPYSi1XVuNs+wFTtglo6+oyVw=;
        b=MTnpqD5fijJ2MMYOeOnbOzFZ4fhqQnSXFqr/AlxsHgaY2DMpY2AO8Cwc289jW44Uo2
         ycMv0oZIXeccKXw9Dnv7F93TdmoKnQT+zkL1B6aAn43DpHsUt11U+mPUcSkjDauCNNfX
         O9xohg8C8JEHTK5MIkqFyuw8HqAYMJnVbjRZdckQ69X1JGgrog97Ky2env/64tdU2XsP
         bZvEFHnodl/RvWKaZmdIXmBRtRT/tKeeyaCwJo8n6qETz8M09OaPzfF/IEB1ArKR5Zw7
         mlUf9AJot6PjQpDLp3pzWww2wOw4KxqYo1jTOLZgFFxqEzTM36xxP50eSWNnPkbd0Yve
         Z9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087286; x=1780692086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhv62YbTyOMG4g+DPkoPYSi1XVuNs+wFTtglo6+oyVw=;
        b=Dt2FRnEgI72mh56Z9W6XpWu4JxYrHhUxvyuMEo/4r+XnKdnJs1JLTijOts7bsQqyGo
         W7CQQKMXhCn9++jtsBUMNbI+/KrGpBKtXDpiQPHkSNw9IlcZ/E2EP+bA9jUeevij4hUp
         93wWUiZMbKBrqOh4myOu880afndRMNQQP4Wd3UKcYAm5LASw1nu/+FUuSvxt084tv+1M
         tzXbUlcfGP3pOmk5pcVimkK/5rzvRnEeZvvSj9dAwVkY+BOWJPUaEeRSIOKWYx9yQgOm
         28GXbZO9cFh3zSGF6yCiPldb4tzmUCWTDeqaVv6MKe2FCrh/gzXHrr3LXz7Rc6kpoUdt
         BAIg==
X-Gm-Message-State: AOJu0YzyERdsveoQlORvE9Q+h1Ca/wT1HHbDwg6aJLYdeHq/44Nm3dsH
	tN7S5NhPlZASQ42GGpzJiuEzTy7fNuU+p7bVi3f5CCtBqF1+xO/sGVXBEngQ2GOLbgY1np9kPPC
	D1ji6pSc5Zu1f9wDm/k3NXm5pwJOsEgAKJR13Ug899TCa/S6ZbgPIUXr9FTTb9So=
X-Gm-Gg: Acq92OE4rcUpVbeXyRzhjSienR3Ox33ykh5LjSN12FPMVGEeAK3JhZH9HihIkkqoAqh
	caYhp4SwUOm0JJyvW3DoFLpzQBW+CKnsAWfku/YiyoVRuFYasKiELjFhzRaGnmQ/UO/mS1e0nOs
	S/nk0XuvEU8A8qvtJ0nFKlup/KnIujsEVpKbXR3FKJBDdiGwEm+fBsMOFmWPavNSyXf9zFesEt6
	RVhCjRV5iYhHAIl80vr37Qeg0Q43rEPp4/nq3gJL9aje0iSJaB77uBXmkPgFa2Yk0b+awuk0Wnl
	fmI3oId+NUlWp6/r/bspMcoi52d8hoOw6kpbdSBbJuQCHpW7py5bwJvtkrGOjGeXBIdaIUo+BEh
	Q0O4z2f80QWYQxKRoalgxkkwD23A3WOc9yLkeQAixPPmpqZE6RcyYJtI64T+NPm4=
X-Received: by 2002:a05:6830:4884:b0:7e3:fa27:c176 with SMTP id 46e09a7af769-7e6a1daa29amr947273a34.16.1780087285899;
        Fri, 29 May 2026 13:41:25 -0700 (PDT)
X-Received: by 2002:a05:6830:4884:b0:7e3:fa27:c176 with SMTP id 46e09a7af769-7e6a1daa29amr947256a34.16.1780087285450;
        Fri, 29 May 2026 13:41:25 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695b8fc5esm2206083a34.3.2026.05.29.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:41:25 -0700 (PDT)
Message-ID: <e02e1e589b3f77902435e5b062b60d1f419b8624.camel@redhat.com>
Subject: Re: [PATCH v2] libceph: Handle rbtree insertion error in
 handle_backoff_block()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov	
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Viacheslav
 Dubeyko	 <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Date: Fri, 29 May 2026 13:41:24 -0700
In-Reply-To: <20260529082242.3726491-1-raphael.zimmer@tu-ilmenau.de>
References: <20260529082242.3726491-1-raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 10:22 +0200, Raphael Zimmer wrote:
> A message of type CEPH_MSG_OSD_BACKOFF is used to block/unblock requests
> to specific PGs or objects. If this message has op code
> CEPH_OSD_BACKOFF_OP_BLOCK, handle_backoff_block() is called to block
> requests. In this function, a backoff struct is created and inserted
> into two rbtrees for tracking them. Both insertions use the asserting
> rbtree insertion function by calling insert_backoff(), respectively
> insert_backoff_by_id(). If a message contains a backoff with the same
> begin ceph_hobject_id or the same id as a previous one, the assertion in
> insert_backoff()/insert_backoff_by_id() triggers a kernel BUG when
> trying to insert the backoff.
>=20
> This patch fixes the issue by switching both calls to the non-asserting
> rbtree function and ignoring the message if one of the insertions fails.
>=20
> Fixes: a02a946dfe96 ("libceph: respect RADOS_BACKOFF backoffs")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osd_client.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c181..482b89009649 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4427,8 +4427,16 @@ static void handle_backoff_block(struct ceph_osd *=
osd, struct MOSDBackoff *m)
>  	backoff->end =3D m->end;
>  	m->end =3D NULL;   /* ditto */
> =20
> -	insert_backoff(&spg->backoffs, backoff);
> -	insert_backoff_by_id(&osd->o_backoffs_by_id, backoff);
> +	if (__insert_backoff(&spg->backoffs, backoff)) {
> +		pr_err_ratelimited("%s failed to insert backoff\n", __func__);
> +		goto err_free_backoff;
> +	}
> +
> +	if (__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
> +		pr_err_ratelimited("%s failed to insert backoff by id\n",
> +				   __func__);
> +		goto err_erase_backoff;
> +	}

I just realized that these checks have incorrect logic. We need to check th=
at
__insert_backoff() and __insert_backoff_by_id() are failed:

  if (!__insert_backoff(&spg->backoffs, backoff)) {
      pr_err_ratelimited("%s failed to insert backoff\n", __func__);
      goto err_free_backoff;
  }

  if (!__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
      pr_err_ratelimited("%s failed to insert backoff by id\n", __func__);
      goto err_erase_backoff;
  }

Am I right here?

Thanks,
Slava.=20

> =20
>  	/*
>  	 * Ack with original backoff's epoch so that the OSD can
> @@ -4440,6 +4448,16 @@ static void handle_backoff_block(struct ceph_osd *=
osd, struct MOSDBackoff *m)
>  		return;
>  	}
>  	ceph_con_send(&osd->o_con, msg);
> +	return;
> +
> +err_erase_backoff:
> +	erase_backoff(&spg->backoffs, backoff);
> +err_free_backoff:
> +	free_backoff(backoff);
> +	if (RB_EMPTY_ROOT(&spg->backoffs)) {
> +		erase_spg_mapping(&osd->o_backoff_mappings, spg);
> +		free_spg_mapping(spg);
> +	}
>  }
> =20
>  static bool target_contained_by(const struct ceph_osd_request_target *t,

