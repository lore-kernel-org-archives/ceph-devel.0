Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372239;
	b=Qqi5jUuOyPzFEAomv/8Ica8qIk5x3RTG32TgHxjq39xzzGA4zw9I2InJeLTr7uJOPR9F
	 KfWafO7Ua27C7x0V1Z/0DIu1Ltjz0+C6mKLs/bXQ4GfbMNJB2DZXkGhBd48lkv2TENk9Y
	 02nnDgqAykLVU+5b1TpVy9XUn70Be3dG91w2Kkqj0LpG4pnfaeHoC6Qos2GdmjhkGUDYP
	 uHfXVw5Cv2OynThI9bGE+szEt0huY02RxDglp/o7NsQHebq5qessIoUfToLJO0vNj/YS1
	 egt2v9y6kT0m38iocAp1BcXnPmwMJp1JY5P8g7qZ4W6kYdRqh5e2cVud0AHQwQ+EocA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372239;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pA7ffUez8uXJBnmDtqlufiiusKMTxEu5kSaIrJvopak=;
	b=4l5i6DfqIPcqPPu0ODU/o+grR61F36EmsCv5ZRPJrg+cdjH8JC9sijzHBjRV2SR4lKSa
	 iW7KbQ3QShdd0chPWRb5w3Yk8gpSs32ggrqxgTZkuA+N8k0wsgpXuxNeLUKST56i2SOxw
	 AVfbjk54pLCkDE6vPmm2r35vxEA0nrK7KDDJG1cRIq7DlGbVnu9JKhIo6mEco+7ESx/ad
	 PmITz8D/DcDUF2EEYcZzsO5EsHvdQzlCcsM2guFRK1BAaHpjyKm9PHwhbLCWzzSxKIOaF
	 idJyqXI6iZ/lwPsTL+wTi1aSk3W6Mcw6VTDlgoEhwoQWlRzboDx8YIrnb8px9mmnYBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2BuQPRV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zp54qHa2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C89606A33A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 18:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C89606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2BuQPRV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zp54qHa2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795372237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pA7ffUez8uXJBnmDtqlufiiusKMTxEu5kSaIrJvopak=;
	b=c2BuQPRV56VIcfg9FzQNqGsp7idWQZjM6U/Ouipd4IqSjk47IO236z9gSpY2fQpADgpOMY
	j4kN8/N0a+/rI1H2cxB5ipyuWo6VYeGweVlASwCuWa/3HSCHyjaz8WdK3E6/GS2c83q833
	U8iR9mom5MI3XzNjDA8stlILLg7VVBY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-jyd8bXD3NQ6khTsT19w2BA-1; Sun, 22 Nov 2026 18:30:35 +0000
X-MC-Unique: jyd8bXD3NQ6khTsT19w2BA-1
X-Mimecast-MFC-AGG-ID: jyd8bXD3NQ6khTsT19w2BA_1795372234
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c50a8e37286so263043666b.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795372234; x=1795977034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA7ffUez8uXJBnmDtqlufiiusKMTxEu5kSaIrJvopak=;
        b=Zp54qHa2XbSNpYmpVS2e/ScVbRbv9eXZOjRnALT7+1QOrN+2khsNe9O+smjrq+3aSu
         f9BlpqYoDfj37FrDZEiOcB2r83rRvYCj1MT8ciGZuA8KW72X8ykNnx6TNuu5nY58b3Tl
         Ek5yqK1owtD6/Wa3g2sl3SCC3V8GfO5YAWMzef8QNryX/cSyprruWcXOCw3EsIwrPirQ
         Bn2pyezHaHDIdn9YeSnfdFsDsEKrsrj+KFX6ojmc5/zJcV8QfwYD6Nb7PGpXRL1lH8gA
         QQvqlNvMASfg1tcse5r2iPU8ZUEbFFU+QYWbJAokZX9euj7klDhBT0MtG36gclzADYep
         H4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372234; x=1795977034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pA7ffUez8uXJBnmDtqlufiiusKMTxEu5kSaIrJvopak=;
        b=GReyQolTaP3SpbOfP6CcyjgNYtHqvXDgTeEes4WbFLAXQ6f7jdaTSD54ZdhxtPHHn8
         3Z4mKLs+wsj1dIpJlsVJ/78Oau1Cwbddz6VJ8wNvlsD04JCO8cDSxVbNICq12AzG5DNZ
         J3cAAWJue9PY3Q2AwtgOZ2R/AIn6Fo6AbT6XbkZcauXg/lGM50thCqWXdmN9z3+9QzXl
         Zc0RXa6GGvxifS/gUZ8g/SWA2eyuDRMKJIdJF+qvMd4JC0DTgfCycLstVcmWLjkyUUte
         fVqKgzRJoBe6WfMH9rg666u0yY2AXR0iXqQd3V8VAwLwfKN3ZGARmDt8AAlffR2dS5AW
         ruAw==
X-Forwarded-Encrypted: i=1; AL+hErHAmHpgSZg7ioP2B9gRxDD8MzLG07mP764E9z9ptJePtSJrG47BNxNGi7Ls4M7Y0i55neTRMAfog0wO@vger.kernel.org
X-Gm-Message-State: APuU4Z96z1gZt41IlylFr9lseXe3DcEzRrrAjyZ7Y5ivORUzuZogPQY9
	XQSo0ckDwCGhGPWNdCLBjHP3CVA2OTaWftUXY8na0kH7pAkv+pRCHAq9inAHsKauLsG42YENxXg
	N5o0M30CHFNG1nkcod9aUI+3KYaR3fuIbO2Nkx6LQuPZT10DBXCYpoAtfrdgq2iY=
X-Gm-Gg: AZFdTZeaGF2sZRXoSVvx/EfsCFQDZ1qeOm4ZBDDUhdrn9S48o5AtnietSTrVGAEPIHq
	nqSPsTYRKqM2o2bq5Y9IOb2pB/5xJrEu4AIQKHWxEf20gVG4Q2RKdPsi1LCJSS9UyTQujHkoFG5
	pdV8NPpSrFaevFvq7FO94IIW86FZYktsFzY6e/kw0B0TVcxloycRxPo9vfQ5UFt4LNkBA/Z1me2
	3jgrFVB+TdgceBqmsy+GMZIbpZ2a0ssZ6JBAnsyyKWve/ZfKy/+P5j27EbotAdb/EH1KWSPVYnu
	8lyNKbYOHAdam7D5dQg7E2SAhFGkYlF8EyFhL6WHY6ImevUptkPqlF8vciZOhdE/pVZNBkhu2jo
	ROihjhfr5oUmUuSHS79Rt0inHBGZmSK6k51sH9k4cpf+7D+J2wLLMy271UOoWMAbIsHoejNUeT5
	CmoXnFsv1ZNFrpr69xzvi/B1LgVDKIzphs4tBYmJYPYvxemouX4sVDQNDgAcRpKKvHEpM921dbG
	ODRIYkoYvFMdT72hd6TXxokDVIuc8NWABRqBOMpahkFONbzH4mg
X-Received: by 2002:a17:906:b7d2:b0:c2e:52d6:1fb7 with SMTP id a640c23a62f3a-c513a82d478mr561179366b.22.1795372234406;
        Sun, 22 Nov 2026 10:30:34 -0800 (PST)
X-Received: by 2002:a17:906:b7d2:b0:c2e:52d6:1fb7 with SMTP id a640c23a62f3a-c513a82d478mr561178766b.22.1795372234058;
        Sun, 22 Nov 2026 10:30:34 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea5b9dsm331447966b.47.2026.11.22.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:30:33 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] ceph: reduce mdsc->mutex contention in the cephfs kclient
Date: Sun, 22 Nov 2026 18:30:31 +0000
Message-Id: <20261122183031.1299267-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
References: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for updating the replay path and snapshotting the send counters.
I think two progress races remain:

1. Replay can miss a wake if dispatch ownership is taken again. Replay
   selects an in-flight request for session A as busy and drops
   mdsc->mutex. An already-dispatched forward sets RESEND, and replay
   sets REPLAY_WAIT. The original sender can then clear DISPATCHING,
   consume REPLAY_WAIT and wake the waiter, before restarting on an open
   session B and reclaiming DISPATCHING. If replay enters wait_on_bit()
   after that reclaim, the second release will not wake it because
   REPLAY_WAIT is already clear. Replay stays blocked while holding A's
   s_mutex.

2. A fast forward of an async create can make the submitting thread wait
   for itself. If the forward arrives during the first send, the sender
   consumes RESEND and restarts in ceph_mdsc_submit_request(). With an
   already open or hung destination session, it sees the nonzero forward
   count and waits on CEPH_DENTRY_ASYNC_CREATE_BIT. That bit is cleared
   by ceph_finish_async_create(), which the same thread cannot reach
   until ceph_mdsc_submit_request() returns.

Could the replay waiter remain wakeable across a new dispatch claim, and
could the async-create retry avoid waiting in the submitting thread before
it has finished the local create?

Thanks,
Alex

