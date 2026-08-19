Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62528433E82
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134924; cv=none; b=E0xOUasBmfrj0QRbmtjQxYnW6/CFEN/zmOXQcXJIjRlNj9j1Lenttd8oZSANlZJnUwQed8clAmHLENzmwN8EpvTt2Q/mY3wqxhShZ3E9pH7J5M15BV+OvutU+VGP/hNfbQ+a3ppi0nbqaRJlfViDSQF2a58KIfxkDM8gapSCMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134924; c=relaxed/simple;
	bh=yTL79n8XJspQuzQq80nd3CPMi8GpBDnq2zZGhK4sClM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVAoxVYNl2CXHD+VCR4lQIa1JA4d+539zfa6vQUuYYJlj/rS1zJJaZfTFIjFMTPVsVTFSTZc0vzvCSNc6/sntID1tY3hk9zcjhEaARlH/qbEIGf4uyVMP4fsjZH/QQCmdetndmSB7bTHEY7ftn6ATtzQ1zyKWQ9422gQyVPEEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ah0shfW1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kiF6opGu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah0shfW1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kiF6opGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787134919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTL79n8XJspQuzQq80nd3CPMi8GpBDnq2zZGhK4sClM=;
	b=ah0shfW1bh3QC7rBwfACLe2H+Z7yXBvRAOZzQg5ax2tju2g/JRlS1g3PWmS6rN9Q6O3k4A
	qc4Pgk27v7zR0kfgRneGWVmMMwsEC0tZu8eTfnAr4MP6QYuR0UQUHuFm17zTxvdA43AcVv
	9b2clZZumTn80jhDPKcaidENp6JmdJY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-efgMzd5RPQKvI3QpBtHM-Q-1; Wed, 19 Aug 2026 06:21:53 -0400
X-MC-Unique: efgMzd5RPQKvI3QpBtHM-Q-1
X-Mimecast-MFC-AGG-ID: efgMzd5RPQKvI3QpBtHM-Q_1787134912
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso75078466b.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787134912; x=1787739712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTL79n8XJspQuzQq80nd3CPMi8GpBDnq2zZGhK4sClM=;
        b=kiF6opGuihLAP2ecCLNy9JykN7t7c8weh3RljdHXeIPd9Nc7rzZUXfz/giYP1G8uIs
         4En7ig8nZsnEpVYinWp4QM8B8DsNgx7pFN7nrpgIxf4S4l+UY1oH7h17bJ1W71Xs/2ld
         SdPjVB1mrHsgr6+/gjhsN8dd8Eqw8jyPUzdAE2IDuul2gpvkgJB28DoYjj2bhEapmte7
         8i2M/qh3xrPxp/xAbJuUkFs23a6XNMmdrlqLvsj0R6FY8FEvaB2m3x6LKScxS74z/NHx
         n8BS7dIfeOqnwD+k8bgMetHV2QqG2F+NsLNjqMU5Kyx7amiLaIbI0z8WPAgYehW0nm72
         fPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134912; x=1787739712;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTL79n8XJspQuzQq80nd3CPMi8GpBDnq2zZGhK4sClM=;
        b=Hikz73pGTcZBMobND3yhoIcgEDWkcfngZxe7MUdAnl8cjPt1mdu2ZqJvospzZ0F+2d
         YpsMBA//TYir31Ixpdckyf6G4AQ+evTFDKrdp3YooI1KjBfTGIziZUhEuWvhtd0SzHfH
         DJPv+GxB0f3u35viL15Fykd/7Y4Z/D1KNBldyLcqk0zd0KGKxGJCu762lZce+t4R6Pcg
         jLdXdG/+6eZwkJoJAJhCY7ogGOk+Ym8JOgvbkLpjZUaU7TuIdSndHi1mhvvHtPlzjczq
         auJTlKd0tAHT8yXnBiULB1x0ktGnItIqVeObbmObaCr61vHzbdDtGd8QRCGoHeC4/4GZ
         ObYQ==
X-Gm-Message-State: AOJu0YzBEl0AUEDMvqe/o2HluYPHjMyIko0+u8bgiDLaQXUhO+Guf51c
	iuQd5Q6BOTmJVA32T4wc0rKUqNnUv9qcOkOvOOrDRCs3JNdaQDSGmgRPvwQt7IdVicXI+1hEiZX
	qg8ONk0mZSyTExicGJo61wFlkCFa9OaPVfC6I83Ows6w98n/I82OaPl6OiS4aGfGYhgH6zhQ7Dw
	==
X-Gm-Gg: AR+sD13YsxbG1qII3MHbOYabLJ7uKmeZ5R74wRjdCYSa4NQAeXSOouJxBncqtE0PLcE
	w/u73Qo9l4z8ndldSrtYXLerD4iHT4fgt2KQkIAgq69vmTjAVprjrQrXBjwwljWEDBAxPUqCxkS
	MIk0zJ3p0UkcCuWnWsSeQVphPCc0/+UtIf0fmfQkNn7xozs389EQUFmJS2b53O6XJ+0q95+5Wi+
	rBv/RPSMRCLDC6tq7Nfhnom1fhcGpAz59bNwnmi/DYDS+lmMTicQxDiH+tQKjLBmF0dj2f6H0kU
	dlcb2+pGsCnIj7Zyrzw9Iplst6HnR07neFkObmuYgu9uDVxKN6JvkRZNqGC9m+j79C7+plY5E4I
	/yDdYDOcyk6j3dkN93pKJ7DovVNEe3GiXvg==
X-Received: by 2002:a17:906:ef0e:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c23f92c35edmr199644666b.13.1787134912488;
        Wed, 19 Aug 2026 03:21:52 -0700 (PDT)
X-Received: by 2002:a17:906:ef0e:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c23f92c35edmr199642066b.13.1787134912143;
        Wed, 19 Aug 2026 03:21:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c7c2ec6sm55524766b.10.2026.08.19.03.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:21:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: reject buckets with mismatched CRUSH ids
Date: Wed, 19 Aug 2026 10:21:50 +0000
Message-Id: <20260819102150.1282634-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260815214636.269617-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260815214636.269617-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jérémy,

Good catch. The fix looks correct.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

