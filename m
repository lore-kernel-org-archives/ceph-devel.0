Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815945;
	b=CNEm706Hl4BSRlGKUl7vrA3wt6B8N0vv74xcbfmT1Xq1tGPQAfGMdH2tWfclcWMQbUBs
	 0e5HprLUOVr9Z7Ua+4yQlQtXNiw8RPWn8YDvBPHYjP1yntIOq0hmL/tn1ADlRAdAAMxxv
	 g2ngXHTsaC/0wJWzbdluC4wa0dVT7Rfn2CBZc1sefnfUg8YD1AZINBXsbX//KvM0fSzqP
	 L7zAzJJHqkfQ4ZImmHn/PPMaJ8NE+MAqVWB15KPEvn85zCrvF6X1K0r+uo1StXSaoxm1U
	 K0xQSOQ9Y34guA7SnHmtjfOixnRgbIdG2gledYqrwlPlYua2aDHB85QX9hS+2+i/ruQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815945;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=NU7No2qvrvI5kSGuZhDbi1R0+OdPWfcp1EjMi6K67u4=;
	b=ZjBwA9BIPiGBnbfpYDooac8UvBnmImTiygZpV7/qfkbAixf1r2aHFLd2e2cs4fB1k6no
	 2nssoGpIswvlzJ9ysqCVSU6uOtm3zcYg87okTgzUGlKo2fOH80gzoAua8npe9eQDkf84n
	 VO55PmkZu3QgVV+bHEOlcnyKulSkDAgFPY6V+SjVKxmKVDXJKWzLLGf8DrX4GXRGRV01M
	 CvrCK4AspHlPyhv5SQcPrUefO+BzdnisrfytPqsjfZFvdVXZ1EyvdJRk8q1lF5gG6abSc
	 LXSGOe4oojXHK5bQ/Tx9MvWOMRYjGMWQycC4mjeVO+D9ezVGPScbSl/416K0FYC4a0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TOG8e0gP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Hx0VW2lN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09E606A323
	for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2026 07:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF09E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TOG8e0gP;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Hx0VW2lN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794815943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU7No2qvrvI5kSGuZhDbi1R0+OdPWfcp1EjMi6K67u4=;
	b=TOG8e0gPRKRyhMKehkb8Kd4w/vNNmO7mjxfMvCYATmFoO42+l2LGOE4q+P9oEJzP0oTsgf
	D5iiCIZTBC1TannF8AbSIYUlIaSmhRqT/4f02Yjfc0yt4MWShkqG1cirl0gI49UylRLkk1
	pmB69l7c0vGi6QQiHN7iG8Qj9twkNac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-MT3MepVwM-OdB_zIbmExIg-1; Mon, 16 Nov 2026 02:59:02 -0500
X-MC-Unique: MT3MepVwM-OdB_zIbmExIg-1
X-Mimecast-MFC-AGG-ID: MT3MepVwM-OdB_zIbmExIg_1794815941
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c505ee61160so435783866b.0
        for <ceph-devel@vger.kernel.org>; Sun, 15 Nov 2026 23:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794815941; x=1795420741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NU7No2qvrvI5kSGuZhDbi1R0+OdPWfcp1EjMi6K67u4=;
        b=Hx0VW2lNTVRa+eHLX0bT6bq50MzWwgBcr1u3wcgh41FX5R1I4kmZNn8r/pWZYwld2U
         5yZbNH2u13zON9XxNbg0u0M2MlU5CTDjyRxrQDTZI3gC6eol3y0E5DePfVemsdbmnoiU
         Wa/N0W9QdGld7gA5uDLXo//rAw3j5cf15CjzB19Bzpf3gNJkTi6x2xcakigUy2qxKQlI
         Yb+UenkY9Nbc3ONHgnYYRE7t2XNOlTwhp2uIu1EB7f1kDKznRfgc+CgWtKyAJsdlvaaL
         BoexQffXkUB77jSeJiHvysKA8lGyFfdW6ObOXmnHxvJ9z3eRwpdJtJmXuvn0XUG8rxAa
         SlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815941; x=1795420741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NU7No2qvrvI5kSGuZhDbi1R0+OdPWfcp1EjMi6K67u4=;
        b=SrXIcIjVkHuROd+graS0ZA7AXU6Dted8hXXTiahiM/pCAm7MonQYcMC7OBFAwvhez1
         U03lpvH//WsIDcBJ1QrxUy1s2c9OjpP0Aze/1Ladw0JxU7g3Fu751mTFQSce2C2mkEqk
         q4yXWbn43LiSOc7jlVkDuV6Up++iRJmNkXsoEKngYL/5SuX9RmNiO9t4kzL/v5ZJ24HQ
         vwXccyPF9rVNoVf73l5IkIjn6z/E/tT1bizt6qOcwB4+ImyIrmVQruep2LTYCCbTJKU9
         155eMofhsorjFyeP2gHz1eekvLevSnBGCU1riCTee9GL93uJHuLrzQhw5HAQQeYFGFaN
         Q3+w==
X-Forwarded-Encrypted: i=1; AL+hErGT1VF3wsDdWnWHrJZlyUblN143d58L68WVKCXgDxE8ka+QXVOAzO55BzbowfCYPOa8ZtNd4/0ZOUaV@vger.kernel.org
X-Gm-Message-State: APuU4Z9+BvFFCcUtEtdpbrva/5HA69ZNVZIOrHUA/oJSDKJ/1cvFtQqs
	f5xv2wsBETBBgGqnUphy2TTg8mUH87pU0IpOdnU+3sf4ftoMEh/DyRbDuj8rB5mdqMblY5F4fxM
	7YxV08rXTTguyHUAarZ5WPYmnSxnZgTouFv5d64/eNPvEwimT0hn8o98qt2ay+Vo=
X-Gm-Gg: AYBFou0RFXV3LtDKSdLPQqDn+2Oz3iw1zL3C1A9OSi15qqZr5phZ2UWOfNRCfBUrLXS
	jB06jyI63vb1+6B1bA4OhfChOXmHxOcqcqhiVebW/MufrlyGBvX7Jxse7yatWVZPXEjgxBJl+J5
	M56JxONJ/+o5G13Y2DtkgiDHLQORxJCpWaXl8cH6qq2+fek9XytC6X41edBwWFpaIgrJGol3Kbn
	ZH1Mt5QNlYwffE6xqvWG5TWnI1w3VTpx4qvIV/Ub7dKLohmAqbOZOArP508ph4CQbt/vVN2XfwH
	ckXT1V6zMIpFcQnVwy3ddnuTxC22DEbqZYuDpZY+1a5YsKk5VICw6CsGX8Ty/kWe0aBLcvMLYP4
	mWhAhOFSBokveJjPI4Ez/7WcWC/NPKFV8kWxOWgiHBrWISvnDRuWf0kVrKBAUvRcj5mlJgGJHYR
	Gp73MJFiwow0lBWtbkgAS+LbywQ6i1auBOb+m6YFTaPbfWiMhXR+8rlX3H0aJWD5C32V0FXYc68
	U6qm7jWeCKLhRSx9hh0YdxAm0HhGB2joAqFupzVbwIWf1mWlqdF
X-Received: by 2002:a17:907:72c8:b0:c3f:d8f2:f08e with SMTP id a640c23a62f3a-c5096413530mr759061166b.44.1794815941001;
        Sun, 15 Nov 2026 23:59:01 -0800 (PST)
X-Received: by 2002:a17:907:72c8:b0:c3f:d8f2:f08e with SMTP id a640c23a62f3a-c5096413530mr759055266b.44.1794815939692;
        Sun, 15 Nov 2026 23:58:59 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b24608sm383410466b.30.2026.11.15.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:59 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH] libceph: Avoid unsequenced accesses to jiffies in dump_linger_request()
Date: Mon, 16 Nov 2026 07:58:58 +0000
Message-Id: <20261116075858.4134238-1-amarkuze@redhat.com>
In-Reply-To: <20261115-ceph-wunsequenced-v1-1-6910c560ba9b@kernel.org>
References: <20261115-ceph-wunsequenced-v1-1-6910c560ba9b@kernel.org>
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

Hi Nathan,

Sampling jiffies once before seq_printf() is the right fix. Both
subtractions then use the same tick.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

Thanks,
Alex

