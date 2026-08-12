Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21D44C645
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543926; cv=none; b=pMYZ1AsAB9MrK0OU5eaPaxAy5vt34Pp5FLZiWS0CiCGmrh8iq9GQS239cswlnTTMgs1oCdqn4GBB07y9rkwdbCkiQP2A+1RDQ9bbCeWsZoV731dXJ19cFyL9CHIsn8snDHxTtOMhIwCM/FdBC1WTPHQvC22cV4er/ulEGhdeq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543926; c=relaxed/simple;
	bh=nxeJE9WkO07Y62CkkTsn7qzamIDyq/xKMIhpzGjbmL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD186PGOHK74otrBLgS9IBBYZ9jWQWFIfAkrVDHQqjn6gXfbAckVoYmYUtMwIgXPDY9LnRcTn1cZob/E0/d8HDLJDE7EWugG5Sged14+u0uyHwy2xb+0tiMx/OWhth6QxWc9yi/yqYyNWbHhR8PY8amSXEVmmrFz2+IMZDmj6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqA9JZkW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pZRM6iSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqA9JZkW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pZRM6iSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786543920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxeJE9WkO07Y62CkkTsn7qzamIDyq/xKMIhpzGjbmL4=;
	b=bqA9JZkWGzswnTP/19bS0Ho+HzPDAb5FAw7LTu5IiQRUUv7uqjDSe8Qy35SsUS4/KSspMA
	Xjz1dM7LXBC3vZ/Ya2HseicRyADMy4hNEDMfCJqkJb2ab0aktdtEQxMxQvdFALS3OOGYZe
	7bHvweSJg4tR5vuADJ9cfBG4ofX1f68=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-6gxzUUU5OUyN7tcKvN5Xnw-1; Wed, 12 Aug 2026 10:11:54 -0400
X-MC-Unique: 6gxzUUU5OUyN7tcKvN5Xnw-1
X-Mimecast-MFC-AGG-ID: 6gxzUUU5OUyN7tcKvN5Xnw_1786543913
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a7c64fbbc6so885788b6e.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786543913; x=1787148713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxeJE9WkO07Y62CkkTsn7qzamIDyq/xKMIhpzGjbmL4=;
        b=pZRM6iSGSR1NcwFmAUqPm9bMhQ6fYr591ramujxYb9Po+uOliiEL5nOVNedOkiFxHr
         sayhUUaPYoGhDwYQCocCaI/JRo3iGqZBV3C5GH1XYOSsUss7fmAXQ9ktoU/T1tA6KGme
         DPI3eJuFxED61/xVCJWNeezQCqHyZnY1sU7x0t/MepTiF47OozsEnP4J603Am+woAm5c
         tflCb96zg9Gc1kqF7R/KTZKKvhn9nkR6F+oYjH08pA88yQ10bKyeE2tawiWjX830xnwf
         0BHGoAqKLaE+cCK37Nr5pziifJoQrUxlhnsOcu6KjBBxudQnBPTmPyu6PybNSpEgXRiT
         HdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543913; x=1787148713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxeJE9WkO07Y62CkkTsn7qzamIDyq/xKMIhpzGjbmL4=;
        b=UHJ+drwSgwcJ1z0KLY/O7uIq97HAS0gpChQV9OwJZjPZUkURNAygnb3KhWntWm3wy+
         iF4OOg0Y7P9u56eelysS/4XSxEUjYx9VPfpvpZFKzi13W4OtqlWPGTeHGNs/uzTyw6IQ
         eID6DgygmwzDxDmjw8DsaH5T5a8kQF2HSOthw55Sgjfg35/DSuIaaa1Zff5m7BgNnNqj
         JtZingXI5BIIlk0bSaBXf0QaoWLx2UNEZb5EepO/w7YOaz409eoZZ3sDyZcmLmnxc7bL
         ICgVl0SKwXyOQ89ZRbYb2mGS7nSPN54NlpHvSXhpMO4ltpRtHU/VEhloaMVxP8FcmE/h
         RCyg==
X-Gm-Message-State: AOJu0YxGDZ5MaVgZbaqnjIHhmsS/kl8r2HCDePwCbQFgxbhZa3NM+0qF
	D6crxKhRBmxyKGD3y9xAsQibkqMufs48QLcbMgmykRLuWehnwv7xanf9FyhUXvMzIMRHw7WvDXt
	EuNxaxssCxCEy/tenHYcYUMr7Wp8iCitQQYdt+A5w8rC4f4Hnh/CYeQs2TIn1b1O+ZLhvAsvgqA
	==
X-Gm-Gg: AR+sD10b0lX6Q658FFLn9VL+SL/oQJwpL3MVyBbux3/T2ZRf8XxgoW74b3rbkDLHGeN
	vrJ1jsckpqWvyZEU2iDTOjXkbpcZaRbIiS0me8U/QNAoNdfg4HLaFt7kRF48tfH3UV1h6FDvj37
	l55vWE7MLUzcg5TXQdK93wpPCwFnrQS/5CBllef/bJ5pGv/ZiT8BvDtUx3iXjwXmJh6QJXZ0R+4
	AaDtbXBqxho/qXt+jGpnEHeaPmEsdiNRYSl1X/Zn2bOxLilb+MACvD6FxpbRjcGro2ly2acQSEX
	KYYgHt0kEiRvSwa5IS56jbrkdqVtFkLgy73uY4b2K2C72exWXuXlw2RORzc7Dsani4SJBg==
X-Received: by 2002:a05:6808:f07:b0:497:df42:1de8 with SMTP id 5614622812f47-4b210949266mr5131058b6e.1.1786543913286;
        Wed, 12 Aug 2026 07:11:53 -0700 (PDT)
X-Received: by 2002:a05:6808:f07:b0:497:df42:1de8 with SMTP id 5614622812f47-4b210949266mr5130974b6e.1.1786543912663;
        Wed, 12 Aug 2026 07:11:52 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1fff090eesm3318125b6e.1.2026.08.12.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:11:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ceph: use GFP_NOFS for cap flush allocation in writeback path
Date: Wed, 12 Aug 2026 14:11:45 +0000
Message-Id: <20260812141145.3356325-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812-b4-gfp_nofs-v2-1-9574af8a417d@clyso.com>
References: <20260812-b4-gfp_nofs-v2-1-9574af8a417d@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the respin, both patches look good.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

