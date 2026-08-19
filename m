Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5C44E653
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137347; cv=none; b=i/jAgfzkRwqFi5WKQpJ7lWY8iQBDErXZF1agqkkFGhKTL1wffJ0ScXh7/ym7auBsgRceSg36g3xnfkJviASPwQI9h79Ji1QDP2PChmNpWMzE+FDQ5IuC6v/tvxuyG/ql7VQ4gsXsNzXmZzGV9rHLkZtef4UHGPkJUYR+7HBjUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137347; c=relaxed/simple;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMR0l4eVN388RXnhyTeVDLrNNQfsfuhcPsiz+Ct0klduF9Qf2TVQZZEJyS3FXFajKaN+LxVPN/bOgiRzgVKcOMFoXvZMF9fRjix3HQwnTBLZTNsUhzs4hB4UJoQiJ8wOvdj25qcqRJwruY66difCBiihxsm2tnP/BjRxDnUOhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh67XLTC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kCXnJubM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh67XLTC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kCXnJubM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787137345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	b=Gh67XLTCjL/XAAWVvg/drbtbFdhjrDec80CCQOGrLVDwtW+WiC6W2dAMR/ufNdKkCJ0vgQ
	YUhvTFL0s2j24Tmk8iOaht6ys+u3Ancveyk8MEyJell7G4aqtbIe1b7x3T73ZeIdy9/0SI
	DN2t2jTcMNW/2/T/6LcO5Wmn00jonw8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-dvzh0Ud2MqazY9OzfKAt4w-1; Wed, 19 Aug 2026 07:02:13 -0400
X-MC-Unique: dvzh0Ud2MqazY9OzfKAt4w-1
X-Mimecast-MFC-AGG-ID: dvzh0Ud2MqazY9OzfKAt4w_1787137333
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90a60102d6eso9816966d6.3
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787137333; x=1787742133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=kCXnJubMjaGE2OPjlQmz7wgrpBjD6GT1hAHp8zgofANot4EnB0dtelPyHoR/6s9KTC
         Pz29oC/hlm8N2W8kv7e/1nT5NcWCRtUPDaMp9n7MVAqKSWLHY0RgDGhm2UYgPUjjcXlH
         bEo7C/+TD30XY0UxF9MQlhFNnNShvzXshjbEE2qEA5jA1n/mm4HQ+Zms7VjxYKMoJvRN
         +AS6bAyJcer28feZLmDXxWyIs0FzLIcf6dsHI5ZiUkeXsS6JCP2089WJAts7+62WDZd9
         NEhZv5YtmylyW584qEA9+TWSMoxGB/Sfh1okv4DF0II76i7rF5UJZ784A07yTn/yM9VC
         M4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137333; x=1787742133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=BHrR0DhIfHtaO5hvdsG2vBbntaX15i46iYPIvLfQTuHatMY6SX9HHymT940JgeBP9c
         K09tNWNZ+VDQiKG7Zef5PqsUTgDFQ27y7xIeodBp0Dcwa9CarCtR48Bn8J6iq3VkErD4
         xnMPsGNp79Hafak9qaWfVp2Za0GRjLLkJ8L/Q3bqYKJUPs6WENG48V5lMedlSFNl5t0A
         DC1CZrUfDCHckyFq3cb1nLtxFG1mHZcnYqMCwinnm/QUSZTpkewyfaCpnCzMjsZNXJlb
         qEsfvh3HkvChh/JdXPVV2GNaTBGz+u/0qlcqIUHNh0bPSiT4ygxzeHOUDnJ4GJ3/04BU
         Yt1Q==
X-Gm-Message-State: AFuF++m5l0Hdlo+8WYgU6AJ3aWwITpq7BBeZ5mhuMNtk1+DSZyps1BMZ
	hIzlAEtzF+ZgsS13+Lm+4e0zeeKwZ9c34Yg4qxJUiDQ96Y7xW5OsmtDB6A8fCj4XtUYegVJv5Qq
	6xSO7yD3AJ6G8bDFpIh9mdUCgpH6cGyQaKDWs4FkHEeVQLdlP8XpU/ZP0sbWbxU4=
X-Gm-Gg: AR+sD12D7RFS/kdPzfu5cKP+RZMN6o4nHdSe2VolpzZjoF3u+Dv9+7IoIRSJxeVf0rc
	mYRMGnSwiqq9HNdWqCwVYqdisFtMItD1DPP1eTblYmNkuzz8y9BAekISBWgenrjrZ2XZV1F/6y5
	V3CJtaJRgU+RaLnsUK0BzkYOd/S1+YfmHvdFKoOp6H/1gKKl58dhPOt1WOY80zdzqKUTsB6Y8GZ
	BYYLHpiP/lMC3IJRnx3wwjZ5wXGa7es+RR58CdCNFoftVKU5xjoSA8Ph6IkPuYPbZrzDV2St1hu
	U5e5drpH5dkPfXU9cyMHKgl2FkdWOOnTTGl4f5BeAmIHicj1Lo83WCUp3vb6K42OY/Wvw0h+Kya
	GHPI9JbYxO9VravgfgxekUSa8q4EETXBwiQ==
X-Received: by 2002:a05:6214:3c99:b0:907:5150:a2dd with SMTP id 6a1803df08f44-90c5e73e301mr31950866d6.14.1787137323140;
        Wed, 19 Aug 2026 04:02:03 -0700 (PDT)
X-Received: by 2002:a05:6214:3c99:b0:907:5150:a2dd with SMTP id 6a1803df08f44-90c5e73e301mr31936706d6.14.1787137315112;
        Wed, 19 Aug 2026 04:01:55 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a2d62sm11636796d6.38.2026.08.19.04.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:01:54 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: tz2294@columbia.edu
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: use iov_iter_extract_pages() in ceph_msg_data_iter_next()
Date: Wed, 19 Aug 2026 11:01:52 +0000
Message-Id: <20260819110152.1300058-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <<20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu>>
References: <<20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu>>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

