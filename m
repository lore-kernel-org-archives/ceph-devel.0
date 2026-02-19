Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B14324700
	for <ceph-devel@vger.kernel.org>; Thu, 19 Feb 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493850; cv=pass; b=MilP7EsdUaKBsaZpJzduferh78wMrShAnhVmKvS672hzVIwJG4QFGNo+VmpkWqU0p4aZRnwrnmbuYsnQSLhIVZPL9JiRDnEzSNqEM8ntmum6wL5r29QjS5IAMoegQihy1D7aWaLJz4kma7718ZwaUBfgFTouvuOYqxNTIapdavw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493850; c=relaxed/simple;
	bh=NPSXSi9b9TxxjHxLZpUcRJKWrGeG6PeYyngk6bejy0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iz/xW1JQkZiHP4Bd6DK9nlJP3Dz3pPMUFACAB2C9qigyY2Y37Yw4YhNwEg19zIdVF43qkhNiA7JAXC+aZXwfxoc8JPVyVSEsk4okgB/oe7WBoRPAudbqN1X5qeDbLB9uhmmWENr3Fma1F0e/ca0yxr4OaVprhi9nuAvIsFYNGcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsvFkcIw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rOXIrnAJ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsvFkcIw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rOXIrnAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771493848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyo2TDLSBnm8RCUIl2jfZS6nvGZOMbEPzxbuvA9Ganc=;
	b=PsvFkcIwA5EjxvHHIrGVbqD6gWpxXl/Ju2VvX0rKbE7jdHEL5VCW0JTWuH0QpXh7fmxz29
	Ho2TIfA4AV3J6pQ47g67jvRNHSMkGN5uqN5Lc+aYkt2eJVW5eveyv5bI4tb+GWECcqOF+q
	9hgSTT3lqCz88mKhfoUl81AyBVOBJlw=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-BSTPqDFMPaiOHikD0fuf1g-1; Thu, 19 Feb 2026 04:37:26 -0500
X-MC-Unique: BSTPqDFMPaiOHikD0fuf1g-1
X-Mimecast-MFC-AGG-ID: BSTPqDFMPaiOHikD0fuf1g_1771493846
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5fde975e9c5so904045137.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 Feb 2026 01:37:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771493846; cv=none;
        d=google.com; s=arc-20240605;
        b=Dzux20js7paBJw6oYy5SUslsJ5iiZN4porHQZb8nvmILnniwqw2wM7VeasFi77FDaL
         sIWxrgpyL9F0ySzkShIvDs8MGQiu+Aqd4FDOrZmpF2ZlEckPy99ViyaK9YwV5G7SE9FR
         SqmwLE0JnPrYbWxrENc7BLvRNbK3l4Si1XidJVul+DS1DjChHIADGcXbs3HbjOsnra7d
         9YADe85KNw3WJR6RKghm+knoBarn44ntvG5E+uJUalC230/i+yuIQ94WNckeOzu3G5p9
         1wgF0gZD8ecqpi/kYMsZZRxCWZ6pi0WXherDSoQ9BI8+SIbiidTF2Ksk/YFi1mtl4w2K
         jcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hyo2TDLSBnm8RCUIl2jfZS6nvGZOMbEPzxbuvA9Ganc=;
        fh=HwFEeUdgrWXZTJJCzqHjh4WDkW+sCaAxVQxHpyuFfeE=;
        b=WtB05vaePnc7sdWeg4Z1JUi9b6ho2WYo/Xii63HWUkRf04dUjEEyUWgc28EF67PdII
         BjT53Rl8jawvlPf03AuKcgjGMbUEChLux7eboLk7BABG3jEmmwPw/DETM7uU3rx0pAIU
         E7rcoUCq5meNt6Ay255CEdMT/D+cGsp4edDAVQiBvegqqBj4pAad0hHxk24bnhVXkSEU
         1UUrr/WZJl4t2W42iRFzHI8AWduJQGiltGikwGBNM6aGenwUI58hrbd3hhPitzccH7xG
         IwXVBQNVA9MwF8B4sUxEDeTee44/OCIL/LuIcwvbose5N1MO9nBJAJs8vaWClYSw0x5L
         8FbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771493846; x=1772098646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hyo2TDLSBnm8RCUIl2jfZS6nvGZOMbEPzxbuvA9Ganc=;
        b=rOXIrnAJaYmxo22cqcsg3ad3f1HEobThQNjJ6Xy5d9XXhKwaLr2ZdDCriICXWy01ov
         CoC+/uPxNyJGpCxWO7/ep7KFJ7b/oxN7/c7f6UyaABUcbRjp/T7UbW4tMu6Pjrjdb2mH
         dsPHm1axmbLeXMPjknAb1liWSsYBg6PV+oz6DBpwjeOZTmDYStzlSx7xv7Aljgd+HbJp
         gB2YnLcX4f6eyX+Mjb+v6FaYSTKjF4gswViDLOIOXxtNrZJ3NhuwHJ5D9r22H/IkqYgO
         X/29D9esTUmiF/4gqPwljpwbMYqoQSqdN4bOlQ6qPNjr24omLEgl8Uo69iJrsQlkWzMt
         qVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493846; x=1772098646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hyo2TDLSBnm8RCUIl2jfZS6nvGZOMbEPzxbuvA9Ganc=;
        b=jmcwhtj837TVioNQJnTXCGC8C/Qxg2f6BubfDETKIrDqE7AbzWv4CNFI5/G2HvgX9c
         2plKvYuUEX3r9wpO1Yr25azFE5MEJYKasUoQz1v0wr0VDaSWrsO4zTqn4ONWU3Q5UTTR
         yeSpLqasbLT5UtZLRxf2z1ybp+eCVN4n818SUDPu1c1QCn/8/o+13mI08U+6W+aNiN4c
         p0YI4RH+V1QPrhT72/pw7iewrWotCtPXFpuNFATXmngi7ZH+Jp/5/oJ9w78KnzHma0Ya
         OcMOABwxPvQBEB12JaHXKZoobrqw20PA9rt83dLs6hEndTLhsRO9U0hMAeOe3mVL8CQk
         8MHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ikLoAmTZlyt1nJf+7Yp8tKtXS7Q45UKkIN1sMG+VOOMxX0o2GImgdbtA0dmJApuHnC8OXAYKOZSt@vger.kernel.org
X-Gm-Message-State: AOJu0YySY2cnkeoYAPR8shLHCd+ExY2ALD8gF2KAG2NuO1qVbqBzU1UK
	ZcF+ntv4sz8JFAcppKVISe4KH9w0n1BvrSAsxB0VbZeo3HTP5XsAe2NYoJeGyagGeFKLOnwlevW
	oGXcJDaFw6d4+2szpQaWmf9+QaBOw9tx5m0TMdJ4tJtOzqWJKuQ+/6jUs+z5jqiPXd8FwWXWu2A
	OXpC0ZLUiDY+NAW3qQaTGS0rPoqQBR17MS9RpwRw==
X-Gm-Gg: AZuq6aKqsSCg1vse1ZStbBW+p8Lr+staghDYW6epac+zpq0/mmi2Kg/t2TX/79De29r
	nw0DUv19+JnDspvxpuFabpln8MA5MfvqcCd8yppetQK028JNQWLW6KsdNr5yLPVlZNtqj62vdFv
	Z2Z4IYwtW0u8EpORa/BPG6hq0sEKfnkdVuASCcXD6bjWVVjtmQmS5CmZgSJn5HUXLHqdInrTguZ
	VAyjq1Bz3uGJo2V/Ouz8WuJ
X-Received: by 2002:a05:6102:d89:b0:5f5:5a45:ac5d with SMTP id ada2fe7eead31-5fe2adbe968mr5841248137.17.1771493846193;
        Thu, 19 Feb 2026 01:37:26 -0800 (PST)
X-Received: by 2002:a05:6102:d89:b0:5f5:5a45:ac5d with SMTP id
 ada2fe7eead31-5fe2adbe968mr5841242137.17.1771493845743; Thu, 19 Feb 2026
 01:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe346c26386a4fc85cfa27e669dffd13191e7ea4.camel@ibm.com>
 <20260218195738.49204-1-ionut.nechita@windriver.com> <aef4d7dbea2fe3301ac922a7a189ecc8c93314d5.camel@ibm.com>
In-Reply-To: <aef4d7dbea2fe3301ac922a7a189ecc8c93314d5.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 19 Feb 2026 11:37:14 +0200
X-Gm-Features: AaiRm51GEnBgOsF3e_sOTAwsw9WqobfzJ2VFTTJ0IIRFH_IIWnKfwycB6hq8Blo
Message-ID: <CAO8a2SjKw53e0PqGCBKOakpmMgJH_Ka7_o2uijBhcr5S7vEdRw@mail.gmail.com>
Subject: Re: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, 
	"ionut.nechita@windriver.com" <ionut.nechita@windriver.com>, 
	"ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>, "sage@newdream.net" <sage@newdream.net>, Xiubo Li <xiubli@redhat.com>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>, 
	"superm1@kernel.org" <superm1@kernel.org>, "jkosina@suse.com" <jkosina@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tend to agree here with Slava, I don't support any Timeout as a
solution before we have an actual RCA.

On Wed, Feb 18, 2026 at 10:04=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-02-18 at 21:57 +0200, Ionut Nechita (Wind River) wrote:
> > Hi Slava,
> >
> > Thanks for testing and reproducing this with generic/013.
> >
> > Looking at the stack trace you shared:
> >
> >   ceph_mdsc_sync+0x4b4 -> wait_for_completion(&req->r_safe_completion)
> >   ceph_sync_fs
> >   sync_filesystem
> >   __x64_sys_syncfs
> >
> > This is the same pattern we see in the original report - the sync path
> > blocks indefinitely on wait_for_completion() with no timeout. In your
> > case it's ceph_mdsc_sync() hanging on r_safe_completion, which is
> > exactly what patch 2/3 ("ceph: add timeout protection to
> > ceph_mdsc_sync() path") addresses.
> >
> > The root cause may differ from the original IPv6/EADDRNOTAVAIL scenario=
,
> > but the symptom and the fix are the same - these wait_for_completion()
> > calls in the sync path need timeout protection regardless of what cause=
s
> > the underlying delay.
> >
> > All three patches are now also on LKML:
> >
> >   1/3 - libceph: handle EADDRNOTAVAIL more gracefully (v2)
> >   2/3 - ceph: add timeout protection to ceph_mdsc_sync() path
> >   3/3 - ceph: add timeout protection to ceph_osdc_sync() path
> >
> > I've also added more details and debug information to the Ceph tracker
> > issue at https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__tracker=
.ceph.com_issues_74897&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMz=
c8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3Dty8gR4OjrwFXUQPjG9Dm4EapzO4Hwyj7aAX6I=
NwulJY0GjoU0pTf7khYkXwrksDT&s=3D3fOX8o4od1TodhJw8SHCNjR4huXJS6VsRFYD6791DWM=
&e=3D  - it might help with
> > your investigation.
>
> Frankly speaking, I don't see the situation of blocked thread if I am add=
ing
> debug output. It looks like a race condition. And I am not sure now that =
adding
> timeout is the proper fix. Probably, we have some issue that needs to be =
fixed
> and timeout looks like workaround but not the fix. I don't think that I h=
ave the
> IPv6/EADDRNOTAVAIL case on my side.
>
> Thanks,
> Slava.

