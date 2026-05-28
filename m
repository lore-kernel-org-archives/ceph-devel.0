Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB443BD224
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979086; cv=none; b=MKzvk2e4Ska0TOpsJRilNuHIDowEUSz60iiYlvTho4Y9ZRN4Na9CcvuLLrb+L5oRBk2tlEdSdFyj+mfD1L2Bf2KWhyhlFeXxPWJwjawtESQK+b8a2ZcWml4nXuYB0vkwJg5ETxErR6G3N71V+mu3NjZ0d5jH5SA1QXdJA8vRr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979086; c=relaxed/simple;
	bh=l2Tt48p6srvUIVxy+xt+rEVv4o4oXz307I+CM2p8V4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm3hB8VQLpFo/Y7hdTE3Not3vEgNEmKotYfQrLAvl05eF0OSFBpcpBE51iIsqYUNFtUijPyGCx5uuUg+s6d1e26DK7Z9KrcJuotAKYM/xZw/0fK94j/qGXIfJYj6Ztpvd7nWzC7SIIp1JNKDefVmQvLXdiBf41uGYdMl/+2ElG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNJL2v9h; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNJL2v9h"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-837b704783bso1141418b3a.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779979075; x=1780583875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Tt48p6srvUIVxy+xt+rEVv4o4oXz307I+CM2p8V4E=;
        b=MNJL2v9hjwORiihAZuoeNgCSTx5k4CWSnDuIBxWs+PFk+mP0FgCGOBQwuQCW4jlmjD
         1uk98ZUe7gnjEjok9i5Zoqg+IyWTyY2cdtfaSPArP3dzzDg8PUpsX1Syjvnu3Fd2xvot
         UFOvLcVoA7yoZOQd5kz3LMY8REr9mC9O/cqiTQE0U5a/oXwZX2F2yyLt0HaCw7U3dbSr
         fv2NvJ00bXpPKENMyqngNSKF3mxVBC1glprhjWGd9jLzom00VlWEcFQ/iExlGuDyYWE+
         /QIae7R5z8cvgEu3jMCkIDs8BjIyPEuc3ZG1hAlDOTksQyrYTvxJ18HAXlN7cUA99zn4
         LREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779979075; x=1780583875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2Tt48p6srvUIVxy+xt+rEVv4o4oXz307I+CM2p8V4E=;
        b=QH3r3w4u0FVdcdgJtye3f/3gmAknzJymwAzAXiF95yHw/g1jGsQNRvhe9w2T/csFH2
         A661UnMZCboDA1fIfz1O6zeZDPzqBHwmxJEmGRYsgM1JGX0giJ96g4g33Ia/WlQkpyky
         MFeWCn2o/OrYuiAkOhFkyh2iuAPLZO0eseNFvOeKqL+c2k5H3vDlmrOQxhC3E2CdUhDU
         afioKhQZlPvmZCiqWEB7slSd9XNOWxIuiLeduh/U44KubuvwGfs03eMoR0dfiANfXwV8
         IyV7KCA03EFApwkfHTpTK0M0Nk4ckuG/RwmZifW39Hj34T/aoBqtr00XILCGEcLhNsPf
         4dLg==
X-Gm-Message-State: AOJu0Yxjv9XFWXr11VZkUpFr9QeIL0hFJH4mR8sYRRbGbNOvN6INyZVT
	ltI033ackKmH63XtphelLmznOZP7MEE6k1s9+PF71zPskBeiV5LS5ZNcdv+vDTNX
X-Gm-Gg: Acq92OFnEtjS1UvMa7dI4++B9sXVIWNA5tEFx6/WZmZQ+nFRqAPil6iM+mzxUzUKU2I
	iBrltYh/CA5vXdsREZv0AFcuEjChMQDBEFWwiZjgQnZreQmeqjFQJCYCjsbm7rmCiwfN3mwX3Gp
	YpF49iWUfuhHg/x1jA6rd3TwJOjBFWlYDdc8RS0Yg1gaCrJHx6WpxnFqULWxiR1Pc8h6Qla62Yr
	1iGg0VbG+rB5u7+WA+RGaxEXZMHlX1DGQ/7ndA6Fufn0Wke38iTskEn0868PS+mX3DWrKIrclfY
	A1rGlRdKH8UhLVaX/SRv8mFlL4QRXvFzTaxPHQGHGE51xpXf4H5aDaXkIGjK5w61mZo/AdTu1ma
	Ksoe5cpfUjRxjv2gWP9vYyV5LpAMDzNNNoSA0Xf+abz63SfEjnCxEh+wL3BznhIZSebJlN/QKT4
	oWQsWiiVoqr3FG/GDv5be8dUTtrSk=
X-Received: by 2002:a05:6a21:b8a:b0:3a3:15e3:4e75 with SMTP id adf61e73a8af0-3b3f104d037mr2380395637.8.1779979074706;
        Thu, 28 May 2026 07:37:54 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70ba03fsm6058393b3a.33.2026.05.28.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:37:54 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	idryomov@gmail.com,
	Slava.Dubeyko@ibm.com,
	amarkuze@redhat.com
Subject: Re: [PATCH] ceph: fix OOB read in decode_lockers() via missing bounds check
Date: Thu, 28 May 2026 10:36:46 -0400
Message-ID: <20260528143646.860883-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
References: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The follow-up patch titled:

"[PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()"

was intended as the continuation of this review thread and addresses
the additional bare decode site pointed out by Slava here:

*type = ceph_decode_8(p);

I accidentally sent it as a separate thread instead of a reply to this discussion.

Thanks,
Pavitra
