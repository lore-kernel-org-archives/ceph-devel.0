Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77A53A3AC
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075725; cv=none; b=rIFKvKMZBRehvGo5tpWT+j5egcjBnFUuqL9rDqZyQRz3t684KnJQgwFwp6y1CWU47sF7SuZnjDjA8CcsE16LzxoeuPVrTrD8EQrjU1Hy62ebgFNFXcTlgV5X2lFGdFbpNpcyz1RMn1mO22O7Bw7fe6TO43aQLR7s5BVGpaKmtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075725; c=relaxed/simple;
	bh=onU/5/kT1hiHwApG8rwpT3PI4XbL2fj4IPsBDnGXyqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKwIra4g+IUgx0dSwvDHKft4EnbKuXCARx1m3sb0hFnVUEC9bC78G6QKb+jTOd+FDdkcyU8qRsfbFCsf1sFaKw6E5L8GOfaNTn9ewOBakoEOk1zqB9wVSz/R2xPDjPvvvWJxvf4b4R2ISYxbxsBZFyDl3HWHYQlsySLCbHJIqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxPA3Tck; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlyV4r+M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxPA3Tck";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlyV4r+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=PxPA3Tcktdg/bZ12rPr7Pxdt2/itO68jSEPIgUELGuACTn6tynke1W7KQ0UIzNGhqk98Hr
	/3pjKWw5ZBx4PjNeiGNy8fBwHk0hrwkkGyDRXNYAOKrMEHSfd4iPfreSWjB98la24RVYLN
	ccVfMAq7oZaGoSrD3d2AvwD2dLbhPXQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-0XNCmaq7M5urHPbndD8Vnw-1; Tue, 22 Sep 2026 07:15:21 -0400
X-MC-Unique: 0XNCmaq7M5urHPbndD8Vnw-1
X-Mimecast-MFC-AGG-ID: 0XNCmaq7M5urHPbndD8Vnw_1790075721
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1e564fd5so632325885a.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075721; x=1790680521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=UlyV4r+MW8fbUoAKs38ZtCWGWt64hL78oU/glwCty9qk2tRlfFCjEbreegaQBtI7Qq
         9Oyt3SSTXOgf2khBM6pLI0Xl51NQaqgVhGqlxASjt6Admeko+ZrI6Yq4Lbikrpx+PzwI
         wCy14fAWc/HeU1IRbC9Xl8LAiJiWyvgn1Zzrxb0cVd5W9+BLKxBEohPII08hzIsgDQvG
         GCesLhMmUupwxSRKEdfcjO0cKuEg8M7TL2wtKCMyt8F8ep65kS90M4C1J/3e/W5/aj9z
         3agZvkpEK2uUXA8cRL9s5fj7HTm6b7F+XmwsfJhnXqO8DWFBHVbWCUZzyi3ftzSnmQl8
         neEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075721; x=1790680521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=vf/7iXdG0gsNg61qqJS6gkaMsCOTHUfgQeHPxy+yXmaDbGRUz6GtpBZ789hr2Zxf40
         oOVOVR07MiV0wJ5c3QBSksfnd+ahT90qk/0IAVzHe//XAS1DQ0wrQFC8Jypmv2U72Vvn
         XfgrI5+qMzti96qqXHsprT8xw37Ar9KJR/j3rDiJyNkUzvqN3AZgpFfAGtm0nekmRuqn
         JqCmjUeSYNbncQ8yk55S/3qqhCXDf75xYtUlcrgUhjdwhyNHMUGvw/cEy9oufttafu/v
         QSFSQuIA4hlx/ohXKEtvGP2oV+JxY7lIsgFUUgLDhc9vz+mXCFg4VCZBahyT695yZ1bg
         qfVQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3VSza/23c+faSGn8dOwozHNqvCZJFJo+V//GB0/ezPbVymrD/CJB9IRx5rb3XwTz3fjUZxtjpukah@vger.kernel.org
X-Gm-Message-State: AFuF++lAsHKhiBrPqP1mSWDRt9+xlZQkT4WtQtkmElImGdG0L7CaeMrd
	ijYt2rrHHDs2RBFECjNQ1hjRxDjw/15VWlJuRUwBJabq5N4hjVkHzQ/3hgoPrsnbHxY7fNwpp5Y
	3CXLN8Pgh+QTtzFPzu5BNpypZbWOXVRdjI7w+IbCjZZpf75VzhxI0qK/O/dy4wk4=
X-Gm-Gg: AYBFou1UfTg7N3Ko/ntHPEVfVRjTvCrqt1kHNBJDnw4zvseXxTDnILR6q/k3ZJAz6TA
	F/3RsfACOyI0kTmw0WM2L638F/ETsXvoTSf6B5CNmJ8mM6DMiEqmCG0GjL0cJ4MOCxBuXSbZFTF
	oZZMxHJyNzMRIUGKYuJ/btWOBuxMPD3Qm9KCNHIcTNODayc63s3lYZU0UTyIduW0hJg+TWTrF2z
	2Tul+lwa9vuoIhK+0heq3qvbS58S5G85Gx73r/iQa80Ls8b63SpKiTasr5JooEzB1/hXaeWzmwW
	0+02PTjLRy+UzR+xBzJSLAgFPixcZjRfv+45tR7ZjzT8hX8q1Gx2/Knfui0OQ13t4hBjsT5aKr4
	CAKK2h1U5P2I4A4lX3jy2+7ytN45mTtfI2/j0/vbvjGqM+LJaC1Ffzx8RwQ47uuyTrCtu2nN4jo
	PAlm4LVx+OSFu7tg==
X-Received: by 2002:a05:620a:2707:b0:939:b559:1e82 with SMTP id af79cd13be357-93c15e7bf2emr496665485a.41.1790075720634;
        Tue, 22 Sep 2026 04:15:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2707:b0:939:b559:1e82 with SMTP id af79cd13be357-93c15e7bf2emr496658685a.41.1790075720051;
        Tue, 22 Sep 2026 04:15:20 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d169ca7sm114489185a.17.2026.09.22.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v2] libceph: Always kick off requests after updating an osdmap
Date: Tue, 22 Sep 2026 11:15:17 +0000
Message-Id: <20260922111517.767331-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909120910.751491-1-raphael.zimmer@tu-ilmenau.de>
References: <20260909120910.751491-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

