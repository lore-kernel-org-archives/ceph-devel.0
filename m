Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858113C1D6C
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466399; cv=none; b=ageJGqvdKwCLmM5F3k1rvHFXTFWphSCj22y2e5Ym8aBRPUdgaMQHcsFJ31wOO3NonPo4hQ6TOifFt7Ql8P2oIadH07m/0nM3mOyIUeQC37K4SRNF5UsLR//jExVWq7RUV4gtpkKYSocWDzpHgMC6zLtLJmGtLRJf2HgiOFZeCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466399; c=relaxed/simple;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNBF9Gyo7OuNfc9Gon9aYifsLTgt994Vnj6TB+mC0fB3pP/DshhHlUnHczKyWg3wxi3FQ2+3Iv9ULq4IWbciM6LguP45N9y1euVhc8C8a74aXbaiZwWWc1vK6I4USaBuMopfvvLuZmIDZmPXRrhtgoTjnmKHGddWCqqOtK/RObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Srz1z3sX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jg5bJRix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Srz1z3sX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg5bJRix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786466396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	b=Srz1z3sXiDjKSOM73DqaXZKOuZT4lUlId4UQW1cpfiIsiaZm+BTXRRqY49bLUBh0DNIWis
	TYGRtyNa8qn2LGKAN2F0x3ZTSpsynZDjAz2rsOLATu8nEUn4Z33DbUp9toDyxt7GYW2QaQ
	i+pAKbtdL8Xnp9OEtEA92JNf0FwhsA4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-vV2qyIffO4KM-32nqLQZKg-1; Tue, 11 Aug 2026 12:39:50 -0400
X-MC-Unique: vV2qyIffO4KM-32nqLQZKg-1
X-Mimecast-MFC-AGG-ID: vV2qyIffO4KM-32nqLQZKg_1786466389
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b1bc2e44e0so82805b6e.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786466389; x=1787071189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=Jg5bJRixnTM3BnqhxoQQIaONAhMy/MfHWU3WJXRRcIM8SpdBbz7JxI9P68UYcZXxHw
         pL08v2yGa8O7uwbWDFWPMXiclZPPm8/WGIqPupn52R09qWV33yIDyxEUXnW4JRzofg7g
         c0aUSauL5XU5o6cH9GqvGqX42Ji6k5SIjOGBw641Kf62C8z8Q7XhbwuAfeEzNV5uqs7w
         DTI4GVBi6l7ZcDjAosqBJPY9urFGIUE642hONvy2BGtaSHUHFQHVw1N+FIIdcZJwtYM0
         TCqEMuvCVdBV/htQs1dZH1nl4kQg3Sz5neNV1iW90zqu6Y8S+8yBT08Ib7aXo3Y0De5R
         wB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466389; x=1787071189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=iIOOG6+3TlIQNlBmwaipTINnWo5umnaIwi6p8hi8PSL7QUxy3FG4GyCM7UYRPuI6o/
         PvxQlIv8lCACIA5Au23z9mVtzmix8m1L+GprH698HgIgE56AaB9jUOXWl1nXLuhhlbzb
         eGTTxX8/alQe89CEX+aEnHWkQeItjF17Dwkl3Uw8xBjiBGCxUuZI3FMhrFa4f5LbOvBY
         EG8WxhjMcwC88yYfuk+vt4RFtuKC0ulygRr9Mqw7AwvvYDSUTzZfG4ndRqsPKwJb/pY0
         owLRGA/Ep2AX8h8ogK0jFm/JCqgpDjNSN6HiNbjJV/HRND06fcFjZthzuSLtKNBmuXwx
         Rhqg==
X-Forwarded-Encrypted: i=1; AHgh+RpuCGbrCpZWSObZhvBLLmh2z4E3mlHXOXkozoahT1B4H6mv/buDwg2W+6QEUO5tDrDrDy2xXCsyX9L5@vger.kernel.org
X-Gm-Message-State: AOJu0YxC81aufUBLVcMBRCoPQndNP/dsAwd6iFu3QxjAFbFm6fCGPOux
	cgK3oR+Q0ooHB0tEd1HNvRHvXr4egWCxuajCbaFwoA4bKDBB3SHLEPRIwa2zFcV4uEcdbPqD6T/
	mxZ3gTUn1MGexYbvNXcni9hL3EtR/rVydcPVPj1cQPmNPk5zEGTl1cIu0OGq23ir1b0PpFWB4dQ
	==
X-Gm-Gg: AR+sD106B7mPDzhVvnPBXXX0YQ7nlxyahg3KsGzSRAXA4tRyAY/laLTH/Z9qt3YPkQB
	JRCmYRHiI1QytdkTkdu0m6U4w/6zuA07hhFDZ/Usi3vw/fSEWb2qYQ1JB8G3avAB1vSRB6vSz8Z
	R1lJYblau1aXVcsAGZYvz1HEcMfq9igcPu/EuLk/SF8T2vSD9vn6ENvSL3IAbrQqZg3Fzfuuk6p
	gjZ4xOviLRpxMHPFrxxyNaSxMo4coOgo0O7d5/CNJHLIeiFaO8sNryRXUFtBlDG3frz1vvTT4Mt
	rCBjMcp+EYO8RpcF6iUwdLEwMdrSoXK3GkxVzti4p8/EsmXlG5JOivWVFLFmAhjaxh05Dg==
X-Received: by 2002:a05:6808:1a04:b0:48b:5dcb:85ab with SMTP id 5614622812f47-4b209b388a5mr777674b6e.8.1786466389293;
        Tue, 11 Aug 2026 09:39:49 -0700 (PDT)
X-Received: by 2002:a05:6808:1a04:b0:48b:5dcb:85ab with SMTP id 5614622812f47-4b209b388a5mr777641b6e.8.1786466388816;
        Tue, 11 Aug 2026 09:39:48 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b200133f34sm1159081b6e.12.2026.08.11.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:39:48 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fs/ceph/caps: mark cap remove with RB_CLEAR_NODE() instead of ci=NULL
Date: Tue, 11 Aug 2026 16:39:41 +0000
Message-Id: <20260811163941.2760715-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706073812.3922732-3-max.kellermann@ionos.com>
References: <20260706073812.3922732-1-max.kellermann@ionos.com> <20260706073812.3922732-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

