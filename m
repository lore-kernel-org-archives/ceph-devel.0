Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB03EFFC5
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649814; cv=none; b=BksvUHqmUm0Fdcy/FYzragte7RlelRK1vkqU0vNUany6zcdcxAUOroGkOfXQUMMaM79oEmn8zMNx4ME+pamGBDRmpKo0EVwLWsO9qBrU7hME4OzM+xazVBvR82FnB5JUdtM5MyZuIgUQDo4C1rISpKWd+Lod17IlWSC40XyWNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649814; c=relaxed/simple;
	bh=2vCa4OWaCxs+EPAwn3Fk12/TtCk2qFnRbN4NZBCJLqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZWAiB6dX5en/sLr5gqMVuHnuz90iuo1ynlEJOEtFQ4cosjE8DjF6GmebISDckiqQFA5IE2B5xvER5qZS48KLOjeuKlwQjrSOmblcDQUn38njzZFhrFTlIHy1lBdZweIWw6DAmM8fkHZ6rkNH5AtMT5AKXcViT67SM1J4q2oY4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSY/4XV+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAdtJP12; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSY/4XV+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAdtJP12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787649810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RK0+xnt7HSnjTdxTCQe8vmw6hrFSmhIbspuPg3DKPMc=;
	b=fSY/4XV+zzNCVtTusEnCy4niWSPhop2fEr777h6560cwe7I/3x0XpjT43xqXIW01zCxTwJ
	VYRGzL2/fU5snMgTmZIJfStTyvnxiEYtL1DGm5MuUWhHpQ3ujNSf+8WgQAJ/XzhnTtE7OZ
	0k1FQXySDw9q3op1kfWBx2QKUYs3x8U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-sYt35L4NORSYhrgz3MoiMA-1; Tue, 25 Aug 2026 05:23:29 -0400
X-MC-Unique: sYt35L4NORSYhrgz3MoiMA-1
X-Mimecast-MFC-AGG-ID: sYt35L4NORSYhrgz3MoiMA_1787649808
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15dfd34e4cso296555566b.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787649808; x=1788254608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RK0+xnt7HSnjTdxTCQe8vmw6hrFSmhIbspuPg3DKPMc=;
        b=JAdtJP12vrPDXseQOFHUlS8b2Fixty79cyYdWCRMjYTo8qT6LyRNUdGt8Cf3yvnkMt
         BbPswJHcQqkz2rj5R7tIFJdxjQun3whNRd0XkG/ofgXb7hBjGCqHMauHX7LIpAhptMAA
         4FaEk1jubo1Dxu++kfYNIGfw9MfylkgEVennnOaRVKuJTmHOnGJw2wzUWdhJSeGMfiwH
         jFZL9SwKjz5DKCSiCOfZdB/o+4LO3nQ6jTCGR1uMK6foXU7WJl53TWGAAhfQ2UB8fyXl
         V4qVsvLP9jGI4p1tkPeLcTkbbKIluAeirPtb4xQqwBwasKaVFIecQDberxbWZHMWqYl9
         6MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649808; x=1788254608;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RK0+xnt7HSnjTdxTCQe8vmw6hrFSmhIbspuPg3DKPMc=;
        b=kXgics1PydtyvK1D13l/6j8Gdr6j6HpINHvvjiT2rvzwHBAuz8BhjJgoqki8xxw+N6
         dJ4NeK95NGHQ2DovuyJBcwBirxCRIwUn2dhYGzbRUbyBf6dJmEQ58JAYLuisKRHdqoOE
         i9DPi5kiLKbPFabout+QDJP/MZ0LOuIUBLzbheMTezkPLuDe6mN6R86EP5xG7Eu9wK32
         VZWil93LUFTgiPzUAczXmmyuaJvjjekaeC8MUXEUTRxj8gJlfxiDhLZuoXnTGddSTi6d
         kOZ9qSI9VFPCsxMc+r0MGVu+7emtF94f3bW6tRjmXWUDji6qO5dmimMfAAMstB2Vs7Ag
         IkGA==
X-Forwarded-Encrypted: i=1; AHgh+RqBbVzsmXXL3kEF04jUaoFgof7z2hifcYg73oLKy9sudR+qwv7qnS0Li32NwcVun1Ji8kZLq7sg0wQA@vger.kernel.org
X-Gm-Message-State: AFuF++kWDt1hVvcZXRt/rXb5btEJv3uu6mU5RXjceXYsDq1myK0XT81R
	L7066PGLqfZCe1cvkhpDNpueO17J1Dcj/qcV96h+WKiFgL3U9L6lg6ox3VTanf4/VFRBh8/Hae8
	DMZKxi7ilrD0V7gCXfF6Y1WGRHo+QCkEwGADwwrzKD7eViS1YHqSnE2NzJ8CKn4g=
X-Gm-Gg: AR+sD13dPt9RsLosr7AkHRKtM1ZZ3S+EPZDtR2QTMuO4qNRK/+VEx0fBgaOxfdIaFLK
	S5J4I4QqiCJs3H3MCMUwsm9PNpnRYb14GrrEjR1T5er31TFn/VS9BXD2WPvXfVXFxIc62/ogtUU
	HIZpN3V54VUQXnErFNHzgnhNOIwOFQ9tSOiHHURE4r/LpujZTi7RiFOSq73haKxDbhBfCKEJmpD
	J4ZIqsJm2lFTZI0S7NVf5LHq2jjsHkCbG2LVOuSXPU6aWjWIff6d91tho+V2J5ukFQCIYLQPLT9
	TCwnxzj+GrLwb2c6A34UoG+tiuuzr+2GbuxPfIOELXh6J2TfLfUyUmytR56JTsRg3EMMq1akI5K
	8/x3n0Ptqf73GoiSXbZuUqPIzECcIsGvRUQ==
X-Received: by 2002:a17:907:3d4e:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c246a4ad6abmr3801348166b.3.1787649807882;
        Tue, 25 Aug 2026 02:23:27 -0700 (PDT)
X-Received: by 2002:a17:907:3d4e:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c246a4ad6abmr3801340566b.3.1787649807413;
        Tue, 25 Aug 2026 02:23:27 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e8bsm1619137166b.44.2026.08.25.02.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:23:26 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph: reject export_targets ranks >= CEPH_MAX_MDS in mdsmap decode
Date: Tue, 25 Aug 2026 09:23:25 +0000
Message-Id: <20260825092325.2605644-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch was sent to me privately. Thanks Jeremy. Posting it to the list.

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

MDSMap export_targets entries are monitor controlled. check_new_map() uses
each entry as a bit number in a fixed stack bitmap, so a rank outside the
protocol namespace can make set_bit() write past the end of the array.

Reject ranks outside CEPH_MAX_MDS while decoding the map. Do not validate
against possible_max_rank here because maps may legitimately reference ranks
beyond a temporarily reduced max_mds.

Fixes: d517b3983dd3 ("ceph: reconnect to the export targets on new mdsmaps")
Cc: stable@vger.kernel.org
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mdsmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 4f0626753429..53079ef34c3a 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -269,6 +269,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 				goto nomem;
 			for (j = 0; j < num_export_targets; j++) {
 				target = ceph_decode_32(&pexport_targets);
+				if (target >= CEPH_MAX_MDS) {
+					err = -EIO;
+					goto corrupt;
+				}
 				info->export_targets[j] = target;
 			}
 		} else {
-- 
2.34.1

