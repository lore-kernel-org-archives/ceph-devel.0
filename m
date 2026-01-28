Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A302328B68
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631629; cv=none; b=HhnZbsjYWuTl2lNdeFwL5Kb3vLMdHIlYkUCC59N7QYSX28SFouYOGBeJO+t6PrP/D5e0GBpmpLrZ9zh85fTU+q+s3+dfyqfoy4f2Ro15dP8iEcy8XqoVbuSppI81omQnRGO803AB3mOKAVA2wkYdw0oMxX4KpGi8GxpuxKAZSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631629; c=relaxed/simple;
	bh=cQhp4NTBavRL5M7vVIbsiOmyCf2bKMbXtu54XvEzlQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAEtR4HNZqz4dUlmELR1q1odpR/eL6/lh344NfU87/vyvCy7Egmh/hbDetAK7VcayBJDGq85osCAtuOzNN97wvoPQZjccdG0vv8yg1MFbkGw41atfsGwigoMGN8I969bH2QIBotbQHhbXW6090VVpig9DHLvrfAPjTl6lZZ5YcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjCpvTyM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvWGHNWo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjCpvTyM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvWGHNWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769631627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2BpxOQY18A0qNxNJaWmNereaJFQzVlpvBrrpAuc1v8=;
	b=RjCpvTyM7UTqXeqq9+z+FLTpNhZP75Xzb8GWOsWt3oPn0qnAUcCI1VcafABgc5uliB9UOb
	b3UiOpuIHVszmjHO5HYoAqhwz++wyWi5+HQRmCvxXnmskglW6POeF+Z8msqsSFWxz2QQEO
	JIau4AyiFzdU8Dyx9Bh/eDG6VGgGZR4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-ma0EdM5YN52HYKLECXx7ZA-1; Wed, 28 Jan 2026 15:20:26 -0500
X-MC-Unique: ma0EdM5YN52HYKLECXx7ZA-1
X-Mimecast-MFC-AGG-ID: ma0EdM5YN52HYKLECXx7ZA_1769631626
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7944693b787so4092567b3.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769631626; x=1770236426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P2BpxOQY18A0qNxNJaWmNereaJFQzVlpvBrrpAuc1v8=;
        b=JvWGHNWo3p5S5elRVPMOkNRHMYYnnCgqbJSKBUi1jw+baIw4GkeoEkFwmMCSrRp3EG
         KtTEh31vx2ggWT0uMd0nkoiiQjyO5GHfmaQ6Hv/700QPPMti0zOx4KPrAiw5k50PkTv+
         NLpU2oWBRMeL5w/+TEqhCCvFSGkXuLeFEoOqDpgeSFjRATi3/MrCxyF+8rNxFy1zPvi6
         E4QiB9JRP7pDCaq69rcMv5G3MXspt8mslQdYpbaONuNfauZFigzk2eLHypZ2q3O9ZDQX
         XkfEoLg/wAMx5aMAoHJIDTku01O5jdxQK2iQfQfSBDwLvZIdvG2TatUSVfuR+y2g3+SM
         dCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631626; x=1770236426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2BpxOQY18A0qNxNJaWmNereaJFQzVlpvBrrpAuc1v8=;
        b=jhb1UhmvJYtvxNFurIZ3ML8P2ANm4L3esw2WkQfH04jMl1LeMTwNRFaKYgBMFwI2xp
         xx+GnnIjLI/tsHIANhjTXrSA40tN7J0JdaPMz8GFLMGOQ4X86fH07L7gtgPgyWnh6sC2
         oAtj/XU0xp2Ws+WjyjI3qP3oH9DqmZdJIkLtkcbirf11xIg2OmRyf171wlphY23ycaRr
         DnO3A2vQw4SDw0gf15JkWCmoPRwXMQzUTjqTs9Ewa8EGsNwSRjElcl0XUw/P697Y+26D
         0MZe0plulseWzlJtSpmRKhVukeDPjucE1KZAnOhFI7Onp6DLKCo6OKzdT3qF4KkyiG3o
         dR7g==
X-Forwarded-Encrypted: i=1; AJvYcCWrXlacburM8z1CHHPIpMGulPXZFmkshqQ989mJOsDEmzQebqUGXEBW73i6dJmkQDLvof0auLHBaz3v@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEyPv8ksua8fJXMlqe0o1IvsOIA0Lq60Z142ZL1NDfuRiKp7r
	mX6jY598gYvJ+AwQuD45Y8W+fUyqIopkD8wPefZgZtXDvk3Ov1VODD4469Nc9beJLGQCG3yB/3F
	mbIPc225sL7P4MJDbPR9buxpkZ87vButACLjuMcpQmf7Hq2sN/RSnwwhwM03t0CE=
X-Gm-Gg: AZuq6aJRI94qoRPpWS4CQlp5vyd/aMUrZiVjz61hSlis4gakqHpS3T2z8+TwB05QC6/
	rhOpXhnfuMB0+1w8D8A3M83+HVcLUsXOKkIZhY+HyldqYcVijZx5kR2qjdY7ft6y6R5fp/trrWo
	Gqymqd9EhLMw4G37+l/yKmxun2y98i+8XxTRMuuA2DbXNrIMvQYEExVGlGE0hYah+63TRaHI68g
	beiwEQ0EGNX9eSljqUtJ6Vmg0Ep0fH0mCFWYXRl2i5xL2djFoh8HTgLU3XP7rMVUq/B+AmpTBN7
	TVhF/6T7YpJZpoV90CurTy8MpZ1HzDAopqlzpvZq6tm4t+kaEY9QW9XefmaLgh34ZxgL0zjtdoj
	ICfHxr5cJy3Irabv5DmjCk76kHROdIoqpbKAJ3Ee6
X-Received: by 2002:a05:690c:c96:b0:794:722c:3a2f with SMTP id 00721157ae682-7947ab7f588mr49960867b3.31.1769631625739;
        Wed, 28 Jan 2026 12:20:25 -0800 (PST)
X-Received: by 2002:a05:690c:c96:b0:794:722c:3a2f with SMTP id 00721157ae682-7947ab7f588mr49960707b3.31.1769631625317;
        Wed, 28 Jan 2026 12:20:25 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828a62f6sm15015857b3.37.2026.01.28.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:20:24 -0800 (PST)
Message-ID: <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Patrick Donnelly <pdonnell@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Date: Wed, 28 Jan 2026 12:20:17 -0800
In-Reply-To: <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
References: <20260114195524.1025067-2-slava@dubeyko.com>
	 <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
	 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
	 <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-28 at 12:16 -0500, Patrick Donnelly wrote:
> On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > Hi Patrick,
> >=20
> > Has your
> >=20
> >     > > I think we agreed that the "*" wildcard should have _no_ specia=
l
> >     > > meaning as a glob for fsopt->mds_namespace?
> >     >
> >     > Frankly speaking, I don't quite follow to your point. What do
> > you mean here? :)
> >=20
> >     --mds_namespace=3D* is invalid.
> >=20
> >     vs.
> >=20
> >     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
> >=20
> > stance [1] changed?  I want to double check because I see your
> > Reviewed-by, but this patch _does_ apply the special meaning to "*" for
> > fsopt->mds_namespace by virtue of having namespace_equals() just
> > forward to ceph_namespace_match() which is used for the MDS auth cap.
> > As a result, all checks (including the one in ceph_mdsc_handle_fsmap()
> > which is responsible for filtering filesystems on mount) do the MDS
> > auth cap thing and "-o mds_namespace=3D*" would mount the filesystem th=
at
> > happens to be first on the list instead of failing with ENOENT.
> >=20
> > [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd3j=
+co6Sq0gZ+421p8KYMEnQ@mail.gmail.com/
>=20
> Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` should
> not be treated as a glob.

OK. So, what's the modification the patch finally requires?

Thanks,
Slava.

