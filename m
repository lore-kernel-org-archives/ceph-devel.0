Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B63242BA
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620625; cv=pass; b=ThLeN7I9zHah1a8VJrgT6zrsIlbxznJ97nMV0z1jZRrMiXXfF+RIurQ/D8+0l0BaDjQE/U2MyKgwpLCdc0gE6YBmbJIv5CEYZteKyimZzwgMc/fX5kfD/QTLPT2bpjqpWEQZXistb4NqcTUPTHPpg0yIS9Ea1hwlhHKJ64IvzRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620625; c=relaxed/simple;
	bh=+IiWs5X+1vdZhz1rpr1SW3QzXxMw0rt6UdXQMw0zzVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeZOaW7LSm9JP/mACX1STgkyO1Qb9djg4wJ0Z28KcONCaS434sL7eNk7Des0zGNQrLaltCZkQBW9m6bl5Hb+taSc0si5SUZFmNLQGAWZy3wef/8Vj2Cffh4uJbSimHFUn3pVL9HVf08wFgZAO981PGiqUJS63Q7EI5OM+PObvQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViuoqMBM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rRgZcidK; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViuoqMBM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rRgZcidK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769620622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
	b=ViuoqMBM1Eimlxmhsx0daNyWkF4lBb/oz8TKG8uOdyFXNuwNGY2znHR/IOZFr+kqstf7aG
	G7ZYnV9hSjq4ED/LvcPPk27Sq57bHdCywTHoYn60Qpk9VnOfT5eNxazJc+xU7+3mI/CMr9
	0PNx68VWbX7YMJcOQqJSjjItWmfI2us=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-NazcOKVlOnyNkX2V42U9Nw-1; Wed, 28 Jan 2026 12:17:01 -0500
X-MC-Unique: NazcOKVlOnyNkX2V42U9Nw-1
X-Mimecast-MFC-AGG-ID: NazcOKVlOnyNkX2V42U9Nw_1769620621
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50146d98660so280101cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 09:17:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620621; cv=none;
        d=google.com; s=arc-20240605;
        b=Dv46Ty7yQnF8m9RQAeXRkHOItRoWzftL/poUuf+RDm9Dc8WDtF6sglkYs+IfYjxIVb
         UE/Aa+54RyDh6pXZ3LQfk+uqptVG37qTie/65l5fDBePLPr/2oCN1rMrIOz59M4u+sGs
         yEkroUlupG3CglQqsZOVZjcJ6N6iBwEKC24irA9BtaBLLPbsRx6PhqjxeJ1lFiKCcdqI
         qiDRvx68h05ga3QMyPkGOA6RT2eIB87q5+5BXw2iASSD6iGlceymrvdbLO5owgmsTeYz
         zAfz0CYw61XnB2gLWBVASUWLSBFyWewZLOv4qgJUYbtA3xP3/cnO77y027tSE3ZH1MAu
         g4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
        fh=KMBTIieebarBF5rgGRquLKsSLK6Agt8CHcsAJrP7aFo=;
        b=IIdb+RdicH7iwVPM4hnGVCWp4EGitK09obc3VZmbk+CBRODXlxMvgtPPDJbDjCTMyY
         yRT6Z1umfoEdp41Qd1B8ACej9jZuCLcNaVaVreF1o4mEkWz5hs4WYrQODMPiR6UMTnyt
         pJJkBhAuABwxybZcJfiY75pjbZ45SVTmdLJHN5nALpfcVy1eBZM49rxBLaaWwMqNkfxB
         Y28/+tn1bZMCx0Tc6KuTVt7A6IJyXKcHOinYKF9tpb0Yahas0qFgTAz4L/3ed4ySCjLc
         6Oi8jjc5ayUeJJkRouB5R6tw/xeCUX6tXgzsR4oYiYcmkTBOyM6MuEWA/X9LCCd1ImSa
         NdBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769620621; x=1770225421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
        b=rRgZcidKtfaPRAoWdKu53gCV2Lxh3XRijcVdMVgRIktmErJZ8QLvaKRSityiKP00rH
         9YuS7VoDCwKjc908v1LYyqWhYrwOTeCFBE7X3axlTe8ItzJvbi/B2lihfUy5YduSfmQH
         U43oXLUwJuqS031+7NA+MK9ySPIZPGSRRey8O2MXWdE0a0uckULZ+WzmN0iPkxEa120j
         LxDFc70z23dxZftFB0jKX321Ji4cDLJMtIMlvkL+Q4ATu2p+KhGl/I8u7JSxxIC7PGEL
         izqLfCZZKc0zj4m2kk3nUtCBtTmTxaAK8iwbET3biD6QB5dnRyYCDy7E12EfismtBQwN
         scLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620621; x=1770225421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MbfrzMkcR+UNo9AHIJTdeDBLR3pjra3jZ2ltU2ToXps=;
        b=X+lNat4OABK4FBxLyvUfNl5L9xvE6bsbk2UPAB1l0pKbl9YF4WgC7/GBUO7RqAF/pm
         DSZhZzl2iffosfMlI0k84FjKmwSbk7a5U7mkqnx8Zk3DiHgGetJG8yEPugPWKmqH/jje
         24L/bIl9hztzhmfpEmsg+9/HiHKMlc0uGWh9T4B+urSrKhGn++wvCLCNERqGwg8/JBLo
         ftPegHr31Ft2UWuvZg80cnobdAY1eS12Kk50J3vMSPS1bj486KWqLVX8D/hXrZy7MytI
         k8qJ0S36BX/6ci74wZuRxfor2c/8OHfdhIpI3FdHVfuEsuyFUmXRO+PHUbqAQDVkj5B9
         b6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWo3m7ubki/hu+IRbMiFcF1RejdXMlxZFzQBtl0vjuY8qP8p1Armh4+RVxOkVyY76O4r9nwucPjSAsH@vger.kernel.org
X-Gm-Message-State: AOJu0YwNF+gg8tw7PMKrbgMvQLAiVi/96uMvGehcOWYExC22Fj/cQup4
	T/HF+3ZM8lQo0rLAn5ZVlXEgkrGOxbpiDqXQGJ3AVYKA8Ejmuck6LhxiADx/iobHSD8PJEcMz7/
	SDEgCkEFT0noEUDnshAAnHgcldOgFD/NkA5wTVHaLIXVzJAFEwI+6KCEs20gklMc1Ycxua173jT
	Ez4iLhnGz7wxV8RpCQsxu3ebGHIeso3oQKmqnBRw==
X-Gm-Gg: AZuq6aI8eeRuCIvsrCm5eUxw46EjqBnRL3e9hQRpZlXCks7QD9eft9boqA5H31AOmnP
	DlT+pDE5BVAFhJAwfVLmAkSnaHMgauOPhseIjCVbUa5+qkgfrwlbWVlc2H+0hQ5HOpZrQEKsWdS
	HJkOPv153l1ZaK4Di2revx7eYYcM+xvzWbhGywFhq6CSs8ezNOik63DKzjCV9vzHEsOLV80mVx+
	1U2gSsVuxm0mWeDlSNB2cLSew==
X-Received: by 2002:a05:622a:1116:b0:501:4e87:70a3 with SMTP id d75a77b69052e-5032fa1a7f1mr75723261cf.68.1769620620789;
        Wed, 28 Jan 2026 09:17:00 -0800 (PST)
X-Received: by 2002:a05:622a:1116:b0:501:4e87:70a3 with SMTP id
 d75a77b69052e-5032fa1a7f1mr75722801cf.68.1769620620320; Wed, 28 Jan 2026
 09:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
In-Reply-To: <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 12:16:33 -0500
X-Gm-Features: AZwV_QgYxRhrIHrM75G39qUToqwLkdG2j3zCs0ZghqydpwcTesEEeCkzdejbaLg
Message-ID: <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> Hi Patrick,
>
> Has your
>
>     > > I think we agreed that the "*" wildcard should have _no_ special
>     > > meaning as a glob for fsopt->mds_namespace?
>     >
>     > Frankly speaking, I don't quite follow to your point. What do
> you mean here? :)
>
>     --mds_namespace=3D* is invalid.
>
>     vs.
>
>     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
>
> stance [1] changed?  I want to double check because I see your
> Reviewed-by, but this patch _does_ apply the special meaning to "*" for
> fsopt->mds_namespace by virtue of having namespace_equals() just
> forward to ceph_namespace_match() which is used for the MDS auth cap.
> As a result, all checks (including the one in ceph_mdsc_handle_fsmap()
> which is responsible for filtering filesystems on mount) do the MDS
> auth cap thing and "-o mds_namespace=3D*" would mount the filesystem that
> happens to be first on the list instead of failing with ENOENT.
>
> [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd3j+c=
o6Sq0gZ+421p8KYMEnQ@mail.gmail.com/

Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` should
not be treated as a glob.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

