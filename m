Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5B4C6EF9
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863745; cv=none; b=T+U7CWvG7vIC7T+pRg9ZXEGIAX4M94X3wgl7qftOyQLZnZ4Y08pg/nUUTbBsrikMxrIKHHp6xEHnSrE62ZgbK+qc4+0o2pTjX/0/BG1DFCDp5yWr9qMiWMWRYxRVN7JeprTSaxu85NUI3IRLGIkJUrKPRjTo3wVgRB5henceaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863745; c=relaxed/simple;
	bh=zV0tRYhjEYEs+ktSl+Z7jsXNU9jQo+1GWeZ84IBSnrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3i8eX2mMMm6ktnszDyMqbjeTY0CE7g0Rg7YFWjGBZ0UO6dPKBuXGpanXDyMd+wexYFosKUIVBYq8drxWcMq5MAQ95Oli30GvlzyDxEriEddUy4wBA4H7Y1M1Q9pl1F3lkxgtGdPV360p644kz+THJnqHNYfn7whOGJsQUkOlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=OJdwRHry; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="OJdwRHry"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-654672a6d68so95205d50.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778863742; x=1779468542; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSgFZ9L/M/K3Vw9fQOZwgrv3KdwrF2juopKREfk3PrE=;
        b=OJdwRHry+qQN9I4k3Ghg99SWmJih2ez33uYXAoPy4t3ruKY0raMn13HnhvXkjhtnDM
         BvlSDe5Kuk6XPLYKSEOa1rO8XSwnhBfCaaLS/r/w09E8WdgJ+7g4gLpwwau6PMPQXJ1p
         jRMOZH2TLD0ICsRy3dFv9HR0/yaWY2we0eksvo3dkaxTkmHJbIsay4jlf/lQCx97+X1C
         ZwTaUSaoQJy3IQT6zb5SXPK2+6JS0mXC1CpG9neghnk6Ay+yVJIb+p/lo1eoOEZpX1zB
         9OKLpnguz8AKT4CP9i7S/OostaSEsEEBeGyTa3lYekvoA92yhWalamElpS9CocPeM00w
         oWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863742; x=1779468542;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSgFZ9L/M/K3Vw9fQOZwgrv3KdwrF2juopKREfk3PrE=;
        b=OtZf07popTJBuRsStqFhZ3Qig4hsmwc4nCsLcC5Aorum97shslou3R7RdqrGPhVcgq
         EjIDktLGv9qgc9k5udYbDJjaNI12g8RnySG0+bf7aL6HA2HTtgI7WjJVsbHE0TUVAXZY
         rnv6ih6GVohT30DgqCLIfracWT6NOp2/wEzwX9uEwB4yIt/qyKuPZ54+CFJgyoGF6piK
         uVIKV67NdNGY+4sa/cY7yG/BnpKGEwHRnzDGZr0W05i8gI+4eqAnQEfU9xXeCUmG3R8P
         Q2dlozX+yxAZf1A/OrZiX9dGiBOxPdu9mQbQ8UIYZ7WpH9VbpgdaT0hHnfs4Ddl1Lg++
         xxOw==
X-Forwarded-Encrypted: i=1; AFNElJ/T6skMIWtNaUVkKwPYf5xKCu1WAVJ3XRjEE+d6kCcGcrtOfq/Tsg6HL7J+IxkZugZPVG6KIXoSNs9s@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcAqq5CLwmsqoewudeFhV0fBsIvg6yjgqkA89wnTS6vZ3ozw9
	Wl29EoOkdKlBzUTPLzX77cFJGF0xpFrbnufTpscKf/Ix8z2U0JTVDq9+zWCNMJm07J0=
X-Gm-Gg: Acq92OEz7XTge1KFvfYwJ5l21U06XrreKGE9hehqR/7sf/cwjAHDiF5iCMEt1+wNRYM
	IrfJCMJ3tlJOyzWvHQCkCXnf95mzWpAD9SFEUCLJwAw89oKlMCsKbvkW+Q7BbXb2HDYwRWuWpZH
	uop7jSCpiRzMDsBJsliIw+/eSbiU58oVeL3i0fwLFtgYPsi5so+7gVEaQ9gTQlHPsnfjBLCb02+
	LhoYhHJ2K9IoJwnHgnahiB+XKAbqf9uhCF5fQ9axYSMd37WawUt9HiC6Zf2rN9UcHVrBCKjpcWh
	D5ml+gK0OYJYiQfoNfIqTcpXiSCVtgDkZuSHICedJ5RiyYUkP+AFvNZjq/8S7DmiYSf30XbFhvg
	k9LdhM1ACsVLIzfE6YgRGOCKJ7TnLLqs+F3bwzeFV6tO51SOki7Pu/GeAI4u1vGPoX0Cxt0l2wT
	5cCE9rwofeRCU5a9I7JfHfMzxU3vJGKR23GXI2m2z8XY+UPEA3uJD8xcUMUsejREMi6YVitFGmp
	3gpp5T3KjNF/RYU77yadug/6ZGnKSmCmmJVK785E8qcKv9nVedpEjPTc8w0GboAUWYN
X-Received: by 2002:a05:690c:6b01:b0:7bd:7d69:7658 with SMTP id 00721157ae682-7c95c4ed051mr52959477b3.47.1778863742331;
        Fri, 15 May 2026 09:49:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7ec4:8c87:a1b:125e? ([2600:1700:6476:1430:7ec4:8c87:a1b:125e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f55bca95sm31402817b3.39.2026.05.15.09.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:49:01 -0700 (PDT)
Message-ID: <472fa2f69fca6eed081417517f0ba2c5d00602c8.camel@dubeyko.com>
Subject: Re: [bug report] libceph: out-of-bounds writes with oversized
 monitor reply messages
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>, ceph-devel@vger.kernel.org
Date: Fri, 15 May 2026 09:49:00 -0700
In-Reply-To: <3f154565-9f37-40aa-b34a-be6f5c2b4463@tu-ilmenau.de>
References: <3f154565-9f37-40aa-b34a-be6f5c2b4463@tu-ilmenau.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

cc: ceph-devel@vger.kernel.org

On Fri, 2026-05-15 at 15:29 +0200, Raphael Zimmer wrote:
> Hi,
>=20
> I encountered a bug in the libceph module. The bug manifests as a
> write
> buffer overflow when receiving the front segment of a message on a
> connection to a Ceph monitor. It can be triggered by a (corrupted)
> reply
> message of type CEPH_MSG_STATFS_REPLY, CEPH_MSG_MON_COMMAND_ACK, or
> CEPH_MSG_MON_GET_VERSION_REPLY.
>=20
> The problem is as follows:
> When processing an incoming message on the monitor connection,
> ceph_con_in_msg_alloc() (net/ceph/messenger_v2.c) allocates a message
> by
> calling con->ops->alloc_msg(con, hdr, skip), which translates to a
> call
> of mon_alloc_msg() (net/ceph/mon_client.c). For messages of the
> aforementioned types, get_generic_reply() is called, and an already
> allocated reply message for the given transaction ID is returned (if
> existing). These messages have a preallocated front segment with a
> fixed
> length of 64, 512, or 32 bytes, depending on the message type it was
> allocated for. The actual length to receive into this buffer is read
> from the message. If this value exceeds the allocation size, data
> received from the network is written beyond the end of the allocated
> buffer. The maximum accepted value for front_len is 16MB, which
> defines
> an upper bound for the amount of data that can be written beyond the
> end
> of the buffer. This behavior can be triggered by a maliciously acting
> monitor, or, with a connection in ms_mode crc, also by modifying a
> message in transit. However, it requires having sent a message of
> type
> CEPH_MSG_STATFS, CEPH_MSG_MON_SUBSCRIBE, or CEPH_MSG_MON_GET_VERSION
> to
> a Ceph monitor previously.
>=20
> The bug can be fixed by adding a check for
> 	front_len > req->reply->front_alloc_len
> to get_generic_reply(). If front_len exceeds the preallocated length,
> the message could either be skipped, or a new reply message can be
> allocated, similar to how it is done on OSD connections in
> get_reply()
> (net/ceph/osd_client.c) or for messages of type
> CEPH_MSG_MON_SUBSCRIBE_ACK and CEPH_MSG_AUTH_REPLY in
> mon_alloc_msg().
>=20
> I will send a suggested patch with the second option in reply to this
> email. There is currently another patch, handling oversized mon and
> MDS
> data segments, that adds another similar check to get_generic_reply()
> that is not yet on the current master branch of the ceph-client git
> repository. Therefore, I based the patch on the testing branch where
> this is already applied.
>=20
>=20
> Best regards,
> Raphael
