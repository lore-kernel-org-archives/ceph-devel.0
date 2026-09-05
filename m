Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0642C11E7
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623874; cv=none; b=SNP90KoYUZv34FnlV/4KUPJ7xfYB52E3hLIJCjPY8oJGv3jNqN0gn/8tAHK10+geSGt32BP5rlWliACjMNmpQprqh6za/PNmH/vDv4NKDdhK403SHS5Yx/NZ/qOLRCtu5U/YCD3JlLBRbZ9C0Hyekkd4XYg6lwXUmd1yh1Q5vM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623874; c=relaxed/simple;
	bh=btt5wbHtCiWz95VoCK4Elf/Hn0M5ug+JrIzjfkIZa6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXpX+cUFA0L2I/o2/oQpU3STWU4CPzdtl8XjzWJtDvH9kuCyFeuxS/GRcLIFpxYgWiq/ISFDK9ltUYRufIOZjBcJhHpFnACi7pcOwEsitzDOIh0DMNEiDbpsEWDrTVJHknIHy+oyDXyu+eFjbVuzmX+L3OY99uYBk1yz30KZbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeifE4E8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xrj1FkOz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeifE4E8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xrj1FkOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788623871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROHaEmisug+OaeNcx0+S5XmIuVriFtDaNRIghTYU/F8=;
	b=LeifE4E8uGJ7dyFF6Kkv5cZXYZx5bX577vP8xaTup0dUmN+WpW/fBs3sOCyGa839JNUagG
	LWveb2K4xhYCoheVzkbDrJdtrGmz8+YP4fit1N8Jb0gx+TQE3p6MII0K+ITSQ3NmF9yULs
	FsHcsAN0FUTzzeg5No8DBMx+13zck/w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-C3x5JMEDMp6N-prZ4WZroA-1; Sat, 05 Sep 2026 11:57:50 -0400
X-MC-Unique: C3x5JMEDMp6N-prZ4WZroA-1
X-Mimecast-MFC-AGG-ID: C3x5JMEDMp6N-prZ4WZroA_1788623870
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494cce712so375146085a.3
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788623870; x=1789228670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROHaEmisug+OaeNcx0+S5XmIuVriFtDaNRIghTYU/F8=;
        b=Xrj1FkOzaLiRZFKR2ctZaxqBaEee9Q55LPbsBkWaEol6nwO2mVEXZQnku7xBJQZsKC
         lDSd5GPzQMCMrfLJT6/oaJAd+9qjT55QPOmZnUv4pjlJ+y/yQqrAfhIJlJhtkfYSN14A
         DyMIRAyjGOG8fqiAzLLOE5bKb/QtbT77mDVG8pAqYrN5fikyA3Da15vU+sCGUqbL/vTM
         MjGdKxNbGWaT+6ejF62Z7eGK5/Odb1Att5zvp5KJb0HQgOEam4bOWGQJlj2zRZOX23dF
         TM7F9uCJwKv7W+jGiJRVESVHWx3hu+Fpiw3D/WgH+5Se2lZU2KQkgFHkfsX4/NknUSYK
         3jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623870; x=1789228670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROHaEmisug+OaeNcx0+S5XmIuVriFtDaNRIghTYU/F8=;
        b=POXrCTDoVJwwJRS0U4EAX5jWXnUa1bKcIfTLSqJGSX5ZLYBcedUEsGAebSqzXs5JHA
         r6U7L9ppXtakSe4avKzsnIScbdE01d6oA1licYCj83s/z9ut+4F7mI3veELQSXayaYVX
         xjE/eSE1UukQHcaxMxSbJ7vwa2wxKuX6EBaV7AvCCuHsNjrF7TinADQuX3ju5GRynVzp
         9zpPW96lFRlNkgj0Lt11fTCupQdzqzQ7fll9UgrCkHM9Poh73ala/bSAPCdEMbBXNnKa
         QZw5Vh7hUbjkC+9X6INvXXBlj8be5j9TqttqLeTUnce54Ga8t2swf8pjQKury3GhShLN
         BAbQ==
X-Gm-Message-State: AFuF++l9Y8prp0AcS5bmQ1TJb1Sk33UciHud/6isP0IFHWGs6Xv61m9u
	Espzx2SM1KPcSvsDBgsBEn94Mght+4sqTaNi9xvooVohgjHyMDSbdneU8fROE7QgOirR+ncNalr
	IBUGL2vbF28RAakXjOGXw0sTHOmuDa3cD/aP3JPgyRll6Szt9U8CVIUCIqg/1rOFlKn6LLOcUCQ
	==
X-Gm-Gg: AYBFou1fwkhWPK8MrkCwDCyZNEzYNCYKAy3DG5Qle75qHiUB1JHKceSNBpFB4mBPidU
	JbczZaZ41e0G9hJ4l+Yhqz6c9S7RdJkKf+8dzLi7e0ZFDC4A//xojq5aEu9+xbJknmQc8z3QBpA
	HQshdNECmRbsoWbSkj1EQXiSYTOQktOTFOWSVJBug+ojW11qu4/54UVNKZsKNsJOpVMrzvE1jr6
	seA8MMFDQhE3K/A+sjuDCklxffoY/L/Nqw0kyI1Ia17/5eUQVqC2WSE2vVUg4gP/l2TId40FHc+
	LUYzrSj59TK0sFc2gNPLb7e2L357TjgS/eTXuqO5jkruR2Dn4m13Lt3c52PlgiNol2utmbmxsZz
	EpnZLrmsM38ERa1AorkZO4slrKw+AxsOYMJU7WPoT5yLuy4VQ1ZHealgNwUdpfaLw5mydUimWch
	Nvn8DJzL1Y62Gc6g==
X-Received: by 2002:ae9:f201:0:b0:936:9525:e952 with SMTP id af79cd13be357-939804a4ea5mr1072314385a.41.1788623870170;
        Sat, 05 Sep 2026 08:57:50 -0700 (PDT)
X-Received: by 2002:ae9:f201:0:b0:936:9525:e952 with SMTP id af79cd13be357-939804a4ea5mr1072311385a.41.1788623869644;
        Sat, 05 Sep 2026 08:57:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb36129sm473162185a.19.2026.09.05.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:57:49 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: unregister aborted requests in ceph_mdsc_wait_request()
Date: Sat,  5 Sep 2026 15:57:47 +0000
Message-Id: <20260905155747.3447366-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829-b4-ceph-fix-abort-request-uaf-new-v2-1-b5e73c6b2550@clyso.com>
References: <20260829-b4-ceph-fix-abort-request-uaf-new-v2-1-b5e73c6b2550@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please respin.

  1. fs/ceph/mds_client.c:4038: Abort unregisters requests that still need an unsafe lifetime
     Xiubo, `list_del_init(&req->r_wait)` is the right UAF fix.
     Always unlink `r_wait`. Call `__unregister_request()` only when
     `CEPH_MDS_R_GOT_UNSAFE` is not set. Leave an unsafe request
     registered until the real safe reply (or existing session-drop /
     umount paths).

-- 
Alex Markuze

