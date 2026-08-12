Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769031717D
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519290; cv=pass; b=IQH0rR5uyZfn4HVXSFaoz3Ye5bauzWor0YKr94oqS/cuwSwIjLePIKBIqK/2H0gfpLkqqGdLG6i5kJ8WgNpVOQ7MXDLcXYOtUqhcBEDPKrbjSDTK/Gf3saGjxAFDFEkixqU3F1QhEmk1T5KOg/bk3keME4HiH0dRXq3V5b0inq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519290; c=relaxed/simple;
	bh=8vYCBrTU0T8j7SOpmc/u/MFdHj8xkh1kw62pLfbOqpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxhrt89Zsde3J7CJzxtoUbDTNrM6qbFJC77zKgKIVpothh6kD2UgBpkRHtztlYago/IODCfFz8CyTRh8g44DlMC4jGekub9DAm9CJcl9TGAFbi3LJkgaR/JXJu1C9PQ82aEKuqUmVKOjJI+u8txS+1aQ2X7kPyg/gbfq9VFZLSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=o3qeNMCQ; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="o3qeNMCQ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a17f91so1037756a12.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 00:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786519286; cv=none;
        d=google.com; s=arc-20260327;
        b=K8ZbteHxRWjc86c8hoqEKjKu30b+A07kceYUKPMMMzSUPZj/95xdSFiJPrsRNFbC6S
         Xpb3N9EjW6N5iB/asq7rXSh3HS+rclfRzVxdqtKNT6Xc7Eupx+GZPkOUlhJKNUFLeXWV
         Y2ReGfyLjSufOAqNJrJ0Y20NN1K/4aUO6WrTWLjnSz97L7MWU7ZxY6VSXUXC9rchKiUB
         T1Y6jKE9fGhgBsLliA1ljEnsdZW2fd+phZVfTkZ3o3LLTSkvWmgwleFmpRTFE6J3P3TZ
         vBolhNZQLEnsesU5YWnhqVs/jLYYKeQndwK+qhKsPsL5KX5iD1br9dLegs+0a+FDLjRd
         vrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xbGxuLiKh0dpm3GTYr4w1LbBeL2dZuBbujKjAxwddLc=;
        fh=k0iXQdAS7ORa1Cgfk/ddC1JRMDQJMVmk7RX+aqBNmGU=;
        b=Fcm51rYds8pW6Ir+JEB0hdVxaDMWpnx/MXMNfDR/Ig8o1WrUa4wN5ET0xkAh05sNzQ
         SpvbfFcr0lEgPRqH//rViQXy2E4BmqyRpfyi6JBJvwlPaie70A9CztvlZlWAubdxaXt/
         C4kE3QRMPuyEUQADXM8IldExrOlQyUbNy8bB7gLDGBkx0+QK7ul/nbMJKWHM5fuiikIt
         Pb1ty+F04rjdvoRKAmlkoHGS8mA5Fh0QIiBRrL8rtPSkSyYEeViMc74taAsKLEiUbr1r
         Zxbmn4Khr8cR7gXjxrWERc6Zal2YkFtO5vZ0uCexXd2KmKdqUh6eqOSIrXHz4abBEHQF
         uJAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786519286; x=1787124086; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbGxuLiKh0dpm3GTYr4w1LbBeL2dZuBbujKjAxwddLc=;
        b=o3qeNMCQwygmJf3x4StouDCk+x73OXlGg805N1AWh7w8EfmDoIpLDqRmd3feXnhUOa
         eR88emhH7ycCdHYBQQTKiqGybHToGzXk4d42p7bdu2HOoenk/7qWFpyprAom9yZ2RZQa
         UIwmWY2FdMpqmYHmdM/JJ3hILjxV66uM9qQwwG98u9Vp9guNGU3UD+xlB1C/O6xsgc3z
         t2GerGbRD4emhw+0CEPATR0V+wL3Httbxx5cpXbXf5EjVGRYR4FX2zZZABwvBAOAkEjN
         LA6o8sPiaaWNgy2qH8CyKxVybUQtVqTlT6srgtm5XzEHPhAxDHw1G1avzOBpEXVYi+pU
         UxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786519286; x=1787124086;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xbGxuLiKh0dpm3GTYr4w1LbBeL2dZuBbujKjAxwddLc=;
        b=NkOYkDoKNY78H/mnKLOX/NZkPnduudAylHW4AzLvPa6o6C+gBFToGQsVV/0bZiVgup
         YHTAKmplOUwJFMdMdv4UXSm3BdvOwJBGgnJAKkR00qWjhiIr984eO6j5LD8QeL7qzQGt
         wbcU6rhZbmeOvIOjN4otCrYRyxnNfbVLmDgdF3JkMy6LJwHLESh1r3U02lh3CJBjCSPW
         EL2/SujE6ZSf6MsFtQnZynbSab9lDkxN+odVGXHvPuv2oz/LWTAHRXP81tuBYoO4o4Up
         9U44OWoEZw0+5QQgNk8KT4/Uk9w5Fz27vnZnrV8LKFrFuhNtYQR+pP+b5kCihBwU1WAO
         3pzg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+9/sm3ySIwGRDyCx6byJvcg2Gmjai9Qx7wLb1JAJrAbuqmxF9gfL3ol6RWSr1b+urG6Tx0oOxljue@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSfdqIaOD1gSCrZX7SucEQikXqzd5UzSxff58oqgQnFn3fhsO
	riUDcYeu4Yezu2vtcQVEWgQUWcfvvByrW/oYaaKKfiJw1D/PryA3OgZ5E/00vezhi7y6wELWOhL
	UhRO+Yr4pUce7Y7GWyHQ3VrEVnbFQnJMSl+Pa7iQbyu2gXhucpVeSyU0=
X-Gm-Gg: AR+sD11ssiUKUIcq+Jc6VtUn4Bsy19Q6cLVAatViHc/pxXL0mnsQMLoELRXJzWK/gCL
	QvsiaS7F1quiRKYxzwx8z9fIAgpXSjt5D/TyU9QAkU2PYjyvOX4XTCGwiTY2i3Gr7xYyWDhGRgt
	szAlFx3pubqq9cpsqz0ECvLsWQPhSQlmKss7ffc5nqgd/YtmF5tcZvjpBmSELSyJOMcl8YYMgL4
	LEURhxU9UC9mcCNUW44R5dUSr7XkBkOHeXDEDh1H6a3tIzlHfT3t5kAw9lU1J0vCMBUQckutqsW
	Ct3If+ffOs1aKvH//Yx9Q/DB/LrJyotgzPfLafCZ3Vpbj3MaNpf4ehet
X-Received: by 2002:a17:907:8dcd:b0:c1c:4e36:eec6 with SMTP id
 a640c23a62f3a-c20f2fb6251mr100902766b.18.1786519286583; Wed, 12 Aug 2026
 00:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-b4-gfp_nofs-v1-0-c06b40354ec9@clyso.com>
 <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com> <5ad4cdfc709dbb58d17472e78d97bb8571944f98.camel@dubeyko.com>
In-Reply-To: <5ad4cdfc709dbb58d17472e78d97bb8571944f98.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 15:21:15 +0800
X-Gm-Features: AUfX_myhe6OHi8Jys9P3uUMdBaDxmXXiQFKh_yPjArdbwvZ_Mr2suwivKOMdZlc
Message-ID: <CAOJNxRJ2k+M4rbSaO5m=8Xr47pTJFN7SnH_FW4JC+A+Xb0gCCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ceph: use GFP_KERNEL consistently in __ceph_pool_perm_get()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Slava,

Sorry for the late reply. I think I just missed your email.

Yeah, you are right. Let me fix it.

Thanks
- XIubo

On Thu, 23 Jul 2026 at 10:11, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Thu, 2026-07-23 at 13:47 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > __ceph_pool_perm_get() has four allocations for building OSD STAT
> > requests, three of which used GFP_NOFS and one (the page vector
> > allocation) used GFP_KERNEL, making them inconsistent.
>
> __ceph_pool_perm_get() has six allocation calls, not four:
>
> 2457: rd_req = ceph_osdc_alloc_request(..., GFP_NOFS);      // (1) NOT
> touched by this patch
> 2471: err = ceph_osdc_alloc_messages(rd_req, GFP_NOFS);     // (2)
> changed -> GFP_KERNEL
> 2475: wr_req = ceph_osdc_alloc_request(..., GFP_NOFS);      // (3)
> changed -> GFP_KERNEL
> 2487: err = ceph_osdc_alloc_messages(wr_req, GFP_NOFS);     // (4)
> changed -> GFP_KERNEL
> 2492: pages = ceph_alloc_page_vector(1, GFP_KERNEL);         // (5)
> already GFP_KERNEL
> 2526: perm = kmalloc_flex(*perm, pool_ns, ..., GFP_NOFS);    // (6) NOT
> touched by this patch
>
> Should we change other places too?
>
> Thanks,
> Slava.
>
> >
> > The function is only called from ceph_try_get_caps() and
> > __ceph_get_caps(), both of which are in the user I/O path (read,
> > write, fallocate, mmap fault), not in the writeback path.  There is
> > no risk of recursive writeback, so GFP_NOFS is unnecessarily
> > restrictive.  Use GFP_KERNEL consistently for all four allocations.
> >
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> >  fs/ceph/addr.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index e2da3ab9f808..d2ac3df47e97 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -2479,12 +2479,12 @@ static int __ceph_pool_perm_get(struct
> > ceph_inode_info *ci,
> >               rd_req->r_base_oloc.pool_ns =
> > ceph_get_string(pool_ns);
> >       ceph_oid_printf(&rd_req->r_base_oid, "%llx.00000000", ci-
> > >i_vino.ino);
> >
> > -     err = ceph_osdc_alloc_messages(rd_req, GFP_NOFS);
> > +     err = ceph_osdc_alloc_messages(rd_req, GFP_KERNEL);
> >       if (err)
> >               goto out_unlock;
> >
> >       wr_req = ceph_osdc_alloc_request(&fsc->client->osdc, NULL,
> > -                                      1, false, GFP_NOFS);
> > +                                      1, false, GFP_KERNEL);
> >       if (!wr_req) {
> >               err = -ENOMEM;
> >               goto out_unlock;
> > @@ -2495,7 +2495,7 @@ static int __ceph_pool_perm_get(struct
> > ceph_inode_info *ci,
> >       ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
> >       ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
> >
> > -     err = ceph_osdc_alloc_messages(wr_req, GFP_NOFS);
> > +     err = ceph_osdc_alloc_messages(wr_req, GFP_KERNEL);
> >       if (err)
> >               goto out_unlock;
> >
