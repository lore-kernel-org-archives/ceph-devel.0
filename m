Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008A38E129
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417475; cv=none; b=owBbrzWWXSCVsu/numHS3nKglaAlkVAcH5TL7elwXnTxvIL6fYLqPQksNitzROCfeIStbeiUM+VkrGKM0NTorupqMAm9XrFV4PKe5xfcLg+FvibLugXrsWEGtKm7sh30aMeeeKLDEokrV8jzQt3mpHBTecuYmjeYHbavZ1pSPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417475; c=relaxed/simple;
	bh=qE5dH4CkvDD61ZnJsE6o43CzMch9qXFudSOelVMbjzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlOTMCr/C4ByT4i2siLOUGJ7lRs5FObhLblE6An6Pqa67mdMXBseVQD98F7DakPiy76l/JDBCjtAgB5o3dhG3nHuVPlju5S9TFxBGxLsJ8XhonMUZ30xv4eUKqXXi0oMpsry0Nyv5jtyKSBD+S4OkI9Elp6AxR5tH3i/kgeamqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTuAhgZH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0AzO1u+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTuAhgZH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0AzO1u+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783417473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRuV1wkpSy04o68Gt085jZXStICYO8LXZ8NZAXElTAQ=;
	b=UTuAhgZHLLHwKD32HNtEHIi2WhD2ER69/Vi4Zb4E/AmQBQQfPr4ka+eStP8TxUdSobiVBX
	hMTDRX3odznGUQCg8n1Ik6Nf7qcWTPU9JzT98/W9YrMW35tOTcPaGUUOye8RmH4A8o1iHS
	8/BVVhn2YS+XLmixxLy6K+6dW1NsI7Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-AqKUNBRLM9iR3qeKEgz9wQ-1; Tue, 07 Jul 2026 05:44:31 -0400
X-MC-Unique: AqKUNBRLM9iR3qeKEgz9wQ-1
X-Mimecast-MFC-AGG-ID: AqKUNBRLM9iR3qeKEgz9wQ_1783417471
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1ada6c43so57483141cf.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783417471; x=1784022271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRuV1wkpSy04o68Gt085jZXStICYO8LXZ8NZAXElTAQ=;
        b=X0AzO1u+LzSJpYDVfjnzFcTLCjpE1l/OEfgFuKEtLV5RZ0SvD+5zMMTAEn1gTrbBcX
         HbC6Jrn2j397qYQdMhv8vpB3Nn0a1oyPcU1i3O/XcdIL9XkqW3lVn/IIFJt2BFyoM9Q2
         Qzm1Qhz03sGmClGcmgIgyqTsEtAsxAvQPSk4bscQyGbTpkXl0WahYKCDU9SvCyBNUqm0
         aZp3EQC5QfHq8SQnO+Koj51EtFQo38cYh4TvgJmjtJTnhT6o+eI5y1UkdMz/k7O5tXlQ
         Igwf8DqpQyPxqyvXtig2c70OifkhgQT4xRVykzfV96aP3vaDptSEkBnoIMZsXr4dFsVK
         69Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417471; x=1784022271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vRuV1wkpSy04o68Gt085jZXStICYO8LXZ8NZAXElTAQ=;
        b=DeH6IIq4xAiVYC0zeEQaeY5ZCDS7yCMApU8Khqw0lGJz4gCpFKoYRtqtp5kYE2vmDh
         fAl77griCTyAmX2PRuQ0a+DiLKsH0HS1o0dNM22pQbyOaTXoXztVLmG2xKEm5Xmz2njA
         HeHEFGqEXxyClVffSbedkwBTI5YjSnxduJvQ+bY9G60CLcOB0Azlj1ilkX9KskvG+1Tb
         Q1zGwLE4ib0aoanlqNMiQFBTXLx+HuAbqgbvVwWfstYB442Rbf8aNW4Q9OF7bezXjsBA
         PIrc9pSqcO8sjR8ydgd7jcBgVFDNzOsh81hKIEt/qWiEQKYEt4zV2eBP4tYKtA86qcVJ
         rqPg==
X-Gm-Message-State: AOJu0Yy6uagGYjbJ9NbhKKuLZYbtWSrOyTmZaVFqfmCa3qII+v8zClkK
	6iy5jzx10r/aTLfcPRJ5pzh4zLq0t89sFpr26thUeEvF8L0x92sDm74VTvpfuzOQ2j/YIuGgBAs
	nmWsrQV8ClE+0NkZK5jWkQ4Wi/zZPGQyNjbl1iNn/TkBBd1ODIq9v1qnS6eIhDFgDfDsMuOxb3g
	==
X-Gm-Gg: AfdE7clo2yDVQ5FZLScEpqQaTfiHpewPp1bOvUgQHpONPqto/sErL7FeLBy9GRbpUdj
	+HhZXNFnuaPx5qIwBROXVriibT8kW6Mp4NaBnnZ57MOSUSK1NCZ7Wm+P5hlgJ0KjYAlR4XPS4Wy
	WeIgucifmpD/2Atth4dGa7zfS7i0KJTIw+RstY5Ag2BI8O4GWaQW7maFtjWYTedQbItPgpQx4bd
	i1HteVlmokHMrDhPMeFZRpVSyIuP9arRCT5WmbKuFTUL0jqbW3ZABjt2Ea5Ug1EjqdBp8bD7FJX
	q42hthiyiR9iNxas6x+6aanuLeENAMeC64lj+SfD46BBTtnWnZikwIwmSbYmL00DzTzOAjMqGX0
	RrSnYD4wijVKe+YMXAMQi8AGWFdPQ1HZ9TWNDdH5pj/D4
X-Received: by 2002:ac8:5942:0:b0:517:87df:d8ec with SMTP id d75a77b69052e-51c747afd57mr47671171cf.9.1783417469869;
        Tue, 07 Jul 2026 02:44:29 -0700 (PDT)
X-Received: by 2002:ac8:5942:0:b0:517:87df:d8ec with SMTP id d75a77b69052e-51c747afd57mr47670941cf.9.1783417469165;
        Tue, 07 Jul 2026 02:44:29 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d555sm155881086d6.7.2026.07.07.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:44:28 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: pengpeng@iscas.ac.cn
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v5] ceph: bound encrypted snapshot suffix formatting
Date: Tue,  7 Jul 2026 09:44:26 +0000
Message-Id: <20260707094426.2192279-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706144423.92164-1-pengpeng@iscas.ac.cn>
References: <20260706144423.92164-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pengpeng,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

