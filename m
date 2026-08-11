Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A97443E4A
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455805; cv=none; b=IDkSSUJkMOGTqTX80GvZwCNQJoNASy6997C0flBYt+5w3M4utTbN6y/8Cr21Kp2IS07sbpHdpilauZbsW15ZDZs1yg45vEZpptt+aoTxKBhA9Op2GYjmOTRn3CcEuEthAUlCAGM3wOHBaAQJnxRVl/LQLhLI4mqFolJr5bYvVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455805; c=relaxed/simple;
	bh=SXunBIkGYpsE6YJhxJ5sJAljxDKXTu4vA5yajTJifGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZZwUwdKHnGmDIwZQEfXraKHgePy4lrbDmC99R++jNjLRqnOyS83EtKZy//ytSk339LzSA4OfT20uzsaTe+0h0CYtH4TfvhUrIDtI52nurVcExw0pulSNdEJ/x44l+2X/LtpZwy8P6ydVVNJGK1hH/tT+x60WejTQgdsnxMUu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9L/Y8oR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOT8Q6Eh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9L/Y8oR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOT8Q6Eh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786455794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aT0wmwduwIB3OJWjo0TUQ+YsRxFkI7VthQfCRclwJxg=;
	b=T9L/Y8oRm7rgNY7UuHqaMf6dYHEZ6h0cxTnI1wkk90T0HLca1LPA7QAvlR1vp4rmupTKyT
	NS4yDrhmM5ApTwpJPOU1dyvleM24V4PSYUmhEyPNfhHth39FV+H+H4jKXAM/A1/4CGdvcd
	N49RkgvYzKxY6CdLIxppH+xfJ72u/5U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ttjYxrfxNK6KlPURgE1zyQ-1; Tue, 11 Aug 2026 09:43:13 -0400
X-MC-Unique: ttjYxrfxNK6KlPURgE1zyQ-1
X-Mimecast-MFC-AGG-ID: ttjYxrfxNK6KlPURgE1zyQ_1786455792
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c232fa136so105986966b.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786455792; x=1787060592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aT0wmwduwIB3OJWjo0TUQ+YsRxFkI7VthQfCRclwJxg=;
        b=QOT8Q6EhCA7uipDo5GtULjd1DET1m5rS20tPrfjHzQOBhJLPQOk+sFpjnqdmGW+KGL
         jhmm1bncKF5D1ybmXe7dz/ee4VMpt9WBz5FY/GWcbkYbRks3oTq+IfQAGlrFVayyg4nO
         BOjixncFk9Ps2Vz1hPUq0F/re18uBHD1s3biDvjPUxd99ADkD+axtO/cVSAkepYTo9EQ
         ht5eCKAWpCbYO+SPq63AsgEWemPiB5Y02jebldbV7BatT6g5ZG6vPR+kmKpeNCOnlkYW
         L0IRGETmis2eE93XU2ubrxIjB20BSWmk2Ps1yAdRhM6lUPXIF35Md5kLwKb1Oq49uX5Z
         nqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455792; x=1787060592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aT0wmwduwIB3OJWjo0TUQ+YsRxFkI7VthQfCRclwJxg=;
        b=EqZqSkaVrJexxgKc7MmY7JQHfpRaaqJ7snnlmyWengfLO5tyc2IsbLuKmrpUrR6Tpr
         yoVEeuU4LaV61YN5iA4k2civaK/qNCBuwVMGu+PVuKZNXQIVWUpNdWbYhNfCY2tW6w0n
         KbuO8hoDeIC+6RtrUgKVB71soH88KEkFjXTHyS4gBPBAVo1Txl6mL+rdSow2u/IsCsqG
         eHymO/xD6JAjmgufYt776fA8kA9eCRA2n4wx8XvqmrD611XIHQku0QKIGN5WTmSl9pmA
         7eKuQAo3DacqOv4huquwHCN8Ggb91crHODGdx0kQy+es9Ls8IZenCR/3yrF8EsB69Tit
         i//w==
X-Forwarded-Encrypted: i=1; AHgh+Rpg7cfLDnQeSvrYE1ia1Os5vmA926IkguZVL8N/eZrK/IqD3nSfRV+c9muWrq113o5MjMG+vAuPX7ih@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjhxaqzn924Kh4SjLwV/2d3ZIfawQpMW7iTjWInhb74oEAxcb
	aCk/fszNmaMJsaScjIYs/fxAeNOFBz0B6cOWjcpR9cjDeQpJtwQMIqAl8JZj2WHUyK/KtugZz8+
	RxBfkkX4GAu9x7ZQvnVIa+gk9I0TGNFfU6dYid8bfX5OKC54PySnaSfwVzl3mrAY=
X-Gm-Gg: AR+sD11lQsEUR0s91Gr7zX4oYnivsvyvMB1uG4vXGZslPfdwC0ZGnL2eYS+ILbG8imk
	MSoe7YEgj/m5oArgQBBQ3dF+z1+GxpvGymFu/7hMmCOWmGYmsjg6n/l0Sm01+FuwAbLPHgSLNFx
	URjGOOdcBMqDbCb/Jgd/rVZOTQSepgFr++HkZWwueNj+BfYT8ODOWPpHN+IqrRM0Co+dHBuxe6U
	phUX3RJY0P2ITh1Fn/sXXg3pYgpNXkbqY9VnzGDOnMxrXU9nP35qhQK9ztjMzMoJkBKo66iruvG
	KbH2lzUI8STRV8AonGkjHinnGgA3ceKRDh1ixrlgHJuDacsBgceOLc12D5AunPp/nCc8Tzj7Ftf
	N/IdTQBKL6GnRzLBqHQhvUWv6DHBS39W7rg==
X-Received: by 2002:a17:907:3e23:b0:c15:a7b9:2ae1 with SMTP id a640c23a62f3a-c20ed0e2693mr11629466b.6.1786455791873;
        Tue, 11 Aug 2026 06:43:11 -0700 (PDT)
X-Received: by 2002:a17:907:3e23:b0:c15:a7b9:2ae1 with SMTP id a640c23a62f3a-c20ed0e2693mr11627166b.6.1786455791368;
        Tue, 11 Aug 2026 06:43:11 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e435e313sm56951366b.45.2026.08.11.06.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:43:10 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ceph: move mdsc->mutex into __do_request()
Date: Tue, 11 Aug 2026 13:43:09 +0000
Message-Id: <20260811134309.2689490-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811-ceph-mdsc-mutex-optimization-v3-4-d031114419f4@clyso.com>
References: <20260811-ceph-mdsc-mutex-optimization-v3-4-d031114419f4@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Two issues with this patch:

1) kick_requests() list corruption

   Requests are collected onto a local kick_list via r_wait, then
   __do_request() is called for each entry. If __do_request() puts the
   request back on waiting_for_map or s_waiting (no mdsmap, session not
   open yet), it does list_add(&req->r_wait, ...) while r_wait is still
   linked on kick_list. The subsequent list_del_init(&req->r_wait) in the
   kick loop then removes from the wait list instead of kick_list,
   corrupting the wait list and orphaning the request.

   Moving the list_del_init(&req->r_wait) before the __do_request() call
   should fix it.

2) Double dispatch window via r_attempts

   __do_request() publishes r_session and drops the mutex before
   __prepare_send_request() increments r_attempts (which happens inside
   __send_request). A concurrent kick_requests() can see r_attempts == 0
   during that window and collect the same request for a second dispatch.

   Bumping r_attempts or setting a dispatch-in-progress flag under the
   mutex before entering the unlocked send path would close this.

--
Alex Markuze

