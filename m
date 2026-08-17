Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FF3F20EC
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964728; cv=none; b=V1IRvHqfq7LAA/QOfDcdo6N5fJc+BufV+HF9epVu2HzUdnifV8RGQFuAd1iRsblQKRBDHGxf1DqMKWjvDB0lHQJQ3BQcXXgyAeYJwE38dTFZ23R+NWjgXW4qPMn1CcmWrtYRKVJhY+HR0nuDLjSzJ89+PcVP+k1ksBb5rbDCZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964728; c=relaxed/simple;
	bh=NlBUoSqOqaNDyYqCsBNuc/U0Q/H9mP1CON5lf1dyL8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7njUwAfp+jVUS8PLsttAKobl6RIry/UoXhYLS+AZbC0sGZTRnabIN6suoukuQ31VPJKp/u8QhwFwErL3Rkrg0ip5Auk0IQG+31+oys6+oMXEbOOlTJs+63YP6zmAWGyyhVqxIqu26EQXclPQi1PQH4NOumvE17hLY/LsO7lrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzG914WJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mN7aVK8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzG914WJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mN7aVK8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786964726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlBUoSqOqaNDyYqCsBNuc/U0Q/H9mP1CON5lf1dyL8o=;
	b=YzG914WJkAnliQ4aeJVdoP0eeq8Q/y/3Bz2yGIbcVx0d3j/DDbit+FH6cadDeWtFNflrqj
	9/9raGi/xYJJkgcBMOcHyeFIAiCePqxRAL5dKDOF0RJlUIt1nRunJZQUFM/kEPnrw0aPbl
	IV5Z3xkJjCEFwIEx2N2ohRn8adQ+3K4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-T3iv44ePOZC_5FeaTA-VZw-1; Mon, 17 Aug 2026 07:05:25 -0400
X-MC-Unique: T3iv44ePOZC_5FeaTA-VZw-1
X-Mimecast-MFC-AGG-ID: T3iv44ePOZC_5FeaTA-VZw_1786964724
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ff68c858so274713866b.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786964724; x=1787569524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlBUoSqOqaNDyYqCsBNuc/U0Q/H9mP1CON5lf1dyL8o=;
        b=mN7aVK8LBoUVhic16qs62PnZS3f17F8edcx6RXSD3YNsehmUNL2KpI8pMn9gcu5ArQ
         iAvxLZTKU/UQL5zs0okNTA6nPy2l/UFzvKXCxbG75JXjmt9QhDOGJKrPfH/85MH69e9Z
         H8QYkVI8Vz3ClW6agabxMTelp2IrCBNeBS5QYa5QO2g3W/eIS9v70fh+xUYWI7PrE9M4
         gKNNGpYz+hsORGKy8E1mCRr6Ccl09/A3nz7yQdaEMaQrjCNLqB4VOq2ZxwT9bu+ABt+3
         nccJ88qpqim+mDaA3wh7Ixy1llt7FXDeQHT3YpDlR6ItUL44r4l3mzb0u5isC+CO7Qv6
         NRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964724; x=1787569524;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlBUoSqOqaNDyYqCsBNuc/U0Q/H9mP1CON5lf1dyL8o=;
        b=HslbEIO82P3qjmVCrJigNKRO1Dpclla6bOKi0NdoFk9a/FRwzLTvaU7OQBZg8w957s
         HE6GOHnH+eaRCIStiNxZh7g4eQW8h5oKErZftYRXb3dlY5CRT353zGHLWQtR4wkfHdnE
         Fxr8iWTkCJ1ug/XPuvtDV0yqC4ROqf8WWdRSub/rxPgvZuW9M0yApeQdeSYd6NSA17Sw
         ARNAQ6vSe2RnrqGsoqIqxEt3uGFFTVEF20gqHj6w4oKIH15sa84ZU4QeHpVvlKjntjVE
         f6obXJgJSB9jNTOv3bBgIfzKwfC44GWquzXFwDQ4WHhMUDuIOKkoloZeDXk0yrfkrERv
         Ndzw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1jSpDnS9WNRxRVE1A/krA0Vp7qKH1/uLPLzct1bT69II1vK9EWtuR7jlHdDiez5tvKBEPnVOk7/ek@vger.kernel.org
X-Gm-Message-State: AOJu0YwemvhnatkEMPyWvSL/JIhD7y13Wee81LTeRDljfWDV17d1yQFl
	hDrdKnL9hCGx7Xlw+WoFYTw+BJ1plkfDalxfWfPNgtdMVi5it6Cr7xUeTamN9usNWjaGIUqkBm4
	c2SH1JYRSXUO63AUtpBUl8yPl12BR3F5ZJY2e/da/OQGAwonw+hivYGG1KvTlF7RGwjbzPyY=
X-Gm-Gg: AR+sD10H2UqDgOF7e75EQBVS4lLHXSuWqpcIvpnRna+ZA6COCm0L0wCeyj7MbtoHHZu
	F4972+RCIKD3QL7IvsxjR32DABya4o9Sfknr+vK2C6w2P3q0wAuAxqTmOcj85hW2ejfKdNESTrP
	0FfmhlkmKsBp1MtS59Keqz/JxL5KphYs2TFuWdGms7DS5FWva7GJ49o3exaWXjFy9sqX96NToVm
	wY67WAbfLv5k5yXx7PqeeICeudT8Z8KQPPZosOpvcGWikqEWrEdBwVHDtFx7eTXGYE5svBciV8z
	+WRd9KCaCqXWTBxpYnDrv4UUFYMfTiux4pQYamcrkKuHozPY8RXNMJLnr5IjrHNSSAM3es5LoOB
	fchEbqEjAKh+SxVqImqOzPyvgTCmb/s9QiA==
X-Received: by 2002:a17:906:9fc8:b0:c20:768:af62 with SMTP id a640c23a62f3a-c212a18c634mr1127056166b.22.1786964723955;
        Mon, 17 Aug 2026 04:05:23 -0700 (PDT)
X-Received: by 2002:a17:906:9fc8:b0:c20:768:af62 with SMTP id a640c23a62f3a-c212a18c634mr1127053766b.22.1786964723560;
        Mon, 17 Aug 2026 04:05:23 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185bc66bdsm6644866b.58.2026.08.17.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:05:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] ceph: reduce mdsc->mutex contention in the cephfs kclient
Date: Mon, 17 Aug 2026 11:05:20 +0000
Message-Id: <20260817110520.741393-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812-ceph-mdsc-mutex-optimization-v4-1-fca3b7462f94@clyso.com>
References: <20260812-ceph-mdsc-mutex-optimization-v4-1-fca3b7462f94@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Patches 1-4 look good — the xarray replacement and the wait_list_lock
are clean, and the mutex narrowing is the right direction. One blocker
in patch 5:

replay_unsafe_requests() calls list_del_init(&req->r_unsafe_item) before
parking the request on the local walk list via r_aux_item. That permanently
removes the request from session->s_unsafe. After replay, the request is
no longer tracked as unsafe — subsequent reconnects won't replay it, and
cleanup_session_requests() can't drop it with -EIO on session teardown.
The request can get stuck in the xarray with no error surfaced to userspace.

The fix is to not unlink from s_unsafe at all — just add to the local list
via r_aux_item and leave r_unsafe_item in place. That's the whole point of
having r_aux_item.

Also r_aux_item is added to the struct in patch 4 but never initialized
with INIT_LIST_HEAD() in ceph_mdsc_create_request().

Could you respin as v5?

--
Alex Markuze

