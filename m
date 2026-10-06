Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E9547072
	for <ceph-devel@vger.kernel.org>; Tue,  6 Oct 2026 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272469; cv=none; b=uvbTpyEXQGPRKRnUQvZI7AKEVEagsRhp1oYH37/EQ0Su9tcw2cTJsN9qeg/KvALhJNbZ3rdvYjB6o0WDtnwrN0ewFlElPS39tbGOebBxy6mXJVdJklAewnLVKaizh0X/2S+3KswjMk+z7vV/lumSY7ssxzxr3UZoO4MWw8+6XsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272469; c=relaxed/simple;
	bh=CUZ0nn2uvOjFXUaMPnDaOHeOLuGuUc47vEk3RTJzH4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXCq9bLIXXuULzplTIhp9mubHGc1AdDXLMTiwkTb1MTvjyrHDwMT+OmDhqUQRUgJyAMypdHzdIqUXXSlOTbLNFOqe9UeRL6zFDrEjxtAdCwpD6xLRUP6c07UMEUzmBUe9G3RyKTh83N9VZ8wd5vvmYzBD2cumQ/eH2tKZpVnQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fg4I03DQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qFCgCpi9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg4I03DQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qFCgCpi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791272466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwr+vjGc1AVFwNePbFQgJcc6y5npBOMv4I9qE2KN3Qs=;
	b=fg4I03DQILmaYIkjOwnO6q5fu8qiNTvY1bgCTC1bk94KlC7+3cConHHYijHmxn5lRbVuGP
	12rTb0KzNrbah1R39pfr3TH3gF1CvOFYVD1Bk8n6wxhm/QcAn4Ww4WelJ+qkgdTq8gPSY7
	KbOWpCMwl8PbB1gtXg8BA10ZMg1BuUc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-pKBjZGXOMQGH8yJ2R_DReg-1; Tue, 06 Oct 2026 03:41:05 -0400
X-MC-Unique: pKBjZGXOMQGH8yJ2R_DReg-1
X-Mimecast-MFC-AGG-ID: pKBjZGXOMQGH8yJ2R_DReg_1791272464
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917b76ad48cso61229666d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2026 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791272464; x=1791877264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kwr+vjGc1AVFwNePbFQgJcc6y5npBOMv4I9qE2KN3Qs=;
        b=qFCgCpi9DANO4wpa8sSmJlT9BA3/z1tMLs3WJv2QAxOOv69r9SDLIZPfZZNq6pRqdE
         AzbQfsgMEnpHsxKcQiLwXvuHOEOFaH9W3edcLqpHYDrr59x5zvQCcFNLC6IM8gEv1PLB
         6dZxb1uqiZYj2p7VB1bQqNVHn7nYZ2s1WH2zm8KHrmNbpbFjTu7UyMdmDvO5GuxGASv2
         HSw5RAdw/DCLYQQHz4JSXtQLx5GmKEgTCEp0imS+rYFPUPcUUanAmiimQPV1+c7lHV53
         GvcD7uRvf3Mts+btcRoCV5XsRHv1F3oTPnt7IRC6B8ACMrS3Ga3ymsO3tHQaCrUMjPr0
         kwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272464; x=1791877264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kwr+vjGc1AVFwNePbFQgJcc6y5npBOMv4I9qE2KN3Qs=;
        b=x+STJvKOzXx88H1r85Ifur6CCPMJ8ZotrbFdx+WkHZj4WFSDEuTOMSwgXiVs7XRgWH
         O/uhhrJAn4PO8z813Ml99i/pcxeSY5qGxv99h2Hu3EdJG0SJhkyosdRYl8S10Wbh5CuS
         g2O2IytFHr0fPpv9wcncOWoCCmqNYqHE2AeTwq47TvTMN81SVarnNLlek3sXUTPw1Raf
         zz5doUziYa5fE6RzR2PS3bk5xHgSfjT4OXR4htADIYKEXQCAwYdOe/9YgROeNfIQ3xQQ
         SvFvMVZfKGs4A7ILLKlhmgUCKasWmUF3UwTusgV4bZoSaRLtAZZ528398a3Zbe6dY6zt
         1BqA==
X-Forwarded-Encrypted: i=1; AKwUvBzAkJOAiXhAw1oRKJBUor5ap/Gqc9//Qzhu158pXH5kuxdFS1wBjgs3ep/THS73WPHOJu7IuxEVXcek@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ+NC+3dJldJuclyfle/78uyd+eM9oz4TZKxGxHTYWcvtZ/bPs
	ZdYNYm3/AgtCpqkA6d8F+ucLIApAX2wIR4aGVZLLWXU5fx5Nim5LZL1BV/9+YL3gvAI2lTKI0FO
	G78Of2YKythBEaRxikR1hd9KSWtRb+u6i12/1UEjLiY6HQ459p5Im+sEpIF5umZEm501DF1fhsQ
	==
X-Gm-Gg: AYBFou3whyI61IV7DrYR5n2o1g5O4+gIN0kB2aR830JWuf5W2H9SxESY+g9zMfoaEwm
	GgVe8OGcyVT4VErK5QHmb7RoaAlLqlb8j/6BPDXhzPh6Z82LSUuDpvt2AKafkIJd506fIpD6lbR
	rXc6TUF4D+UEiDsd+Y7Dlsxh/JizkqZjSj9BP9H5HCnu/MVxEk76kfl//7Pr4/PSZ45zU7YE6e3
	dxHgOM4TCoFhIeZj5E568DMXInyAARz4P6AITpeovp8hghgNkff15RyNXjfdjU/nwckqnf/GlQc
	QCJIctqJSjVCsAIfIkHc08H/nK1FUrkUL5sAIJH/IBJUqcPotMwMG96/f8u/t2E70rNLYD1Kxwr
	RLAyHxuJMI3uIhuQm7wfG60q2Kb/lxUoLbih4tnOkMaBnm5Pt9jLiXYxGwAZMOQP3kDKMebuTjW
	V+bpno3PspFkdOsw==
X-Received: by 2002:a05:6214:451b:b0:914:56b2:89a2 with SMTP id 6a1803df08f44-9198b79bda0mr11060096d6.20.1791272464468;
        Tue, 06 Oct 2026 00:41:04 -0700 (PDT)
X-Received: by 2002:a05:6214:451b:b0:914:56b2:89a2 with SMTP id 6a1803df08f44-9198b79bda0mr11059826d6.20.1791272464000;
        Tue, 06 Oct 2026 00:41:04 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c14c97sm106627146d6.42.2026.10.06.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:41:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v2] libceph: bound sparse-read consumption to received data in secure mode
Date: Tue,  6 Oct 2026 07:41:01 +0000
Message-Id: <20261006074101.2081774-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002104720.2041815-1-zhangdairui@gmail.com>
References: <20261002104720.2041815-1-zhangdairui@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dairui,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

