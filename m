Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615573A48C2
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071806; cv=none; b=M9Y4eZ2SzYKi8YxSKOIyxVXLLzC2CGD457DYyLhAdwrb3rFWfKe7L+QazDen41/IsE1wrWw7PU3VqkEXMP2SKqiS6b9uZ1dm9NcUd/1CrxHvxxqcAHiwWfdTDYTlJMfNsncfewtWcANle3NLLq5/D4Y7hVSb0Y+JwHYpz9iFy8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071806; c=relaxed/simple;
	bh=6YotnDwkFf/zQ8wTkR9pRjDXFbBT2w/nrwxV/UUvHcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9+ewZE7Ag5wIW15tc6V0Tg0rykcIqPQOVO5+aY5r6Iisjh/YnXsIE4q10c5CxysNceNrcC/IwEuoxhiMMIE4/gx1czbzMJHHeMkPDfCTASMKargxgI009os2smtnl9AnBoc0RpY1FKWgz9Ee9pPQvtM0Ye02C3TyxyBgs50WYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=iQ/ORhKA; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="iQ/ORhKA"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c67a73eb7so1724832d50.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787071803; x=1787676603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5IlKfqMSSjBmNjb78D1BFn6PS6i7cHQiXjw7BnmlgwE=;
        b=iQ/ORhKAZsOCQoIKcNj2YNBf7hbgYbj3gy6Dp2PrGn1Ln2lXDCjgxRYLJ36TP6RIvX
         qQ9iH2XlcXp4BwkWSnBPiEAnz9WaNVfl+qsjwT998ZnNDzIM/NDTKphUGs08FCwRbsg+
         UOuMeJFdPBsO/BwSGkZMu+KyogOca8mjTn21fMDJSYuCkFYP4+kVpAL4A/zstKl2ZUk6
         gkYwiTaVoRo4iHMJDtfhxSruYVOb9RIk3NLgq2Gnr6M6IGGGhrXgxfuvDqxeqlHaW9s8
         +/xCYOyZN5VP5gGfZEy39De9AeNJGGRMiBJuYSQL/f/gAkZHjO16qMoTjDHSwy2QfvBX
         SfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071803; x=1787676603;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5IlKfqMSSjBmNjb78D1BFn6PS6i7cHQiXjw7BnmlgwE=;
        b=L1lfPbhgl5l01Fvg3fYEkdAhtF4FKUAUcNz92bF+oEYYTKNHynXvMz9zOKDfZEkXGK
         YYMw9Wt/Ih5f6uSm+CgLmYraKnzgtauHc/6sD2oxlEwXRwIOliDQuYNjJrpaTYgMUFH5
         9/0akIls3/FbFY+9wbxW9FuLnDc76acyYbzWwVcpUvaNWDJiGHW9QF2VWZ6hz8QfztlG
         Z2tawOLqa8lfoz4tId4bqdwh1yhoz7wfXi/Brh/5xI0xaeWk17K0hWZBiKEgwRIMC4ss
         l1u9nkbFQVY+IaZcrJPvWFfF9+mw5F/n2DDJNPWbW76Dy7zmgQViKeYXBvoL403p8Cbg
         Cd3w==
X-Gm-Message-State: AOJu0YwDZ04mfvuaAbSdBPoj+pra7QC4S4PFCgO2K/4wAEYdJknx/Luf
	BWawMuBHmeoaEQ/DiftRVAGldP7B5vfO/h7gyKhHV8XeE48nYDlawuQEJ6mYBHH20gc=
X-Gm-Gg: AR+sD13wQprLaMKOY21liub3m6AonM6hbv4uQevH1eAKtEJIcZVWcdNgb9IvEPNuVYJ
	nqzXTtefM3om017fJC981vdg4b/tAzrHzx+6TikEGyIy+uFzEStUjlzwcBswaCyP1OPH/+TPZBE
	XiLkBUMtPGqrkdpytHkpSNe1g5lSadltrlmOUSz92h3y03flZF7CVZutvJa6zcHmBQd1PFhqqn4
	kflzlMOBYxVoQoSgx/lTu8WaOWuymVkf+iEf6QnMk/4e4TTBuqlMcl9EXoUEaCHY/JtqRfLL+nd
	JN/fe8vhgQgfFPb7sHsxBZ/hGyyyk2b2goofRfGYwl0kU15KdGsX+AVR9GJRR8HRtsGL09SHiKI
	yW6Kjg2TsH9eeG5e9dz4bmhRR4vA4V8G4k7i/+1vg/0N+GIl5iPMZVEGnWavjyGJIM41Yu8oQNa
	pUyPiTs1k7UCUeB8z7ZEjFSeUIoZeV6aSwrUlq3xrGOkc1X9hhKOocXRxIM3pWe6Y5ng0gETfFk
	R2R+r4eZpaCCoQKkzDaYO374T8YCcpkIIQqH6bWzS+73JMXj6S25flb6P12lYhpGGl6yoBN8yop
	yPScgWi4ToIM3wB1qg==
X-Received: by 2002:a53:d352:0:b0:66b:2bb4:9d2a with SMTP id 956f58d0204a3-66cbc4279d1mr2213044d50.23.1787071803114;
        Tue, 18 Aug 2026 09:50:03 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:b604:cf21:f53a:b4f0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47ee907sm2581675d50.21.2026.08.18.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 09:50:02 -0700 (PDT)
Message-ID: <43af4b0ebb1f3c42eed96732ecde768f88b6846f.camel@dubeyko.com>
Subject: Re: [bug report] libceph: Oversized front segment in
 CEPH_MSG_OSD_OPREPLY not in all cases correctly handled
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Tue, 18 Aug 2026 09:49:59 -0700
In-Reply-To: <4553345e-d370-4f17-8c4e-e3f631343a3f@tu-ilmenau.de>
References: <4553345e-d370-4f17-8c4e-e3f631343a3f@tu-ilmenau.de>
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

cc: ceph-devel@vger.kernel.org

On Mon, 2026-08-17 at 12:21 +0200, Raphael Zimmer wrote:
> Hi,
>=20
> I discovered a problem with the handling of CEPH_MSG_OSD_OPREPLY
> messages with oversized front segments in get_reply()
> (net/ceph/osd_client.c), which can be used to trigger a BUG()
> assertion.
>=20
> get_reply() is used to get the already allocated ceph_msg for
> receiving
> the reply to an osd request. In this function, there is a part that
> handles incoming messages with a front segment that is larger than
> the
> preallocated one. In this part, a new message with a larger front
> segment is allocated and swapped in for the reply message. This does
> not
> consider that the message may have a data segment. If the now
> replaced
> ceph_msg had data items, the newly allocated one doesn't contain them
> anymore. This may lead to the subsequent
> 	if (!srlen && data_len > req->r_reply->data_length)
> statement being true and skipping this message even though a new
> front
> segment was allocated to allow for handling it.
>=20
> Additionally, this behavior can trigger a
> 	BUG_ON(msg->num_data_items >=3D msg->max_data_items)
> assertion in ceph_msg_data_add() (net/ceph/messenger.c). This happens
> when a reply message for a request that initially contained data
> items
> in its preallocated reply message is received that doesn't contain a
> data segment, but an oversized front segment. This could happen,
> e.g.,
> for a CEPH_OSD_OP_READ. In this case, the message is not skipped, but
> processed. If the message is otherwise corrupted, or an error occurs
> during processing, this is treated as a connection fault and
> con_fault_finish() is called. If the connection to the osd can be
> reopened, pending requests will get resubmitted, which results in
> resending the request. During this, ceph_msg_data_add() will
> eventually
> be called, where the assertion triggers because max_data_items still
> has
> its initial value of zero after reallocating the reply message.
>=20
> This further allows a malicious peer to intentionally trigger this
> assertion by sending a message to the client.
>=20
> The problem could be fixed by also adding the needed data items to
> the
> new message. However, for a request that has data items in both its
> request and reply message, the normal way of creating the message
> wouldn't work, as setup_request_data() is not meant to be called when
> either of the messages already has its data items. Therefore, this
> would
> likely require manual creation of the data items for the new message.
> With this in mind, it seems simpler to not allocate a new message at
> all, but only allocate a new front segment buffer and replace the one
> in
> the preallocated message with it.
>=20
> I can submit a patch following this approach. However, I would like
> to
> clarify first if there was any reason behind this implementation.
> Should
> a larger front segment intentionally only be accepted for reply
> messages
> that don't contain data items, and does it even happen under normal
> operation? In case it never actually occurs as long as no error
> occurs
> or a message is corrupted, an osd request reply message with an
> oversized front segment may be discarded right away without
> reallocating
> the buffer.
>=20
> Best regards,
> Raphael
