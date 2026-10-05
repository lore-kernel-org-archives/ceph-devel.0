Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D73DA5A0
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200803; cv=none; b=hP182AJHN5SP5THoIYdf6nId+oyZ0EEHZIsfPCJuFXse/Z+WXTCBZ96JjlUcK8lGM3deat6Qq8YRkuewvZAZLWzMcyQskHmRxA+HAN6dahcB+Q4zM9cuuQdbPw463CN8xMD0y0x3LDoLuNU1JTTRmW2o4LCo87C16QbPW0NpMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200803; c=relaxed/simple;
	bh=uCyM0+PIjxayvpfvRv9JBUXuj6HqF9nwhvuwLZTnOeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loRh/jnOgZjbRwP+uOOCQTXJOukWMRNw0Lrph/dxCERGzoZduACbb6gAy15IwDPNIUm4CZK4o4hsc6qO8lWLp/Ynw4nD/pQraqfNVmbtsv8hXOFLHsPaulf4YJLsr+p2D1RA0OanOurJWahB7aqkhqi2QsT23SWX5ZhUKFse1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hoi6d1aT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bdx4STwb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hoi6d1aT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bdx4STwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791200801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy92/h8ADBZqNOZB89dPU4Y3tXGsnhGvUjg0l5F0MSs=;
	b=Hoi6d1aT8EPnCL1IY/XdM3YmwFhdHwPR6s0ca7cK678UWs+I1wA/fA1pOS3Fg4laE00/kY
	Fc/TBpvjdjeMHPeiUMsFS2tZy3guVfkuS8CzEmBZqyPdgMBFrMpzJSZiFYbKCuagLl0mFk
	Mvn4kOjpAaC7RcuRJq6wb6lTmp/tBLg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-0i_GW4e4NxuNe_S8suXQjQ-1; Mon, 05 Oct 2026 07:46:39 -0400
X-MC-Unique: 0i_GW4e4NxuNe_S8suXQjQ-1
X-Mimecast-MFC-AGG-ID: 0i_GW4e4NxuNe_S8suXQjQ_1791200797
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917b76ad48cso43897626d6.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2026 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791200797; x=1791805597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uy92/h8ADBZqNOZB89dPU4Y3tXGsnhGvUjg0l5F0MSs=;
        b=Bdx4STwbq89Dl/EkdMGv4X9Denyb7cloUoOhY0PnEiUKVpIQsrZfpigjdvaitxKoHX
         FEk74YPGHK4e6Fp4wvTzY4j6+y1SkQDDA3eoMDoDbOlIRMx07SBdhpNn+ZGOdIHa/Llr
         kF0yWO/bEWWOYJx2OzeZr7gtaFSjGGY5iHZDxl8OInzO9BtQ7Ki1VcBipLRB5v7mALxL
         nXLMG9uCXCKWWxkIrAw9UFuIDG2r2A9dPpLYgPsoG+sfSN7jMh25iwMBrWswKKBfIFD4
         F7pfryitbX18ghIen2ZlOGk80cJN2V/0DBniAbLgOAosQXLHMyrsZozcU7GP6d2tdduI
         D0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200797; x=1791805597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uy92/h8ADBZqNOZB89dPU4Y3tXGsnhGvUjg0l5F0MSs=;
        b=zjxVwmF3z0vHr5g5p9tV2wAE05qzRZ9FmadMAi/BA42tJxI3J23g+8C33XvxosO2uW
         ZT3gn0NFNCUUegJbOmiCoUShHSNPQIJjv4lKvv1v2R1Pq4uc4xJMOwOf++CRG2fWIvZN
         WbXqdQ8fIVPIB7GKt/9tV53tkOm81BliIXpyiO7SZJa9QvNRsBhSZuE7WcRgUxp+vMKu
         ORWjjVywUgOkvHCNlji4MzlfzrOTiZK819TEmRxhRIb/gJXk6gb6fULGw8e5Ti2QCm58
         PW6WYugcZh/mh+vdUpK0zs8OpJjrmO4oZsx+BNbUvnITn2EYNbqrWLv9wDFWo2p5acJs
         CysA==
X-Forwarded-Encrypted: i=1; AKwUvBymWk/UI9664Z0q9X8D04MUK5u6XgeLaE/KcXRoPWDvUdNOydKNXB3vt5NZSON/pADTs5X6s9j/929Z@vger.kernel.org
X-Gm-Message-State: AFuF++lUNUd//e13g26fMdlNKf9ml3SlQ1EJyiVex2E6lX6ay2Kkwnin
	7vqjbutXCVAODd0FlIEag/oGXAvWQ60wM1nlf8Mbuzq9X+i0TX1OEm4S8f8ao3egAucoZ04HuE4
	Dka896HvTiGg+EX+ZpCAXGZde29Qos0FqIyCDKbDffQWwCqTvcK2B8HCIYQuYKtsPJfLWamy+cA
	==
X-Gm-Gg: AYBFou1+9c8SIly0btecAkfQ28j+a5Hk5mdK5jya6YGRky1CKu0Cu+qQtuj/rD56gYj
	Mk7Yo9So8pFMuUT18IcE/8XZ8psEe4Ww4EDU97MU0+hiKk7sqx6YMwRmAfhlpmnY2BR6UFjkNIa
	BqQfW6LtdjHkUxoIlRdEfKWA2v8Khf75ndS3fH9NyRTDTKi5QSgy3ZJnOgwZfBD3culwyML+nbZ
	hPFp2yvI7W5RitB/Jv1hS50oVqV0ZFJJQGwYBSvZ+DjdMYLrQQVwIJOrDerpDoabmReSgthdeIh
	NsgZqSSFxAYSYk9vDi1yQ8jOF3MQB9FwVqc7pXsSqqSA2/hL5YMLMeza7FHjlBRbTXxVpicJyZt
	bMhfEyWysyohcLE1pFukMaxWbkQTAFmMS9CN2IE48Rlp2oLdL1Q==
X-Received: by 2002:a05:620a:2626:b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93cf18a0e40mr1743727985a.47.1791200796983;
        Mon, 05 Oct 2026 04:46:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2626:b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93cf18a0e40mr1743723485a.47.1791200796338;
        Mon, 05 Oct 2026 04:46:36 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b682dfsm85899546d6.19.2026.10.05.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:46:36 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ren Wei <weir@nebusec.ai>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [net-ceph,1/1] libceph: initialize CRUSH choose argument weights
Date: Mon,  5 Oct 2026 11:46:29 +0000
Message-Id: <20261005114629.1891786-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e7db8a6e1dbedd5177b772b570674e8a00b23214.1790491709.git.zzyy19904204639@163.com>
References: <e7db8a6e1dbedd5177b772b570674e8a00b23214.1790491709.git.zzyy19904204639@163.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ren,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

