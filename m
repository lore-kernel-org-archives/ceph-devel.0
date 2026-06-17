Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AB3F88B8
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708401; cv=none; b=V3oJfgxvqAQ2OygqSgrjR0BGYSKojaW86/M5YfdDVVkeKgLK+h4Jj4OMntFm49e/1qO4qTsSOcU615SKK2S98IcUM7JvTUp4Vy/2Oh7HY0CDInqLV/8GAIjS6hFLZfZ+LeQnpDqndO+qlltG6Xdd/02KEUWf0DQdklrhwRrSOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708401; c=relaxed/simple;
	bh=FUiD5hzkPqhzYMDBxXJu0LT6b+MrPQAihBJoheKzhSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZkmsOpkiXe37EL3K9Ejf/oMz/FJH0CxhLdfCp+HGNuNLoelXukda+WlYuPveMu/oAE4dvJ3BLCGPuWjD7xYo9/uhUcbsGLbutNv3azkU4osMk7LfOSTVWOlg2msM3yRknG0jRqHQX7eYAmGylkEIiHmA4cwBjWCHGiwLxDZ9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaRw2vaY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0a1et32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaRw2vaY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0a1et32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5V0jleFbufQ68ThWzzi9dmDDWhHvsxDqL5WKzBFJds=;
	b=UaRw2vaYSG6E+z4QkLnhtkzm8MlhoZ0vGQCAxuUmQxZB4Vp2VXTGkCBbI5r0OY/bFlAig+
	glQ9Mqi/b5rkjG8xyJVRMeUSZ+hl5NU7ygdyQmEYB0NqhHP9jShLqbrIImAFL4SwSJg+lO
	2Z3UCjVnG3/77aPFpzDmTDJZ9XsfDck=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ovjO-FVVPMSVlTuKSygMjA-1; Wed, 17 Jun 2026 10:59:57 -0400
X-MC-Unique: ovjO-FVVPMSVlTuKSygMjA-1
X-Mimecast-MFC-AGG-ID: ovjO-FVVPMSVlTuKSygMjA_1781708397
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-486055c1c6fso6210679b6e.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708397; x=1782313197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5V0jleFbufQ68ThWzzi9dmDDWhHvsxDqL5WKzBFJds=;
        b=A0a1et32k8N9vI6i3uA23lUFoUdASGdUay5Pby8veYhkMHE1HlmJ7xXh8HS5x+jA6P
         YalLFlZnearaBOc8kEOtABy86tKJ6mewSJaFPWWtgCKNsbnsRI40jp/SfZF94lkvtuga
         pnJjoT2Sk3N4+fZ4bU4wdkQzGH3MaC6jXZzIa+dm6vwkBZOF6N4rsQ3X/dyxxc1UxTGF
         bOWeja7J2gmRUz3s/ZueXIaFjFUXCyyMgtXtuFIalA6fWq8wzG+8eN6iXJCuZ4jEnE1r
         ZHTn+vtPdl5uXsyYE+Wz/kuPlBmrFBHsTqNHj7CnD1Pz3KNkEZFSChwuI+GIuZpoSvTb
         mUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708397; x=1782313197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5V0jleFbufQ68ThWzzi9dmDDWhHvsxDqL5WKzBFJds=;
        b=nmPkb+oCZIwptq0aflj/nAY9V/l9AxFzY/7uZrW9vseZH1JYXGzIAP5bMwn9vExryN
         81MbvysMADA6k+cPVgoMgpGXP8MO5OpSeN4CbJdTlw4G0Q3mgdhVdWY9e3+614JWVAa7
         Pgdijr9AI6OkcproxyGMgAOtVhaBNUCilLSBIHJp/EHaprjDEndR9ghQF+kkqh4HqACb
         RVfgtxXd1FVIg8bwPEkmuAXUdRKf4TECpxJ49ExFHhjJQFiHErdVyc8mAmU/T/MwZ5c1
         sUMBeQVE7wVuj2ymY6lNcgtNUyehI0GAwxfQo6sYhz0h9NtHrdoyf2XuexttnwDWT8bq
         xuFw==
X-Gm-Message-State: AOJu0Yy9Z9tCN2pBIkNzowcQV+KhVEAx+dS/LGYEI6dL68T9Liok9Suf
	Y80NTLMmF4LOB2yLLlZQ34qahicZbF7PmNpwXgKaIbRqooEK5y/QUHNBrSovrBgHwoxG3K5nRCm
	uIgf0rGS9q/GZR3WhzaHvNvngwhEfafCct37nszgCq/wFjGPAs26PASvA68DfFdWdWf6r0DgZKw
	M4EuniYLXRLUtGKXM1X8QTUPtSl8pmsyOHSIn9SRuqigG55Z73TQ==
X-Gm-Gg: Acq92OEeR0sZ9Upz4AXM453+tmR8bMPg+lyLMxoJV+ozEBS5NtJB2nzcsdV5X0ejDC+
	2c435inY1IIo1oQtfLaomRICix9Qc+2UPxtSY8AAp2ipI5VkwwI+iuPLTDF5TIS/iubgHIdraui
	ZamY1Zsr+9tBhImYUyFxvz3VnxQLBV5W9XQz0P0B+VWrd7swrEJ4UrieNsxPF4B9MLBJa8/T9Za
	Shjsvf0Wuq94A9LD6FVaOWLYGu/P+50bdohfvyGxTlWNzIwRrv/yhPqMw+gjTYt+F6Eja1QLJDI
	IzNQSxgY/+ekKsSoVhw+kFWTSqbfO6Q4FWdIDGrXVMOgvhCJnYOB159E/6ECaFbZC5OMmGEMBwj
	OMlpS3aqPoC0vHksFrWA49mE8f3Bn8KKax2V/0cMpH6P8
X-Received: by 2002:a05:6809:25a:20b0:487:65af:8946 with SMTP id 5614622812f47-489444e4124mr2215685b6e.16.1781708397159;
        Wed, 17 Jun 2026 07:59:57 -0700 (PDT)
X-Received: by 2002:a05:6809:25a:20b0:487:65af:8946 with SMTP id 5614622812f47-489444e4124mr2215662b6e.16.1781708396675;
        Wed, 17 Jun 2026 07:59:56 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:59:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 01/15] ceph: add BLOG public headers
Date: Wed, 17 Jun 2026 14:59:31 +0000
Message-Id: <20260617145945.1912736-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the public header files for the binary logging (BLOG) subsystem:

  blog.h          - core types: blog_logger, blog_log_entry,
                    blog_tls_ctx, blog_source_info, blog_log_iter,
                    blog_source_id_cache; core API prototypes
  blog_ser.h      - type-safe serialization macros (blog_ser,
                    blog_cnt) with compile-time type dispatch
  blog_des.h      - deserialization prototypes
  blog_batch.h    - per-CPU magazine batch allocator types
  blog_pagefrag.h - page-fragment allocator types
  blog_module.h   - per-module context types (blog_task_entry,
                    blog_module_context) and the __BLOG_LOG_CTX
                    macro that drives the per-callsite fast path

All headers live under include/linux/ceph/ since BLOG is consumed
exclusively by the CephFS client.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/blog.h          | 0
 include/linux/ceph/blog_batch.h    | 0
 include/linux/ceph/blog_des.h      | 0
 include/linux/ceph/blog_module.h   | 0
 include/linux/ceph/blog_pagefrag.h | 0
 include/linux/ceph/blog_ser.h      | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/ceph/blog.h
 create mode 100644 include/linux/ceph/blog_batch.h
 create mode 100644 include/linux/ceph/blog_des.h
 create mode 100644 include/linux/ceph/blog_module.h
 create mode 100644 include/linux/ceph/blog_pagefrag.h
 create mode 100644 include/linux/ceph/blog_ser.h

diff --git a/include/linux/ceph/blog.h b/include/linux/ceph/blog.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/ceph/blog_batch.h b/include/linux/ceph/blog_batch.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/ceph/blog_des.h b/include/linux/ceph/blog_des.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/ceph/blog_module.h b/include/linux/ceph/blog_module.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/ceph/blog_pagefrag.h b/include/linux/ceph/blog_pagefrag.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/ceph/blog_ser.h b/include/linux/ceph/blog_ser.h
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

