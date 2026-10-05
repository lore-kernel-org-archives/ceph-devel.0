Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97E477E20
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199646; cv=none; b=FWeG07xA2so0HhrKqUpd+Wesx5ytIGxMPn08YoBUelZHpZixjzJ9m5HJfrBys/u2rPr9E5Rw+KTRPRV6cxwRvJS5TubE5vsga91J/OPlrUcRx1rAY32lZef3WluBKKJwERJhKQRbXg+vtfgGstRGTcSgSFDEarMD3bgUfJ3f1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199646; c=relaxed/simple;
	bh=257ZYm/onK9NmjFUuWheeVrDW0MEc1CP8eA0y4JopIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGesl/mgxcdf5/6x1iPzYe6mne9xeYV0vnRIIX/3LLSwZrRrB6vpIcWqlZ8OsHQYJpwq7+ew9dbuLvwclt7t6b2rfPiOy3kgGqMSG67Xa6p6KeBK5pA5/Af3nz04tLw2lTyUXZPY2brvwSekmg7N9j7NJePVMiIj47vpl8G9y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxJpPfmD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OX5jYioF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxJpPfmD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OX5jYioF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791199643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGtB9v1GsGLaJhfSAUhIyFl6i0Nim+LY1YL2weIAg2Y=;
	b=TxJpPfmD92UbuvaV//ohL5MAxSLwhTQt3dbVJ9mfpbOPNx7+btnlqMiQnoQ93JYaoghxm1
	GdIfwdJCHI2NW2Vo/h1I0vR2FPlqX3+fShFm8HKlaN/zkrAdNplQxAb9cA6PxFHILOUxqH
	/QhhLNTu3s5iqriRRS2lneG20CuLr6Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_CiqinRtOJKMaGDjBrAJEA-1; Mon, 05 Oct 2026 07:27:22 -0400
X-MC-Unique: _CiqinRtOJKMaGDjBrAJEA-1
X-Mimecast-MFC-AGG-ID: _CiqinRtOJKMaGDjBrAJEA_1791199641
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e77b7738cso159014766b.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2026 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791199641; x=1791804441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CGtB9v1GsGLaJhfSAUhIyFl6i0Nim+LY1YL2weIAg2Y=;
        b=OX5jYioFp0nyZ3myrRvgIUtVQtoPwvHlHzz0BY1qEc8NG1chnrTHJee1CVfU+h18yE
         GedSlikQ5aenK9wz0yzan8OiogObJRr1LWAKHNpR5gtNp8fcoMGyFMzcBlCdJVfxE46v
         SA059q03QOhe/RN+CtdfiSgLuLixm586VCE7rObXpjM3zLZR9bN5s7xyDGRjDIEmzZBz
         eAqBz65+W/h93jula2qzcl7MGVbTeEnxjaKD3DxBtxuyx0dWE64W6BeZ9ywjPASf725/
         COuJ8RdvqUcOyQ6mAu4hUX2FFDbVbdx3s5CtaaLqaQTWZmLyBeOWVh9kxrjROnptSIU/
         UpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791199641; x=1791804441;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGtB9v1GsGLaJhfSAUhIyFl6i0Nim+LY1YL2weIAg2Y=;
        b=CZnfEI9vgw9MjROghbwwmyWcvBWaKX3tFnqID8XbpO+75I1WbL9VHwLqE20OVC+vq9
         Ih//eH1GiphOqACKB0daHveWlNIakQqq7p7z5VuZpcloqAf9mm7qtORQu3vSaM9uXu2v
         J5+xgHOzkm6Yf+sAXj3U71SEOxdGC8UpPw3y6nE7TcnPo19Qet2V5OB0fHgqx6L0QaN7
         orQPRJqhon/Kp5un8HKaPoErUDweTRxTFfrH+MSmVOiOZ5+gCOV2lqu9cFCa6i8BmS0K
         LZBcOxc0rqNe1mhdW7VTiSB4gTzHAX0cxaxbXkmVGH/8Ctjj+jqwEwO7VBnpEGcbWF2b
         LTKA==
X-Forwarded-Encrypted: i=1; AKwUvBzke5p8xcR0LYpDAOKiafvPwV8yjaQrIXu8iONFM8T4pk+3g6yO5vjK20jXuNvyOXEqOBYQIZd60BaQ@vger.kernel.org
X-Gm-Message-State: AFuF++kep7pfRQWLMSvc5UWU5FaZR9WP2QGqzsujHWjGkjBo09w+1Yt5
	RS3i3LNPs1BoFNDnjuGYPyzBQJU3FI00tRyz+/+EupjvhdfVqJCYW5Eli+Im5UmXs79EHAts8ZC
	m5pNoK9EyuLSQSvV85Er0BkxiE3BYXo6/mUuU4Ba+gPqd1vdT2ISc+LpIJx8KazyeMLuUMIM=
X-Gm-Gg: AYBFou1B2GbUOkLHalMOOOQRDUXhjykNU19JWSyY2D20fzVjAZov2jn12VR1TloZ8vn
	Y6DDFE+ns+Yf2JCvycCsFqMYhzrSPPDUjvYwhKD9539oIa9k44wzU+0/16fbDyqyKfJXaJld9UV
	E57yEkkLiAIvIpNy8/IFrz6kfGvod59f3zopJ2k4I003lPjkGJkhT4vifvbgNbm/Z2iMe633hGZ
	YMNgcrhHxX/CVKladmzny+A5RqwlJ45rGl3k+MULFbYv8CSu19uz/RLALzCsTpXEsnTypXrnTuA
	7TQpHG6hgF0GyNiKWQanbzEKKEUR1Fw7lqSyZAvfnWUpZfOutmvfeJHNXJYRcmod4BJbg49bOw7
	6xjiml1jvGy15xkpV38Ak4NZrQTJinlL/ijb1SB9tvQFSG0gRUu00hf9Em06NGZcGeQm7I6N4su
	+9oci/8JdBv5xBHQ==
X-Received: by 2002:a17:907:9704:b0:c2e:7089:f125 with SMTP id a640c23a62f3a-c2e708a0066mr562305766b.8.1791199641215;
        Mon, 05 Oct 2026 04:27:21 -0700 (PDT)
X-Received: by 2002:a17:907:9704:b0:c2e:7089:f125 with SMTP id a640c23a62f3a-c2e708a0066mr562303966b.8.1791199640780;
        Mon, 05 Oct 2026 04:27:20 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c315965bbe5sm33233266b.29.2026.10.05.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:27:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: fix out-of-bounds reads from repeated CRUSH bucket entries
Date: Mon,  5 Oct 2026 11:27:18 +0000
Message-Id: <20261005112718.1885200-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923080720.1680210-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260923080720.1680210-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jérémy,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

