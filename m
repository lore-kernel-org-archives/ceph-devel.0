Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FD46AF31
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992463; cv=none; b=WgcQdtA5HbKFZDmBz1PY/MmNKye253qy+eY33PucLl8gokFBkCUdB3+E2eGLiJFDnriic9wcIHeVa3Z5dKIhMZl93mVRvZCcDHRQd4X1qb+ozx6CyJYzU/nNYGfBNtd5h5ZYW/SVUJe02QjRhypr8ghAYx4/B2TWIUsnt+s1VrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992463; c=relaxed/simple;
	bh=Tj3TOn9tIgnM/oY1Ihjy0oeRZzZoITeT0EJy21D7RUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCBatqbaTN1BIaTIwCjh+UNDMVtZ2JsPIIK62eR/Wycf8MyvlaR2VvkPs5bqNZCic6cayQ3gqbME0hlKH1Fk7WaTtsARMu1lh2V/brjRCgTbESqtNMhhWP69GZESVDsFZbNiHpIVVm5yKwYDiBsXnscN5L8v4CTA9dPikn4HoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UN5Nyttc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rMoAjh3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UN5Nyttc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rMoAjh3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUhAaFeUiq5wN0FRCa6VaRWY2/u/UZnqNNBXo0CwUww=;
	b=UN5NyttcP0nOW5KzNSiTXiaulAXXNjM9B6urUMXHF4YBOp1x9C2Vtah8ofE20yX2oQYxR4
	DQsdl35S5zLoYH6f75sYRs0q2Fm2/CuWGfpQ+aPo5Q1LWL24ttGwyyut1OKE7JTBIC6XPC
	odnutYhvk6xIN0wwVCgbldvHrifqxBs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-lT69UmNTPQqhfoTJ7j-5hw-1; Thu, 02 Jul 2026 07:41:00 -0400
X-MC-Unique: lT69UmNTPQqhfoTJ7j-5hw-1
X-Mimecast-MFC-AGG-ID: lT69UmNTPQqhfoTJ7j-5hw_1782992460
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b59d85dcso2361821a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992460; x=1783597260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUhAaFeUiq5wN0FRCa6VaRWY2/u/UZnqNNBXo0CwUww=;
        b=rMoAjh3+jQbwqqiXDlSfuUV7YzZE3NlnEsOa1qQ4NjyuEVtyxyddGsVHK0NTWa6Nn3
         qznlAzUMMW/cRjrZA+5W4MEipHBkjZl+qvBWtd5oAOP0BEM5eq6J/hhjoZBBu+mGCUzJ
         7M9JK/BdiPbj3vGLiFgfp7DYPUFcLxuAwsMAUg1Ko5oP3naqYfLz6Huc/TmDsW/oqq6G
         l+gje3Tiqro0qfsX1jRNZ/bCYB1ktJGuTwyen4XuThRjmVImrqD52XMR2ccy7qFynGIG
         Va7tNQi26VApdZqke7nnwuIGKTA5tFMP5XrJrCDwjbXqEtpkeF73vFBH6x2BDySODvF/
         svWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992460; x=1783597260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUhAaFeUiq5wN0FRCa6VaRWY2/u/UZnqNNBXo0CwUww=;
        b=ZBqMMtqtyxEfiIemjmKxbbKJvhMyLChE+PGo+kfkg+0JYNnMhUjKtO0SM5LDDPYlJW
         ReoJhJy7BJ4EWNdL2FOTMlZ9i3bSQZNe+lJ6n/8IIgtTN+MR4zjzJGh0eCyhNiK/LiTR
         2RpDD4ffzoXpaUZ2jbuiDzwS4FmgL5X72zSkWHGVZIEa2YY5Qd6YTpEtDpIdZEa22iRa
         sVzcgd+kanRCQDj+4kXE75CH+VztDlvoZuDUHJo0a2z2kdP6Hfv2CmqPdBKPD7b1uQko
         SutrtxqqeAa4Vutv8LF5nnCOV3eLJfppij2gaLlD51PjyezpIhe39FjgAEwlxen2x7A8
         FxYA==
X-Forwarded-Encrypted: i=1; AFNElJ/Fe9dlM1ftv9jR4KZxmEgC63wMzpcJCfUwhtpYrDbiA9LkdmaGv1hX4rTNS2LkhA77UVl0aj8ooq7N@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0nWSgNLWLJ6L2zI3B9N7+2n72AgHOyOYDL2qEzKYvAoJ65xT
	Y3oPjp7pYQGSqcHecDV133TJtcuVPo9zoarGNXGiNdUlDcJS21LpMyNsQOynaBdtC2X8021XUH1
	JGDGFvo6d1RXGZXy+V1glNl50mKOo7NmHHlqa1al627tSvYiRpCdaiLJZNSXJfms=
X-Gm-Gg: AfdE7clxLoH7h1OesWBSWk6YD+mBDgd2gsay1dHKbYFewdAp3xYOmvQ1t8zQd82ES3B
	cfBZ2C1YbJ0QVdiJuf6o2h9l+FcxNdokPnn2Gn8PbIffBruYJ1tywA6XYoExqGgS3alpCe+X4wl
	Or3fSPE3gnw/XIURs0u7X/Fy11Gs4BmMYoLPhzaEqXvNUqSMC0hVLmyqnqXdlxlukjgybguJ9K/
	3Y++Cpx6fwccsS1YbMQXg607ejImetFaRBGbZRs4I6CcPWU0y+T4qDs05ENxvT978VXrX6JzDMW
	zQD4pvWKv7TDg6iKTUvQf1aZJ33VWj/LmgiZ/aWjg7FB+9fy9QLOw3fU2v5tlrjsQct2I6qUcNQ
	GvUkO
X-Received: by 2002:a05:6830:6c13:b0:7e9:c8e3:4473 with SMTP id 46e09a7af769-7eb4cab81aemr3738468a34.16.1782992459833;
        Thu, 02 Jul 2026 04:40:59 -0700 (PDT)
X-Received: by 2002:a05:6830:6c13:b0:7e9:c8e3:4473 with SMTP id 46e09a7af769-7eb4cab81aemr3738459a34.16.1782992459405;
        Thu, 02 Jul 2026 04:40:59 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:59 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: jhapavitra98@gmail.com
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v3] ceph: fix OOB read in decode_watchers() via missing bounds check
Date: Thu,  2 Jul 2026 11:40:33 +0000
Message-Id: <20260702114034.917507-12-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528115916.796696-1-jhapavitra98@gmail.com>
References: <20260528115916.796696-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pavitra,

NACK for now: this patch does not apply cleanly to the current
testing branch or linux/master. Please rebase and resend a new
version.

I tested it with `git am -3` against both trees, and both attempts
failed.

-- 
Alex Markuze

