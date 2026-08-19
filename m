Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CD44B690
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135122; cv=none; b=CVz156/lD6JrDsWy4/YMfwfYQOosGluTzre9GgggU4SIgLyuX2Ql6kBVc2ynfNiQXaieAw85IQKxqNmjv/n9dVrRxp/jMUgx9hP04vPbR7qPdJtkU8RcMYSOwZU+EFaOiknTR17uph58D9L90/5CiTtD86MfmtSV8GKUmuvJfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135122; c=relaxed/simple;
	bh=ol9vHi80gGi4Xc0uImw2n0r2jJVqIY0TTCVXHqjfOXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMb3jvK85CcDp++7ktOjlFiGrz3gDikoSPplAQDnCVVJGVaWwnJNw8jSXnqZf2skMsLCDcV+BuXPlPBwFw5kB8jCqx8EXXnWjgDUa4JzJ8iVObv8uL9N7KzAB95kV8eJrW3IqpJlCYD0YJw5fx+y40Yct/PP1maJlboC4ekGTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEJBJN8S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sXs33xCZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEJBJN8S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sXs33xCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787135120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ol9vHi80gGi4Xc0uImw2n0r2jJVqIY0TTCVXHqjfOXk=;
	b=AEJBJN8SY0bP664Bez2/iSt/1PiAfJfLL+UCtd9rTvbezMMc2bExuOqTF/hLCG7Uc6+8YN
	i3zd3ubThhR9u4v3x4vdRLbDrDWBJhtRwVqo7RYnxjuaozBcw0JDaLsNtiIIwKnSqim9BC
	yznqIwgJINRQE+fwyFq70ihEndpI758=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-7RLrrVwZN_W_eD_TJxcZqA-1; Wed, 19 Aug 2026 06:25:18 -0400
X-MC-Unique: 7RLrrVwZN_W_eD_TJxcZqA-1
X-Mimecast-MFC-AGG-ID: 7RLrrVwZN_W_eD_TJxcZqA_1787135117
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15f0aea084so56272366b.0
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787135117; x=1787739917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ol9vHi80gGi4Xc0uImw2n0r2jJVqIY0TTCVXHqjfOXk=;
        b=sXs33xCZ9ZUJ7xbiUnxs7RAti3djN4OP5dF+hRuHboiZxX93pvN4qkanaTkcH27ksr
         tIzuB4sGpVGx4fZTya4t0b7g1PD2t1gcupj2K4GsjKh5HUMu5IXKFm6F4tdGHFaOs+yA
         C2ztoGPIhIhAw1WH442r2yQsgAgKE+KY88cxl79uAgVRL54jl5uHKaAG8YWNcCMUBupB
         uJfsuwvmNut993QwgIB+/QA6st3ClUE0NOE6JSbnD05Bp/WUiUvADCmTJG1qQngEtHIw
         GW6LP1ffmH8grsl+TSbc+n6mc6SK/Dw2qfJg0dpbRYMpvYyfgxGjxkfP8VLzinC2GeIT
         2FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135117; x=1787739917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ol9vHi80gGi4Xc0uImw2n0r2jJVqIY0TTCVXHqjfOXk=;
        b=Vj9XL3jQcQxILz8ztawgJjZFXhfw8VbiWUNIg/+ZygLXJ2aNDZlzWPaOoWjwQfeb/g
         kBp1+fW2e+B3YQCq5RC8SQa7D8vn3FcBXkYXwrBLmAxmAS/27li9ozyCu/CMNFAf6GCB
         91kOZo7E9dolemvIPRJeqnMxSFaiCI2QIF5XLmya4pxnnm7/o5bR+vyjpD2p2uRnZTM4
         HYy0JHBScILo85OO9e9rgcPRlk4qpWwKJvvSxLOImocMz8UoGwKEuLTt5y60NiABUg6z
         8UTaOcAac/PiX9/c+IL884ymR6vLfty4r6YJVtT3s9APItOc11aQznfQD+iAZPzUj/yE
         5U4w==
X-Forwarded-Encrypted: i=1; AHgh+RpOLurVpRsBH4isJeOvNNjtaksYwJ3KLYYMLoUBu9Kod4V6velZy0TYmCOFi+UrQermKys5ja9uwMDq@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4+kVf+oakukCT3sOP+KW+Fk/2SCMnN2Y5r4M4qhxvNK83csu
	ZNVrle6x+SQwGJaq6uuD8SgGTglvs1kmB2/yvMkjNAL5ZZQxgzewyb7XHV3dR7pT+6q/H+Q9hT/
	Z/o0n1YoQYvbVXVLg5mNiHW6BvJasKWDvdz5/zvMxEsifRZnSDY76VjaD7HhC6gM=
X-Gm-Gg: AR+sD12nV+H/1xl6M/n6XY9PWxe7J1cE3oWlACwiI3lwSLOjny80Zv6CN7P5EgcypP8
	5xOYRl66cqOQkyQUPAS2Jd3r4LTt9BgzLuXuPvcSdVpTocFbKHoHa/UgIV5owWlKj1Lm453kAfT
	ZkM1i3qNfIKWGVHtqbZbtjU0VVUELgyXpUjqtDNDSjV7HBxHqb/wn9GUCdbUA2dXcMjLvbogL1i
	h2di7R/KeVRBZpatKOWp4ZbrHAgUfvH+Te72uMtAKfXdR/DxbrpLxL947ha9bL8nJWbv2dmvFL2
	PKTwWR2Ql2hYM3dnpx7Erss+0YdU0n76Lk96V6GKL65th/OJkSq1x2t7aFLjELGIrLSctVlpdGH
	ZZ2q4uy869e0KOUS2op87uxk1PrIaaAgSYQ==
X-Received: by 2002:a17:907:9348:b0:c1f:1520:4de5 with SMTP id a640c23a62f3a-c23e81ef9b1mr227217066b.1.1787135117405;
        Wed, 19 Aug 2026 03:25:17 -0700 (PDT)
X-Received: by 2002:a17:907:9348:b0:c1f:1520:4de5 with SMTP id a640c23a62f3a-c23e81ef9b1mr227214366b.1.1787135117031;
        Wed, 19 Aug 2026 03:25:17 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c38c5dcsm55157566b.44.2026.08.19.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:25:15 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: tz2294@columbia.edu
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2] libceph: remove ceph_put_page_vector()
Date: Wed, 19 Aug 2026 10:25:13 +0000
Message-Id: <20260819102513.1284434-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <<20260817-ceph-put-page-vector-v2-1-477dce5372dc@columbia.edu>>
References: <<20260817-ceph-put-page-vector-v2-1-477dce5372dc@columbia.edu>>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tal,

Looks good. Thanks for also picking up the leak fix on the EIO path.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

