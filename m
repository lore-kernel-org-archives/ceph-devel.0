Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528459;
	b=MzkeIDNsS9NJOQai5JWvJrqqrZMZFo548BQ3El+SWLtqJagXee7+Ff4OmwQHB2iLNgNX
	 KMgFZaY4liw0uZi4wozYduc+66oO5XMpcAswubfSMHU8kxYcRPiyf58Wa4B7REh+VmMzf
	 m0U9q1Tg9oImzDwCcilMrjV4y9KmnIXJPavDrq+4tWW3/Pm7piy6IZ9v4KrAMGBZFDy/V
	 byEPmZTwcPQ4qS4M81NiVv0LOBweUREqb/XCYIrNWvaBU89BkZqD8u1Dnw60H1axCAsg1
	 N7XbANWmnxR2A3DHJyNaSGqLBTeD1/rf2oGUWxufuJXDinv1O+ENJXiFqpZyJQF/4Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528459;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=BTSuTvabptufqbTtra2OQo4b6Mm8L6DWa02Gs4EF2GI=;
	b=lBkuFPrtAvWLDW/7BgZt0JSWlEa7TJBJx2HaaDXQ6z07GYrMjuhoQHFTJDsgZoXlKTcq
	 8qQJwKa3G+EKCaojW2ldA2SYEV40Q/Y6yxNY6P/wybmJTaSzrpvrQUpnm1G08nVnfVkMW
	 8lgFIEjmAHrn9yH7//qlIfI6Lo55V2FpaSadwQavif6bpZxDdHFOZdEDRc2LCIl/sLIKc
	 DnDxvZSujVYkcW++oNR5NMSUlk/54SwCMAUn4c1iOksYfWdti3zb62jrYkHfdtfBqS6ff
	 MK4zacXa++NqLuyc5Pc2+wZ1Bx9ZMx/dQHGP7xxNkGMSbt4s99StPEDqsd9hfjMYhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G0smjJGS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=klSRcYDL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734A606A322
	for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 13:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4734A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G0smjJGS;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=klSRcYDL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795528458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTSuTvabptufqbTtra2OQo4b6Mm8L6DWa02Gs4EF2GI=;
	b=G0smjJGSyEPFExvkFxF2R8SxPsIEBG9F4iEhIk2VH1CSlJsbgC7F5XkXQ2cJsyfvimbxFN
	paHnyID4WwbYm+LIyrS/l07yVPheW55u1E8b0qokUmpEyd/iISF91z5F5eEHqSOpnyVS4W
	9u6vxjiJAp027y4hlxvyXOK0yIrSZzo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-X5jz5jdQN6SBetfqWJjJCg-1; Tue, 24 Nov 2026 13:54:16 +0000
X-MC-Unique: X5jz5jdQN6SBetfqWJjJCg-1
X-Mimecast-MFC-AGG-ID: X5jz5jdQN6SBetfqWJjJCg_1795528455
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b879462421so5345521a12.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 05:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795528455; x=1796133255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BTSuTvabptufqbTtra2OQo4b6Mm8L6DWa02Gs4EF2GI=;
        b=klSRcYDLBO18m1k2HJu95QlxqagYzaq7dvThtg+gCUK16pos4/R3hYLFyOe2I0S0Fk
         BUSHBLjR4tculnF5tpEjiETOHBLw6pg++jvybQqDdJkL0ZTDZTKW6GF0UvnWnVf6esXn
         yKsXnjQJZoQbITx/OpgtqF2qUK1MmrLT8UqsiPUfQ4XuzkxC4d5nNo10IjuW2KOw+b9z
         avAk/KNi1+GjkaoyTBEpUnSLfW2Tur2eldMP/ZJwIErsvAc64pliuwdGXwCkuKl9kjGf
         cYamUGzj6nqpJQgiVS+L0G3GYMC/Ly2CCX0aV5mpFJqkHmY/qEchNgOD7C6/c3FEPE+c
         qi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528455; x=1796133255;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTSuTvabptufqbTtra2OQo4b6Mm8L6DWa02Gs4EF2GI=;
        b=xTXd/rl4OqXBPZK2N260PL5DC7kRwtKCA1nTawUgwuFYOs+uur6nhwi+kBm3xVAy4a
         fkVENTq8pacZJVejrGYKBvOEb7Tm+WjSDPgFCt2W5rFk5BnKT9UxE5272MK3ffkMfyip
         nogbjJC55lgSA8vNNMy5HHijVgRZr5vlGr8TbL0rqNGMNdZ0k1n31v9ItDh6C6Pd0ZGI
         RaYxzOVhzj+z+9FIiYXLMFThlY4hd3HuL+rjIAXYqG7yiJYelrYiNUtn19QeYW3qgFAE
         Voiv3KHAB60MJrrhQVC/p5KM7YX75LqQxqs/ka+nbLnJjlNFb9QOyn0qvt/cusBmbGAU
         KZ4g==
X-Gm-Message-State: APuU4Z/y+FtqCsTaIPpWZHLri1a/23nyxO0scuB3rftd6uXb86oFCvFF
	YNeW5Ot33NNBslpiHyi4651f/EtchYoLQ4q/S46gng3TB/vbvEqKLpU/mL/N3+hmrIaCtuEYKAc
	tN7s3nYRLEaI1oJyun55gtrVhVCeiepjKuE5DHHOuKEFWFi1RWGv8G/HwxUezgCE=
X-Gm-Gg: AZFdTZemqWFHS6R5utgFIh8y44gb7TE6RTHpAaAEQFxEi0tzIDnGaPE0/rDsQ11FFCQ
	t4viYq7l20tafypjP4pdm3VHwk6svSIL6CV2XzvNK4w8FNQStVy6a2zbk7FjrGH5U4ZQjjhmBUK
	e6AnT8AietkFcZKAcOvvWMX4uOmSQMzO3PqkOlO7ma7RwX1GJqLMet6YMim9KRlJIMXL1Pmfv3W
	AOY4NlCqDPuUyEtjwd3jq1mVoxW/z52auEJifLoFvuneW6gt459/JlJgfelPB4TGjdPopUa6Gkf
	nJYLOH6iPOeqTyvhQAl4C0aYff/xIWOekonCmZyXj3t5JyOUPlIKPLeFyWa+8e8vsKOVXjGl2xX
	g0Avfwli6rZupfQh4IkbC5vfVvYmWL80yvQq4R4M2CcLiTe9V/ikLyGJEto/IqCLN5Rwc5v5YhS
	vwIYvr9CloUkfOhsMLyv2EzAm07STbpRRPf0tfl+czTKSOekOtplTzYjACEJa0zlIg8Oi0fbgZr
	4bHRR4AWZj/4z3HN6Bc/YI/dlNX3afz1OjbwuwbC2MgAYmFvHHP
X-Received: by 2002:a17:906:1651:b0:c50:6222:7b1c with SMTP id a640c23a62f3a-c513aaada4cmr976109766b.23.1795528455119;
        Tue, 24 Nov 2026 05:54:15 -0800 (PST)
X-Received: by 2002:a17:906:1651:b0:c50:6222:7b1c with SMTP id a640c23a62f3a-c513aaada4cmr976108266b.23.1795528454791;
        Tue, 24 Nov 2026 05:54:14 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea1fd8sm509052966b.38.2026.11.24.05.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:54:14 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Ionut Nechita <ionut.nechita@windriver.com>
Cc: ceph-devel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] ceph/libceph: killable sync waits and faster recovery after network disruption
Date: Tue, 24 Nov 2026 13:54:12 +0000
Message-Id: <20261124135412.2204051-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123080152.163172-1-ionut.nechita@windriver.com>
References: <20261123080152.163172-1-ionut.nechita@windriver.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ionut,

A normal final unmount calls sync_filesystem() from ceph_kill_sb(),
but ignores its return. If SIGKILL interrupts the new killable cap
flush wait while the MDS is unreachable, teardown can continue without
the flush being acknowledged. If the update never reaches the MDS and
the outage lasts through session close, the client can purge the flush,
losing a previously successful cached xattr update.

Please keep the OSD-then-MDS sync waits uninterruptible during normal
superblock teardown, including both sync_filesystem() calls. Keep the
sync()/syncfs() waits killable outside teardown and preserve the
existing forced-unmount abort behavior.

Thanks,
Alex

