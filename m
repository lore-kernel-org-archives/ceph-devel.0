Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309280;
	b=nVn2i2Y7TQmoCv3XOYoXgx2Zb1EBhkGRp2Zf7ATE8YhM0WzGHnoqzekwprh7hRqAJDPY
	 EE2TYI6JJzMaqHYfBm3MVurj2/yBYXfENKn/5tZIHlbngdcTfGq7r2MJiWrvjiScW0x0J
	 Yb4Xu1AaH2DHeLeLdAa1CDs9w1Fqalto3+GnnFMij9+FODPAJYE3xvU8zyRW2rRSevQN9
	 pAaLsdcgZ472I3eGx3VUdyydhtxK6tYt41i4lgl3MX4gZcBZw82c9Gg2cesWc636z4yY7
	 cyaOQBwzE3Ru3FJAhhSrA354DxoizsGoIVu30/NxJzONuPMYFR7dBW5sRX5eho4ClDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309280;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=qACbfDVhyhGYYbcnX67Ru6IdU96mYizMSKoGyjfLT9uM0yEVbtXTlQ8Jgxn0aguZluG1
	 wI6wmaJEGedraYuMMPn5+rOhRr/BZvlPScC/4bLNOAk8HQMs1Lu62GUuHExNw7/L7xE9q
	 7AatEMxpJnkp1wNKJhzfOz7aFr4iVdkG4AvpL4vYowDCX6xAUfpA4/P6j1NWkogPlI1ys
	 Qk4AathnFS3uz4S66Kph07Bd9yGjGr0NJM6XzEXa8oORV+9R/j4W2dqSRtRXjMvTpFJQs
	 7tHV5GwD757dNG9OJdw8gBGF/1Uth1/bL4/0+jE+fW4TJMyZpLI7fzm92qlScOb0aQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hB7iYy6J;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T1mhBFXU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72294606A33D
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 11:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72294606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hB7iYy6J;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T1mhBFXU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=hB7iYy6J4V43CWV025I360bmaQwT2qnB57u5+29EUrK7LwXp22aeOoW7Nv+6Vapa85jRet
	1OgY9BooAe3Vbmbm97Bc0LRl96JUGFVeYLkLSZb6tDnHaTace5vNn7z/HoT/aRuvlTH2W1
	JLMZwqMd2rkzK8tqInVg8lEwAbDHgBI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Ck9Bofk5MNm3dHO-iNxfjg-1; Tue, 10 Nov 2026 06:14:37 -0500
X-MC-Unique: Ck9Bofk5MNm3dHO-iNxfjg-1
X-Mimecast-MFC-AGG-ID: Ck9Bofk5MNm3dHO-iNxfjg_1794309276
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c504b52eed3so71718566b.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 03:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794309276; x=1794914076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=T1mhBFXUhSGd2Klh80eq0/yaAwUaukRmN4QuNgXhZz4nKzxtn+9vB6cfmSBY1W2vP1
         gHZ+25S+MpW4MzxG05csZSIgd4PDcLJSX24dL3OWO2Zs/fSwt0X6fPuJJlzM1dD59H6j
         h7ZguKTxgTmR6XvvmM3fMEReeT/3amqwGVdcmlKfrAEJ/o99896qYBtRcdF7AKFBr4gX
         kiwwjxwJLER9YHEoh/4Lop9NXghvN9915LPS/B0soOd2RMd+F5C/gNHnkth7Zqp13+vw
         +sG90gUbY/cDatY3+ykXjf3CmMPQqOPSQMUWi20PTLQaYCzgV7oWOthpRKWPN2MFsGJX
         qaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309276; x=1794914076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=kKd3vBW7IW4p0mlRRTyDDHX/hN8BVnJAZiW5WC58RdgaXLfCGGawWLFF5EMBLghC2f
         sCtxgqmQGzq9iSkxT1EmJK8XU5v3k6a5hQ+vY+LuTrtunoTo4RMePBMDYkqklHfMOQSm
         C4VNsjM4OvMWuf8vOQT3OqRG1TdltgqF4sAJ1oqPnkYCRUd4k2PIGKAlMXgiQm8xa+OU
         vWe8kkmEEHRV9dheuUXJ3CaZpCAU4R4r7I+Eg7CxAgqdtkpQPQMqGwCt6UIOnQq9tdc+
         ITzoL/BXMV9DxnkotPVR9zQlV7gMGF6kPSrJJZz84h6S95LkUUdCrkplxrpaxCbHfuRr
         VuNQ==
X-Gm-Message-State: APuU4Z/+VgTbp7Ql1u9YLpuA1K/jALpt1dm+QdZpVfRXhWqC/2uzZg7v
	zLSAhktnPz2iU2nO9NJqW8JdumnYgMDky98dVpOLISr/YDbASTcSuQLNp5MMMaLlg1PBdr0InJW
	Ax0iWW+ViQ43PCvl+OKcbx9EyQU7G5nptXCLLFSzPyjtZ7aKPqgWs1ZTEkEngYxX+oeYap6c=
X-Gm-Gg: AYBFou0jhVb1vJDePMrP+7RRJBV8Ny2CsiZFR03DmofGIjePCEMERJG8R3guua6hnh3
	5pKzofLFxyAqV83qiqZ8CSIK14iv/RioUMTxbjrpra7/NSxFNxmSmGH4T9xxyNxMd4hezNAMcnt
	RqR57IKgmfADvMNUurUiVFFv3EZGK+j0liRPpe06gREguMPRNGakVfUM6GuuN1b+ikpoMkUMIaa
	zBwufbEiD8WWqqD5HdMpuDHVsd7EVpUFGG0DGLzK74ldu4RkbLLDVFjHXTa086yUerYOXdeLbQB
	44W0erii0xaaFdydZGwN5g2tNhpJ1L4WQKD0WX/1A3Wp3+wZ8CQBpPHcU/ykCGy/M1KgwYIQYwM
	uHhiRqjJ5nAB9IuOJa4eMpkgd8Rsp5K4a6R0F7fNRQiChmm2SlomCFa0MDZMaxQbheG/bMRiMYK
	E3PsSPMaZ++63Bzr2xp0hb6f8vZL27epV47LeUxvjmSofO1EHSakFIxwvC2PhjwH7tNELqus4iJ
	xCbw7AFtdEx1QoFr0aewXgG4yjYj8dSSmqVpjAjy4oNRtQDUA5V
X-Received: by 2002:a17:906:7947:b0:c41:b4e4:7958 with SMTP id a640c23a62f3a-c5048c75ebdmr186630866b.0.1794309276044;
        Tue, 10 Nov 2026 03:14:36 -0800 (PST)
X-Received: by 2002:a17:906:7947:b0:c41:b4e4:7958 with SMTP id a640c23a62f3a-c5048c75ebdmr186628866b.0.1794309275679;
        Tue, 10 Nov 2026 03:14:35 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5704aasm96757066b.25.2026.11.10.03.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:14:35 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: hand the lookup lock of an in-lookup dentry over to the reply
Date: Tue, 10 Nov 2026 11:14:34 +0000
Message-Id: <20261110111434.3260903-1-amarkuze@redhat.com>
In-Reply-To: <20261109-ceph-lookup-lockdep-v1-1-54f9cbf9e147@clyso.com>
References: <20261109-ceph-lookup-lockdep-v1-1-54f9cbf9e147@clyso.com>
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

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

