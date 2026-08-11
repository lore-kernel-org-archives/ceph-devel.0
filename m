Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8386403AFA
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466496; cv=none; b=rghGvylXL47Es91h1JLQd6vwe0VFgSwBZh39dBLxKtSjSj1VdRucSR9DHkxlLuVIORf5lFWxXYK7K6Id0jGKF/6atRIOE+FgYo7qynUEceCrKgFiUaeLA6dKAxKG4cOQmkwIfiRbv7hUbERwsKS21to5wIvH019vDTEIDKFamRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466496; c=relaxed/simple;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDX4RgC5KD6n/AiFlc76zr7vQoq2QYpt6RgTGfoEWhanSEVfF6BEi0j+I665imqr/pvHDZ5TFhToZz5cftMekN7fuDHWtaCRsFA4Wkh6VX9ue/yanGFL4lKMcxbe2zE4atJ6Q3mq2CHre+YJVhwnvPAgrGjjlDTL4JmX8Y4YMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzUeSJ3l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIgR4Z/g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzUeSJ3l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIgR4Z/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786466493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	b=hzUeSJ3lx+tkQhgP1gkDsrkUq1z5CzszunQ2v7zc8p3l0HTEecsYwbqKzOuH83nXqCF65Z
	npgFtg2+Mn+Q/KBBr5+y0pmcluXL6UGa/1QCben2Il6OW8qg7zPV2yJrhqYb9AXHvZSVll
	WRKsyCA0eS4Gd5YaXbZxAI7htyWwXPw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Cfk1ls87MaCaKRGkyNFLvQ-1; Tue, 11 Aug 2026 12:41:27 -0400
X-MC-Unique: Cfk1ls87MaCaKRGkyNFLvQ-1
X-Mimecast-MFC-AGG-ID: Cfk1ls87MaCaKRGkyNFLvQ_1786466487
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ee59eeb8c1so99890a34.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786466487; x=1787071287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=bIgR4Z/gpXT2viOiAnUjYEbMUFsBK2IC4ujvcW3Iy/s1Pyk8jXVnP4Sqfw8oOMuWfF
         IfWq/Wh3alH6gg2wDST2jkBg6QESnax8WJ2Ufp57jhGUDI0kKJ59t1kXz+d/Qx6neEUE
         XncPy5Y5luWNfwFYAEQJNVJt3zRrJ0Ul6w5k11KpLhHwzsCkYEGtW7qfF00UJrLVQA8s
         dvP1maY64YTJ6SCZWGUvFTIqyFL8qFRNjUhTJTxS9c2gmk5MnEqmd+2Ax3P5qpKHnFMK
         ZloFYuKABxwVYLZxda7UQhejZvzqotSVr+KRvqlNlISF3vtUEGQPs8sYjKREsS2zsARK
         hVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466487; x=1787071287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=qC+EQTt6+UiptsOaykzvnDNbsxd65h4KVxbA+QNxSOVenJgOcD9353lOLP9ZVq2ytL
         3bnjz6xr2B9+mlhZ1Cm56k2VzInqQOME8i3vhrX5DXESvXVb05ikIHVN5ysyHz/j9ac8
         LDF0PzUnsj8Ug65xGRfl+YFgHB3Jkmtu148ceXVS1gCMey+kKhWZx8J1KxDDjmpecB7b
         gL3ADFspg82QbDpzRNTJhoe/Mgol7aW3PvNa1pUnc2sO0Vaek/4Z2Utre6Rh+iKWInrR
         4oDPfgeM3/gDkXgXVWjT7EDdyAZ87lL2nWwYHFtHB5fy4DRV0LLhzhORKMHaR/LXNVB+
         xTmA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+Zv5NplkzmC6kvl9bjYqHka/k208pvBEoW0pW45az9C952SVyLKeW2AX4uyWb/f4z142zfu5ZkCiH@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvoDO3YImJmC0Khym+I7dGKNDuKg69zhQoXpsOL0Q8W/YjonF
	Rti2CZLCeeieeYPW/hYA0qm7xj9SPqII50lmk/5pIAa9ISNr7Jp3NuaugghCs05t+C532h6UijD
	AarzhGYSMFcddJ/gZs6pMK+csVEvWQoWe1LYYyy/4erBEDn/WBcY9PkVUmnqlIEI=
X-Gm-Gg: AR+sD10iEyKAhelj4xs/3vyFDcmL/p6xozuBQoTBFfZJ++glm4voowKTZ0AoAjPSQoD
	EWb3FwG0+S6BUgaxICNODeK8SZz+2FxfMnNGBXSwluv5o6nmz3ogsWzHrgPipxA6BDmwMxrR5Al
	kuUQV+qm5Go65WMn9HI4un7MNwixqaw5XPUTzncM6u3636poLu+MjSt/j2jVV+QmW2krxE6Di0k
	csunam3aWRtUEfScdDk0RoYJwzTOSgKCvh3Xbu+y8WPbgrmGqSoijo6s9sX9Xj006UsEnBo60tb
	Pacfr2DDeqE1wi+1H9iDcwfcq9v51MPK/nbe4ksZrXyMktVvCY/OyqQUkfmcbsOPybwvOA==
X-Received: by 2002:a05:6830:3813:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7f3a82f4485mr4000855a34.12.1786466486590;
        Tue, 11 Aug 2026 09:41:26 -0700 (PDT)
X-Received: by 2002:a05:6830:3813:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7f3a82f4485mr4000798a34.12.1786466486159;
        Tue, 11 Aug 2026 09:41:26 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b34266e4sm265424a34.23.2026.08.11.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:41:25 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] fs/ceph/cap: pass inode pointer around instead of reloading from RAM
Date: Tue, 11 Aug 2026 16:41:19 +0000
Message-Id: <20260811164119.2761154-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706073812.3922732-4-max.kellermann@ionos.com>
References: <20260706073812.3922732-1-max.kellermann@ionos.com> <20260706073812.3922732-4-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

