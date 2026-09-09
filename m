Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A45505C9
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956944; cv=none; b=CEqjYXYWxbi8S/HKpo7Am+H0RZoM+kqMnU5QkpNLVtTqt0hNyoEhGFzYfHh3s6OTR0QcPAB5Q7jMzftYDycGnGulfirB0qR39NGr/V5tzk+syF70FqbKXdSof5itBQrhy3m1O1k3kZSlUg0PVaI8yRuLwGYbACH42cOt5seed48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956944; c=relaxed/simple;
	bh=uoNphzvPjuQhTew/0jLkNVD92HiI1d7bgSIoOysNw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sI68OQe/ii6EZFLVkaBfU0yVpYjZqZN1xG3/v1fRgdsig5NEMOpPljEGtk1C5k953YBdahF7AhXi/Pkbi81FOAJlCeEQZujHSYGpmkW9Vr6220I1L5a0td6yNkc4BihWwRo3yFIrmbWDfWS7G6/LafcLgV8O9+BSB6NDGgJ+qKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZBtZVEG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nx1xqM6F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZBtZVEG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx1xqM6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788956942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxoMDTRNCHWRC8xGexRuJJ8wCXMrD9zStjyj+Vz/JSU=;
	b=aZBtZVEGXdHdATdsAi4Lpn3oV34+WRyzqAVMnKcqLYJFxMa7FGvHH7tNJ32RJ2cBA0UAau
	2mm8aKvKpxCyjcGv+ukvO7/wh6sBofpuCKo9aY1apON/+uXYx3nJT0Masq/ff3k8dnaObM
	RJOLIT3V8ae6C/BpMqaTUwnGTZ1b68E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-QX3LL7EHPYiP2ixTnSok4w-1; Wed, 09 Sep 2026 08:29:00 -0400
X-MC-Unique: QX3LL7EHPYiP2ixTnSok4w-1
X-Mimecast-MFC-AGG-ID: QX3LL7EHPYiP2ixTnSok4w_1788956940
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90ce8ad8002so108890246d6.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788956940; x=1789561740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxoMDTRNCHWRC8xGexRuJJ8wCXMrD9zStjyj+Vz/JSU=;
        b=Nx1xqM6FS2AJy6d8oTCvhN83hzRHFMZ9p45CRWZbqXbXJI/IYyWii0JM5SHkSgACuu
         n2fYI8m995/PA7S1EV7Qpjab7fgh9x3EaboQ2SoZ8m3fqkDMCYqWkCBCGWWPhGWM3j1X
         udZTb0GjKHi/qtgRaaeEQSOX0TW2lgiqu9IhDc2ntSkiKFLwfNfWw7/OCqSVaKBsyc7L
         WJwBsX7rUFJrro/lHSUgIVwcH4oNHzANRKksIYTCsxsg9ZoVDdBp4LfYQk1EgBqqjw14
         HCJybeXCNPj3C6A8bt7kFvkThuAZNtYyfblX20Hz/JZFqAT47NHwTY6aK8RpQROE+72H
         glvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956940; x=1789561740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxoMDTRNCHWRC8xGexRuJJ8wCXMrD9zStjyj+Vz/JSU=;
        b=o8o325Xp3vlIeEXaHVLcOPL5N8vEvfAQfnPi/Xt0E2YAuqHYsm19oG2KCasQVwut6N
         lSEzAXT86fmvcxT+BtlRuuVZC6eXpi1ccQMkNtLqBWg7jHeS9S2avl0MzzV37QkAX3Zp
         ftTWGuvL6h9VqHI/+13vCehv+WVqyvdkHbT6ZmPVtAWypVc6LAloy9OiI2WGLLBRA+bs
         ZtzvxeQFFbw/+Z31WArHUHsrgonkg32GtrncgKdq+jLE8NW5z7LLxSulilgGOxxtjJqt
         edW/Q4hyToj7d4YCwp1LIGHbZy7ziTi7daoMrF+iF7AUn5AicvdkaowGAh192JomGarH
         GgMw==
X-Gm-Message-State: AFuF++nHUrqYO8bt3AFqmcyYZyjiWLf9ne2d5vlc47qottX1CGIQBUxu
	hh10N+VUqAsFSRb+8HJC3CV1cstVF3dlFlNs4e9Ks1LvRq/fusbDQ+6cllVKdgac7QJzDdsq3IW
	gnQgceQBW08x5ii3ZvfPDFQwE5SOeoiBdLj695mI/94V1Qwp1cGYoq1y2ccf00jgx5XRvwoTxkA
	==
X-Gm-Gg: AYBFou2XFsYRAmoJsIhURuRw0gRH2kYu0gluYPgOJHIaeiFxB+I6hTSJ8kg2WHInCPc
	ayPJ+2o5M+pp/3KARzzN1qjlHSF8iWugN5Of9IlXPg7+PNqjZs0BZAsxk4iMlOgPp0XdLczufyl
	1+z71q/HV0aoRx1MZ+dhKp5tTayufcZ88Lgr611PkO8Jmktg9HvJOuEEOt+M+RsSjJdNQdcHquL
	epgLGae2j3P5Ok2HK5ZQg8vQ2fQSCSnNs4OZ1/AiNYHToJiyUa/swJC7VLLalyG+FrMQ8yKL2a9
	PsSyRCMImOUPQgfHpZkFnm5mK0yWCUIl9efKRWhs1FH2ozjwd3juU8Hh2Anh3JUWBckOiEDBCA5
	S5Zl6XYBzXmuaPPFCsoan1hoi9Q8irnutn9Bu+Kw9YTLdeJMIwT75aYKOZ/BWLciEtu8GmhazQI
	mlfb26jcpJHhp/rA==
X-Received: by 2002:a05:6214:5989:b0:90e:9d70:69ab with SMTP id 6a1803df08f44-9103ef1b588mr416531946d6.10.1788956940221;
        Wed, 09 Sep 2026 05:29:00 -0700 (PDT)
X-Received: by 2002:a05:6214:5989:b0:90e:9d70:69ab with SMTP id 6a1803df08f44-9103ef1b588mr416531656d6.10.1788956939727;
        Wed, 09 Sep 2026 05:28:59 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406940f3sm142754336d6.38.2026.09.09.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:28:59 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Wed,  9 Sep 2026 12:28:57 +0000
Message-Id: <20260909122857.3964737-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908062119.402027-1-zhugl3@xiaopeng.com>
References: <20260908062119.402027-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guanglei,

NACK. Please respin.

  1. fs/ceph/addr.c: ceph_fill_inline_data (1/2)
     This does not apply to current testing. The helper already takes a
     folio and memcpy_to_folio(). Clamp to folio_size(folio), not a
     kmap_atomic() PAGE_SIZE page.

  2. fs/ceph/addr.c: ceph_netfs_issue_op_inline (2/2)
     The new start >= inline_len path leaves err at 0, so the subreq
     completes success with no progress. That is EOF for DIO, not the
     -ENODATA the commit message claims. Set an error before goto out.


-- 
Alex Markuze

