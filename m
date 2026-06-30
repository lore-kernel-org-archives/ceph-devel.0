Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59147A0A4
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846252; cv=none; b=A+jOY0+XhSg2Hhv7tZwBQct2Zfeo1lW7dYvGhy7dW4sqi21Zh/vc55mKPAXvAVN2c+sFOJajrnxe4dbzfqRCt+I+sXV6AaYgHSrlE2bXOZHBA9gej1We2caix9417eRvCd0m9ulAkW6ni94zELWXrEn80BxswDWL1wlGmhqfCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846252; c=relaxed/simple;
	bh=FTGoRsWmRxwuE3gqkwwwbnopIrv9xJEQFKamMXP3P9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtfFN7AZ6LtR7EJfiZWV4r+GgR0IROa4WGbasJIrBUSenInTerNa2Tya6l45EIEIAYKyyk0/hrEF28N6OpnDKdQe0/muUPJ/i1QApqawp07+nO3L6GSe/Y58fO46os09MK95MLCOPL8GBckfuLvEpPZXWfHE0x3ZiP59//r6gVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWy4TKpZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqRRWU+I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWy4TKpZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqRRWU+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782846250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuolnWM1faOqU3Gn0tQEY+KZcNHWwvx/K4vT1jIfAgo=;
	b=GWy4TKpZcaOW5NnrxzK8a6j+ozm0dVe2UVP0rMMAT6KibWCxcoQ82H7D1KIsT/djmzBPrT
	hQ1g07oQnqmWiFMyxXi2N7wPbMSLsBqjqqgS/Kb5k/DlUpkfpZTHqKE9hpU8SPUi9qcVVe
	XkaP08cllGJ4l7QpIiKxBSyGAmsG92I=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-gtET-fkdNLqxpauBfNRL6Q-1; Tue, 30 Jun 2026 15:04:08 -0400
X-MC-Unique: gtET-fkdNLqxpauBfNRL6Q-1
X-Mimecast-MFC-AGG-ID: gtET-fkdNLqxpauBfNRL6Q_1782846248
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9f565a6e7so1156303a34.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782846248; x=1783451048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuolnWM1faOqU3Gn0tQEY+KZcNHWwvx/K4vT1jIfAgo=;
        b=BqRRWU+ILoVpwis26BVPXYqyJOkb4Q/7VVXnvXiSZ7ZnvdYdz2MecX4UWVCZrt+STy
         sl8dwS2SBn28+Zrz8xEMm0btyNKpk1Cl0XwN45iAxFqbbwa8N1wSZKZ8/dGaGBKCw/Ix
         dUKQTkLaVzR8DYWAjkzJka/NHWYeWvWSRo1vm55jFY29572j78IiZrmTdfNethbRgiB2
         3L3mggttlLgMu5Z1awycSzJrMH3cQFiI7wcwN7uweKYmhXtElF8EO7+MsuDwCNsQI2uu
         HECb5AqzrT6Q3zfWJWQLWLWHKxVeJvEkaKYAONHMSypyJFK0lV9AVa7b3+ht7O5F+E3Q
         v5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846248; x=1783451048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuolnWM1faOqU3Gn0tQEY+KZcNHWwvx/K4vT1jIfAgo=;
        b=emWJNbHNX1XIx+yqbwe+QFuBm3FMpxfjnH4jTaUpTv6Lks1q8uXBj6O6qP4NFZEtgY
         C6ZAHPfuHqhPNGcCM8OAgT6/pyOeqgTBvSskRHXvFBGhGxFZorwe3J99DH+ksZ4JELXL
         NRo5EGI1npokq0EaGh44OC43OzPgq2CUcpSAyiO/yYD9huZvNfhhbMpQfbAePkBUPRiW
         zwVjfmUkedQwtwMd4WhT5ex2BjUL6bWT1ct0CSV1XLgro3apfSlVOkburmvXRDcfx+rz
         b+76Fd6yKeL5PXFnIoc/lDdXnEOke6VUYOHMwge9nSeRqiT5pEN6Xac75URULzYOVcHD
         4rQQ==
X-Gm-Message-State: AOJu0Yy+mygq0tIvwvMrSkFj9zoOoYT85IkobLg2mmfEhYxMOvZVo5/O
	zg9PN1fgnZhddvz8ts/EWaGg8wLHVFBoS0SSQHlXd9yHpXUAiMj2xjdi2VlzEIBLPyYdQgG7NTT
	vkcwtJACxvPgvb3p+fKwqfE0PqbT2sjextuJmJYuS5I03uztu5hHgS1oKZO+aAdQ=
X-Gm-Gg: AfdE7ckZDem9Gh/J6hVztvOAW2txzUMgZwracPhv7Uhs8fi0ZEN96NR02TZBKkc2nvB
	ocqpvva5R/fLUWpaSN2AYDzYqCxJE0XqvLdY8OJBttTH9joW3h8SxET0Vy2hYKuiBx/5KH5czQO
	JqB7JbvpVNBbbcqeB9iAjiKXay/goJd8EsoKoZXepWOxePRWJOpuWR6WExrmmhEgnc7nPNyVHHN
	kL4igLqGQepbgGE/kgH7pmdU3T7QXJVITydU0hhFEty9dtMttixqnFLRqq+TQ+WAYO9h3G1520a
	8F5kcvGjOPoCW+9ZbsuRY+ptjYi9kb3qsMmgTS88hrSB7FhxQVE4XenOX6ZoJTHacgyjmMkqacD
	dluF/WBQ3GzU6qMCbLE1R+edZhz0X9X+cotOa6Iz0oWf/
X-Received: by 2002:a05:6830:6e5c:b0:7e9:f1f2:720c with SMTP id 46e09a7af769-7e9f1f274b5mr2603378a34.32.1782846247862;
        Tue, 30 Jun 2026 12:04:07 -0700 (PDT)
X-Received: by 2002:a05:6830:6e5c:b0:7e9:f1f2:720c with SMTP id 46e09a7af769-7e9f1f274b5mr2603367a34.32.1782846247472;
        Tue, 30 Jun 2026 12:04:07 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2ba18esm3116878a34.16.2026.06.30.12.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:04:07 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: refresh CephX authorizer buffer after update
Date: Tue, 30 Jun 2026 19:04:04 +0000
Message-Id: <20260630190404.460782-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629171422.4163904-1-shuangpeng.kernel@gmail.com>
References: <20260629171422.4163904-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuangpeng,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

