Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E813812D1
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789625; cv=none; b=l3A/EdnyHmHc5hpZhTNbW3H9wLVAUiwiOqJONDi0dIq73RTjpYJ02YaS5oCMds58aQIc5aUa5F5UtwVkyWAGSTMvNs7dPGxgRKTwa3A3a+fMAhsnQjYn01C5OvtIi15Gp8DJMlguv3wRIrUBhq76ni2awzu0KbLOAojvqQuTSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789625; c=relaxed/simple;
	bh=tANiSwK27Bb6N4lauLHQ/pG9GUgh81f8sQ6eq0lsUMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tq4SvK19iZGJAlmuYsA2dYO/eEoMTcEFEH1iTyEGWtFC+kDlIbLpw21gpQ3pQM4UyR2idNZO/+h6SzI5JLxE5TLhF7Tdb/XURKLuka+XmEmdaW6tv4nirxORNMG4Xk5h9nekl31xsFQeAWPu3BwFznRf4bgydM6foDibfhH20qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0B9VFVA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFnHzkfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0B9VFVA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFnHzkfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791789622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
	b=U0B9VFVAuEBztqO5C1q1ZdPGefuAlDnGMNzdykF2bHoXUb5JH/Qrjz0VNvxcL9H5RFX82j
	q/4UBvYEDPdozv/glo2NRKCvdKd31vM0UWCMDoG2+RizmbHj0fhA7beeAs6SBZYwpNO+4M
	fu/yLztDTn9PnK9yV6uM0Ux0xVdnAV0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-7PzdAVceMoaxvhl6sy8NtQ-1; Mon, 12 Oct 2026 07:20:21 +0000
X-MC-Unique: 7PzdAVceMoaxvhl6sy8NtQ-1
X-Mimecast-MFC-AGG-ID: 7PzdAVceMoaxvhl6sy8NtQ_1791789620
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1adba2488so964694a12.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791789620; x=1792394420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=UFnHzkfCd2+zQwpFH8MKbFjrdp8dXcUVUn/2IKdfENPuJQ5RDtsLNpXDWNTJRbSVf3
         MpCh4bzJwWgCVSnjI40lYMdGkpa9SzTngS57Gukmeqn4xiCTkwifgq9HI6983G3Ow4XR
         9QESUYNWKLD99biFPE+8/K4BP5XBINMRlz9eTWln896Owzf8xK00H/6Gh0QM4hf3ePEx
         aGrEFIYXDIA6gskqUizdaVRYxsOwOUMTxBsJL6Y5bZAT6NV/wyOIYrxsH1+uN+4YP1vF
         +lToHsnV5LgQjBBwbqa6t5jgaluyZABwDjpJEBSnnEvQ+gsO+kt6R/Se3MzuXbAW+30p
         ZKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791789620; x=1792394420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=aYQeVbe7LPWS38+Nva1AF6iV3PCsc5fXwYQPWBOaWTd6lo3dXSIFYMl/fPkz9mK249
         0Vaa2RKb9aT0rc6oZ5BGUr5IWYQb0zm/zukl/WyuW9Op8zHvsqX5lGNUgJTyKvh8R4AG
         d3hrfKwDvAdFEAi+5mbnvJewhXWEFjp/9pR25LV8NXyUPEulK4qWd3ZC7dG9lbCelKTE
         7p/6bVPMmn0R42WWAgeBccrfpNiJDlu+uqGuSO/2Kqz+ZvFXvURJqp+9jrT/Sjkyqfyi
         sF6OvXzPI65vQe9QQFhE9D5q8aoCO6lYLJSHGg/Ot4Pdtz31TH7aCgI0LXyErjYPVOqf
         vVsQ==
X-Gm-Message-State: AFq9FYKisEyQzCmbKpdOLHh3Vo8h2+jgOL1bUlsI0CjTpFWxe2rTCvn3
	GYoB5by6LdpKn+hLAPhu5yTC2FDAxIdTsLYJrw1BjRQDC3FICAr47uN15TP3R/0Xl0gydPaaQ2w
	utDNXjLNfycYZsd/sJl++9Pvh5/ZN9HM4ve9Xz9SzWFjI2RxCrAvgztL/OVyy1Z/uEY9oJYurOw
	==
X-Gm-Gg: AYBFou2/r395aCf2Nxl0LK6j5fHMqKO2CeEUGecs8eO0mVwKR/zny5A4omUL70n8TbH
	QfeE+CUm50hb/rg7ABcSccM7vIt8aZQkRsvgp149Kkl54NrX5BrFvUCzWeMiCxM6nHtAGG/Dt6f
	3roP7JxcSRGq4LwPpyMrSBC/kd5giAjpw0sl/i2MOhwJzkXwEswmAqqUs954hsWoeoh7IqOV7+E
	UGvIxtueRbgFoKvjSz+Y2cpDCMPIUnlxxeWInslVmjdqLKivAE8HLLjPdBsAukCR1uAsLFoK8w3
	z3l3mdT7rKDvIcU28qNSxZK+toQwmxSF7b5nQjjiosCJc8U0kEGK/vvr/0/eFZ1OO+5nNRdNZEF
	6QvEXl0mklkBUG31/TbaXjyD4UvPCjkAn5AuONkZZVV5esgXjv+wTkxBnP9p6dlx4J0KI+VjD14
	wxOrtC8lUju5Onyw==
X-Received: by 2002:a05:6402:44dc:b0:6aa:e7df:136f with SMTP id 4fb4d7f45d1cf-6b17aeb0eb9mr5827459a12.13.1791789620034;
        Mon, 12 Oct 2026 00:20:20 -0700 (PDT)
X-Received: by 2002:a05:6402:44dc:b0:6aa:e7df:136f with SMTP id 4fb4d7f45d1cf-6b17aeb0eb9mr5827438a12.13.1791789618945;
        Mon, 12 Oct 2026 00:20:18 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b1d2d2fc21sm364722a12.28.2026.10.12.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:20:18 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: validate encoded xattr name lengths
Date: Mon, 12 Oct 2026 07:20:17 +0000
Message-Id: <20261012072017.3427855-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008060738.183352-1-tjdqudcks0424@naver.com>
References: <20261008060738.183352-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sung,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

