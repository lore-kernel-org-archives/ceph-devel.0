Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4930E828
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557817; cv=none; b=DdqEZAfDKvTYj1oePgpsfbdbgUNpJXdA6IJV8gtvwKG6u9zJC/QzKL73nKHXEwjP/zeUHJAQg4LvtORtGxS8vUg5PQMbBK1Tpm2q5+YlhrPnoRCfSu1KTyTW5wLRB3D7y03VrdEiZx8+pj5XUVXfYqZqlvmZ/X6Vj26t70Vcw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557817; c=relaxed/simple;
	bh=hLVQ1ftq7EVejCnHot1sW/PcbtMmvC6zm8K/x3ZhQa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNRU6Tw929zla0xgj+VWCQgg7SdQBJsHpnJ+ILiEShCp8Qvik3qCqFEZZquOmdPAKA5kdZ0PJC8i1aEBWhBf/8OPd8xplwONV+W8njhou2CVYHOb11eAsMAwKfKn9bIHtRQ6qvyUoteqHSabEKtxAOucG2Da40Kw8s7N6tVxSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBstqk2e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mdNyyuXC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBstqk2e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mdNyyuXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791557815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=NBstqk2eI6Sc3uIwVtywmgIr/ZmPTyjJ14BpVwMjcNXIfTRcYK6GlZyUevgUOMbCshCNdu
	7JAe4kur9kCFdaT7GBaW+LdX8ZQ0NjvLyhMT9gku8kmTYqPmzVW1AhZToiioOqh5drTqu0
	aXhUhzLLOQoQwUURZZKJZ/CVLYx53iQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-xHTSlvinMCCnyUg599E8vg-1; Fri, 9 Oct 2026 14:56:54 +0000
X-MC-Unique: xHTSlvinMCCnyUg599E8vg-1
X-Mimecast-MFC-AGG-ID: xHTSlvinMCCnyUg599E8vg_1791557813
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2e77b7742dso323498566b.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791557813; x=1792162613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=mdNyyuXCMY/o6AfdU83TfpwqwxK720PxP9zaNYXXkOOx925+mwIGS7BDyOL3Jn4LPE
         k/1gb1YowMddbH9bkQEB1Mx4kd0ZxFD0jUo0Z4geIFjsoeV4axcjZU6VJwPvYtAXKcIs
         brlWxLowY3Q0feEn8VJXAXjinks01F2rXyAricPg6Txs0WyhUFJ8R6V10Pt2TVMfCuxF
         9tIJhsJrGqyTcoG0xmedqaK3Xeb/AZF/2MvG+7i+hqqX+fY8RYzanCTX/hUPytqpIPFU
         of0JsYTtjU7DzfHqLNBnoWYwax5+NPBF+7i0HXkSPLC/OED4a4OJEAZAevfxctSiJFcx
         8zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557813; x=1792162613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=eWbo29MOqBKLkhqSNl7vedsZ3bEF4GtBCGcMJJ2rnwR80Nk2sUUYsC/vuv4tYTF7s3
         MyQsbSfWMM5mYAhh5Oo4wJoWmlbciA8q9x5HutcS069DHLIkpTgcpILRoLVx8pe9GUrw
         Q+roBWn+DmTyhNSgMnIXUFrBzyI6G9do60pzgBJPowTtGAupEhZTKzIFYEKXmHLnj3Zy
         oqWQF7nToyqm45cj7Y78LPJcMG1ljjOXDN1D1nC8nqRwWUF4wrpMNxMjVNqdj0Y7NY05
         cp/M9kMJEfrZpbooMYZ4ZLOztKXBEiu2ACFUhxLHxfx3SC86DD/kWVj+YWJHxyHq+AC7
         u6/w==
X-Gm-Message-State: AFq9FYI3nxjtTdG5O1hkp2VR/bndhKj9brJy3LbxqioBay2gW9Z3rWcB
	FhjjMsc9pRDO9FHlgRKrdYX61bCvMLRwWWLNiOhNhyRtKxrJxe/QEg96CrvWnEjYVsh4S4x2B5R
	1r0hzCHVbEfSEmbcwZI+cRHgLzvlgzY12VPbYhr6SKcvXPDuN/vPwiHSosLxev0w=
X-Gm-Gg: AYBFou2ppi/Euhmc7CZwPRr0gPz1QqL4z6S3gQ3Qu+6RHO1Mcii3HER1PetQ4k81p1Q
	i2cOM761/jIwqxT6uIGaD9qKJQrT+VgUZXHMenfopPOM/KhAb9OaCfnbbdCr8lVtdXHCJmLuOzT
	JUH61FQGj0ZW7tAuxo2VPHJTQXWC9Qka5/hG0qjgwpWMBzh4rcdDzumtB7yjYYFUHLN4ot8EaCb
	uZgljqCK2cFTrlwvR3Q9wJiE71CYnIqd6KTelblE5Ph4+wvdUrCgS1dTG59vE8PYTlonoqRciqm
	zeZ5VsrhMnh6h8eIEu1wKtbVYtqjscFclpOI8zwuJNS08EJrDv2Pazog71lO5GDmtSB2ZwGcrzV
	pjQCzvxWh91Lu9bSReJyKQ9XXqYduCSHWzkqrBDMPA0dnrkUttlFr3RY52DHJogNUICUay2yv6C
	vQ2T9c/jIFO8ch4w==
X-Received: by 2002:a17:907:3fa9:b0:c2a:6c3:9e98 with SMTP id a640c23a62f3a-c31aa098468mr204242966b.40.1791557812895;
        Fri, 09 Oct 2026 07:56:52 -0700 (PDT)
X-Received: by 2002:a17:907:3fa9:b0:c2a:6c3:9e98 with SMTP id a640c23a62f3a-c31aa098468mr204241866b.40.1791557812539;
        Fri, 09 Oct 2026 07:56:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9762af5sm107995666b.1.2026.10.09.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:56:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: check the caps of a closed file after caps_wanted_delay_min
Date: Fri,  9 Oct 2026 14:56:50 +0000
Message-Id: <20261009145650.2381060-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008-ceph-cap-idle-release-v1-1-86e7a8bf36d0@clyso.com>
References: <20261008-ceph-cap-idle-release-v1-1-86e7a8bf36d0@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

