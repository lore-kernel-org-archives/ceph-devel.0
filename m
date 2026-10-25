Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950393;
	b=GhrxpNyPSzpw8p3VzneuxBCeqoAmQGqgXayuJlwyaMPCoSs/3l0ex5rjrsb5st7rGB1n
	 2v+SsPxXgEcMogAB13frzJx1kIeeRiuWnuIscKmwzhxrEqO9pqwgFi6Ky8mtk6oHdfBHH
	 xbiWaFMvVJrdXTnD9AXMdyKM7nuUPwp/ZgxSEsyqaUqok5+ton1sP0qB196nd4G1OQF6G
	 44QwR65aXS5AiA2q9tFcRuDztVGYj+Gv58es+QeXyJ5jMEYC8t55wzv0kx3cGWGEKsZII
	 TxZPIGsgYvYH2QgAkxMgW+jsh7S0yhPPdtfXIDKD8CPbmfDQfs3IKXKtHzKwtp33mAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950393;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QKAMv90JZNPIAbpXnHJIxmJ/B+Ql4iNx7i9WTX0AJlw=;
	b=qnFAJjevHKV9zHwfN26r9Mb62lF/jw2+CJ0p03jvphingH5khsW56bY/aDPtbH7EOoec
	 olH1A/84t+HlcSB77N5WybwbQ/kxMtc47joLyvnXoZ4R03jpSKPYwH40vgMtJwjP1f6Jj
	 HwP1Ppa/rkOe43HuURoo41UYIu672XWDDWp8hG7OcEfRXcrNF9aFToFZUCR3k/KuB914b
	 5b4w9jbt0NvgCJHAI0uWahqinb7frXAWAIHT6RCVjvKc1V9KOnpGEtOKFThm9RtsPuwwO
	 pDxYNMKsoLTPnROWEq0yr1HdU5CbNOeagPU7lRPEKuXAtRAmggtGy5C9Sa60tH1RbUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Om4t8WrT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=P1GGJoaW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311F606A31D
	for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 17:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B311F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Om4t8WrT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=P1GGJoaW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792950391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKAMv90JZNPIAbpXnHJIxmJ/B+Ql4iNx7i9WTX0AJlw=;
	b=Om4t8WrTQw5/KiHBiWCkzAMF251LoBaUHwX5I1pb8fr7Jqa913nbBqxUWzto37kN2lU1Ti
	u2bslb2HifFIS2pi/azLB8wfwAlo9GbHY89dRrmMHjJZTeF4sUWzYEOPxtXOobJrh+QwIo
	8AzRFga3rg4Db5idTSQssZR/VDe+pvU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-WLzycTUrPrSga_7PgMNNkQ-1; Sun, 25 Oct 2026 13:46:28 -0400
X-MC-Unique: WLzycTUrPrSga_7PgMNNkQ-1
X-Mimecast-MFC-AGG-ID: WLzycTUrPrSga_7PgMNNkQ_1792950387
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53661e036a2so53519641cf.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792950387; x=1793555187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKAMv90JZNPIAbpXnHJIxmJ/B+Ql4iNx7i9WTX0AJlw=;
        b=P1GGJoaWWmC3UY2aMBcq1nNzrTll2sCQxut8BSnJbSla2sT4l//AIAPQbbT6FynMaR
         rpbF9Q0npesQcBI9ZBTHy9Ev2KRyOQgLTmY9PU//MMRBJ8yE+F9tKRvWoYsPJR4hYA3P
         pimSd13inGW8iMOH8fshCdzQDPwmfGWrgwTsVPNoLMw1K75FVpY5eHWM2YuXmiU/i+Tn
         PEEaUGcU2fRGPCu9XF1je4OfUXIR+F7NSm5T51YE088Q3C46jFolQtk8mFANBDdwNCZP
         FKTb739tMQU1n7XEfK6YVQkOkgnxHXDnCz9iNziVV9MZedH/9sQWYzCi0a0ZeB8V4UeS
         6K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950387; x=1793555187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKAMv90JZNPIAbpXnHJIxmJ/B+Ql4iNx7i9WTX0AJlw=;
        b=kO8bH/5BjxySoN5l3j2zbcjoRJN1MsQh1uUwuGd+zaaAzUD85dXP+qUoaf4yRUZ8EB
         A6CmRLPBF3RJXAaw3pHCgUqee66u5GHSUau6h1/FvHkI0oqJwozCBPb4YbIpeFhw6obb
         HY5SaIhct9Os7slUTzstcGRDFWeYL6OOVNpWgysS47a5TrZVeIEZC71Uu5ywqDuSt3b/
         Bmb6B1mZKbIvqELenPlLJ67AJ+3pHNziaeUKwMdyefAdKhSI40IX7OoGgLtk3TXVu3at
         PPNqPnlZOU7HyU89qSQhpFEOSdWLoTtbPauDg38MsHQ9qQLHBRCLiFEEsKhEc1lQIKG4
         MwEg==
X-Gm-Message-State: AFq9FYLHgPUqH1x41q6VfTcAfsZ2knE5HxBZX2yLnPIqnA8xIybwL0cx
	dwUjRt+STDRI7HC5i3vCvQmR4LkVFa2p2CmVZuUvhcsmREp5FZQNeWP7KZx4rbrMXB6FNVyjaYR
	db1rssuEtFrJmpxlMaDinNlS6OVow9zy8PkiXeD9kjNhfwrwFboASt54MqYme3Ng=
X-Gm-Gg: AYBFou1TRIcUJ5Qyn3+j1JljcAbVUaqaHN6MkO3zF5kBpItwCBJ2eKMpOzNmWqCm6Zk
	rodcK3DwmNldHio39+ewy2M9xVHOV26mISBg9NsNDS4QzSCDa/bvv+LhhLhnRUZ+vYKAv7iDY1e
	NiTmAH54LePJScxiVHSzwG+IbRZlFlqHnGudxnCJ3jGNfx3eekG3wvgxgM34w3NRqE4TXXufUvz
	DW7OAc5BTOZsC5gdlSvLwAUsDtgF4RF14MSZZYJEa1JKqq8bkaezR8RmNoKwlQqc1twHoWZ5beQ
	EjNEZse+IZXTXMSqplgqMWexMRWrNZtXLOFH98ZVSFmuB75qFJO2DHCdQ/jyySBwsfZmx8ufFox
	rO0kWfLmlKYJuGnCtBAdy9vdBl46dK5xYx5MSDFFxz2jPPob1ft8iPe4lcOBcpB0FKnQOo6lXAn
	oLKbRHlANkgBZ3p6iuEJL6qzdqXCmOBfM5AU5o6REtm7/r04FsEixkhGl2ZCgtZlkYesmxQj4Sn
	pM=
X-Received: by 2002:a05:622a:5149:b0:536:79aa:de06 with SMTP id d75a77b69052e-5383b6ee917mr74720961cf.52.1792950387568;
        Sun, 25 Oct 2026 10:46:27 -0700 (PDT)
X-Received: by 2002:a05:622a:5149:b0:536:79aa:de06 with SMTP id d75a77b69052e-5383b6ee917mr74720731cf.52.1792950387060;
        Sun, 25 Oct 2026 10:46:27 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f82cfsm37877071cf.13.2026.10.25.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:46:26 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: In-Ho Yi <chajath@gmail.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: drop local lock records on unlock when the inode is shut down
Date: Sun, 25 Oct 2026 17:46:24 +0000
Message-Id: <179294998358.2893725.3903560640864672698.ceph-shutdown-unlock-ack@redhat.com>
In-Reply-To: <20261023-b4-ceph-lock-shutdown-v1-1-f9b1fd9ec026@gmail.com>
References: <20261023-b4-ceph-lock-shutdown-v1-1-f9b1fd9ec026@gmail.com>
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

Hi In-Ho,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

