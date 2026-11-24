Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527003;
	b=Wbj56kJNs7Yir3XFhMDBslNp1lMBQVINSbFqtgf252D+pvUtWMGxO4bUYjNdd2hMTqio
	 XqbuSiCVMY8Kk6O+8z1dJeXInsVLB6vqW8VIaJjyyn+0kx6X6tFhcnDalhbsiHsxxpQJ/
	 m8QolOa+WSDWmdBEfGq6j2KaWonrrP8jOM3wPFkeZT1C5om/LHoUMVQ2aE0a4NB/DvRZB
	 SAF44sBYKyUZ+ZGLYu9aFH5LY8UHZNdHxCyBVTTqdMLmezp7e/7499GgQzHBOlxVpfBjA
	 aifrV+tc0L4qDNerhHCC1e4IkqLXVZfHyZbBKO2ZBy4VZgV7IfnlbzgvZa2/WKSN3kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527003;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
	b=3MLGBpcCqW16w9icGjiQbbCLuryBpF6yJS8R5YxKBpqkk2Li6obIgdBdZZI9EQsSR9Ok
	 pnSrWOgE1V5iLzJ51OfZSQXA4F33PqOG76ThH4IbmeTT+n7KxtzXuUdMUfphFYnmtHSGx
	 0PxyZj0+e24gu5fZdUEcHdZH38u6TLRiIumZ0nqg2K1ddD3BItCQk/wGRv9HnS63Q//JD
	 vSgaIxVswZ88sp+sxC1m0SPMKBDdCLiaEGzR/HxCBF3CP0M3KWAZJW7gddQEuGNZAdaNc
	 rxOLyqbIWUyw5GQUxuLrsBDqmyQ24EEupXlx3MYeALH9xnzD87bDC8GkOcktbgF1EXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3nV9I3s;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NIDesLzg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E0606A32A
	for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 13:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 729E0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3nV9I3s;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NIDesLzg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795527001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
	b=C3nV9I3sP/Dl90g/bvwsEmbH9CgoBjZ6XgVpt5n2Fd3qkih0uhhArOUHIppnqSSvU8tvfq
	qRmE+b7f1+DNhJeHwhRzrt3Yt+ubHBIAaEEV/vl+HXDkIGqJQ+8DXPiuvTqiQ7ce9UhVR1
	Ivsblio+a9uXelAP9c3Iioq8WVkOBrM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-9BWDn6mKMBSj26RAJ-P3zw-1; Tue, 24 Nov 2026 13:29:56 +0000
X-MC-Unique: 9BWDn6mKMBSj26RAJ-P3zw-1
X-Mimecast-MFC-AGG-ID: 9BWDn6mKMBSj26RAJ-P3zw_1795526996
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so791444185a.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795526996; x=1796131796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
        b=NIDesLzgePeW1RI0l9jKnJHf2IhnwUfrUG2lBF5y+GZLhZ8Z3Ie7UpBf6SP23F4iYV
         x2qvOckOntfNSX1HuCJ0VQoFYumN6u7TV8xuc40J42HiLZk/fq1i9FTtDmjBd2oau2LY
         PGHK8eItVm68NPPY+LdgsqeEgv2Sb4wQ7am7tALLiq3Bfjsg72hnAkEsD7NvRKDAGQa9
         A6WVvroMc+D7Tjo741ZXl4KdViQW8l3aAOD2YfJlq7hT1RbgByrpYDzs9hi0tUD7AJnO
         OqN4vluVGic+u3umCBsMQ2KT+1vD3Wgpd1xXw43e9B0EFg85cQ0i1uewBw4wW2w9EvFB
         tceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526996; x=1796131796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
        b=o4JELULpivNZe+c3RJmC8hgUk8Tvj5pu1N2/HL7dGRsL+QxpIYgXKkmXFIDeExEiM+
         tD4GXPVKbSjZM3Ltm6BNHy8uEjjm4zc2QGpdYP6Z3/NrEpvO4RsGyJpFjRsdhQz97EyX
         6uQsa9i2xvZuXyuecr+b4FQF7CZum3JcevjDWJwfT3kXQXG4TYEyCZnqR/lPJp4lI1JM
         pD65q37k6LIFmUGcmb70tyBPHewoU8HEGbF9JBnkGLl98aCNS8kAbovsIwsoB0vZvymZ
         TZc+klIpLlCb35sfSiKPv70Zg0+fnZctjD2U272VvRzjswCqrc1e/iqcNTHthBKsPMHo
         ewkQ==
X-Forwarded-Encrypted: i=1; AL+hErH8fJOhM8NPk3o3ver4/U4mRbMJI7khbENw30fen18WrmtHtp33WKE5mEGl97e1Pl+Egp9n+3SVf/e4@vger.kernel.org
X-Gm-Message-State: APuU4Z8F2WUVaN7oiTtNnCXrFFKVaQiuLp1HLz5sBvsteXUTTcEH8M5L
	f3IY39ZY/E3animhG2QTZ7IQqajlFrHjEq5S21QVxdk0uekEtMzbi1wB5U2xd67GXJDYZ0pxJwo
	lgACnwKt3eht833lT1Ug274oxQaJNEXbS3ZLeSuRhy1sT0hvZgy5Mq38Y6AL1le0=
X-Gm-Gg: AZFdTZcLXImje52aq1XPrKuTzVnDRt+Da7rWQSmXYd8o9ydEU0H3hdSYhD5FdL70jM2
	j002lHY4sWZGO4iFIFwYWaU703Qej0DYFodMvDcAMMWuVWLslmxO5gnDlqSxtv35uBkXEg3uhpt
	Y25Hm1ZQ6CMkGIz8IqagO3c7o7kLm0DaAX2tFpLoaJVb1lOQ79TR3L5CNGCbk6E2rSeEDhjQXgb
	9AAtO9NYxj9VMZlYiGcTMihukvlqO0ULBifiHeqD2RwKBWUZ6c02//SFMgEC+x0tQdFd6miV6Oc
	vigu1sgQMktTQfesfj0Mf9Om8rl7ElFyBR/d0nCRQSAAsmdkLuTBwHoZ0nEIdfJmVHm23Wys0fk
	yh/6Z+l5tqmmEmuDse0W2GsZueVX6IHkBiHdUhxLZh7T9RA9xV33X2O/9P8eBCSui2JM6Q0lYpA
	SkhPpVa1Yn5Ucs4k+S/amvdnSk2y4bwy263WJ0dhYtBrdgjojsw6syTcjATJDRE3/UelrKtw8j3
	adM1xZ5AwMt0cmbv9+9QEKNYLAyZX76MbaP7bX9ARkvFlLmW55D
X-Received: by 2002:a05:620a:4004:b0:949:7920:9d06 with SMTP id af79cd13be357-949bab0e640mr2535561585a.68.1795526995978;
        Tue, 24 Nov 2026 05:29:55 -0800 (PST)
X-Received: by 2002:a05:620a:4004:b0:949:7920:9d06 with SMTP id af79cd13be357-949bab0e640mr2535555885a.68.1795526995359;
        Tue, 24 Nov 2026 05:29:55 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f1ee7sm1033930385a.28.2026.11.24.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:29:55 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Daolong Zhang <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: fix inode and i_filelock_ref leak on file lock rollback
Date: Tue, 24 Nov 2026 13:29:52 +0000
Message-Id: <20261124132952.2186886-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1795396934.6B039543.003.4jXp835gJkz40Rf@fangwg01>
References: <20261122193828.1324376-1-amarkuze@redhat.com> <1795396934.6B039543.003.4jXp835gJkz40Rf@fangwg01>
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

Hi Daolong,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

