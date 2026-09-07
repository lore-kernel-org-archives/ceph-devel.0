Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899294CA779
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795440; cv=none; b=oXFkUj9MkIRm5Br4BUmHfJMT9E+iIcgQ0qv7UUAWEKWPhHjY/OPuNVY68ExxwD4G/801uOc0GIb8Hlf7wpPGloJOqgGzNiHCvmNJ3VEL92GsE0uRkO/yVEhJLTL29/k8gAt2X+Jk+9QYyuDGQmhY9hAzwFUKrR94Qd3oG6hcIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795440; c=relaxed/simple;
	bh=sn9pdu77hKCkp9lKuDctkKWt4DiwgzukJq1BRnJq1Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SChWXqHgRH0ATnNp9qFakTG576vxjRD6qgqybaX0wzrgGBaw/kZ5gS1c//zHdftn5OwBVmB3aEuRYC3RR2hEjiIsBCAQw4cpItVZfll6/XOfBpTrtdKPmmGbhuELbRkZRseQkCFxhfXED+3KgSM9FyEkuADYyn4XXjmE4KqJSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCRYzM0q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ztuwgcvp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCRYzM0q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ztuwgcvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788795437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3p7EuNQM4V9aKvixs/bbf+GgeD9SYUcN+MCH3zJUelw=;
	b=hCRYzM0qGPQjCZMgvt6us/3oZEjOqSvXwULp0BN/wRXdWYuZvG9agJa181iimSqmRvpyQv
	IbbpJXvEcZ0zLsbxxMdyTqrJdYt8tNzYkWsVGKC0P8pjsoI6VuHjUOQvF3ANBfKFlcmWX6
	OK9MbvX355x6bk1SuOqBukTpQ1PIFt4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-wyuRtVYtO6STFvYm2Mxu0g-1; Mon, 07 Sep 2026 11:37:16 -0400
X-MC-Unique: wyuRtVYtO6STFvYm2Mxu0g-1
X-Mimecast-MFC-AGG-ID: wyuRtVYtO6STFvYm2Mxu0g_1788795435
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2192b12cd6so315725766b.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Sep 2026 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788795435; x=1789400235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3p7EuNQM4V9aKvixs/bbf+GgeD9SYUcN+MCH3zJUelw=;
        b=ZtuwgcvpfAkCbIbRnnMk08jFRlQ4HZbLEDT2ij66xaLSEWzbaHUJKc977bp3XfaERh
         k8VWfx0BbxhqoiE2LgTcHAP+nwKCV7D93KxloHs90ZyFdx78tdVr71PPq+Us7Qd51fHW
         yw/uZ5pqwhYS/LkQjzv4Ubp7KUGFipR6MnCurpfDui1zuS5y/6FfcVVI8TnRfIr0RDav
         tTIDC+7g12OKOHtwivfFdvzYgT6LpaaguX/7WuOiByh1+DEbtVbQn61vEGj9GpAC+iw7
         0cHvjos2u2Zgh8JtlaUAonfbaebtNUusEIHdMSQMHkYEBVYB5haDRthD2Z5XO2kfjqDL
         kk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795435; x=1789400235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3p7EuNQM4V9aKvixs/bbf+GgeD9SYUcN+MCH3zJUelw=;
        b=WMIg5Imu4hcplu16a9P4UyHzMxs2fEDVMZTkru8eoAqxeHbkZ3LrUJ79Rt8uBtAmfv
         sW3BvXS/jjG3h94dOYDdesgg5e1ELTWWHHyBD+um5GGL1sQdIcmacF8Jy1X9HlWiQuP/
         j3RbDbl/pe79kSa3rHvkOCtt0+2DGdEeI6lqaNjv3rhYvQo8A6I68GZknoNkoNZIMlxu
         3vHQ9+z+XOw0SgBfDfImB7CNoY37eSN00JKVcTUTWXz8M3yDYF5OG4r7xHZsFSY46sr6
         Ex2ePu5QxNMSKFdKQXbJtxmI4Wh4zKVvE9B32j5UNAaAuvddqk7p6mkrCS2pHsA/+Dur
         jHHg==
X-Gm-Message-State: AFuF++m2l4KrlK6caLilq1gSOtyhrK3uwEkWu8sxkGa1arbzcNcS3j1C
	99AUMuovOiHiV6UYquJ4j+Cqes1mfsP9BQOvp/SzaVvbZGpAkjwGBpqnaUd5HSA5NlQjfBjK8wC
	m6uNLEvM7t0t/TKLSvJt84He1lu6ChgPxNwFVabzUvxMEsBIQXV+NfqtSPnlrcyEgIWYTvgw8Yg
	==
X-Gm-Gg: AYBFou3sgEZN5bSwIvGeZNwIn/SvmqS9clBVoKMVSHnFQKF3V0L5jNFn7CEMO97U/Zc
	aGJBmyGF4xqwVlTKm1S7DXUdTV0GydSmmqczlBv66xihwM9b12Wqvd4thPIbN6Qo/Cmdx9coPTy
	7Euo2ylDPegvdkvNSyz/tK1+/LpZNyTTgUeaW778jqnHF6cmu6wDjhVOGReMX7hLiIy5duKBuWE
	nQIx2FUy153XFBOVLY7SYiodR7fpV/EEBaSmv006KdoMye0j9TCI2mxDKNvENU3HKAK99ts/9H7
	I3muGSpNbp1as0XyziddLptcOMY9TD8LQW1lW+HUIm8nOtSlVctfWWuROwSReONrZ5Q/ucrDoD4
	9K69wzS/k9AICDmGTJsQ2d+twrL5z9cMLl52LofN5Dm6/rD+KG7BRgTievDy7ecE6gEf+uaOCKW
	c=
X-Received: by 2002:a17:907:3f18:b0:c25:4e5:fe33 with SMTP id a640c23a62f3a-c260cb5fc01mr1567864666b.24.1788795435044;
        Mon, 07 Sep 2026 08:37:15 -0700 (PDT)
X-Received: by 2002:a17:907:3f18:b0:c25:4e5:fe33 with SMTP id a640c23a62f3a-c260cb5fc01mr1567862966b.24.1788795434712;
        Mon, 07 Sep 2026 08:37:14 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca88fsm325027966b.17.2026.09.07.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:37:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [1/2] ceph: fix writeback_count leak when a bounce page allocation fails
Date: Mon,  7 Sep 2026 15:37:13 +0000
Message-Id: <20260907153713.3698805-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904-ceph-writeback-count-leak-v1-1-d41b070bac9b@columbia.edu>
References: <20260904-ceph-writeback-count-leak-v1-1-d41b070bac9b@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tal,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

