Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70441DECE
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432032; cv=none; b=P7d6ciHv2mUB2uvWuo2A5NMk4CJo5YaUFx1wVQCO6N84Lnk22Ubuco544yDUmMlfaaC52V+vDvTWS0Udf1Qwf75ndTN/IRPJCGbErskz8CwL/HIiLLGFqafQSgcifa55tGR07voCHhrHyZbSYwMJNyS4RRXVLBuXZfyv7W/qO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432032; c=relaxed/simple;
	bh=onU/5/kT1hiHwApG8rwpT3PI4XbL2fj4IPsBDnGXyqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFSb5nbEZK8tPIkDzV/cnBLHJyDU5fyyDvQd/cuoIgkaOQcdwysPJt6Kg6l63JYWa04I3JQFe3GxYjaPaVzIA65xRD3wDf+/kWgOb+FMTDtjGZeMxAw9U+9dvBVF8BR542zZbhVElKHgfPJ4YuZd5ItFgp7MiBC1VCUJVLQeayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcBIeXxO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNmG8CeV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcBIeXxO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNmG8CeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783432029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=XcBIeXxORbYdoL7LNezSt3W/Ed4gq4OjxBn7KY51L2ub3HQg+meqqEAsdmrV5BOkKsk4uD
	dyDq7Pf9b6OrmFB1q9WONErjyyFeW3QzpXPeDHtgzgyA6NeGFTw5zSHM7ALDxml7mkStge
	5BQAPfdgBkcY44CQSnvSaV+cUdUKCTU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-q23TcsZHPoqw3YvRdRHJHQ-1; Tue, 07 Jul 2026 09:47:08 -0400
X-MC-Unique: q23TcsZHPoqw3YvRdRHJHQ-1
X-Mimecast-MFC-AGG-ID: q23TcsZHPoqw3YvRdRHJHQ_1783432027
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c12690ff1fbso68411566b.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783432027; x=1784036827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=SNmG8CeVlZPxeF1Hg908yqIrpSbgcGw5K9gBvOsLSOdfu3OhLy+7eIkNj/j73vPr9G
         b2fgE/n4o8NZATTMQgDxGdIw39QuY5JBV8k/8WauE4+qwyl+MHacLENXNbPXRw3a5h9T
         Pq9PQB/X0xI98Ds9A7JEJReuDAU1rTgHFVNqFjMSgSLukAgyJZUHypZARWz4J1YN5prm
         /e12ER3YbNS2jtkIcvz7ba/2BbfpK1yWWF+TtYJ+OpOIlSjyqyB1mQgMaAvMzo7Ck5fr
         CNWJ5KZItq8quVN1+WZJR9LLimKa8pX+g0nxRq9zfCsseo+905kecZLGFAPl8eOmXCcC
         CKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432027; x=1784036827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=bTe57y/0yKp4c7+Kf5Qwjoc3HdH3LliUYb9QuVDYc3khbTWyAZEOoIJFvTKyA8Rhn+
         ccY10W86sQoAOb1IjDxtUHMATJcIEw9Wgz415yg7O4DyZ4kD7p+Ap50figLzwjn3LrOo
         nFaN/YFGiZDu+CPMPdXuwq7RpsvwoHTbUWE6RUqpNEjd8bvevWYV+fMvWjTQ/uTzRRi4
         T94BGB8Ct0OFKm5T1jO5FwdUqWHhzPse6Lt+J8XKcfEIDmZu3IJ32lUj++s8ATCftN8z
         G5PrbAIufgC6M12mI44Myr10GCxaX3uHM9rZV+W1Pu5A5nBQgDI8KvqcBxoECYUhl/gz
         nfCQ==
X-Gm-Message-State: AOJu0YyY7K3GRJOf4dz4z8VYRn8Bl+cg7roxNAg+ipHBgV5adgTN1VFA
	0wzLG73/+rBP3YD2BVa32lp73nU8IKQtbI+H5UqmF3egN0yi8UUp708XPku2yEi5TeQJghi2nv6
	m1ifeJZTFJjQNoiJX2euqp8JOLz7K7j6MnDG2S4RDNbCPi1JhSK198mY6r87I7KbNMNkfHKhG/w
	==
X-Gm-Gg: AfdE7cmLQFEBHF5reegmLmyaIuCG4Nx4Gc1q91zs/wgfBUPyNodwwwOTG1zVBw1pTLr
	+NatUHSBV8CZvwtzOZ3VAqmtktU0CupCDSFELCBTF5p9rrCwaMUYt0VPn3ic3uvqLTJqOwPg2ox
	tH+yTsGCBnbQ6oNVEO7zIN4d83PiuHBBEGXgQVl4sTzEtHO34luaCNle79Wf8kIz+Jimb0bvTuY
	rxXNj1g0iXdkyjsyY7Z7enetjIAZewD19zjX4v4/AjW+qI3itPcDu06x2blLylCVgzYwtVHd/mX
	9CV2fc5jMXyWOGpbdhcKflrBiHQWBDz2yC3nBt7Flw9icu6ZtGLS/Y9Mu8koCqNIXCD9W4ik6Hi
	8afVISj58+ZyDEM4caDv3naETO6rF9cQftfg/FxzHyL+h
X-Received: by 2002:a17:906:a354:20b0:c12:ad3c:d0f1 with SMTP id a640c23a62f3a-c15a69cbc82mr240550266b.64.1783432026809;
        Tue, 07 Jul 2026 06:47:06 -0700 (PDT)
X-Received: by 2002:a17:906:a354:20b0:c12:ad3c:d0f1 with SMTP id a640c23a62f3a-c15a69cbc82mr240548866b.64.1783432026410;
        Tue, 07 Jul 2026 06:47:06 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ada0352csm144997866b.46.2026.07.07.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:47:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: raphael.zimmer@tu-ilmenau.de
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v3] libceph: Reject osdmaps advertising pools of unsupported types
Date: Tue,  7 Jul 2026 13:47:04 +0000
Message-Id: <20260707134704.2236765-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707103119.3909051-1-raphael.zimmer@tu-ilmenau.de>
References: <20260707103119.3909051-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

