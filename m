Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667436;
	b=IZD9AjqTJqxYBLwQ88MPPfAJGVEEeU+TADPpe9i/W0BieyxmwD3o8iWaKc8sCInRmBli
	 UPAWvdMXrQecnJH5irSNdBgH4a+i0UyCSIM2zeC+VxKIH36xu8eoHKj5wHAS345Z5KgHJ
	 +/1sWe7qLCiVoS3VR5MjeizRt0AhDWS+tKVrBF+c7rewb6IWLCP0VaIh47GfIK+LyJOfm
	 LbgPBHgpcXCj4uTg8fXPpJbRJ/cHwbBObZNX/GUjM3LY6ZCHezuW+LZAqG2V4ufDkv1QO
	 RBU6AI5orxR8lRSKyi2TNm2R0rr5D4tVRMQEaVhrvh8wqOgAti4ke5KMlNcxoljfNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667436;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=Mc2I0Q/Ud4qdxvudnUfg1cQdzTDelGeR10OIVN2urM1MHYrmY9i+b8MVM7yETz1M6ex8
	 bn420cDoEQoWQ4DC4Oe1MlpPHvAnGYgDpeAwl34l5IXAYgCRJp+YoerJgHA5CYl4tmvTV
	 0Yx+C0hcs9wVs53dWOMOsXUW6lG+GCrXRNzgiLYYUH5iuijptCgAcEnYqbZ/oBfQ9ch4L
	 cQqEj9rHo3enZjjTekEW7oJIxiybY1vvf9RpffRlXfzO1CI1g0ZRpxVII17o1ranBn3EL
	 Zw12UM73BEy/05NaoSeopfZK5qPpg3XwjbmaTS51vAUKBthX14UWFtUdNEuErfIHBcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FzDO5A77;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PSLTuJkQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129B606A319
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 11:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5129B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FzDO5A77;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PSLTuJkQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792667435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=FzDO5A7720vbNrZMmWKsqBhUv6dq4zTcOEcLkVlxi28YJcmzV1oP4ihJ/6DxiUGafv4mb/
	PV/qXInjQR2adb/ZKkEFc7P/O+33Eo+Xw+JTLSr+aXlhiXloCsRDB5SKSxY4E2RoWLk61U
	oczseOf1CWW42y5X19JgarllDdeCYW4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-yMun6slSMvSTu41w3pAfHQ-1; Thu, 22 Oct 2026 07:10:34 -0400
X-MC-Unique: yMun6slSMvSTu41w3pAfHQ-1
X-Mimecast-MFC-AGG-ID: yMun6slSMvSTu41w3pAfHQ_1792667433
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c449a3223e9so98828366b.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792667433; x=1793272233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=PSLTuJkQyVdT8+isM/+ArYkE5VBedfUFoZgVjgMFk1mvi/bWTLBlztFx41Y3JXrQ7g
         veA7I87C4I4eWSRNs8B+iRtoM0DdZwEw0i12p9KXyIxPcZqMHgi9JWC+m4HjuQ2TNLQS
         fe8xNLIn3un4vPScfpduSZRyHPmHwbBCOF846tQHG42DE13mZ9cvKu7WZyolWQNeKpp0
         L4RZQnbewA83rj6sl1cSK1vyRwOqkFxQ2NtZhCigczd4+zLvDVimBVXUFKNwLE9udInr
         +YY1QMAbGyYIr9/TK5aSJ8E47jEwXV4YS+uNyEV9GHbCNJuBGWvFwigQG9U3J4rwIcSH
         PesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667433; x=1793272233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=AzUDd6vwfZj94ciPUCIapgUV+PHTxM8wFZ/5NK4n9a7MptmQNh44xkKnKSuHrjph8Y
         4Zf50zmMbhGKi4pyxeTcdzz0E1JPv0Yf0iZD8c6G8VL7agpOPMFH7xoi0JFNLXI6ruWp
         J6/zjpma2FKwliyXtDFNfuLZd+4QqCa5C1x6dKPNQZxuu+yAtuO7xt4MmRy4n7AmVR+R
         JOqv+Mttdc/Ck0OdZMCPhO+bPGBV0tVycbPrHH2cw9fmjsReCCqWpq174/SzPmItNQC+
         BhR0gFhvcmtOZPfqblBzSCTkD1hyg+V1gBW3DOMe0ohpT+YWEX4VDmw544x1OhjchhRT
         Hblg==
X-Gm-Message-State: AFq9FYLO7AWq58XCGSPZJwXOST71PydJERaw5VZZTCRlk41zpYGi32IP
	0cksQJjM2RGqtLXUrh9ex9LfJFeqotn3euBznt2V7gdEVqMC4SnPBpWTIHzRse8zD4BMMz3qfFX
	AZ3BrbJwQ9e8LblFkp5SU/ezcY/hkmanVELH6Wwva9pUsC9rnnQy4XMwQnt2Qu34kBqKer6I2fw
	==
X-Gm-Gg: AYBFou0vFAvH4RwNHreBTGoc0NS3M499/6L40ZdvSH6k06yx/p5yjZTG1j+hxxRXs+U
	5V5NLWZdmdo2nl+Jq74rL8W0PhkWF8an7vHk/6zg/JtwfT/Lz5Qw6IbVOhFkxUyoEFxFQQE1Cdi
	8hNKqyK8IcNRi/tVdganPF0uIOSs9oB1EjUYBJXqhwo3Z+M1J+C4lr7tebUEh1l/YKUEydnXaLt
	BNW5nfEhN2C9Qw3brD618Mzqb6YXFJMK4Jb+ZpNszUQUUn9msPRFaZ7H9lSPUas5kAF7dDR390R
	PthMsiitnxilZWrtGLqMQ71vCvjQC2vyLXpKrRzryxl1gJycncH8BJLDe325fm0hkaTYJD6lrtx
	3c8CdYESa5VM4Dk/SO1SDZPy566abHutjtBdSH4fxgcxUGUK9yh1tI2ORgykN9OsIof05ZiIGOm
	fpJ8RvKVrOfv6vdrZyjSbWX7Nx3Qdxo7LmbqJjmaacK17j0yywOMMKLGYGuVoxaFD+LRBWOuuPM
	BM=
X-Received: by 2002:a17:907:868c:b0:c40:f9ea:7375 with SMTP id a640c23a62f3a-c46795e8b35mr520438866b.15.1792667432822;
        Thu, 22 Oct 2026 04:10:32 -0700 (PDT)
X-Received: by 2002:a17:907:868c:b0:c40:f9ea:7375 with SMTP id a640c23a62f3a-c46795e8b35mr520436166b.15.1792667432463;
        Thu, 22 Oct 2026 04:10:32 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a57491dsm94114666b.45.2026.10.22.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:10:32 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: read ahead along the stride of strided record reads
Date: Thu, 22 Oct 2026 11:10:30 +0000
Message-Id: <20261022111030.1896752-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021-b4-wip-ceph-ra-stride-v2-1-59a582388197@clyso.com>
References: <20261021-b4-wip-ceph-ra-stride-v2-1-59a582388197@clyso.com>
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

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

