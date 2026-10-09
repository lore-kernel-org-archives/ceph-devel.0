Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBD4582D3
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557667; cv=none; b=sCmt7dLJj4xQrmpWCxikEfmH9UpRaEOVYaWjrMe1adZJ83bDQr6m19sCjyJwocHfRETeRJw14t3M+zoz6bTxoc7u9KJCXS/8W1bpNMci0sZwojjC/sInmANz/30mHPs1zGkmxQDfkPMrzA4xUBAuaHeLBQG7YkMUIobcMxincPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557667; c=relaxed/simple;
	bh=PDkX3qXS+PW7zt08QUXkxcYG8+pS1pW4EI5n09BIMaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PafUnwrbciKNtSSNQVvVYgceq/37yPNYqMfx+NLemqVGXsF0JVlYn3rtlnT8cUAkLbl9wH5M2HLPg0M8FX/qBGkiF4ikjxDBGosFU5dZuZlEIy0//Enyg7jGyg7Y6Nm+aPfjANLnqcwvtr3iqztlD3PuPxu3D/ytXzSua7qJvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQpot4Q2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZ6mJady; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQpot4Q2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZ6mJady"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791557665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0QHkMk8teOzUo7SSUdHtXWqTy5BQSYPRe5TzvGyz5c=;
	b=UQpot4Q2Qs8SeORupBj8NKUOgOL7NkkqMDjzSdhjTELBWZQ5izSqybUjQLT08NHZr8xiPQ
	QmPw4q92B3I4aSbOt9JPBn/ZkgMqw9kleFvS81AKlndiN7tIkcJcMpHgrODdBd1krtC7Jh
	HJzNlLX6n8Sh7hltL/12e8I0sGIf5tQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-2-eJSTjINBm-iPqhgmrfbQ-1; Fri, 9 Oct 2026 14:54:23 +0000
X-MC-Unique: 2-eJSTjINBm-iPqhgmrfbQ-1
X-Mimecast-MFC-AGG-ID: 2-eJSTjINBm-iPqhgmrfbQ_1791557663
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-917a7fffbe0so140979266d6.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791557663; x=1792162463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0QHkMk8teOzUo7SSUdHtXWqTy5BQSYPRe5TzvGyz5c=;
        b=bZ6mJadyuno9nE6jVLhXKdOCRTpCFzf7hybaEuawF+itwACKTXnP6bsMuQ31+I3OYg
         AwD7Fx3rKIm5PCCX1s6ihhP5bCA+uGIvRtnCmjG6nddDVOCUtw3Q9c9d9+9eszW0v8LZ
         uSqS8VdiDXJEDn/eJ88/Ls6N2tPO19EU8DkPYcJOrDK6iikbNol+jisvoptJTXvvbTpT
         N20Run4nxMPMttcgD8Tq1oGMvT00KhS1wPq5HbNXj1EpV9b2GuRPT1uhmhh8Ce98W1Sg
         OgziTy3sGewZGZR6lxq3+yisxOkPsE5O3I6K42ABtc7JfzIuxY36prAZg1xFFWAxPxH4
         Rt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557663; x=1792162463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0QHkMk8teOzUo7SSUdHtXWqTy5BQSYPRe5TzvGyz5c=;
        b=pExgxS77SdiMlYMUytkDasZ/ZziENTcz/dZVdwdDH36kN4wtcp7PTN/f5yIwebYqTj
         bqt0zPI/UGjnJ9XJWVrVZaxfF0Ma99Y4PHM25xP2hyd0bwxoi3m6BYyQg9NlJnctztmq
         /wDVHgYHysV9JP/3CdueCXP01d7HAmoyoUDNCkgDh+uBFFtSKSAPBvMudeUS6ps8BMHL
         5p4eABateHuwnh32uOLuusP09OniF3GTjkjNcQc4ab4rZc/RUBOBJH4L4GTq5TSxtqhR
         VdBK6hUcqVhI5UCRu1VZiVH4EyC04Doz4t0cnqZfj/ReNAwDa/YKkTpep7EVf6gy0vZ6
         UfLQ==
X-Gm-Message-State: AFq9FYLiftMRkBt6cv3vl/GHxI3nS1oX6BlnQl5J/KQS8jmso+Y9bgip
	B+Ao9wiPVyDyVyXfAaNx+t1BXW34b3YsRYI3WRyXpVrzUyprblFWitIi4KQWfaJDrv3OpwusXvc
	lfQecGpMyV016B5L8NNyNcmyTJ3d+h3bmef3WXE//naiW+hrnXK3ChBn/dmZh0Kk=
X-Gm-Gg: AYBFou1dfM5aKL8JbkIGCsaewpPaIBklevE5MX8xd/xH/uxfayeqQStkBh8oz3VCeQL
	d7ADsSY/7ZfXdbsOC9dY0MQNAsbmhMYEqfb3/rsI1a5xhjxWdFsOsv7iN9LN7cPFYmj/UIWslgH
	0SMGYZ/u1FyzRkHXH60K09Wmj53uJfuKtmITAYTjI1r9ywuRndgkoGdZQ9Uyen7i0RTOqMyoErG
	9pxjSJm3pgyxQ9pgUsaObgJB0eMj/lZvTqugxRNxFkUqKw5rFBuskt4o9kyEj7idbSR2DDo2zuh
	kvZzzGKw0QwRir1X4y+z+sdbH4HxXSRcqe86JC5vCB6IHFgQDvxQU+86f4NfxdYVvaDdfoTu2F1
	h1cVtYudUGt8ozNdQsitmgfQOqp2Rl0jIF37ztBebznu6wQdvtTyo3tTxaaibyBWmJVVwE3Ll22
	ds6lRNDSxz40YXeQ==
X-Received: by 2002:ad4:594b:0:b0:917:882c:5754 with SMTP id 6a1803df08f44-91b554f0867mr35061976d6.17.1791557662793;
        Fri, 09 Oct 2026 07:54:22 -0700 (PDT)
X-Received: by 2002:ad4:594b:0:b0:917:882c:5754 with SMTP id 6a1803df08f44-91b554f0867mr35061466d6.17.1791557662199;
        Fri, 09 Oct 2026 07:54:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b54e80353sm20429036d6.1.2026.10.09.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:54:21 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Venky Shankar <vshankar@redhat.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [1/1] ceph: don't fail write_begin with -EAGAIN after flushing old snapc
Date: Fri,  9 Oct 2026 14:54:18 +0000
Message-Id: <20261009145418.2380628-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007085601.195793-2-vshankar@redhat.com>
References: <20261007085601.195793-2-vshankar@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Venky,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

