Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B64499AD
	for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569836; cv=none; b=AL2/IreQaVurwDbtsm/qtCqBrY70A0qVQVdmNePHqEvFSUm/nhnEVKbImNlNIV7Eohd2af1Ym4Zyoe76XRwIPAFCrA+YKrD5Vef/KKN+/Luw2o2q+KmoYVModX+DwKW2jjQWDmtoYw9k61iFlmtQ7rwDdUEq8qL6izaUdaOyXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569836; c=relaxed/simple;
	bh=Mug6mdvOzfZiPSR2hwKfq3W/EClr6r8ewyDrw+dd8QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvL5Y1a41j4rvdXLpD7fWxlIwfszTPXfLDQrZsgyMPCccsn6IU5RvgB9e/btp7EzRkjhkNaNPmmk+snLlhL9DZB2tOteyvcknDwhKcf6xcJij8Mde48ZhHQlv4kGPAu6O+fB530C1zsdY8C7QzlXebcVG+ViDRtnMtbCnWW5f+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=K0PJE6/7; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="K0PJE6/7"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e69a2db34so55447357b3.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784569828; x=1785174628; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=egWhZ76W8oq2GbxOKW2F7G35JG/AS23dvrE0KrllWRI=;
        b=K0PJE6/7ZF0sEYZndITODs0ADbxrLlVENNHYcZTh/SdxfyzcmRiurhqBNviuoyYhak
         BMWIvn+OT76SnBaFhhBnwem6OCfp1T8xQzinOKUUYoPojtbVRdhH31PMITl+d/P8rCM8
         c7+j6M4CpfVJ7ZGX//J+ljM+AI6QDpukwMoal09QXoy01GdwO3GvsFWUrP6tujkgOiE1
         ULlf0m+LpVJ2ioCwhpjLDA4hTNvsM6RJlX+1W1IltGaunPwycMmRLgDrCYw86Ryihtkj
         E9zn9ltX0zTgHVu6G46UZ9yOaQM623+X52V5i76LwAC64EjXPfrXrxbFET6fRVFrPqFc
         CGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784569828; x=1785174628;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=egWhZ76W8oq2GbxOKW2F7G35JG/AS23dvrE0KrllWRI=;
        b=Go72WgYmPj7yxtDj7w9y4m/Zw+9QMNfF9GHeEpMdQRQlbC8DYuRjXF/Rdzu8K5phaK
         K0YurncY15+Hfkb7QGQ5fQmSJyjtRsdSuUff+pUR0rRHPfrQUZBXa0vCty3kius3uH3Q
         CTXocPJ63D39LqSWOQDZE/KzXDhp4I7FvRgDhFOQsY07AbObmlQHqWH1mx0UVS0OHLfo
         ApYg9oEzqEMqCfk8F8l0aezlA/rIfQsXpDSIVvYjJRXX8a8D4H+uoVtnKwsvwXLU1BjP
         BppcOfp+BuoQrwMi2dqrDY1j1VLKUZwI7VnteaBv2VfSdNNbfNRiVejbXV/CgWdQ6sts
         uWaw==
X-Forwarded-Encrypted: i=1; AHgh+RpIvjY+oAVSTHQgEL4Gn0PJLFvDHMc6PHuXeDtgai6eTqSk/jmu0rW9IivWfzKGbaBRuzjd+gKBiAwH@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFZZwZfwm/OZibJR4KehmJQKzFg3KvYm9pq3kshZQhrGgF3K3
	rVL+rEPKdfC11/2eOlo76ivrlYUL1oa9yVahFBiMmgrmF4j7XJD4IwtPWPA2f/HMILo=
X-Gm-Gg: AR+sD10da/1DyI8v4tmNOm47XbQ4EoSXRRiaogOUoknvEelgz1Bjnxc50fcs7ryf0CE
	D6mF2JXEp8Q5GlOXq5VK6gbF+CmHMxLrOY/iO8NOyWZDxPv6CMqPHnQgnkx5BZKbcuwxharndGJ
	CyO7zgsIme8Rsaw+V61x1/DefDqPG4m2HvFMMqrOh79j/StnYXp6zxuFHb9DcDfEVYD4Z4TOTaU
	DxAb6U68QwHkaLv4+Xgzq8JenWKbnVezn7zAogVoM4QbaS/icymov9NataYEwWb9rNgpp+A2BHe
	uN7X7SayhFUJrvZR+T+wbMasKjEPygU0xu04fJ9zk8xbjkQIaQxBuxEjar1a2m94E2xyW9lcUX7
	G/JpZDRiwmE79d24A1nt9di/9iRsBERbnaSca0VHe0KI57yKm6VdNqA51MTJU9kHUQtO7toPayE
	5pyuiLHFbU3sUsMqYfRP74b3aIsm/E0bYnsux3oUAB/edblCpw8If1oPezaF4+J0J34vEZgMXdi
	gGDRw8gsR6VDQ37S1V51qWTdeph6VsNgGaGgmZoo9GM4BLf11j0osNLSBotdEQ3mn0t
X-Received: by 2002:a05:690c:4b93:b0:81c:eca8:dbaf with SMTP id 00721157ae682-81ef278d84fmr46500557b3.31.1784569827720;
        Mon, 20 Jul 2026 10:50:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8546:6986:b83:77a3? ([2600:1700:6476:1430:8546:6986:b83:77a3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42c5c84sm53944337b3.41.2026.07.20.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:50:27 -0700 (PDT)
Message-ID: <9952b19ffac512d2cce2036a4f2d7f20418b6b32.camel@dubeyko.com>
Subject: Re: [PATCH 1/1] libceph: unpublish osdmap before destroying it on
 stop
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <enjou1224z@gmail.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net,
 vega@nebusec.ai, 	xizh2024@lzu.edu.cn
Date: Mon, 20 Jul 2026 10:50:24 -0700
In-Reply-To: <bbcdd44d07efd11c7211195b6302b179918cb253.1784371311.git.xizh2024@lzu.edu.cn>
References: <cover.1784371310.git.xizh2024@lzu.edu.cn>
	 <bbcdd44d07efd11c7211195b6302b179918cb253.1784371311.git.xizh2024@lzu.edu.cn>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-20 at 11:49 +0800, Ren Wei wrote:
> From: Zihan Xi <xizh2024@lzu.edu.cn>
>=20
> osdmap_show() takes osdc->lock for reading and then walks
> osdc->osdmap while formatting the debugfs osdmap file. During client
> teardown, ceph_osdc_stop() closes the OSD state under the write side
> of
> that lock, drops the lock, and only then destroys osdc->osdmap while
> the
> pointer is still published.
>=20
> A concurrent debugfs reader can therefore acquire the read side after
> the
> stop path has dropped it and traverse an osdmap that is being freed
> or has
> already been freed.
>=20
> Take the osdmap pointer out of osdc under the write lock before
> dropping
> that lock, then destroy the saved pointer after unlocking. This makes
> the
> write lock wait for any current osdmap_show() reader and makes later
> readers observe a NULL osdmap instead of a freed object. Also make
> queued
> OSD map messages return after taking the lock if teardown has already
> unpublished the osdmap.
>=20
> Fixes: 76aa844d5b2f ("ceph: debugfs")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
> =C2=A0net/ceph/osd_client.c | 12 ++++++++++--
> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c181..70467eede336 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4145,8 +4145,11 @@ void ceph_osdc_handle_map(struct
> ceph_osd_client *osdc, struct ceph_msg *msg)
> =C2=A0	bool pauserd, pausewr;
> =C2=A0	int err;
> =C2=A0
> -	dout("%s have %u\n", __func__, osdc->osdmap->epoch);
> =C2=A0	down_write(&osdc->lock);
> +	if (!osdc->osdmap)
> +		goto out_unlock;
> +
> +	dout("%s have %u\n", __func__, osdc->osdmap->epoch);
> =C2=A0
> =C2=A0	/* verify fsid */
> =C2=A0	ceph_decode_need(&p, end, sizeof(fsid), bad);
> @@ -4238,6 +4241,7 @@ void ceph_osdc_handle_map(struct
> ceph_osd_client *osdc, struct ceph_msg *msg)
> =C2=A0bad:
> =C2=A0	pr_err("osdc handle_map corrupt msg\n");
> =C2=A0	ceph_msg_dump(msg);
> +out_unlock:
> =C2=A0	up_write(&osdc->lock);
> =C2=A0}
> =C2=A0
> @@ -5268,6 +5272,8 @@ int ceph_osdc_init(struct ceph_osd_client
> *osdc, struct ceph_client *client)
> =C2=A0
> =C2=A0void ceph_osdc_stop(struct ceph_osd_client *osdc)
> =C2=A0{
> +	struct ceph_osdmap *osdmap;
> +
> =C2=A0	destroy_workqueue(osdc->completion_wq);
> =C2=A0	destroy_workqueue(osdc->notify_wq);
> =C2=A0	cancel_delayed_work_sync(&osdc->timeout_work);
> @@ -5279,6 +5285,8 @@ void ceph_osdc_stop(struct ceph_osd_client
> *osdc)
> =C2=A0						struct ceph_osd,
> o_node);
> =C2=A0		close_osd(osd);
> =C2=A0	}
> +	osdmap =3D osdc->osdmap;
> +	osdc->osdmap =3D NULL;
> =C2=A0	up_write(&osdc->lock);
> =C2=A0	WARN_ON(refcount_read(&osdc->homeless_osd.o_ref) !=3D 1);
> =C2=A0	osd_cleanup(&osdc->homeless_osd);
> @@ -5290,7 +5298,7 @@ void ceph_osdc_stop(struct ceph_osd_client
> *osdc)
> =C2=A0	WARN_ON(atomic_read(&osdc->num_requests));
> =C2=A0	WARN_ON(atomic_read(&osdc->num_homeless));
> =C2=A0
> -	ceph_osdmap_destroy(osdc->osdmap);
> +	ceph_osdmap_destroy(osdmap);
> =C2=A0	mempool_destroy(osdc->req_mempool);
> =C2=A0	ceph_msgpool_destroy(&osdc->msgpool_op);
> =C2=A0	ceph_msgpool_destroy(&osdc->msgpool_op_reply);

The fix looks really good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
