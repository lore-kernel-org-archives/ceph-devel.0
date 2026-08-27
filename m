Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C523DA7D1
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821880; cv=none; b=meySQsP+qI3GAiCM3QHVap2NrXmCKvOzuOMqt5C4PWwsKXeyjl0YZ0JAVFRWw+UQOni347pFRGeFP+8znI36oiqqIMunXQHUvVhWZso1jpsGjdzeSDqXgt8JJYjrZdLy+Hdqr6kXQQyPZQ4OSYaFXw06JqGOZrL7eeDxT6Q/5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821880; c=relaxed/simple;
	bh=gRWLpI0ujWLklEzYPzKI6kW/+Q01BLwLZAJqF3Gp3tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otFZ1iYSI7MmT91olOPP3F3V144+GbaYe2gdVFX2o+6eagtxFoqW5xDMp8aqGeaf+T01e0G82dvFNEf0Cd2GWs3xTmOOOxWKi5SQcPUy+X0gMi7oGZkCTXh8TwMLvWt3ekzOSoXiZz456HA/RKrna9G0Fcdpd09vwHzyB99KFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2f94OVz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJXcH3U9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2f94OVz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJXcH3U9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787821877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVYUWj2VGroaYopGxdXQXuf0pEph5oUzD7d+T0WVgX8=;
	b=c2f94OVzZoIoXIjgRtByjCP9iz9KzfsfQtMdpLzKKuMKBjFGfGDS75owWGK6H5a3jaFKrt
	dEfX6v5jK24BFcoDCO7LOZlKFde5t5KQccL+lke+UVdkkmIOhYZ3FftzraX86t1m1W2Rd9
	whgzTA6iRR+Sajn56ZRNZX81+F53zT4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-EzrUgXZ0Owu4EYXRtx9kSQ-1; Thu, 27 Aug 2026 05:11:15 -0400
X-MC-Unique: EzrUgXZ0Owu4EYXRtx9kSQ-1
X-Mimecast-MFC-AGG-ID: EzrUgXZ0Owu4EYXRtx9kSQ_1787821874
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfe48ca1efso30535225ad.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787821874; x=1788426674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVYUWj2VGroaYopGxdXQXuf0pEph5oUzD7d+T0WVgX8=;
        b=NJXcH3U9JK5j3a8fHzNaAvIntSVGBBrNwcLHTf5htUnKN3rbkl2gPTEjKBVAYprwUy
         Ao8KTIcnEyWqIsP6PLJcp8XXaw/xqt6RMdXbie6aXagt6cjRD9OIiZP0OSX1yaiAAOM0
         B/IQmAM+tjPVlFnvEtd98y7eHM+APPCQHdOP1NUTJ+6Zc7FvFVehp4u3I/0GjaM9f73S
         oEX7D1ga6h9pfQi5BJ8QzoVVjHlNcN3foQ5OXs1KX/1SXiYhR9+jaxY2VXNj870oHgyc
         TPqdtVjfHnfTSlHx/YqyB23CE01vmUKBjY6z17Y9VgBRADdvuOtvfZNz0UK4vbAZ7siY
         lMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821874; x=1788426674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVYUWj2VGroaYopGxdXQXuf0pEph5oUzD7d+T0WVgX8=;
        b=sO5LlJO5r7DbuJE8NZ+rhUMUPWWYnnDDtyerhKvO7/R1J+7mRsKMODiQYqusan27E9
         Xcb8aC1n9xTCgEi/OZuNCfeGo5YGE5968rFjL4B7fNf5sN9eti6rn7mXkhTZ4z8RXrDi
         8M1RBQ2Kn5IF32FtvlyQH97GTlPLfHhcslW5+5u6h1SVDLIJOdQp7nYEG/ROiUtyDKOD
         EmMCc/apq6vFx/ZSkj86J6D5OK0CnYjK/sLSFIXi2g2E2ctTF5YX8swRbIuB/JyAZLYR
         NR8lFIowdKiTN6d/I2q72hc3x4rDM+w7+kN01CZeEahQq0Gy7tMpWluUHvezVL+trA0v
         z6jw==
X-Gm-Message-State: AFuF++llv0QPh/OxG76egjn36yvhQKrknV/rZJC/bfgKsuC/R+jbrUic
	r9M/+9N8jz6RAtCR50lvgLReQGuFmeeI6scJFymMX7DPI7fjFvJhDDy8ukOozFJ4dKcWqVMn1RV
	z5WlWziy8PlMzZKp5y05ZcSgX68AtHWdULd+tFT+nLCPTSTiYqAXG1K2TPSODoyGE9rZKhSwRSw
	==
X-Gm-Gg: AR+sD13TlsxfgRWu0LF2sLeS6oZ8Zhy/KOMzZDFUF4h3IGJYmgkVO4ojEmrlDeGPdoQ
	wjKATr36KjhvDoZ7e9p4YxCEUemRgzuLrPhuac3c9dCOyHLmzu0m2m6EZEIrsgoBoYafAUX2OLo
	9RTZY3G7v6Ep3z6LAH5ulx8zQTIUhF02bULSB8IVZUdjxCkL6QWjggJGhd7pRUMl6J0Vozrdcv4
	nDuUOaQXAwsdkQMXAa1O1nN+y46HJrg4T47Oo6xkdza5AyCqHD7hyZwMu5r1AA6i2tOglNj9LYi
	kwNxaeoaTxqzbf53KX2teguu5+tiqqp61aF3lMBXkTGqP2hEmzXTFLaTCUO3pfCaNHkTjw==
X-Received: by 2002:a17:903:26c5:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d707b3c6a6mr257141975ad.9.1787821874082;
        Thu, 27 Aug 2026 02:11:14 -0700 (PDT)
X-Received: by 2002:a17:903:26c5:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d707b3c6a6mr257140595ad.9.1787821873543;
        Thu, 27 Aug 2026 02:11:13 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60b59dsm17437195eec.3.2026.08.27.02.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:11:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: don't unregister an MDS session before removing its caps
Date: Thu, 27 Aug 2026 09:11:05 +0000
Message-Id: <20260827091105.2740625-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824183042.234264-1-max.kellermann@ionos.com>
References: <20260824183042.234264-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK. Please send a v3.

  1. fs/ceph/mds_client.c:5942: Address-change path overwrites CLOSED and reconnects a session CLOSE will purge
     Max, the CLOSED skip at the top of `check_new_map()` is a single
     load under `mdsc->mutex`.
     After retaking `mdsc->mutex` in the address-change block, if the
     session is CLOSED, leave it alone (no `ceph_con_close()`, no
     `RESTARTING`, no reconnect).
  2. fs/ceph/mds_client.c:6016: Closed-session export targets can miss their only reconnect
     `check_new_map()` now skips any export-target rank whose registered
     session is `CEPH_MDS_SESSION_CLOSED`.
     When a registered session is only being kept alive for cap
     teardown, do not just `continue` out of the reconnect path.

-- 
Alex Markuze

