Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D93F0767
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650189; cv=none; b=DRekn6SCizYYUrY6h0uF0DbQLI2oOE5G+Luvoc3l1ginVlWdslOdY+hsEgWTSoV79MuDpsIjopcyg/WRvZ+WKmp9OSlOuAqtZx9wpWMX26kVIOZf7/JGxxYvuE0Szqh2y+WpwHWkMy1hgHC2TNNS2G6W+hqyaxmQPge7a7OxYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650189; c=relaxed/simple;
	bh=hb9INDHGhUPT/WoB0U9k2zL8xFQlPxW/TAPBgVzi9a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ot9kfMwW4f738VNl4BhPZwBKyWRO6cFBdc7sh06Yp84aADDoZMG0z/Ni6pwy9Kh733VjdpA53U+P/nDNb78qxRiOrPfsl0xfnQfVIg7rgtOKLfnVPA6bFgXRnMQom8txyasiEMQlPyV8AEtYcqZCprmUguz/O3rMNHbWFXbM0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsnWsHE+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A551CWFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsnWsHE+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A551CWFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787650186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tg41b16JGPoqpM3yPOQvId0jCuSStoTlxNu1GbBo8cw=;
	b=JsnWsHE+c2NnuQyAKBfC1zRX4mrTn07FusJ/3obOfpAYxksnsdHDPYjpiUGBFzi2fzwQJq
	vj8IOdKyoRawrefIpjfesOkwMBV9nVOwZjoYJia9kjTZUMNU8r0fZk2PCxnw/Us+jMjovw
	iHFZ8kcYedZjyGWYeIazvroGdHd39CI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-yRDFG5bIOVyu3D3JFiYyUg-1; Tue, 25 Aug 2026 05:29:45 -0400
X-MC-Unique: yRDFG5bIOVyu3D3JFiYyUg-1
X-Mimecast-MFC-AGG-ID: yRDFG5bIOVyu3D3JFiYyUg_1787650184
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so5897620a91.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787650184; x=1788254984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tg41b16JGPoqpM3yPOQvId0jCuSStoTlxNu1GbBo8cw=;
        b=A551CWFeLOnB+y2gRoeXffMYyKxULvicfEb/fsZC0uw85mdDTX1drOcKFblX/wUCS+
         QINFQWztJU8HXr77ee7tIl1uXkSyVL7HUwM/IoyyAp+bNTzSEXBN7dfHN4RseRxWg4SW
         RN3x2jfcK0CQjd407yshsNCcbXyBT87Jpekic1SiPUs0/Cq93ToNduLWpEiVYL0tG9Ck
         0d51wBlx4NZgCYhKPUSAH1Y1bBkxAuOQ9u2R6JIRIMucGQdRK0AQ/z7zhGsaIiYVrz3f
         qagr5gWyHM13l0osMhmOSGy+J+wDwPRXOyQmIOgL0kU4q8nIkY4pb5Pk6RQbi9Oljk5a
         /Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650184; x=1788254984;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tg41b16JGPoqpM3yPOQvId0jCuSStoTlxNu1GbBo8cw=;
        b=r5teqdTmyETW4il3feBauJXF62k7i2NHXZtYfBybed5ivFfSiqCk+eMpR0c2yXjKXn
         xyGN4KvPoAytRubfs1J2kgV9++JZkQvFPDgBS45oR8nrCrP4mQ6iIgBKgO2UWDxhLCI6
         1iDv2tgDh+coAixrpo2ae/eZ19a8pBrTCbdw8qjzxUTmkQ2GDTcraVJkGWwrAiSieJ/Y
         wbpDQpiUB0fJ74dl94PIRC5DL2Hbi9SynwznK4bn2XcST6I042P7ZuCHYxe3+Q7eNSJa
         04dDMnp+HUSeUHKuu39plhdbK2QLGEy7eMvIYdPxmIvtH01bisiRklcUCGDB0+d3G6Cb
         cPZg==
X-Forwarded-Encrypted: i=1; AHgh+RrXOlTBl9xMIRm68CT1+cOmp3TEcpAN60bbQNmaKRfRRP7SuVLMpxArm5PcFulGEEZk+SHc4yPHw3a1@vger.kernel.org
X-Gm-Message-State: AFuF++mNdCZSjvH4UNc4F6P3EJL5twzFtFhxZeapaHKoJzw0qDaLk+Jz
	sNysjqH6HM4Vl6PscCrM2hZTeDtCpMq2T4TXmfxVMOqWEXFnxHTVdVaFb11QpGBnr+nGJEwmHCL
	ycKxvR9l3fH8Cw3uklQN9Aaa0rnbT47plLP4JVk2XD+/w1aVgcDSBAz5Ez0p5F+Kp0rCZer9tmg
	==
X-Gm-Gg: AR+sD10JbgMM2ugaZK0irRIaYWIx6pHwWzLFPcAGDkpOXB6S1RisabQ6Q7vUNVMhQdb
	trxitP4KgH47ISToIq2/GeBH5oL0DP8ETb0ALMqucbaXKdbpLzy3uGo4fCfoUOqQCTETxMedUna
	RHyduu6M02mI8JGEWikFW/GB3bM3ZHKyOCInKmtWEyBG7aATPxHd7ZF1axcSgCUP9KGOXliwKy0
	bSNKP6zJSXJ2MGQBLHH52NF4qkTgxqek+4iAz9/0MS8LnmKW6S6AGn9I3z8LCJgsiZZTmYwy47N
	6pQOwA5lcLmTxoz2zYOi87A21jsCKiazcufoIqBCGZ/lLrGWzHMzEOtHTBp/AMv3I3EJgQ==
X-Received: by 2002:a17:90b:53c7:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396464a15f2mr10987938a91.11.1787650183773;
        Tue, 25 Aug 2026 02:29:43 -0700 (PDT)
X-Received: by 2002:a17:90b:53c7:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396464a15f2mr10987851a91.11.1787650183236;
        Tue, 25 Aug 2026 02:29:43 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d2d1esm36270057eec.17.2026.08.25.02.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:29:42 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Tal Zussman <tz2294@columbia.edu>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix page vector leak on encrypted netfs read EIO path
Date: Tue, 25 Aug 2026 09:29:34 +0000
Message-Id: <20260825092934.2605898-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ceph_netfs_issue_read() pins pages with iov_iter_get_pages_alloc2() for
encrypted inodes and attaches them with own_pages=false. If
ceph_inc_osd_stopping_blocker() then fails, the request is dropped
without calling finish_netfs_read(), so the page array and the
references taken on those pages leak: ceph_osd_data_release() only
frees pages when own_pages is true, and __free_pages() would be the
wrong destructor for GUP-pinned pages.

Release the vector with put_page() and kvfree() on that error path,
matching finish_netfs_read(). Unencrypted ITER reads are unaffected.

Fixes: 1464de9f813e ("ceph: wait for OSD requests' callbacks to finish when unmounting")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/addr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c05bdf5d7273..8b009e354d30 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -442,6 +442,17 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
 	}
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
+		struct ceph_osd_data *osd_data =
+			osd_req_op_extent_osd_data(req, 0);
+
+		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
+			int num_pages = calc_pages_for(osd_data->alignment,
+						       osd_data->length);
+
+			for (int i = 0; i < num_pages; i++)
+				put_page(osd_data->pages[i]);
+			kvfree(osd_data->pages);
+		}
 		err = -EIO;
 		goto out;
 	}
-- 
2.34.1

