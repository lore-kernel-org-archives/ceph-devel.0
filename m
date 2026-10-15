Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146673C10AE
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081387; cv=pass; b=ANm0N7udwBI8d8gPswB8f7ilZ46UreFPQb0/gljQ8WJp2GTY0Ab+DTmPDrPRJ17hVeBdVMdFLg1PCLGKIU3hD4BskSB7zOBvBxHPFL+7WymX9tYDGmqVaycPWO7vk4RzCufeZ1jlxg4TG3aDEhQq/XzV4Wpv0uGJCCRovZrgQVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081387; c=relaxed/simple;
	bh=B/yCQsQtMKDM8DM/5G2ilFhH7RPMWtxJE0jv5juoXoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxBHLuOAz937/AmcMz+NwGROxPptNUdOxJZWvXZsLHyxZgIoCzOcvx3VAe73lVjj6E7DDNvehIteUn7EFv+Q/BjJoWhUa9Y8FyBacJjWIxKLhiKRjCS2xM+SSZQgq49Jt+L7DFCSx5HZVBM/iS3xUKS3cSGHBrIAvmqV2O/b/CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw9Vjgt2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiCxLbw8; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw9Vjgt2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiCxLbw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792081373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nx4sPS7ADcpxuloB7jlHG+Ce8rGDNUHgOUTEK11KwfU=;
	b=Vw9Vjgt2bOadMaFiPytALzehB28He29MJ6NDr/j/L1IEP4WbyR5II2g1sY/fjRH4HV2qZs
	fMTvsJrJDue+G8Hn1kK//BIoEejPt+e96zUGEEy+OVQzSHJNlAaTqxDBHvUi2H4oJxQFXw
	0ZWOb2zVcyhYTmo4e9QnEthOAQpkCtw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-KT5Wx24MOkKMpR4IhGy11g-1; Thu, 15 Oct 2026 16:22:52 +0000
X-MC-Unique: KT5Wx24MOkKMpR4IhGy11g-1
X-Mimecast-MFC-AGG-ID: KT5Wx24MOkKMpR4IhGy11g_1792081372
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338c59f90dso2318001cf.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 09:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792081372; cv=none;
        d=google.com; s=arc-20260327;
        b=qnRtmTRP+CNyyo4VQ3JR9TN0UEhgWWP+jrdwKraoyLomXYyiOcnw8Y/tTAt59mk2fL
         ew6d3jwBmBCDO1mh/PnpUZxX+nEvHqADo0ofm/+zebAE1BGa4J/Fnh2vQFg67vNWLVV4
         dFfz9EGnxsDa19EVSe+EMLXmKhm3u24x+GuhIYXS3NwW/IUuUUj5WlRaDuaxapti8aqE
         sOFmQ3gdO5cQv+zaSWjh6Dcx1Ynz9Tj41994RDr75vH6qBCdvqrr0A04KikFhQU0Fh/k
         zqtgsZg03DaW+8ELLxgqmuLdBlsvUdLD/smlTCBRmGqX/G10cv8/Ufb0mfHrCiQiID0W
         cXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nx4sPS7ADcpxuloB7jlHG+Ce8rGDNUHgOUTEK11KwfU=;
        fh=QPYHhnctFqjREYl3KmupH+E2Ar6L2qmDLXR0eBq3AxI=;
        b=SV8M5rbgPOqwHE4veOWzoJTG5abNE8Gsay4NiPHdz4qo6vg4wzOy2ZfauRFXejItnK
         EyITwuWm41gZZJc2cdjNNt3HsP5qfWzt7/rQdR9tLUVHwxWb8DRHLSx8EH2+nrT+egYF
         dmOJed2zles8zzV3ISaaABS+cuL5NOXLnwOXP0BS9vfwUZbTIkQGXrHuaREnn1nppcxm
         7NdHtaHOsLtLz0sl6Qypr8/PNwZNOBSnU90m94JkmIqwuCVwIlUqGqDIo6DmVI+li8U+
         ke7J/SRdaIkJdwLcC5vkf3ed35CB87bzyo3Ly7T1O/EhaPkjJgwUmMVsix6aAdEkTf5I
         t0DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792081372; x=1792686172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nx4sPS7ADcpxuloB7jlHG+Ce8rGDNUHgOUTEK11KwfU=;
        b=SiCxLbw8zj1wvA0KMLkuZsrgJL4+dmbZSKROheleCC1VHYsHZ0LmX+irdcWGoGG5qo
         SENoFcuDUKd1OdvG6+lynwp48LQJSum/T0oUjZCxWqWIr6SnOzlWNoSWQGrroajm9hcd
         6CWOP5ycV8A8QNvn988vgIQ3MPbhFgbBmfnsE3cMTQkye8wutyaT3GtFlK6zMqhmT7FM
         K4m6iBiQHiQF9sLPygMAc63hWFq6LJC9B1tuhmtA/S94/jPHXM0fTjlSXbjXC7EbtEn+
         A6W9Nl7AcfvKGCTGX8wssZ9uhM9HW3Lcl7DgbjQ31xbd2fZAdZxPL/mDpWotS5vHHApN
         G3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081372; x=1792686172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nx4sPS7ADcpxuloB7jlHG+Ce8rGDNUHgOUTEK11KwfU=;
        b=EKrtzyC91hmv4muIIHD4GRwycfodf4uRqah/ExyJY+YH0mcC4lUHG7hd810+luUKkI
         VQ3+JB3oQ0tLNSAqsL2kJpI5FqTpFVwqLzuhjNjOa5G71lYEMM2xJ9fzXdPC++fW8H0/
         ISoyGyI/KxsuWRUjCbrqOwRbcIv26O5cNDcVAlAmikTe89EFnbz+cAI2YVXqcYfynYWn
         eKCdLjc1byRFrECK4U/xB4SCjtLucUSu4deQPfl5YIgXbzALbQDps3Q9jo7m0ng8rMpm
         MNlWXo+B54iWPA+25nwdlG3mYzIJIWmnLmkMAoGI2SaPGn3dIIxCqz//VsCF9fJYVcb1
         5CVg==
X-Forwarded-Encrypted: i=1; AKwUvBz/KhpPEryGgUuHZVHo5CRrp4QEylR5EBkVLnUUy0F/RMVfqH7gm36g60xuGDDimanXyOolZ4upr/St@vger.kernel.org
X-Gm-Message-State: AFq9FYIlPsoAlgjXyntqC8mVWQ0hoiUTvf+aqf96MPWMYkGMkpKkaltE
	++tbSWgkMeO4ABqWFCfxvhWpBCKQGyOYhKozcdIO3D8dYjQKuCELTe+lh1fjZoMEkbB73lJd9GH
	PWRQyehK92+dWEDPTM57w9Dr7YhIe/0n3KvVY/f5CQDAq/k002FF5DGRYqWBlZEpzn4SkT6Lj6Q
	YKrvDiw15p30eAhSWOvXlPCY4dMTRzjWiTCDIx9QKVUUsotZhjBQA=
X-Gm-Gg: AYBFou3HWARgsKgpkCjtJDxD4Iy7lcramoNZrY2AZcvfX8rImCAjCNHhm/968lJWaMG
	fxfAaM9wA4qhALar5AOmks/UyCJB2F+AaPUwNlhHudgbmMisqsosIPPcLfZno1yMEwME+f33NO3
	kRJQQMW/hUNnRX7gy5xESK2R4GlftDDsf3AumEtFd9j15F6No3Pr+I2SDBxwwsEqfNExErBwI7P
	GMaELltXEZQyVgBZGJhDUdGVnp3cpd6HDzbO8q0lbXutECIuvcm68V6m9tW8hiBlOsy+NIiEnpT
	R5WV4MTuhMQHt+qykqSXOWbT5Q==
X-Received: by 2002:a05:622a:1905:b0:535:20e0:2778 with SMTP id d75a77b69052e-536272c3576mr10070581cf.20.1792081371570;
        Thu, 15 Oct 2026 09:22:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1905:b0:535:20e0:2778 with SMTP id
 d75a77b69052e-536272c3576mr10070001cf.20.1792081371066; Thu, 15 Oct 2026
 09:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com> <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
 <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com>
 <CAO8a2SiVWYSR6s=Z34QcfPVNVSLGk+YQQza4DDEt8_8+j37AHg@mail.gmail.com>
 <CAKPOu+9x_7WQmKhW==AmLoSzuPrUqeSV+JR69-TaovjEhuj6Ew@mail.gmail.com>
 <CAO8a2ShEjqyNA41ujmF5GfOM+YbJvXqCHKO9V++KBkJCXNOSUA@mail.gmail.com> <CAKPOu+_+oCzprewMeggY=32eEUt5ukTvhVMbEFGSh3Owa1zJhw@mail.gmail.com>
In-Reply-To: <CAKPOu+_+oCzprewMeggY=32eEUt5ukTvhVMbEFGSh3Owa1zJhw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 15 Oct 2026 19:22:39 +0300
X-Gm-Features: AclHuK_h7EDDc7jHJBjGn-t3Ju7JmTdSqJwHvcYvOANr8UoOsGNOkrmxHLArJn0
Message-ID: <CAO8a2Sj-_hbqEc=z0jgWW1oP36obzWWPm6KhQEDFAUB4v_2kaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi Max,
  git am of the posted v4 onto current origin/testing stops on patch 3.
  Patches 1 and 2 apply. Patch 3 does not. Two context lines still call
  doutc(), and testing calls boutc() there:
    ceph_mdsc_open_export_target_session(): "to mds%d"
    send_mds_reconnect(): "session %p state %s"
  That logging change is already on testing. With those two lines
  updated, the rest of patch 3 applies. Please resend the series from
  that branch so the patch context matches the tree we apply from.
    git clone git@github.com:ceph/ceph-client.git
    cd ceph-client
    git fetch origin
    git worktree add -b ceph-next ../ceph-next origin/testing
  testing is the current head of the Ceph kernel client. That is the
  base we use, because for-linus and mainline are behind the patches
  already queued there.
  Your patchset will be applied on this branch with Xiubos and my reviewed-=
by.
  Unfortunately, it's not scalable for me to rebase every patch sent
to the mailing list, your cooperation is appreciated.

On Thu, Oct 15, 2026 at 5:08=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Oct 14, 2026 at 7:42=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > > I see no rebase conflicts with linus/master nor ceph-client/for-linus=
.
> > > What other recent changes would make resending necessary?
> >
> > Please use the ceph fork and the testing branch.
> > Since the last merge with main Linux the testing branch has grown by
> > upwards of 100 acked patches.
>
> I just did that and got no rebase conflicts here either.
> I still need to know why you want me to resend the same patches without c=
hanges.
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
>

