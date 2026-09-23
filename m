Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC041684A
	for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143944; cv=none; b=tW3MX9ho5hwSffrEIQ2haPJtGBmg3YUqRMRY/mImTuLrmL/RZhSqYG8OoNYIkNHr6jxyd23hUDEfXOBvbXE5zf7LlOlHPvlLxcdplAhGqK8dKmzC8DbsEM2AWe4O7dZYUPEUM9+7561bQF84Suku579sl2pZV+zkuQ/xU2+/xMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143944; c=relaxed/simple;
	bh=pDG+LUYfWE/lg9GV3EwC7bNAC2luO8YmosElSYurcVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiPDI4Axem25uVPP+dZ/hBKxJSP1Y6TW3aN5eWG587c+AlPdTmG4PAEGbFnDSJApKiEaNHNyLGxGOTq1L9izYWUCtxdj6sPT8bfagIdGsEJ/6QfSSD3hTjEIEkzd9HNfegMzSqpY7Wr+eusfgMraHGST0HYSIgXAtYnPNNf5Dx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtU2xhN5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXHdJRuU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtU2xhN5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXHdJRuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790143941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
	b=WtU2xhN5CMzmL/Dt2AaD6hRLsx6r4HSYxhTfInv18cecnVSLMacILMe2/EjNUrewJ+i2Q3
	ijUSBRFN3WTPRVtPFTCtDpq+sU+7S2F9u2rrgzUId22R3ZzJOmQEdLH5J9EgFOEGgWKEZr
	7FSPL14UO7ZWdWmjqHRKEH9Eja1wL/0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-InPzvfUWMcG-DMmPp3Uf0A-1; Wed, 23 Sep 2026 02:12:19 -0400
X-MC-Unique: InPzvfUWMcG-DMmPp3Uf0A-1
X-Mimecast-MFC-AGG-ID: InPzvfUWMcG-DMmPp3Uf0A_1790143939
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e87478402so14838656d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 23:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790143938; x=1790748738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=DXHdJRuUfXskjEHY/gejvyHmMSxP6MWo3cnCp5knLxGl0PVYqMRE0b77+mpxYhWH2t
         KlZohWRkvXRbk4N6Lo2QP19PR52ALjUrp1sslOpQhEgGWbDUDR2ZC6aw2uDhGlDJmMEE
         Uac0FmhJpuBbrPNKh2uZM2xl+DyNL7xp7AwDUhdIYK9WG2LNfwuGgydRlzKPMr4gFFMa
         wlwC/CQfux0zOF1OvsHjHS1cpaWTsqGrgfGGmygiSTYCZZvvCdKkqiZUkiSKlEoSwYzG
         Bj/K5gtweDQRlgpxFb+R3shAUCGrvNrSgIgqVP9u23c8LeULFymp37gnmtLxAj0QK9W2
         0faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143938; x=1790748738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=rHgYgDm0n35Cb/kgsQR3DcMAxEsiIgDzyfNyZQGwydYbZsDIGSR8kAGt2FbwljxCZX
         ZnRJfpn1Kk6u1hACnZgR7dFSXJfzyLFa/WFQimKTxt+wOe7xEiRNI74ZEbkh5aJ1bAm0
         j3fMpIOrTuEh3FV5mlXLNU8O7vSWXyXeYGH5oF1rGM0XncANcG359zQEDoo7YYZ8RL+q
         eBeDH8AlpON8KDz12RgAQkrkO8R75dN0bJWLdhG4iN/okwhdkPmtSJvytB21OZik12Or
         zAtB02DKonguqXzCz7sFek7TL5sTNwdmy6Zcdv21A/xzOCp8ZO+7JeupvvO4TIzCPAVK
         Ta/A==
X-Forwarded-Encrypted: i=1; AKwUvBwd3xZXxBmTC/zLqWXWkSBUx3XfvVxOgqg964JYUKwiMBZfKkliisOFWRjgXHbcXejnp/vsVvfp17Ow@vger.kernel.org
X-Gm-Message-State: AFuF++m2K9HgBnKzC69helHDX3oSNI4yBbBnv9nvghgnrfp/AIHJHvBJ
	sDcLqsRY6TXQPQMd8C1nLC7QgrfIcoGK+HC1zQECYpOL/OQeIJj4P0WnUmFzRTUpVFLk9vFHoIS
	5fcJ8Vq7O3weVZoTLCE8W/TdPo/DTIQMymU1PBVKX7vxyGh0/IOJRLf9h9CA83+8=
X-Gm-Gg: AYBFou3ml+VRMPAz/XptSgSujNL3aas9OcBNp8mk5h4UgMsPBdiWlzCcvs7CKRV8frp
	lj9rha5czzlxirK822lvr5F7WfybmrtRO1WbubPskknmxNMtxTj1dQlFlZU0E4swZmITBHLg0HY
	dYm25IjY97M/4O4Z3JZ58ix2cqicvbuCr/I5uia7v6JArPZ0ywDyNG3aC1rP4Rk/+8MGIKoXqyf
	guR+FAKOgZfRDAoca1iaW+Reg9tINCumzFIKV7VhfG3GR1k12A/nZ50uxb0LKWQZDjWrnzQkClR
	OvxeMlq7X72BYNXp25AQnUufbb9pE+bG8kSiQLzsvrT2EM8wUMS88u0GOYxbDApUoN/oqjKH5Si
	5FT3stRBT8NrdaUY/qe+xllnhFYEWxBVLmCQmRISY2g1dvgiPhZ2+Qxt/dy6pP62UWRJxIWPc60
	ReOjEuZZQG73asmw==
X-Received: by 2002:a05:622a:4d8b:b0:532:c1b0:299c with SMTP id d75a77b69052e-532eae344cemr26065271cf.60.1790143938678;
        Tue, 22 Sep 2026 23:12:18 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8b:b0:532:c1b0:299c with SMTP id d75a77b69052e-532eae344cemr26065061cf.60.1790143938246;
        Tue, 22 Sep 2026 23:12:18 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb34f735sm13171051cf.20.2026.09.22.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:12:17 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: ceph: fix integer overflow in the snap trace bounds check
Date: Wed, 23 Sep 2026 06:12:15 +0000
Message-Id: <20260923061215.844720-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915214027.1415623-1-xmei5@asu.edu>
References: <20260915214027.1415623-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiang,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

