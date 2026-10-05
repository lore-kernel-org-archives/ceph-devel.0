Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47786429037
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201684; cv=none; b=qiRd6N/vuaj9aEpZ3XML/EhlUoFUpgLFQs/Brs1UF7OTNUEWtbaa59Ic7KR82yYu4frdeQR4dafmh/zaAl7jWpnhf1wMQL9o/wQTzG8tfUlGKPNtS2sUgn+9rYeVODUSh7Vhm/15Mnu0AzX7y62jUMX/h3Kz56eNvBUT3QW1f+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201684; c=relaxed/simple;
	bh=wYjnXXyCSAf3oW4Y5Nu3Q5yczEpyFnJxoUASGqY3J0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A64Z+GaU7wDsHwHRDuV1WOmXNvhbnVN4Mt8q9jHpFoLDeALkRdhI0KQmX+/qGFtL/KyjnV8OabTbHtrAGnD/UztgPD1E/YDIm/Z1Xr8fr7jGpakwhbHSXTvd2aBEzpzZHzbDvuYpwCAny+oy6frFpZ8FryuNi9MFS2GsB1Nnw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPA25Qv3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8z3W1Fu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPA25Qv3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8z3W1Fu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
	b=PPA25Qv3z/4ock1GNqEqdBdc/gg3z8szRu0pVWEF97t6AJSWtzdtfRNp/zgS/C5vzysQBg
	Bw1byXoUCcYILyDloubJJ8dWok8KrI+vCMTGQUte0CBAcZ2InHhHeEPZWNZXV+9xPiClkC
	sCa5i6+F678UEkt/zfFF+z4rx+VTAXU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-K4h4yOmiOry4vPRJH4yCzQ-1; Mon, 05 Oct 2026 08:01:18 -0400
X-MC-Unique: K4h4yOmiOry4vPRJH4yCzQ-1
X-Mimecast-MFC-AGG-ID: K4h4yOmiOry4vPRJH4yCzQ_1791201677
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29bc25836fso204428166b.3
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2026 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791201677; x=1791806477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
        b=Y8z3W1FuO5992aWjlCfEYVFTR/TY5peTaAHNruSQz6DWOU+2HwS8bqbYjJcOwhAboB
         FfhEb7OMquz5Wq0Rot0xKqbS5I//Tgq0vVQtmQ798EQJ/c3r1SXW9ydsvs+oJm5B0QNy
         hV95jKeksKCEurk9jW7axtHx4d93zpbRNYLGB85rC/P6unNDGXrfBa7M/sOD2qjKJ29X
         8kxgwCFSTdsX0WdfVtk3Jakbue+NtKSNRq2OPH7jzz1SwJEkwbAptPJNaxj32iQOTjx2
         cSMXvzUtPCxDmnj31wtN7btxyNAj3dW9WLk1zjo3o+EelBlgKt7U4Y3prsXYeIHv3hrL
         EwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201677; x=1791806477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
        b=b8YdLQwKCqTHTR3wArY5iJUMCF5KRu7XaVTAgK9kNXH4QVjyYRzJ0Y8cm71hNX1Lyb
         xiH8PXxEmIv4Gi/cyZS5MoDUeULKrTCQatG1TrukMxAryIbVWLOhek0ekOC5vhAtrTn9
         uKCTgGE2IWDQlSi7KTBB3M6RAbRUZqwQrRX6MQMqfK6a5t0aiUXOfJLSUK6QDsoc66T0
         vh5h4DIR4BgvnCkqSsMX8UD4/q01BfbkJyU2RMV6+O/2KcSwudnh4hSKQJP84vBNtuvH
         X/kbdS9farBAbEXIhekKHaKwwi3lzW9SgzQ9xkoXut1BIToxcVrAVV9K/NMoou62wVGI
         fPfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCWVRNJVUzB+zSa6NfMc+aDq2hCCbbZdGxT63S5Ng/e/Z0THLht0eKrwR9mIqXHdPFVNVEQEb+usR7@vger.kernel.org
X-Gm-Message-State: AFuF++mR3v1f3fwJ7rxtvS/RwFK3yPBdB+vrMThpcd++aB3omXYXSpC9
	9L72XnkePVj6MfaEwb2NEnXRQy0u9z7ceSALvETGIufk62g083fyOJARtrCZs9WobwByxF9lSQF
	dVT8sLUw2FegdVvksc8q9lWDn67yOB9OgDXgbBbwV7RJYmttQOgCDNODwewBJtieTzBewJILi+A
	==
X-Gm-Gg: AYBFou2OGdKBkeu+endZYLd0SBv1nxNoivggYcXruzsBbDldK8yaSXgD3Qm1pnI/77T
	/gqd/R+OR2B/zCC6m5uNR0M3J58pGzV9o4nQhDwmcCtunAVX58S1Q3S8vNRTsV+gXZgRGAubzSa
	bNHV0f5PAoT61qnebQGUHUG//hktQQFOwdBUicee7OkbAslEqph0R7CGOpUiOVEz+T2RDqzrzbm
	ulfFHGxo2auAS/iYVPDpm5aigbXI7l0mLBYemVSKpb4uZDf7AXQ3/6onTb3QcxJr78HmeW/rq0x
	Q+b93uGeKB4zDojOy2/UL7WFJMiIAvMUwoPT9E1uvuMjtNb9KO/S0rsORM4xcdSWHbN7acJ5hDc
	jZ0QXZ7+WnJufzWvt1pk7CS1ud3n4OnH6MBLgZWS041lBllONQ2wJd4KkSpCkvRoCJMx/x3Typ7
	nrDSC3d7PvWCoZxQ==
X-Received: by 2002:a17:906:1014:10b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c2e63ba3e10mr493117966b.48.1791201676339;
        Mon, 05 Oct 2026 05:01:16 -0700 (PDT)
X-Received: by 2002:a17:906:1014:10b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c2e63ba3e10mr493115866b.48.1791201675948;
        Mon, 05 Oct 2026 05:01:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c315ae11974sm25194066b.73.2026.10.05.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:01:15 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: ceph: bound the mon command wait
Date: Mon,  5 Oct 2026 12:01:14 +0000
Message-Id: <20261005120114.1913204-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7412F740-8826-4790-8BEC-A590DB2BC2E4@stu.pku.edu.cn>
References: <7412F740-8826-4790-8BEC-A590DB2BC2E4@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yuanfu,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

