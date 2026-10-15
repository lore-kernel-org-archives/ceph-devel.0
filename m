Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C1381EA8
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075690; cv=none; b=DYPZQ0CocDu698C0cyx8oc+jl+yoNiAV7cBZDSBAwpdGg4rhN8M5AY20tCjFlNg2UKrqkVfJKXIReSlcC142viIKdGB52IxBcrOYE+ddPn/HKwSyqEV4l8NUKcNLkn0xouqY5Vam9Sw7GW9pPsnu2JxYZwF1GuHGdyUVcYA+BE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075690; c=relaxed/simple;
	bh=RCOL0IrlQuaiYqkyQsYV+WcqQ/DHtNGyVC+ps9d8368=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkXByfhv+zQBUFYiauQADzs4zjGwigUrWYuZiyMrE+zXpsg/3lKO5cZFZsYXdUzgyHutg1EqmjXBEaZM4DsrCr4lOj67DzO1cnlqp+eNfqBferg6kmuQjzegVRxtp+WxvZ6tevJ3c06YbhqwsFsOWr7+SkKG3P/fEdSgbBg5ScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yu1bv4Qz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbEcd+g8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yu1bv4Qz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbEcd+g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792075687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Hr1MYEQINuKu3Ft6kxQHdc1RMX5KFjViqCr2eMQn0c=;
	b=Yu1bv4QzREkZ6lxVtV0S+aELulj3DKm7F1+rxBAsZM6fXZgWOFvXgj5Jmij6vDptJuxVwk
	ruCukS4EewwgFRzGEY4Yk/NX3gx65F5iRdLh0pz/V2hi9H6PROHADUAXq/Ws6w0JtlDiTn
	JoYtceroNXHTJz91dXKVrHA5uAPPAGQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-rF2aQzRoOJ6a-D54gOgNUA-1; Thu, 15 Oct 2026 14:47:59 +0000
X-MC-Unique: rF2aQzRoOJ6a-D54gOgNUA-1
X-Mimecast-MFC-AGG-ID: rF2aQzRoOJ6a-D54gOgNUA_1792075679
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2e71425f87so668660166b.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792075678; x=1792680478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Hr1MYEQINuKu3Ft6kxQHdc1RMX5KFjViqCr2eMQn0c=;
        b=UbEcd+g8K9ii75hPWR193AZZRFq1H0Tq/9BFaxtv+CC9Y/AN9esVnFcHpK4RFIwM1M
         OKUloA17uVSArIo1JJ847fbfQlqVwlaeLwbjRq4k+Ie1VS0HFtxKrU+rGsqmWTFiehSe
         n6kOEpPxPrasdCqv5QTheYj1In3gUyJ8w1hu015yU9LWpcpdQmKpDy8ecUvkN5RuckjV
         I5eoAvGlu/PiiWLN/FnnMZqXqNa41igJfYudVAt0IFxQ6opT0XcYPoWkJo4K+H4hN7WF
         bZ5Wx9BYTv3ECUwzCQATonoSKq9UzPpPm67VWQz3NwzgvDypRcAhWJRr7uSfBHDyiyma
         snUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075678; x=1792680478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Hr1MYEQINuKu3Ft6kxQHdc1RMX5KFjViqCr2eMQn0c=;
        b=Krs6cZIwMDKYHz594SeL0oK0xeKEZkwV8zNK5R72CgZAB9pdWDT75IzQv9Nql5Dkjv
         tHEAlUgv71Ue3VdRwXrlzgjihWtnGnZHAsJ+kPB2/dPPHTb78NrnCQBwW8dZt2FUPsdh
         g4uPbNDu8nTA9J5D/3EtjDoO7m4xckPA7Nlxrvpskg2s59O6FkyIzDilX5Hsxky6D1S9
         /cVMHVbxY0PP585hJ0lotqv+vxPi4t9rxhDJXfChypsvtj8SJWNzO1sgdWoSQnosu6+f
         5UDBo/cySnWkZ4u6bwKF1E8rUHVGvaF1Z6ptfMCTMT20CkQmOiSVe2F6Ho6jQ7lgD+bX
         ZIig==
X-Gm-Message-State: AFq9FYIUDIQQg2ZAbYnqBRqjQcIH05aGjgVh8g/fHUS0sMV5b/vpEYms
	xCCkbCXq+E4EZwHKyl956nWuRqdHmSd8FVWZqSlyBEPU39Sk3dN1WeT47dmw0StS0zQ5IADIgag
	8alRodAzuc6DYyVfVGAGSfUadd5m6Lv9NgwleX/UwjULiECnSETaOYmJ2oDn1jKConJAc+rM=
X-Gm-Gg: AYBFou0ihFW48jt/OAACgm8h7MTfWGo55YsI5M0O75z35/+KunpOvqMFNjIo3ELVUgL
	ZMRFNqwrLWLso+p1dPsA7hfxJif/dm6ttGJJUBSYYWEhdcjq+w9gvZ3ja6Y2h52oI9LDZ1rzjXS
	ODuYNq/4+9j5LdlQbHnJWNW249ib+IjRl889SiyH1P9bt1hefXZttmx4lRMBX9Fz4RPRvDnS4mF
	IGO09Ks+1pptgj+wfAD8g34+NHRiGbRmNQzrPC7voOJzVUSVcSnNrEBFuxg60omBYgpiUbHvuKR
	LIECwTAkZvosqJF5vomZBDSnfiAuoJhJTd+nA7oC1Bh78SbE/K/8zTmW1nr8EtjqGISplu8wM24
	8ccC6ICfVi09E9KgRS20+91H/o/DYxCsPLu3cUkV7A2M5OknIE2+QMR2JLVpPUYCoEwcecE6hec
	RSZb4ZCj6Ifu+DDg==
X-Received: by 2002:a17:907:9694:b0:c2a:704c:8c75 with SMTP id a640c23a62f3a-c31a9fb5434mr1685128966b.39.1792075678633;
        Thu, 15 Oct 2026 07:47:58 -0700 (PDT)
X-Received: by 2002:a17:907:9694:b0:c2a:704c:8c75 with SMTP id a640c23a62f3a-c31a9fb5434mr1685127866b.39.1792075678263;
        Thu, 15 Oct 2026 07:47:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda924073sm133812566b.78.2026.10.15.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:47:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH 3/3] ceph: accumulate subvolume metrics per CPU
Date: Thu, 15 Oct 2026 14:47:56 +0000
Message-Id: <20261015144756.122551-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014-ceph-metrics-percpu-v1-3-38c5a24fec6e@clyso.com>
References: <20261014-ceph-metrics-percpu-v1-0-38c5a24fec6e@clyso.com> <20261014-ceph-metrics-percpu-v1-3-38c5a24fec6e@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please respin.

The per-CPU slot is cleared before the tree insert lands.
ceph_subvolume_metrics_fold_pcpu() and the subvolume switch in
ceph_subvolume_metrics_record() copy the slot, zero it, then call
ceph_subvolume_metrics_fold(). If kmem_cache_zalloc() fails, that
CPU's counters for the interval are gone. Put them back when the
fold does not land.

free_percpu() runs from ceph_mdsc_destroy(), which only flushes the
messenger workqueue. OSD completions still run on osdc->completion_wq
until ceph_osdc_stop(). Flush those completions before freeing the
per-CPU memory.

-- 
Alex Markuze

