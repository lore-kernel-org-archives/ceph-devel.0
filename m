Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7F3B4E8A
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837446; cv=none; b=WxHmXV0XgdjcX60bf5eCQWxTBPBLQwYARG6oWPIko8GRJa3pcIFxG++EEfTV2ba0zWcmNODFmYdNVzic4Bly6itvc9mxyJaWftm9tuTbwm204PKeuo6C9kpv/omWn2uApj9UzLh8NZL6RouZOBSNjiCUx1k1W90e/0fv+2ij0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837446; c=relaxed/simple;
	bh=CJ9kELUokqPbctMihFyoJTCcXZ6c8gKjxKlox2Pf/uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Np+WtbP3r8PDJ2EZHY9qiaZ17uvfiHdPFno6UcVVsnTcI+nLpVoW8GqsPB29uJiuDoRVjj9ZAoAifqdKF/P1ioV24+BbFnvJwbSSGHmnQANOEemWKrlwkJV4KuITGvG3HIzlWKNDZylq12I8jaWvymtxgizLXXm6MXNA++yfsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlmvIYu4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDBPRkkd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlmvIYu4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDBPRkkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782837444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpC2l7uReQ35ng7nLpWrk3RCBkRWc2JKSciYAXld+rk=;
	b=BlmvIYu4aJDW9iu4C4ThrX2afikJya89fFLTBahQkr7eJUkYZJhiGFEWFCddbWzzKWY3Ml
	Eo12OzFY1K5KjLgl+aMNZzmiivkZyVem/Wn8knHgTA1led2IsqmP0yw0gmjdigAKu5Vp7K
	rkbrhH/HfHzmi1NZnAqcbjkx8d24bR4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Vlrh7GfUPZ-xRcJC-a-Lzg-1; Tue, 30 Jun 2026 12:37:23 -0400
X-MC-Unique: Vlrh7GfUPZ-xRcJC-a-Lzg-1
X-Mimecast-MFC-AGG-ID: Vlrh7GfUPZ-xRcJC-a-Lzg_1782837442
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-495b8b30310so4099647b6e.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782837442; x=1783442242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpC2l7uReQ35ng7nLpWrk3RCBkRWc2JKSciYAXld+rk=;
        b=EDBPRkkd05SMiZd6KF2CgODjslRPEAcghWW9/zrVb+mFqrwt0wTGGEk2i2T7yenOim
         hErGRS2eppGmaUPjL7yb1S6ksExT9AONYW3eCOde95ASPe0CnOukhFe3FdZpdbTNoUl4
         kL2/E4yseBSwZ/2MEz4R96XNno58faquKiJCAHgLgafQ/Qu4/7DMDlF9QS81wsYoPAus
         K37C0db3/XTJL22MHQoV1ZfaBdX5eqJwqKdlyXTGPtNgnS9zHiTV/tg6SD7o1ZlNNXeD
         d3JXeGtCaYxJ+fUHR60LabWFzfnAxB6+kNDu/9E46ev0FJ6MR5pNeVWPkr2vDydhRrNh
         xQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837442; x=1783442242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpC2l7uReQ35ng7nLpWrk3RCBkRWc2JKSciYAXld+rk=;
        b=gSGmZC4i+5hAotOdoOiuJ0vrBepQFIMeZkslt/nlIUS7qIEmaanFOV3qgx/Pv/6bLH
         ih0buH7rOO9JU5XzdNZ9DmN54syh/9aUXYLgmwlCu0/LzNLecZQ58Jt3PH6USjtoEatR
         oXm9+8iST0rrwupcIr8fUTZc3WRa6q8S3sz7NdEub36tWjG/uOsOT5eve+xktJuRSJFK
         c0BcnTGkN5QgHjsgEqW5IpJ384R9qBcaXDJZPcukAFYYfKb6e/7UUxP5+u3mD23bAzc5
         bbiaONe1l5IgWd4YdJ+iIBypgrkFx9gt3fadJEDj64sV00NNwhrLoGunl7vyK8z2v+5O
         SvxQ==
X-Gm-Message-State: AOJu0YzEeFkvGk6h6pJZDSm6CP/kZ6EcWPBNanXpTFTtRNhQX1RvosTJ
	ZVYvpaVtLcSjoKlB09Hss+fV3rZpLfm6ChaSebskDj62FBTd0YiR7F2IxfQRbKvkZTawSsgsykW
	yu/y8Gk7Tnlot7OdvMJo3X7hEcop6U5wBl324y6sf45UpcChyt4br9Yr65ii8rtjz0xk5glyiFw
	==
X-Gm-Gg: AfdE7ckSvieUmwjjOVZ0YtfkmHU7stIt196gizCLtwdTT2KiA5CGvhhxJt/v3NdNAOn
	BVQufnAk+cDDFz/J05zrrl4uLHJZFkxo8S4oYwgXB0PGCbyFL9sncvaGAcDaWIN+ZY+8gUiOoIq
	F9+6drb7pN7w6/ICOpQrZUMQH26nBi74wJx55kaqkikZ2jwUWLWFw38rCzidjM/+mCBnvHTcVRt
	ibeg4hs4A7apQIoNfehcdpjbc/md8s8qDbK8o3+Ci9TcVxuZUmq3E0pY7YEchryy3d0Eyd3IDUx
	+RRjgi2QsvGKCpbNXyj/9Jw8EzdB0I08P87sZQp4u8hs4NqLVAh4rWgmtmST3upZI7LQlUx98Tz
	e86D4VLIPRHkorE7UcR29xZbwxSKEE3DfJTea5Ijdv2bj
X-Received: by 2002:a05:6808:bce:b0:493:ecb:6b0b with SMTP id 5614622812f47-495ead293c9mr4656612b6e.7.1782837442272;
        Tue, 30 Jun 2026 09:37:22 -0700 (PDT)
X-Received: by 2002:a05:6808:bce:b0:493:ecb:6b0b with SMTP id 5614622812f47-495ead293c9mr4656587b6e.7.1782837441813;
        Tue, 30 Jun 2026 09:37:21 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4935536690esm8714169b6e.13.2026.06.30.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:37:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: rework behavior for not recognized tag codes
Date: Tue, 30 Jun 2026 16:37:15 +0000
Message-Id: <20260630163715.432998-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526223829.1385751-2-slava@dubeyko.com>
References: <20260526223829.1385751-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

The hardening itself looks reasonable to me, but I have a couple of small
comments before adding my Reviewed-by.

The Fixes tag looks like it points at the msgr1 field split rather than the
commit that introduced the WARN_ON() behavior. If the original commit is hard
to identify, I think it would be better to drop the Fixes tag and describe this
as hardening.

Also, could you include the peer identity/address in the new connect_seq
mismatch message? The nearby protocol feature mismatch errors include that
context, and it would make this useful when multiple connections are active.

Splitting the connect_seq change and the bad_tag ratelimit into separate
patches would also be cleaner, but I don't feel strongly about that.

-- 
Alex Markuze

