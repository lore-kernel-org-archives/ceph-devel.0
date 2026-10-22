Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669049;
	b=GuuKz+wk7y+JTT2hE40u9qGP/HHJWH29cnCu2X5noWdM6yH/usGGE+6CKj62pHMwBSz2
	 X+eqL2lpYfOeZaf322fIgRG0QYR1zTl2Y/dAO9h0zw8vmOYVrU8USuOSi8zyr2QvB+7Jz
	 4IT7RuXyTmiLp0vQVBRLZCO1wlAGOzrEy4zuRRmjcTJFbU5j9RSbwpFZkR88vq8iXndQj
	 7fuo+M7ykgoikATdFuoXLiwzdZrK6RpXz1mMsBEvBHImgtNj7n6j3/VjOBAJ18KP3nmKS
	 NQkXyDB0xUTikw9x/Iq6fK+MgvX3tKOSaW8FdvNSmLSSrTvDrQjXHrEbHwQ9zQh38lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669049;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=L2t7vrt0IKcIUXQvU04+fCMQKp2YzbpSaE+uog0HYPfSqcDL+xpIsPKQtSP2ruuzTfzg
	 8Ihv9BD5PgC02EW6h3YZ0btPo+yFbPTHHlFQo8a3cjIlYaE1Nhf/oNp0bjFT52MWdAZTv
	 ived+Jdt0iOOC+HBuI40AOMv9Ha3+/07GMsyNZPK4PcAWiGAii7kfOGVWjEYXSCTqMPdj
	 qwXIWaoJBM/FVI7VMTXolDfHb12yMIZW02cPreg+FWN0itd81pYtXPCU1Amd8iBiR4N3C
	 5s8H2rpgk44yfhmbQZVH0tGKTyC08NN4uC1VrEg3h/ecQQQCv0QiGjo/wOpN3rc1S6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hil68ukb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PTCI6TBy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522F606A31A
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 11:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6522F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hil68ukb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PTCI6TBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792669047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=hil68ukbuDQaqCbhLzMQlwDms2244W+2OCovgvtuzJpnDxP2JAIM+QBPVaueqoVVxzm1xG
	sgEbDHlqZZLDMeIvxiCOkxFV+G0UBpwRDiFjCC/5mATGtDKOjyZMy2LQwE3jLeLbjXn9wY
	/xj/ZZuNrhWPJoQXuIA9m1AZcNMvsVo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Z6pU_3z9Mp2A9dFPeBML0g-1; Thu, 22 Oct 2026 11:37:26 +0000
X-MC-Unique: Z6pU_3z9Mp2A9dFPeBML0g-1
X-Mimecast-MFC-AGG-ID: Z6pU_3z9Mp2A9dFPeBML0g_1792669045
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91be1227fdeso37560196d6.3
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792669045; x=1793273845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=PTCI6TByiUmRpxoWqXU8HUE7ukzo6G+IqSGcwRmPvnGyFkWJhSGmAlFlKIfNr3lgfz
         IYrNbLA5d9/fv3niLWtGmGtPiSxEGVLYwALkLkyX1MWixVPuDfxzXpgee5k4DY4pdA4s
         4xT0XnNt8TfNypJzCNNrr+gdF14Dc3lJ4WlcMmej3Ms7+6bXcOupO8D2/AHWeP+gDLjL
         oVN1H/J91rg4e1eqYe1fbx1AIknFsbjf77NMMtR8LI1KDQSOV/DiwJ3Mqp7WF+0HCr+S
         Li5UGv2MV8BftDJ7vwUdeTovBv6EkpaINYWZTxwGS0svu6a4G3OKWVeLZ4jnFqkpQibg
         UKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669045; x=1793273845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=Bu/ZHR2b3eB84hJ2Mk79hxz3CVE+ufTQyDxuAFSrTTAEp791aF9RYIxKi2CyaTrzPj
         A4oVMwf5nCkSHbpk2evkv68xyhstmOqp2jrfyLvBXiy4nNg/3RqJQTYlpUSXGhORwaT1
         fA19fzHRMu9c01gMdIU10knEg1MZ28+4Zs8G9g1O4ZhbomVgNBSj2rnKPYlr7d0vAYhs
         nXpChZqxTYCV8wVUU2RAb/QKO6S+aXnyRNxmGjMT+fqpsAtxreT2NACUmoQhWzP9i6pl
         2cLBO7wupE8KDS1flnsLGvd7ZzZNJ1VDHqijh/NDeOS+eqWqTTGzlYtQtdPj/PinmH5t
         b0dA==
X-Gm-Message-State: AFq9FYLq9DjsKMNiQXC73XV1wrrS0sH+wMo0WyTYok0XaJpmagFxeGel
	5Q+/XjI8djwavKE89kZ5VR7njFTTTS59MT34XVgne+zEhF/6FWq5lO0l4sMO2GbPk8ZqV9l6AeN
	fUOOrpt/vgZPjeOU7tJfEueqpOTaMeZL76p0PLQvQ1BcrG0bsJ8yYRigpGaPFp3TAhAuchGcg/w
	==
X-Gm-Gg: AYBFou0jqZw9y6WKo1zQS+TTImnJhXGhJuq0AxSKoI46D9KS6abjIbNTe5yMv41/i5w
	TMIye94XWZjt5cPkkfvep5jz6NbLfjDMojSz1u0EhLdtmsmTGhnrIspuSo4FM5lNNGb2lknGK5s
	YF64pIXGEu/Dj5930ZOXX/yp6+wlvfGCC+AuE5wJAKqKm0WIe08KZGMc+GCEwdocvKJ6WrfoSnV
	rTLNey8tTScWYM2DbJ2zOWu1WddX2/Wi8g5Lgv7jSehPjmoZbax+wsbS0bzxfgQ6LUASXCOzprD
	+Bxz8BnYBvwrvdID9zQTJwgcmIkuDFSPLhG5XSqWNvC8NvmQPSciiJ6joUXhT3FmfFX2qPXoKpf
	Ve/pnuPSI/GzXC5drhEWznQdDXrRZzA84T61FF4fKSoIlkjq4p5Np0XbRqTPiX9srUqsuqiXz0R
	HgIUdahZqFWN/AoJpySDPxOVBlpFI03UMMF4U=
X-Received: by 2002:a05:6214:4589:b0:91c:3e3:6b7e with SMTP id 6a1803df08f44-91c12ed9495mr86407096d6.30.1792669045205;
        Thu, 22 Oct 2026 04:37:25 -0700 (PDT)
X-Received: by 2002:a05:6214:4589:b0:91c:3e3:6b7e with SMTP id 6a1803df08f44-91c12ed9495mr86406836d6.30.1792669044704;
        Thu, 22 Oct 2026 04:37:24 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c23025a78sm19367376d6.19.2026.10.22.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:37:24 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2,2/4] ceph: drop the unused subvolume metrics debug counters
Date: Thu, 22 Oct 2026 11:37:18 +0000
Message-Id: <20261022113718.1908484-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019-ceph-metrics-percpu-v2-2-1fa5229b00b8@clyso.com>
References: <20261019-ceph-metrics-percpu-v2-2-1fa5229b00b8@clyso.com>
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

