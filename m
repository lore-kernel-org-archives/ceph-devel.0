Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5354DBD88
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609302; cv=pass; b=QJQdWas/HHgq0k9iAV4bSKf4CpdjCVZnV/WdcH6RbyqhGehPmOn04RBQwsgbOAceEJCX4qYxn8gYLax+8TnVC+QvW4l6D1LquYPxQJUd8S7EJQtIZIcsEkFhmFtdOXf7hR54kHvrKbyqveZh+bhT8OhnFgRxm6k0itKY7elKgdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609302; c=relaxed/simple;
	bh=iXAMupSIbuFDpRaG6sj2HuLSF1UiHApeeOlEO/9IwTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZlO8dO9z3FSPephE5komBW15DGnrypTdwF+mv4osh2d4ec/cKdavpvNvJNNq4fdYEjujDU3o9znOoNqhWBsTi2ywSmt3oROSC85lBQSbfx7M1cDVOhihOafrPlN2c0JVznLRVlIQvVVnJwYG2cmb4gibezbyMnvO1uU9jCRZ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJkxaQOQ; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJkxaQOQ"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dbd25309f7so14559007b3.2
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 14:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780609300; cv=none;
        d=google.com; s=arc-20240605;
        b=YzfRNKpk4fS8TJqCtf8SfYhI75Rq9lTjBFZ3dM0FbXB70zZLz/TO/SJ7tFGyh2SrE+
         ng1uZ6P2jNtcSb74hb80NCXWIFpt35VyfJ1keVjfPS/iDEwXrAX8fjLMcUxUQtI3k4Eu
         rXfwVuR2/Jk02qb0nSQDO0Twihpgc8RUmtvTxUmP6HkUmmKtmNwjw9oNQgkHHxC+n6px
         hynulQdZxSQDmvPOjKzoO0SN6mPqnnaBXPlmf4ZW7EHYTbvYe/wUmBdJWF6chCsrFrjC
         eiAWr9OeBQkMPAZEkfxGxJ3kc3+zRAhozDncsVlCIZygRkKlYRSqi+iRynTcTDtuPnL/
         UmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5a6iXoR15Bod41NzAFYKOufFV1xEyLDe7ajdDC+X1kU=;
        fh=F5qrROMdmW1wjfo0toVixNezT1Ltyzq3tILs5ZOsTXs=;
        b=D9IE03Ditm3FbH60/K9u7/QR9CMtEJrMu+NsCkvnUsf4agKCps3lBXTMn1T02ioaJ1
         W4owM9YOyKRSxWYunsxBHRC/LQ6I0j1hDR2VO4t/ogEtsMqrNDr+QTwCfoHmqSWbeQvT
         Ooa9Tp47yiFXQmAEh3IobaqKgdBoFVMwiCWGhPKoLZvt4/WOK7BicAl9n+jOXwI6an20
         M49qaPTqDsBIjUJo9Oix/SOuThDchmgkblBtY1dfJhUan2mMhgoMSCsJfWpoUrefXVyf
         H7M90q2Oz/Z4RdSKtF8Cq8TH3zqze2EJikoTd0hXVT3mHZilCb1ALKONE04bsDMjXucS
         1YVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780609300; x=1781214100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a6iXoR15Bod41NzAFYKOufFV1xEyLDe7ajdDC+X1kU=;
        b=rJkxaQOQTGtX2z+PwMhJ75TUeg7e/O1Jr8RCZtwZc1h3CCnKHIJgkNGUXCqEYQSryo
         gJVp4tm+MLXK30k3JzPpnEN32vNJWrosXuLQkrS77CTtxiKxwnrvoRXGftMsxR8YoHGh
         QMfThZV3irr6E9CSkXSb/wSw91la6Eess1OmhF9O2I/bADZpTWOXonsxH9/u6bN5ECBq
         77FEUu9aKgr8xJgZc0QKfZeHTvbLW7GUJFN8X/TzUlXBEsenP8doy3A+PtytQexEcp+w
         qlTUM0OJmo6UtQR8PiBRwSuYBcrFS1emZzVRJTN11KPiQPbv2oABo9BuG8gToRIYNHc4
         decQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780609300; x=1781214100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5a6iXoR15Bod41NzAFYKOufFV1xEyLDe7ajdDC+X1kU=;
        b=bhUUtFJu6Fwv5WC/Hbc/El2oxUtQWTWgQe0sS440YKahRGKAtYKi0a1IRKjyAKxSY/
         7Za+viUlLGnHyeIRpLkjxQFfwa7hDvpTZvM01+C3/vNo03kvhz1RJRfT7tCzoi4lNATF
         qf8wf4RGmkKxBq/MnoyUQBnRywkml+JpCJS5NgXPCSH3oxOUrHImMz2Zq6c2eYczovnx
         taj2uIR4TU8ouYJBSklMq3/l81BU9pu3TU4taASxvlTRMTGsthPUm5DlHindQgVYkIB6
         repzAJjlZHDrJIgZJVZFAEKAZaogp/ADN+GGfEdALMlFHcltt18VS5tB8JPcqXIqvoY9
         Yg5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Z6tG2pRLkHAubyeVb55qC5yn3x5fl6uv/aSrfWgKuQMisrmt6E9JT7b6F9mtn94qxmIShf0yhwhy/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Cij7rAijZbiBWUaRjS8vIafPXih/VH+PXwjy7GuIj62U5/r3
	YvWaTBwckz/n551xKDTcO8wLws2keoZD9FG2At+GP3wvrLuhhsSnWR38CIdPDY+orgaA4pKv/J1
	u8LWGEbStZjCemqXpOoxMRt/O+ejcdTM=
X-Gm-Gg: Acq92OFzbDX4ulTBTbsxKBI61ketyjcZJ2PifqD3Dg0a/u1EgAOOb07h976EWfVYCK7
	IbVAhPmxGJ/hv/aHWOsMLMqcYwA/orQK3I7V/3I6MWERLyowKMBigeY0Goymg65q6cp3wbFky/g
	RUy1LoryqwkwohbGAD3je12n/LtRqcqdTSiLzebjC9qPoL1J8+sRzJ9XtH7po9OwicdPrfJiXdY
	aAo85r+2COKct4MEPVmfT6vxL66LLamH24NOf0rGs/JKlLEZa4OPMom6DTF3G1h3r9XGRLsX/Nk
	S29Qk51NNMArr0JXuh8wiQTBWgbuk3EZB/IbhG8hZ2xsSG4=
X-Received: by 2002:a05:690c:4588:b0:7ba:f3a2:551d with SMTP id
 00721157ae682-7ed0de8bd29mr7464247b3.15.1780609299748; Thu, 04 Jun 2026
 14:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780596023.git.michael.bommarito@gmail.com>
 <8f25e9ac54cb3c408d061993a5a797186aa50506.1780596023.git.michael.bommarito@gmail.com>
 <c3d563d16537d0bdb03f4d4b7c677de28ab33223.camel@dubeyko.com>
In-Reply-To: <c3d563d16537d0bdb03f4d4b7c677de28ab33223.camel@dubeyko.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 4 Jun 2026 17:41:28 -0400
X-Gm-Features: AVVi8CdFFnzaP53-p3KPOZKBgHntpFfutFMtNalE2Sk5GJWjDeGUlZAhCA75yEM
Message-ID: <CAJJ9bXyPgNzRRPApmky9FSpAZwao0aG8bFM5gk+ukrBKdM+38Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ceph: cap delegated inode count in ceph_parse_deleg_inos()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 5:06=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
> Technically speaking, I am not completely convinced by this limit.
> Also, this limit is for one single interval. But if attacker tries
> multiple times, then we can still have memory pressure or run out of
> memory. I think we need to consider more robust solution. Could we
> improve the fix?

I looked at a per session limit but the lock management gets to be a
bit more complicated.  If you think that's the right direction, I can
implement v2 based on that.

About the count, if we move to per session, then do you agree that the
right number is based on some factor of mds_client_prealloc_inos?

Thanks,
Mike
