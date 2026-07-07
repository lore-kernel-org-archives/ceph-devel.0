Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F239934B
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416137; cv=none; b=nyZaFN/PVsLwSrYAp24tz128Px/ZImPoR1NkNvkwSJ5NqvaLNs2//wER0rpLFNW4gNxMaf1m44rXV6Bt5D8uCPj6+ovGro54pbtYHzfwiARNEbRL640jlagrpYf5+aYAvrb5942e07Xj9v5JxBSXOjGcgUFq0LO8wbWcGsjFj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416137; c=relaxed/simple;
	bh=WxjhaKCyJdrrSmi5smW9eF9czZHPoSjIFvfDoycEZUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BL7nVn+qlEpLAgEafhRRrExF0qpX/8DOnWlE+r50ocBf7LyVJc9D016fOw2mszmKO5MkBvqqWJIAkNY0O/MAIRVa7zc8Qy1AfApPR1NHWspdqlBJ1VkCj9PwsFfaBCKguB6YfzTXmJdxdqeNpbQR55Jv/8oxL+x9Gnr6DsgJlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJjEgpm3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+NDGlVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJjEgpm3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+NDGlVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783416134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IVcySQL23eGG2rMYOmit5ll0hDEav5B7Wjz5J6CN6c=;
	b=MJjEgpm3uU5eO9rMUtdmZgPQ1n6KCSdw0C3sJId0i54PIKhSiK+wL0msceUHuZ0Cl7S3Ei
	BwcRgdfLvkCpEn1S0vgBAMK5m7RY3Wn+YdvSBF24XycAayYYGyTMpjcTmIGBP7sUcZ7Pr+
	jGYjTV2ezPuLzL9LPp4mfhbFRjo/Vjo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-PXH_2xhUPyekMQpbG7HkbQ-1; Tue, 07 Jul 2026 05:22:12 -0400
X-MC-Unique: PXH_2xhUPyekMQpbG7HkbQ-1
X-Mimecast-MFC-AGG-ID: PXH_2xhUPyekMQpbG7HkbQ_1783416132
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c12c2d67af1so246233366b.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783416132; x=1784020932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IVcySQL23eGG2rMYOmit5ll0hDEav5B7Wjz5J6CN6c=;
        b=H+NDGlVCh05OspcxfCiaTjbWOwbER2hcn0D+hjTStlM9ExYZ5UwLCafx3z6QYQpKro
         YKlwD/tgCLEnqd1SJz0hEyiVBEsHAuAEhZzOIUgU/QwK+ipq0HDVZRWDy6gGS3t8xKNx
         sILcCItdJgQzqy2w2DfTUJwrmJQathIi6yEfRowO7S39nvuUfdaNYvGByKLYM9O6zC6z
         0qztSBiMYHGF+XHAcUuQ2WsM3O4fz6nR5JBeE0If4nWsv39z1U3s7qU+ho7hPtpU3oGh
         UbrMDuYSWFDcPrW0fOAL7icfeAdUTj9uOg3Wy7tpwynvasj/7IliNxAluoDSsNQ1Bw94
         GLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416132; x=1784020932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6IVcySQL23eGG2rMYOmit5ll0hDEav5B7Wjz5J6CN6c=;
        b=l6xk/zTeUSCeHuH3J/7nawwvPAalblpGEgqSbPrJLQ2bLmEx8KE3KtmOsYby6idg2d
         qRa4h3rI6bpzJSLAp0G1CabR/NEro5YHVCXjnDwRUq/TkwOJIhYZDMCznHmboM/qaZle
         OB6WucJ2OLItCpYi0eUntQ44fIHJOWT9mPY+HrbW8GZU5qFYYjAuF8gK5cqa5mJNNTNF
         LwSVYdbIyqg4DFLARc64Vp+o8Lj9u6wLXuRIUra3su2+I4OnmoNI7XPKmk3AtXSFY89W
         VfL7KtarhonEUwHoRSBjRFxcMoky9K8tNyvZwEYw/CvDSqSL3Qa3465fsk4qSbVRhy9F
         TevA==
X-Gm-Message-State: AOJu0Yxbm0kRaeBp23noCdmSO5t8MjscadbdE9Q7FCyzQvDTtwa30/AG
	S0D8lakLkaHsKhPZjewNuILOwLwUbozyBVvq065pqtGt3J1a9aPm59LcKr2tm1nM2+KahtlGp0E
	Ck2ME0mB3pJBKjNc3moEPdDuUpb/4zP0x7mHemRzp5qfNZLr+tbNwgZfDLQTQrfHPSFy4odfL9g
	==
X-Gm-Gg: AfdE7cnpN0OGCT4tglmVXc2EsfSfczyj2zFV17HgkF/PkRQUDKtv7Mm+SekYa3cEJpd
	Eo4JPGQ3mg5OaKffc9QkNvDbbh5rWl9p9q2Pk5rxdA9MJz6M8Fief4CzvMaauHmNZkSVMRPQisi
	yt0pTLVJfKwa+S76JRORQlJJeSzlcHNMU6YMSa6nnytmBnNwx/9T1mLDoU6vaF4j6QH6fUcqSXK
	JD26zUNp1hSLlCu0VFYz9ljYBjs9gZwfshWXA8PpJ4n54BqQMZYZ9wPQqAwOuAIO9xRGB1sa7mh
	7Gjx85Kd/8JrSiRanvcaV372FFRpam+PqVje8aO71ni9ZZ2b131IJf3Fo287VM4+6wdCMWGcuBn
	d6enn90UWcdDaZg0Daj+IgA/KCPIg/h7IcaPgxNJ7+W0q
X-Received: by 2002:a17:907:d301:b0:c12:c936:86f6 with SMTP id a640c23a62f3a-c15a676c68amr249381666b.12.1783416131720;
        Tue, 07 Jul 2026 02:22:11 -0700 (PDT)
X-Received: by 2002:a17:907:d301:b0:c12:c936:86f6 with SMTP id a640c23a62f3a-c15a676c68amr249379466b.12.1783416131209;
        Tue, 07 Jul 2026 02:22:11 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9bca46sm91755466b.40.2026.07.07.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:22:10 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: marco.crivellari@suse.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: Change system_unbound_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 09:22:09 +0000
Message-Id: <20260707092209.2184748-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706160450.370729-1-marco.crivellari@suse.com>
References: <20260706160450.370729-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marco,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

