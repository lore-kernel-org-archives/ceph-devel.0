Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367132;
	b=mIcwvjyrb28rv/85ylg3BnEz8HA3NxiGbZKTlA3Z4ctVyf+3UG8VsuyJ7XC142CnWxnI
	 lGG/NTpC3BFjwbncuQ3HXVD3A69Jhz00+5ow/hmoSJMh7peKkYTGgAIxXSzA9bg5aBNXg
	 KF0pe9RxuRo0ZLzTpkmk/inTEiu49/soMPFNuLac5BMhUQsav9gGPzPqvC/hLQgCWpvjh
	 KiBgF5uubmHjM72VMriMNxFN7drLGlqSlYn3I58hbjQrCgU+oNbksHoXyR+lXPpJFv27b
	 UyBpGgGE41nL8pfN7rap3AXIQ1eNgcldlP6JIuf2AOwR0H6oHwfPZnhel+PLxBAfICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367132;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JMf+MhBIiw5vVzxN4wAuJERjsw7EJStsqqgnBBCqdjE=;
	b=U73WziFui+BB7X1yWsmz/J9yiTBsXQVDfov0qllmqsReQ4xJVVC1nv4BZtOlzsXNRso/
	 gvIwcSt5rMhb+9CHZhl7C6DKmlUiUE5NLmbE3JtuvsVREv1eWzdJmuJwjc9xuhJJFaUxU
	 qJlMKJz/5r4CH0LACVSWstKr6PEl7PyWlQu9r18LYKmMnxZV0OM5lOQSYP3ugdmHaY/ZV
	 2WjoXx6BnuCKhMVJ9v76n2dT3Oub+IihwYZZXxpXqUQaqc24WuoywkdAWwOtZqgx/WcfG
	 E2Mrz/wu21khVD+lj1Uq69nZwktxXtm8MvdXXUEGh7kqsbFbBsrkumozrxtUlH3z58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="RTW/50Tz";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DRDqoQNe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED8606A32A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 17:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBED8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RTW/50Tz;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DRDqoQNe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795367130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMf+MhBIiw5vVzxN4wAuJERjsw7EJStsqqgnBBCqdjE=;
	b=RTW/50TzhfCUW8kwSU0C48p8CtF8NdVrzobrEG/TMZz/2lemEBKRSS7Qjjy5nQ6N22sNpx
	oC7eDKDuOgEqJ5ollV+XGDudXTTGf8lpSiTFLXggCUQtzJeoCtqY+LGjr+eqaMOG8498HL
	xjGjUYDKwtAKqcEDdIww0P4pL0F+UQM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-jI-htiWuNkSDigShVbeVOQ-1; Sun, 22 Nov 2026 17:05:29 +0000
X-MC-Unique: jI-htiWuNkSDigShVbeVOQ-1
X-Mimecast-MFC-AGG-ID: jI-htiWuNkSDigShVbeVOQ_1795367128
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55d2c49c3d9so35188521cf.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795367128; x=1795971928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMf+MhBIiw5vVzxN4wAuJERjsw7EJStsqqgnBBCqdjE=;
        b=DRDqoQNeINbShsStdaDhLcVjT6rovk3+Qxx5ompjdJ/TdHSpzf98oI40lVCJ7j4DNM
         VxjmW4tMSUIhI+7jnXy8LR3un8Zgv41yZQNTGE7+25Jg5Ay4CvnBuLmvvb+/daieuSLn
         qOrUt3VTeg/R5kOPdH8EgBZnX+A7mxOhXvIDNnVBk4GSoCm0qr7G6K6IKqpt4PuKS9wz
         ZhNhmJItPbtkNNVG2vBOsoSm6Hgt0i8evL4K5Zaf5WRioHP346MZE5UtaVGkiidbvoqx
         n7m6EeQmz/6rIz/O6WkL1rE1FcZQyOUyAztJykRB2j3VmM8ZQ8BI7zlp7gj7zzgMPBmr
         lWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795367128; x=1795971928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMf+MhBIiw5vVzxN4wAuJERjsw7EJStsqqgnBBCqdjE=;
        b=CoVpHyeWdLfEDC+lp5XowPiiJG347SnZ76KW6ia3rcImQuDx6oGXo+BvKqwx683PNG
         0Bnlb88YfBJe15z1YV+75jmrMiwyLbq+FAy7a4Uafgn7MM+X6Z2rJBVHn548X/FGFBhv
         DrCEmrKpwMu8JLvSeT2XpoeXeTtbfUOzoidv67OQei9SMQCE7YxbERFwobzSrA8pTVGt
         Hn1wptPP7KanwlGLs3b7N2mc/gHh6JQ2MjYZsbllTtXk+t3TGG2Fddvi3+v2JxxwFLwQ
         1vV/9ORFiIgd/3ED4MLvtxuRLtJzkjkRpCZbOSz192rXTGmcyw+6Znr4GuCfz20bYzVg
         a4dw==
X-Forwarded-Encrypted: i=1; AL+hErGit8i9MPQAhg9ZfSLAC4jyJTg6MU6H1m2TqofNYZCZV6e7ml0DLGHkpckL8eysSAW1HFMXDtJahtTA@vger.kernel.org
X-Gm-Message-State: APuU4Z+44vDrJtLH4hlIrin5pyN3GXhnjiYUtu9F8+mwGEI+EzkIbU6p
	aRwKIYz0r4UQB4jsKigqLru1ZatBBZagP07Unbf2wbQm9LW8f5kmKnQWImO9ENEmodetI8z3brN
	8BEwH4Ji/J85uRowVIsQQe64MPR5HXPEYlAJQ419tDernPzMJJGcrhaVRTpwqMLc=
X-Gm-Gg: AZFdTZcscRHDfwAGc5qiqkDdXf6sVXBYa+y/7ZxJDBWypuU7zW+Qb4ki4AtPlFM9jUZ
	BW9Uv+/pTfKpLpF4Ug56elqRb7qqea88WMo9rClfFwqeSCr3QMfDSM5pZsjHNUK3LA9zwSPDFq7
	PUtEEc4kBnQnAuD21fttSYb2Easz2JcoZ5zi05qTGa0AX7e6dsSSHxWgkTwNOp0sgc9DoCaX6+2
	fFGIpWrC2mtN02FjLVIJoxsn9ikw1XDbNOzxLXEL7nALMdqo4KCgmP2gzu6YK528Wv1dEnzopgk
	/s/+ynW3rQ+BhdIrcIIwJLeyc/wsDHsOrk/W1fUAYkO/HWOvmi8TiRqveTIU5JFBn/sij2Ri4af
	0e5cLG0uOYlPgJS3sitXo2nSrFbe/GltklFJOLvPOhVX5H5qwD7/garNcera64QW4Ti/WynKCnn
	mz0diukcVUFvioKkFiKto5xAvhdBpyQtpZ0WUXQGI3qCV9jLhWl2kwoh18n4NW0QxwKrnwHSJXE
	+3RAFDLplpwfzxULzgJiMSrpcDA2CQR9JE29Q==
X-Received: by 2002:a05:622a:4a8a:b0:550:fe12:22da with SMTP id d75a77b69052e-55d7688cd8amr172622161cf.6.1795367128112;
        Sun, 22 Nov 2026 09:05:28 -0800 (PST)
X-Received: by 2002:a05:622a:4a8a:b0:550:fe12:22da with SMTP id d75a77b69052e-55d7688cd8amr172621171cf.6.1795367127446;
        Sun, 22 Nov 2026 09:05:27 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889f8absm76210181cf.27.2026.11.22.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:05:27 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Alex Ainscow <aainscow@uk.ibm.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH] libceph: don't put a linger request twice when its watch is cancelled
Date: Sun, 22 Nov 2026 17:05:24 +0000
Message-Id: <20261122170524.1272906-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119-wip-libceph-linger-uaf-v1-1-40f3661fea68@uk.ibm.com>
References: <20261119-wip-libceph-linger-uaf-v1-1-40f3661fea68@uk.ibm.com>
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

Hi Alex,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

