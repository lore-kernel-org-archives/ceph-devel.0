Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2C53A3A0
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075733; cv=none; b=g61o1GhsM0OtObc0bZxeCVoOuHosH6E9/15acrSCRFtRxGhnxxNwbqGjNNuAschyLdsf/ZyluSZB3Bp9T8eJV7glkTU+QaAxebS95QgLuQyulyhP6gfxOtiu1JPysBh7UHXgLKBJoxCMCqKH+N5tIcrPVdhQdX7GfxiUwHHfBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075733; c=relaxed/simple;
	bh=fagoIsFsB1ppqeB9FLA0RG6EtNMW85DpkR/00tgHQ4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzYh9Oi9eZxeR2muzri/O7cQeXGQx9NLH5FSuxyM1M6EJ3/MYSxRfq4KnpBNjv7GUpuaHZIAtuZt56Apkg4OOru/kIONhvx6uN75+MYboTxFeZDgJsGcb+oHlCU6q+UwFzI6NLY+0PxnZxYS2Bfpuoef07ehuOvLBNHS8Ken7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ/CPy7g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kF/kY+gQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ/CPy7g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kF/kY+gQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6f1Tv41G1kbgFM9Qsub8iE4zCUOv1XF6Ga5zNRdZoE=;
	b=KJ/CPy7gRja9lX5Fexd2TsWmKtJwtzFeHE7Q8xsIZSoLZ0/To7wipndwJbHIcESrlNFv7g
	QsnXP3LWahiPu7Qkz9AJ3BggE+T5ljDnMj5If0V2hvgpcso/CR7xbdECOKfsz/akwl1DJA
	zuJPRzi4qiArNWPyqoMputYYu4h5N6M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Yrw9xXaSM1iVlvM8cafZzw-1; Tue, 22 Sep 2026 07:15:29 -0400
X-MC-Unique: Yrw9xXaSM1iVlvM8cafZzw-1
X-Mimecast-MFC-AGG-ID: Yrw9xXaSM1iVlvM8cafZzw_1790075729
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so753362785a.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075729; x=1790680529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6f1Tv41G1kbgFM9Qsub8iE4zCUOv1XF6Ga5zNRdZoE=;
        b=kF/kY+gQ/g0FMwXb2cejtyr4Kw5IlY29uPwJX+XUBnehFdKT4RvV547MvmHRwJ5C0M
         /bYvAMU/UiKAFqUmgeq1lcCfnSNfydyjOToZfs1zeV5803r7ZUKr28rpNZB4zEMF1cYm
         wwxMuiie/naz6EGW0zAYEHOmIRsjhkAydTC89S+YvLPHLx+jTPoUTEpRTsKjCsvdIM7s
         Wet6FqNfD6vP4NDEqHCMCmmOHvb5JPHhsWQ/O4O3ZHFksr5YvUpN5/kOCnnZxVptPQQB
         6po8Cm6DhCRWEDDdWOMx3HY3x8jdA+pyGFenKAHpFhfZ198DBoz1HZxC3UWGlrsrWYlP
         AFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075729; x=1790680529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6f1Tv41G1kbgFM9Qsub8iE4zCUOv1XF6Ga5zNRdZoE=;
        b=xCVBwnrFGV1CabI2iSMWZcH0W3M2ItfNu/BJKBnOATGKH8myc+VwxeIIvy4ahaAzkq
         0kYoSySJnojHuVtuGQLuNS3CYabRps1Zl1iuZOtR0Q94pMXsFnEgFk2og2q+anZSMNF7
         b8/nwO8p2EDrEh9mCXLgtp1Rd5RvkZGKO147qDZAgpMZqw7QEbLIn7eT3zbW0F2hoX7i
         sus5p+6KO0U4JT8M+fr7D/tCZYekAUPjlCwRGcZvIpGAdMKaiAnQdbWgGdv0Tt/nuABi
         Up1JNHXS1oEjs1fF+YHnnlGMfsvedpYc0Uo9r/8FlY2xG1J5HrvYqixUIZ8EDp3thts8
         NAew==
X-Forwarded-Encrypted: i=1; AKwUvBzbQsFB9mJ/iayYrSZvTaHEywur43PmQglevBTf4ZFVV52YhIt98737v1DhIejkaV+FZEpvyRfJaWGh@vger.kernel.org
X-Gm-Message-State: AFuF++lbylG6wMu+LYZQrJgLPFyPMkZznZ8WYf77AoUHNE/5H8ajkRx6
	rih69c4io1GOzgN/GAHD9yPnDbRBJWfk0japy2IYLhDWc+r+6MQkDEqh6F+SdGyDM2l35kbhma8
	4yCVm+PG4rvKzZjgzFCxvOVyhp/9/7XuyPoW/tn+s1WmAHfKqf5FByIlSW7m9e7+/mQNA3cxwHg
	==
X-Gm-Gg: AYBFou0mkvn0tgf6tr+2E/3LEw7hCRrWCxnFFY8FWRV1uS/HKcJFyn4vQmZ8VxI897F
	ZosxN1NT8x0obgCUNeP9mMJ4//xHtv/QnsXi0ThtXNntPCzIZnpWNCBSvE+DuGMOEcJ/YVWVIUo
	xKm7FgN6lwIkM9318vaFwA63VmSvX35ff81hHkq2CxravONmoxVoPynQz13E0rbGPikVAXEJrxx
	QikiF72qugpUrG0HH8RTqZOzGMuv+SZlvSJUJvosDWONSF72mgRC1sNY/H196UvaV2OD1hRxiTH
	NEv6YTe3YhladykbIr7ajqmEqIXyBGMQGcrG2DPEJ70GqoRVmdtgTZdGnCJ9Swegj1NaBq1ZF7X
	AlRJVIso8GDP8263W3rvVM+y8n9DbRc6Jzj1W6VYwX6Z78OdZ/8tdyEqIlJTT5BJVQybXoIho6S
	eadAU2jexlS/qTSg==
X-Received: by 2002:a05:620a:d8c:b0:93b:d79e:1906 with SMTP id af79cd13be357-93c15ea683bmr556822385a.73.1790075729166;
        Tue, 22 Sep 2026 04:15:29 -0700 (PDT)
X-Received: by 2002:a05:620a:d8c:b0:93b:d79e:1906 with SMTP id af79cd13be357-93c15ea683bmr556815685a.73.1790075728652;
        Tue, 22 Sep 2026 04:15:28 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d247bd2sm115148685a.43.2026.09.22.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:28 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: reject mismatched CRUSH weight-set sizes
Date: Tue, 22 Sep 2026 11:15:26 +0000
Message-Id: <20260922111526.767393-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910113936.336895-1-f3lix.dev@gmx.de>
References: <20260910113936.336895-1-f3lix.dev@gmx.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Felix,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

