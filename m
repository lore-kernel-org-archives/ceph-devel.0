Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7A4562A0
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933037; cv=none; b=PNGM4XEWfOYawXLActElZrQ60SW+HVbjwk5lsHdXYjn30TyOI9B0wGubf0T2dZ9FWjF/6OV7u30ulqjsqhLHZYHiEivX03cqUKhvvHQ3fSfg0PbMg9bltixtvM05aECHrFBuSzPn0Q3o58et7cRlWMYxXMtRQsvDDkpG8NXUOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933037; c=relaxed/simple;
	bh=257ZYm/onK9NmjFUuWheeVrDW0MEc1CP8eA0y4JopIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1olxmMKKJNHRsz87owsXs8yXTZBUB5JChOMH3acn0RtejFaxmbRD0VDnqvMiuhX6QEb+ralsPCpV48xYmQsFH4kEeiDNbN6wEKeQP7mN8vfjWY6X0aFSu3ACBsUTGZTFG9HACIfUgCrRXgWCFqT4HZVdU/MRXccn6o3W2d7QYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRs3eQS3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9nkYNLu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRs3eQS3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9nkYNLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790933034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGtB9v1GsGLaJhfSAUhIyFl6i0Nim+LY1YL2weIAg2Y=;
	b=RRs3eQS3SSr4/8Gx2XGeNRd43O0QDwtERdcBRTEqnInuonwii4KD44bTwt8+EVt/iJXyui
	Z34pi3V4BhKvve+tKuYi1jMEx+2QRWI3/AKQRtJfccSR5bmAU+4bF2CPhgSgZ9NXIwK8Dy
	UQWOZ9pEHndTdFKFwMTr0Xx6rLF8GnI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-GaCW9ZNsPX2ZBx2ti3XljQ-1; Fri, 02 Oct 2026 05:23:53 -0400
X-MC-Unique: GaCW9ZNsPX2ZBx2ti3XljQ-1
X-Mimecast-MFC-AGG-ID: GaCW9ZNsPX2ZBx2ti3XljQ_1790933033
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93dd3c3badbso70248685a.2
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790933033; x=1791537833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CGtB9v1GsGLaJhfSAUhIyFl6i0Nim+LY1YL2weIAg2Y=;
        b=D9nkYNLuDsQx8ACCJyWFwqQrehvlXljgKQARuwWLhR0D4BttXwEu0RXqFnmpmKXNd9
         WUyGiKiAAl62Xj4i6Zeqh0G0vA3ykTMRrHdLgpnaRQXVnDoGljWgzfgkH4YFL3vHsNIN
         skvUAxSiEDATlzy06eL7SoMQ0Zeo8ChL+/Zb7T1R9jFWF+3GjltyBjlehPSrGB+eqdV5
         6eZeiJgrMKAgxh054HPqTiB6kqT5pEdREXxY2Wf4dF0kyu+WyQYw5SbagSlXbwBBDGWU
         D742srk1/a+dtziwJCgT5ZqgU0aaaSwk4pk3VCXPhEMj9XvHFPdC0ZVro8qFxdVzSE1v
         RL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933033; x=1791537833;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGtB9v1GsGLaJhfSAUhIyFl6i0Nim+LY1YL2weIAg2Y=;
        b=06hS32ZP4kMHgKlFriGmwgxybiGJP3zSp5/JS+jrmwkC2ENNrzz9vmEW+nJV7TPo6y
         9s7d+hWcIMeYLwdEDMSAx1/1PaSUzmRcBS/+eUQI3o+1NHnvKBuSPWb3131zkjmXgweW
         7HzRoUHRDAGTpW0d6BwFR5epVL3YdLr2bsEhMQyY/XvEVBdAByWM/EVQXVBssad6R8rL
         +68TieYKbsTIEQu30TdVGOgE32kodkryOzVlll+79oR3QMIKWoy0GtNVEDtVR+/7CVgT
         kTE/QSH4McjW3DySPIYSDZLY7wumozHEO1pbNl+9HcploiBsm0aQTLNLSRq0v5NK4f3H
         DjSA==
X-Gm-Message-State: AFuF++lGv2wNpQSN8wMerVAItbnw8PvUc7AG01jH9Bk/vOxVfTSDvTmQ
	EsUlNBC5yOXPtHuJ//1K2HFbnmDwcpscTuWAkKBZ8CkNjpYPN3MbR+qbOvdY+3U0y2jbfpa+C1j
	rPK9HVv/cGJKkQZJ8jRFHjjphCPYhTpIJ5h4BoDsyNuVbbhuc575RX6CMyUoOP0E=
X-Gm-Gg: AYBFou1NQbCFGpMt77L9wgCLASpd4RqmKaepASa/WvDpvH2YscVDrWbbuvtdtgNnM7g
	gYCPSaZJ4xSJ9Pq744pCK/zJ58O5YcMMq1fGHah5+NxQvYxFZKjffW8iEAaHnhAv6+AecdUVvEC
	C+ZLorrnRWSSjcBSlD0jov+QTdt2mOWk6a1J6bOcoWdbDhkpfm3NLxR2JeC+VsGjgzXeqrOIynU
	YPZRqiyhbCQtcDM6yEt8sIE+YBuSvTClaZ82P2NvoCzwSsRlInWTz5bFzx3HJkrTfPNpRnCnKRm
	QzQOVxzEG4IlLr39jpVDE3vFVH31EkTSvOemY6ppnOGDUTm6lUXwrLcOhmI/dofaJbpT9+YYOpV
	tkF6lNWV6iKwNyqrKpmi13arT15uhlPMPcb8N09BzJyGg8AdRE62SaX5MYQRV8eeSg4dujRfSHh
	f9cu31bVbK0fQpuw==
X-Received: by 2002:a05:620a:9504:b0:93c:b719:ea07 with SMTP id af79cd13be357-93cf1755aa1mr266818785a.42.1790933033011;
        Fri, 02 Oct 2026 02:23:53 -0700 (PDT)
X-Received: by 2002:a05:620a:9504:b0:93c:b719:ea07 with SMTP id af79cd13be357-93cf1755aa1mr266816885a.42.1790933032573;
        Fri, 02 Oct 2026 02:23:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a4312sm170545185a.10.2026.10.02.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:23:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: ceph: fix 32-bit overflow in readdir reply count check
Date: Fri,  2 Oct 2026 09:23:49 +0000
Message-Id: <20261002092349.1638909-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923202533.2229953-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260923202533.2229953-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jérémy,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

