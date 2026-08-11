Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95E43D4EE
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467319; cv=none; b=B6eFE64Er0CLQEbQ5+mtxzAcmrXBJ9lXqTZNK3bhiZebnWo5VET0ZnWGnIoq7n6+8YPDVUI2iyjHviViivZ23xUy6KIxI1VvhPq0mQzlQHwg5xSSpqa4lEi0zKXRSWyuaSQpxcrT9SA09XhDvQ8ggX16zTHmiDyEYVCjZVGcDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467319; c=relaxed/simple;
	bh=ZqruKMkTCRUcF6klrGSDvaM3TpFYsk2fl8PMH8L3278=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOhMfkgJgzcSFfcklmMPySXjDds/j5xtTxrUDMwsrOgMdhmq2E0k9OibNrWwB8JXz1uZM2fPTJMntFBwuyvVsUkBBec7AxH3pkweFy1a7BhvraUMLA7MiZnCbNKKAJKoFJKthDmru7EpLgfrxEJzKI7zLjpOVan4erj+7VaCi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch3mjnZr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3KKxuh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch3mjnZr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3KKxuh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786467316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqruKMkTCRUcF6klrGSDvaM3TpFYsk2fl8PMH8L3278=;
	b=ch3mjnZreELtN3EjHtL14aYF9j7wzGVJw0XjF12gUHyzD4J5Qm8Se4GWYmPXY2TkamX/8N
	qd+XductwS31/CP21uI7w61gsCtKAPmOIQHYBHnp4p2eTep/0nfNLeMVONrqwJ4qey1QcP
	6eXYXRhLMw4hl75IodPq5105gfZH7ic=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-kJY2oDnqOiq51gy2dlpRZw-1; Tue, 11 Aug 2026 12:55:15 -0400
X-MC-Unique: kJY2oDnqOiq51gy2dlpRZw-1
X-Mimecast-MFC-AGG-ID: kJY2oDnqOiq51gy2dlpRZw_1786467315
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ead32f5c6aso81000a34.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786467315; x=1787072115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqruKMkTCRUcF6klrGSDvaM3TpFYsk2fl8PMH8L3278=;
        b=F3KKxuh73r+F9IMoqwtNSgRkv2eoLI7rFvB83ltPKACsI2xA11K9ZZG8s8su8Gm+Wa
         AozxgddzXdFmywl+80b8gAlMvUJW6c95rpaLD4EQKRFE7oJLSHbzJyNYdWAbMFbmeqL4
         NiopMl0wdOcLEkiFXo3AJbTxScc6PVeWOB+5gZnJx4Pe938LrRCmoeS153TAuSa0WTY4
         nVEG8LSCaxzye1R2jJ8dh0XC3Ds1HCB06cmTcP2hSD031cV/1TqKOjPDsUhOsDoTxc1M
         wJbyuBrHBvXYf1ZN/+51GG2orCdNwVydowbop3at7o+FF4RxD2K+odizMAgmWCQ5xrXa
         PRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467315; x=1787072115;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqruKMkTCRUcF6klrGSDvaM3TpFYsk2fl8PMH8L3278=;
        b=ERVWEaQIXcYuUXefnNFDk03T/4iTF4HYrgrPzmUI7AK9MZBJHzYGogh8fYg4UVH3/8
         YvG/g6No2AiJ7it9hmmEzFc81n58DERjSMa4sRfGUjpwcYJp9A1l6yp3Co4LWTmPTP4n
         ukAfQf0H4Fj0kIZZu0nOtrzcef5l4TmQOhE9vtlyASQep0WYTHwwOYAk/jKUhV13fRHA
         1+d507KK/ALGv4MmBjSTbje5FcVKq5RfcKoNiKz52Qv8Qx9Q56+QtXRUgWWx8DR0tyrB
         kR/2D16DWUX08Cbm6tc2/uOYVTrCzmbW1yukzJXeN22gW7FIUCwLEYvWpcKpB0anEz6g
         5qQg==
X-Forwarded-Encrypted: i=1; AHgh+RqI7lEC77p4Fo5tl050eGCGBKo/K3q+rUhb72RCahRpydD4y2GekV2ltLHA4KKYkiTu/vTeImxjIket@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuNn5o4JE+aowiz96W2FhSaZO7C6TS8KY5bFyCFyPMk1ovJyU
	WZOpsF6DUumYjirzHBRJF0IER3J4Jak5d4VFdWMLbY1oJN4svBUEGaIA35CzGay3cBilxk2Wrb+
	pVVUvOlWWwqOONvySlY1a/YH4QsUm6xWnXpatlo6cL6oEanqxxIViHgx1895Z02E=
X-Gm-Gg: AR+sD11mcBld5EmrZq3qG4kEA5jVTyTwT3brCxzt8xe8CNp89OVxwJviXXIXwz8CgUR
	jYKZbyszsu1ps3/Avla0qDAXDAooMTUm0e80Od65Y/Jj5iBk5wqMstX005lSvQCQ33DS9UDtFcL
	15AtWLOl8pYj9OVfdSYR53WEbA40J6E5JBJO2zpGhD4wAeTDszbmhe8JE5JWUefpINdG7garBzw
	rJBAxYNb+Z2+VsI+RmU5zXgV/ncvFIMrLRLHVu8eEruhs4JEEkEK92Yk6adDkx/0BzjZkOASqlp
	KsEBov5xaK9ALswPA0vnYWUfzStlYp2rnuBA68BNBAFNL9h0lObKCIEJqsBbz8e6rhtMLg==
X-Received: by 2002:a05:6820:4dfa:b0:6ae:8103:f6ce with SMTP id 006d021491bc7-6b0a2fe17b8mr2981153eaf.15.1786467314713;
        Tue, 11 Aug 2026 09:55:14 -0700 (PDT)
X-Received: by 2002:a05:6820:4dfa:b0:6ae:8103:f6ce with SMTP id 006d021491bc7-6b0a2fe17b8mr2981111eaf.15.1786467314228;
        Tue, 11 Aug 2026 09:55:14 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad6ef08asm196903eaf.15.2026.08.11.09.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:55:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: michael.bommarito@gmail.com
Cc: slava@dubeyko.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] libceph: add KUnit coverage for OSD sparse-read extent validation
Date: Tue, 11 Aug 2026 16:55:07 +0000
Message-Id: <20260811165507.2765916-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714115141.3768034-3-michael.bommarito@gmail.com>
References: <20260714115141.3768034-3-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michael,

A few issues with the test code:

The test suite leaks the page allocated in osd_sparse_read_test_init()
when an early assertion fails before cleanup runs. The insert_request()
and erase_request() calls in the test body also lack the locking that the
production code requires around them.

Also, Slava raised a concern about the KUnit integration approach that
hasn't been addressed — please make sure that's resolved before v3.

Could you respin?

--
Alex Markuze

