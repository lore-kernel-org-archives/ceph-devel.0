Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311420;
	b=vMtNNAEFpbSE7ikIO2lzcFJKTc4rUfyist7o8HM4hqkwUNDZX+TCY0iI7Y6qoNUSYzxL
	 HJVmTAonVoT80B9fHcqnPc45GUnXeb9+6rEuicTWHg6Bcp5tem/K3J2O/QYy2BqlsSMac
	 KJOE0NMOjLSOYSgXy5XjOvqojwwfcxfnSSZy18ny9k88cZa3PYAS+FriCIUlNLTfPijEA
	 h/rswYOa2gxWFfeMO7Kh4v1RA4QSOMAwQCkzFvVLfr6TuTRHxQ353nVb0vfe1mMoCMPKP
	 plW8uY8Q/0lfP3HttUFPVbJp5lvsc49NR0mOgsyI8Jx41uVwb68iBs4ZPgIUDzZVqKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311420;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NV3VnFLMuKlrnZgC5P5AIbtQYdgALzpVqxSBUSYHI4Y=;
	b=ZQJa36x6UVTRZ/CG3wQARnlwLe9h7RyaSIy57HT1yErJ5x8nVKzZg8bKdkmlChqZrLzw
	 F8ZraZTa4cwPo4Ffwg/6+xDY4pTSJ5xBcn2AMnqsm2EwhKHlMRI5k4he6l1b56f8AfIAd
	 X6E1wWMGLg/Z9zL+ii1p3IZewGfdVfCaIVTGwAY3uwWYAd/Fr6J12cotJioPbQD69f14k
	 FzGcocZTMQX/9TF18ZU7oyUPt+95o68P94OncRqyPdDXuCSY5waSZwvzwkoz5LTfOHO3b
	 OSwhetYtvOwGxJTH6VcQ0v0+j5AI/dy/utOhWPjq8mOZ319ct8cwXwCYNAz5wqIfxjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYQr6Ktc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qZoB60fz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA42606A325
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 11:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA42606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYQr6Ktc;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qZoB60fz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794311418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV3VnFLMuKlrnZgC5P5AIbtQYdgALzpVqxSBUSYHI4Y=;
	b=LYQr6Ktckj+Kkbx7yOdYbFsAmypoT3JYZ0Wk4fban6FBx2lyJ0wqViB2EzAjfBTSFiJS0U
	6HQ4FTaN66qRDUzgkKF3q53vZsbRUmpEJCle4kTwOOXs05lh3EFJe7kkKqxI78xeN8yOJW
	is9dgmO+qjJDSgTs7wVDfaedl9Q5vsg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-zlqZvsxyOtCUHQZKkmmvmQ-1; Tue, 10 Nov 2026 06:50:16 -0500
X-MC-Unique: zlqZvsxyOtCUHQZKkmmvmQ-1
X-Mimecast-MFC-AGG-ID: zlqZvsxyOtCUHQZKkmmvmQ_1794311416
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c504991a35eso81183966b.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 03:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794311415; x=1794916215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NV3VnFLMuKlrnZgC5P5AIbtQYdgALzpVqxSBUSYHI4Y=;
        b=qZoB60fz1UvXdufp25YZxJHODxYfQI0ewOGXlB2CkEEJbmsN4od6EhUgWA9P/l09zq
         0p+q1YoPUmtqgG+Sp+xbPcosfU8AZNK6y6iX0A5JRW925bYOnW+ff7c/gGiOiR286seW
         hz5Wj4JIs2YlIftCfpHLBz0L5l2bAgzT9yl7cDpMl+Rvvs+Zvxbb9AhyqjxBUY2si82X
         1l9cr1VGcMxnlC9SPX610uKM25fN+qtr7IPDM8SQR0Xu5X9JE00Qng7Gfj+9kW9IUYKj
         Wawf5yOjrnNOaJtLcFm1GzWp8iXNLH39lBCeQ4DR65f1wGgeXVcU8QaBAb8xLeUVDl/R
         y9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311415; x=1794916215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NV3VnFLMuKlrnZgC5P5AIbtQYdgALzpVqxSBUSYHI4Y=;
        b=Px2lWSoVMnqDFgYVdAf8FChWbvboswca57/KUSBZeDB8dBUM0/n1+PfEzRS9/dRpqD
         L5RHJ9imZ97m6k2dp2bUKH33S2O7vM8eri70dDMGR/8IkVVcBu9JX2gAoDiPJUoAuQJx
         3MCdyyBsgxysdlC/jtEAasA1QGVw/0CwTOxoPj4iotpxWEWqSuMSuGXqtMp8DKBFG7+4
         bj4TvoqdJVYRx4rpmPW1T+uqoh2k+RJjbtKtOv9HE/xFSGPiarhTEnHF7Lm7kzIQMGWt
         dS7OBaTVlkkvhkOfDZdgqWOQnzGpmdnZkwYjysAjJ8idlTVfrhH/83xPNzjk9JuZZ7vF
         0dqw==
X-Gm-Message-State: APuU4Z+belPTxBr1jtkqhwBrdtrymMhnr9DMW0RXRwwaoKZM81mEvM+h
	9vB0mCov8/DqsQjuDC5cWPsBkZDSlorKfePoOyMukbhYTOJ4Z+jTMuwwTdiG8Qs46PjHpgHGI9u
	7hBVGIt2RxOUIfsfJRzMxLwG2GWXCbu4r9Yglx8Fq9GZsO7iLf8+5n9k8/noEwLw=
X-Gm-Gg: AYBFou0zTj81EhY6v4Ws+W8CrVd5or+d2GZYP5b+iy7wWHXfwDEeC1m6Tpcg6V74A6Q
	cOYJmGPB7G8jFSpOiBj009T4+Le5HXRgDs04e33Dbov+rJIVrndMtyuIPHOHKI4XALTs7H+kJGY
	hKosBz7PA/+gSTNecEjA08vNQQKQ9Jb9PUZHhZEZ310JsL+C4k+7q7GEM7YuOVS68r9I4snm7o2
	vMJU9x2Jcwfgd17kvYwHWQOMsixAUcOFpsmWoRsc2XlhpaiXK39EradKZ9cU0VL7ciwsZUonJMh
	NLc1vKoFj1h6dFzDVIHW10Jx1AgAdD6zz3a3eAZSbLbMdYLzrSDCQv9ygbkECTmzV/0SFidTCjW
	XtpyBi448HUT2lpSouYSU/jD9s0OH+Eagmfsdu+LNr4IEav4wy7+RAmj/svWwJjclTVSUhMasQk
	3SZYz0kfKhWcjBMEJfJQiGQHDUzKI4AGyU+9Kc33TFK+pcorEmNQiNxT3QvfpJpUP3dpqPSXHZN
	HTFod1OFB/kyTQew/lZiokKvjpgTuHjJZ/X4MTVSItb+pKhWCfJ
X-Received: by 2002:a17:906:9f92:b0:c50:59e4:199 with SMTP id a640c23a62f3a-c5059e40eccmr82397666b.3.1794311415682;
        Tue, 10 Nov 2026 03:50:15 -0800 (PST)
X-Received: by 2002:a17:906:9f92:b0:c50:59e4:199 with SMTP id a640c23a62f3a-c5059e40eccmr82395866b.3.1794311415312;
        Tue, 10 Nov 2026 03:50:15 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a618abesm98403566b.50.2026.11.10.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:13 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: ceph-devel@vger.kernel.org
Subject: Re: rbd: Handle overlarge result codes in rbd read replies more gracefully
Date: Tue, 10 Nov 2026 11:50:13 +0000
Message-Id: <20261110115013.3268036-1-amarkuze@redhat.com>
In-Reply-To: <20261104153659.1117700-1-raphael.zimmer@tu-ilmenau.de>
References: <20261104153659.1117700-1-raphael.zimmer@tu-ilmenau.de>
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

Hi Raphael,

NACK. Please respin.

  1. drivers/block/rbd.c:2902: Overlarge read result is completed as a full success without filling the tail
     Raphael is right that a malformed OSD reply should not `BUG()`.
     If `*result > obj_req->ex.oe_len`, fail the object with `-EIO`
     (keep the warning if wanted).

-- 
Alex Markuze

