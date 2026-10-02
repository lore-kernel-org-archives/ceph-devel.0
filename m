Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF62D3A75
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924764; cv=none; b=Y9lxMZ2jYzjprMxxNBI7xADtH/OU4/dUxFV4liQgelW/6KK9NaabitUdKtFjHmt2hvBGcSwPKvTWw9Gr0G4rUGEvV4h4/eI8STiWtwixbw+fDqVk7rEKauly2Z3327YNhCT4NANw3714tsBLb0yUX+GnXPx05D39WEIl505IHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924764; c=relaxed/simple;
	bh=ntHn2gIpIvReRVp7063/8qtZhkrD3CTEsd2uucL/UEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1HuX7/QZBlJDpIRp2l4Rg5MEh4KcKx85ravnvHC810Xo/QdmszRpnMMzi7q9dC1Q09En7NhCoVCBhxnRsUaame0psrcjXwly7iNvjMajdyud8NF5njh4404JuJo879nn8Xa/fCBJKkqT/LBVEfkVhXEfzVmuYVPI2jAuZRuMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cleh1b7O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oTw5thrY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cleh1b7O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oTw5thrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790924759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfF2x8RQWtyAXGsaiMhW876SPgXy2qzFrBI7xjxo0ww=;
	b=cleh1b7OuL2w9FhE+9kU0VRrqexwjPcalpfJKptPHCBpOdKMPeJQLjJ42uqMBNBafaw6B7
	I+WMYat8UmQFIBFt6+tmBH+KP7Ua560mw5MgSi4Cumw1CELJJCRfAtceEkZUGX5U8RS8DO
	AIVWNHvkH0Z993k0FQ0vCUeoHkdpYvo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-v5jBLPBvMMGia4g91t9Apw-1; Fri, 02 Oct 2026 03:05:58 -0400
X-MC-Unique: v5jBLPBvMMGia4g91t9Apw-1
X-Mimecast-MFC-AGG-ID: v5jBLPBvMMGia4g91t9Apw_1790924758
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91785bd637bso91665746d6.1
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790924758; x=1791529558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfF2x8RQWtyAXGsaiMhW876SPgXy2qzFrBI7xjxo0ww=;
        b=oTw5thrYnN0LWQQlc2IFV45tizAk61R8P4DEx61ZuH++r7ZxLG88P/EcJC4sxfs/Xx
         hIQHcgySppgeR99G6MFti0d93N0zitOBbcp5+C8BmORynpnPQwglPkG58qhMMgI9aiKE
         xMcJg92uz4+YREF47ZVAJEi4FoDwNtz65TQmvi7yIHGDipXPFpUFow3bq9F3H5KNL+tz
         dvcLGI9dZe0UFWoaM4dzZXSZWkOjJAAgZuo4k2AmFBDAi4RjW6zpCjn7wXeaYGRxBp8S
         s9xuXks+Cl3P5f6WT4FYHtwW8Pa1emj9jLiJBZF4TamKrYC1srcXT9DBK82WR168DyRu
         YqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924758; x=1791529558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfF2x8RQWtyAXGsaiMhW876SPgXy2qzFrBI7xjxo0ww=;
        b=KYFOX8aYZX1GS98NF7spwE4srbHXyuIZISNlZke6ZJaP2RQlygN4MX6JUk4XS8r/xR
         OCKJenKznyaLivRzQ5OGNR7Ip3rDmgmrq+ijncEaQFVb1pooczLapRbJ+pvKxkJVytKn
         eIBZejUVf81l0fnJvvX2CZg7GCRbakeREMSwoaZu00bi7vuCASmvilYWu684mj0slZjQ
         sjAoe+ST374yvcDtlciRgh4gZZbNyNakUsQRrJ+NXK2QGqugaroPowg7+Ck69cWhRKAE
         5XP4zyVgLKWI2m+kpQJ4m3zSMKm4IYutWI18aFBlU7JpNhQDLlL7uDoIJTiDmr6/AppA
         kAFQ==
X-Gm-Message-State: AFq9FYL2Cj8DqLCs6HAjAzjqmLeklxdYiBCrJ+4n8bqhvExxVI9RHsFL
	GWgfnaqMnUezFseYJ1gHV9ONfRoYpPulURajdkPQTWAwPwnNnR3BoAajayvTFQMIV5ApY1nEazf
	+LzQh2Nav7eVxyT3fkonV3gbIInVLRhGC60P5lYF5dhDEXihH2IGwlKnIkxT91V4=
X-Gm-Gg: AYBFou39/54Ne1kgLW548G4rwS+cZrwj83rr7LRkBSfnZ6uZW8MC1iV2Zp2lGaxPy6V
	xRVuW4KmFGKFIsarngFAk42y6hzmdoSA32Qop3sKwR3qmO06Q8daM+NaT3mAFQq8zAzvu45WGEd
	TPrdLamQtbWMvLugizHksxWGrfiW7zI1YfYYpceQLnKyQtcUfFvBS4cV2tKrAJnvDnTwsQYS5hP
	/xvXnMqNyTbx8hNj9eIBbK0JLdJDjkoKs7VDlnoi2kwrWXz4EqSOFibpj0uwQhGbm/imxDYn8dO
	ZtLPROSqF30LtKPJbTesY5G28Tqrj1uHeCpz4XJi4VWmj1n5T4zqbSzLw7aThwthRYwixjpZ4K3
	LS1g4wjDwDDGH3afycK0aDNjpnXP4Mk41ket/gCOdXcfU9Fy2AfUMKJ3YVqC/OzEeJGxJPYZJkJ
	BFg2AeoqPpBYjgzw==
X-Received: by 2002:ad4:5f09:0:b0:90f:5154:6a93 with SMTP id 6a1803df08f44-917c00438eemr37970466d6.11.1790924757902;
        Fri, 02 Oct 2026 00:05:57 -0700 (PDT)
X-Received: by 2002:ad4:5f09:0:b0:90f:5154:6a93 with SMTP id 6a1803df08f44-917c00438eemr37970086d6.11.1790924757276;
        Fri, 02 Oct 2026 00:05:57 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c3a0b5sm12946686d6.45.2026.10.02.00.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:05:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: reject bad connect_seq in msgr1 READY reply
Date: Fri,  2 Oct 2026 07:05:54 +0000
Message-Id: <20261002070554.1628799-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920115334.16219-1-ngocthang2710.1999@gmail.com>
References: <20260920115334.16219-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nguyen,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

