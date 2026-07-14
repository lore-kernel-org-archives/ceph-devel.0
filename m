Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E5309EEB
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006193; cv=none; b=lOl05ThiABFUEGT0XWOzHO3QrTToTqJN1ITbNr0CdYGNXXRb00koEOo+t6l/H32Fdc/k12ZkGDkdzvQVwhZrdaQG8IEyt+fRejdYlgraQ0QzSpPucD4pn8SjTicwjHBR7ZNsEz29LkOR766rtFhlGTrFQ+DBNTXAEJ4msTD0Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006193; c=relaxed/simple;
	bh=95ki2VzVyYPk0TNHRLJK6UMU7V5q7XMlXy9bQwnRYh8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDJ/H8RWKzzP4xXsbuUBheWsZOKSeoRHjMPHwPxgVlm2SdxupiKPoZ8fJVY10aOLd78GqVlPXm+9YAIEwDbZ6FT5fAEA72KuAO7MzbSto4smMaeQYJxCfzBuEg1ByWz7UixfBCExg9L1kSWi4aETUBzH/5U9pzvG26pdzdpC6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=Aos3sr6g; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="Aos3sr6g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=95ki2VzVyYPk0TNHRLJK6UMU7V5q7XMlXy9bQwnRYh8=; b=Aos3sr6gUvGlTcz7fo7l0KN6bw
	M6U//m/S2Tbg7IwRCG/K8KMmb5ZTF4ZlPReM4EBCwAdQdE/ZOxMv4qzD1cnZV8Obq/nWH/NSxbwmp
	rWL3xGZtTHivnjv9tlDuXG+d+Wh8oCClQLGROXAEFA26SMU9topQupz0kgwVWl/5ak4NEz4rglYJs
	e2Y2coSoFgaYMW+1cSoqvXZtM2ZbbSE7VjlMLDsD6/q/WuIbPfsZ5AEirdWjDR6P+QVgBPtgBvkOO
	YfCPgLbRneBzdJ2imE3Y215LlZQ8IjQ0axvrO4oWbMFj6pwJEXhCM514KeD/p5xbE2QaBI3hHstBU
	oUYldA8A==;
Received: from [207.189.26.187] (port=60959)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVVO-0000000Frcs-3XIA
	for ceph-devel@vger.kernel.org;
	Tue, 14 Jul 2026 12:16:30 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: ceph-devel@vger.kernel.org
Subject: Dear ceph-devel@vger.kernel.org, 
Date: 14 Jul 2026 00:16:26 -0500
Message-ID: <20260714001626.1202A0520AABE015@inbox.org>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day ceph-devel,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


