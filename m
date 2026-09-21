Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C113486BA7
	for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012829; cv=none; b=KXIzyO2KGUP7wOxdBp7vzltMuFcfYWSxpcIJjR9iDIRHhdiTVTzsmwh3imqehoR2nQnzu2h5BSBxeJ/U0ZdrEdEOzqyM0p3k5C1AoU+lxon0Qa99loDvSNGrJ5EW5QR1NrCRd/LRvtg/BrlmltCxpPl/MrqiFNopHdM8L7dh0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012829; c=relaxed/simple;
	bh=4yNG3iZtxi2TxOu3a4b+oXSXgcIQWwYQHrMOJotx1EA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gF7mKU3BJwODYH/ZuFmJxv1vrRQKwv7YQVToZPb1FLn+0d8p68fjOyjzj5OBW+lP/SMniTEUcWSYfzbEqsi8OQns+UmmBsVNd6G0XPgLLgkupsbIvCYq/veKAXjMNLumfS4batZ7Qq7e02QlKe+YawVYB37JS8ISxe+13OMdyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVcg7THM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kKYsr0f/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVcg7THM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kKYsr0f/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790012827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
	b=IVcg7THMUJL6+IWSq7D8Vv4LMVqH47Lpidnr72UIEGJ2ognJgW7LbfdqzBNCYGcyCnQQXh
	dY3NX/anPbGqnivN6UgoorXG1gc+uSLJeKlC5ZysQITam+n0zf0ratsQp8czysZ6OvJZB/
	dc3hzJGus+HTbequbLC/dNqmyNhHM94=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Po1LdkyHNwGWdeV0aYFbDg-1; Mon, 21 Sep 2026 13:47:05 -0400
X-MC-Unique: Po1LdkyHNwGWdeV0aYFbDg-1
X-Mimecast-MFC-AGG-ID: Po1LdkyHNwGWdeV0aYFbDg_1790012824
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c294ae16988so416764066b.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2026 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790012824; x=1790617624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
        b=kKYsr0f/rgol5+myG1qVwUlWVg1qIjG9oZ+T1JU0+3biji2P8xeVc6ijNzXFxtiLy5
         XcdFGftpM2f5CZLUDGNiPDMiHqdpr2V0mZunj6cB+5VK8aXWFqofzFr6U6sOFgRQX9x4
         rGi/e+GJB0xRqWalKmjORBUCrU8JLStv/MLiTU3Ar6UxRPpCOVia/dwMSZvNdRzTdMPw
         2TLd6FzQLuxmLtvpKL0S58+IJfVvg8jaLDGKt9LgoNVUYAMnt5DbhbIbc1cmmzynu9KX
         gC77i6cjkMttNENXwQm7PnIzOTNfyEkWZroGecSbCwaQc/9P5rPXFQC1TfWKwOwXcgIr
         tnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012824; x=1790617624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
        b=bjCYvooLFRSrY8qRHF65ah5weXIBOTiiIK6uqwOHlUeqUUArql0QCWRCny25I0RiO2
         We8//LNSuq/pI4yLpgAY286TCL0uc4lf1I9mQGPNGyGg8Kk82h1PLHfkOjdlugMNHYAO
         7Tq3VJXw1VIO5lr/cqdQDaYaJIxhpw2OmMpJkTknTnjlzXUu7gDSKlRVM5ObdelcmF6q
         jaRS4GTy3wO4hQ2d5dVp74s0JdT0crOaSI6vLf6jOp5wu9IbpkDHUtne8myzV4C6rhGj
         FP3H50QXl+QZYMM3t8iIpXijl981/NJ6W7bO+JxNGScMNCRsCQWVTWYSdaQ+O/uK0zLa
         4Hlg==
X-Forwarded-Encrypted: i=1; AKwUvBw1xmGNk6w/hTE4Smh79j1Slhv4Kr8MuybMlLUHBYlFZgAZW1+znzCjsxhhcECIgmnJ+hCUe2HK/iTA@vger.kernel.org
X-Gm-Message-State: AFuF++lmlcC1MB45bKo14Pl9mUG4pEfPuqwqwZkhXKH936TRkpV0y+9Q
	fi+PmkFgVBafnpT6qmSo1bZ3fKCVQ4rb04VeYPoIKusoDlahXMbdqgDLqKfTAH8lp7j8bdDLy1C
	IRhBuuwSWalMUCDwkDRHb+9kVyQdWN3KsFCORliNScTLlTSmD+3Jtd2kAzRxC87A=
X-Gm-Gg: AYBFou078cFaL0+lt0aFv4qRxpGdpnM764tXodQm6OOA9fPl5D8KKbUwXV03IgsFCea
	VuSM3JFpl35Gft7yylqsU5nKJ0f7RzI9ml2lsvZQAEYlhKuFHzI910LZyIelDzP1RdX76wbe9hG
	qD95VHddWo+lHJ4CT0TgpyKjvAEI2GOmGKsEpSySEoWwM3xNbdWfadMJgXESblkG+Ev6E4QpPpy
	NEy0JldyMqOtWwAKNhxl5WRVarODxPAPd2nq2EEGBMO5/C/H4u7TtGHYN7gLM52HEI3qJY9q+MN
	BOmi8B3fZXg8Ia11iLDTIQpcQioCJIiH4/P8gDHm19Gf9+/QvlAa8AgA1ZfNR9BhdynjcJuZ1MV
	13JNg79YYStsEQc0uAo0CpHZYoRat+C4BEKDDAcjIZVy9D+JCMS76uXXdUAuPvoVDrIXWKPvs1l
	IQzHG9MsoITeuLyw==
X-Received: by 2002:a17:907:7286:b0:c25:c954:faf2 with SMTP id a640c23a62f3a-c2a159ae00cmr975744966b.21.1790012824367;
        Mon, 21 Sep 2026 10:47:04 -0700 (PDT)
X-Received: by 2002:a17:907:7286:b0:c25:c954:faf2 with SMTP id a640c23a62f3a-c2a159ae00cmr975743066b.21.1790012824019;
        Mon, 21 Sep 2026 10:47:04 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358868e1sm332724366b.47.2026.09.21.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:47:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] ceph: add 'lazyio' mount option to kclient
Date: Mon, 21 Sep 2026 17:47:02 +0000
Message-Id: <20260921174702.676415-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902-lazyio-v7-0-18c2afa06352@clyso.com>
References: <20260902-lazyio-v7-0-18c2afa06352@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the series.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

