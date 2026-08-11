Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEE446831
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458346; cv=none; b=hE06KB+czBHUoDp3Cou2bbe3Y1SL4q5CFjCnjlSO/NY88kKFWYeUhzb8KPk/qWU2bMbvAK92pCspncNQ7f+CvlPVI2EsU58UeERlaImnGgfzrV/dw7ASp187mRi1SX/JLoChRKaXgQT1O43EUm2DlQbTsmEs5HdXfSA2eNow19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458346; c=relaxed/simple;
	bh=x+pSUyzzST4rnwqe2PFvlL7bINWWDXi1Y/gXAIft7p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eL3daWn5RGwiOlY0lKCowip7Wz6DshsZiyn8HkZfX7ZIoQSCAWJGdq5fnJDNa6qgoMGyibEfvVdyAtdxOtaDpwDZYbutGssNeYf7OSQSHsmPOi7Ucvgm0HjQa/nfcXNDCbvZyQN2aFurqkHAs66Mu0lFxIyjCANUyl5fK5RV48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMbrJ1dR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxfeF888; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMbrJ1dR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxfeF888"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786458344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy4KOfbv9nd+lUT6XT3ZcwKkeb8ueaNsRHdVT5Sqowg=;
	b=AMbrJ1dRuK8t3Q1iTmKE5Ws8fIY71dGDu0Mtcdb05s3+xptdgnslyTcJEUw/KoA2BPEmes
	NzkVMMu0u0glg1EZN87ciXYdfoVXsVqOSvXk+Lk+eoMclib0v8d36Duxgtkek2HwgYevu8
	rJp0eUj7jMpercCLv1PlN07YxPS0Wt8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-iMfFHb_XOf6-zO_DQz3SWQ-1; Tue, 11 Aug 2026 10:25:42 -0400
X-MC-Unique: iMfFHb_XOf6-zO_DQz3SWQ-1
X-Mimecast-MFC-AGG-ID: iMfFHb_XOf6-zO_DQz3SWQ_1786458341
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15f4732dfaso256130466b.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786458341; x=1787063141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fy4KOfbv9nd+lUT6XT3ZcwKkeb8ueaNsRHdVT5Sqowg=;
        b=GxfeF888Sj+OiBd2JhxZDSNqjm6EYextHfzSBMe6FReRjWeC5ua3vse4hIaPyV6bTj
         cXO1goyXH238ouSbMAn9ucqa9ajTSYR7tUzPiJiwDyovJs3EJ0ajLiwO80Ll+gIwauQN
         C43C32SMhTU3IEsMNBoXA45AoJFdKBXmKq2ZduUzFW3wI20e1HmeZdIByF5KBxnQVxLj
         xyvKXNMvifdk0m6SV5qg7EFM++3MRD90zMcsMJwp01t6BE5U+qj2f6A/Xr2NaSRgeXUp
         sMLUdKRT8j1GYIj21n/c1U0zlg5mLEDILdHgrOngKPVMHQg3j+7r+BUAVQP8T9r0dqP0
         XdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458341; x=1787063141;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fy4KOfbv9nd+lUT6XT3ZcwKkeb8ueaNsRHdVT5Sqowg=;
        b=Ka8n1dgoIg2MkdcbdsszUjfBfFNDcNbxhZlQHDCLb69r/orbIX1DwIWqbkQmDLTIGD
         FwL+LrNl6rSTPktkZpyenQN6MFyYtySqpXNkD8LKgHioRtlh70m3hWpem+IR6T1gdGQN
         yffVbtqlVT9oh7onmc328mWxBigg2bXgH+M+2WfoKBHCkEDbwNx1L005aGZwcdg8Y9uj
         xEL4QWvFiSN83rmbEYLWiDq54THCLnCK83l6EnPfo6aIF7r/q/0Z51OSw+t0lSyvcQAW
         Q26DxenKO7FMdhq/noTimgMukJTa7YRMJzrPkT3WqqluQClAzCje0nyh2HzIwx3BcTDa
         TLOw==
X-Forwarded-Encrypted: i=1; AHgh+RrZfTthGW3W0K7mF0S6iZRe9UCYgYjOVsPAE7mNOUhwddWapXrFz9j9asD7PZFCi8OMYlMN0pSp5GHn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ovdt16zSQLvKHZYHiX5ewZT5/THY3MD3kmuloEfA5FwTIGHu
	tqH7JZI0UNnUQLjFhDmcGfori5u1VL/GEGRdews0cISVGQOzr0ERj9LxE+2HUjd7VFoPy+MnxFb
	rMdavFiCQdiVX+tpnV3lZhdPTnf6GRtacQ2IdSB1jU0E+3Psb8C5YcFR+UkcFnc0=
X-Gm-Gg: AR+sD11MtP5TUoJY0F8fGvI4CTa5XYRr7LNgi6IsdlueCcnv7c//Alt8XsoLRGn0siN
	hHVpYgFonEb6r7jO/J1njxz55AEOW/OJ/DGUrVe/wUn5lj3UAnuwgwf+rTRlQiPAhWLkaf00ZzQ
	voGDcuyp/NXn95+Ql0qiRdo+wIrPThe4GxesOujiuYC/QsXON3cj5kBDIZ7jZOMmBRr8Mu9ttJR
	ly00JGHIqn+S/JFwrn8eFmSx2LHleea5QvbtBa3a4XDY7TTDqgPDLYl76vb1O3XcFQPd0akpioa
	bzcmKIof9FAAu0digvFT7aC943xQC1XS5zpXQtOvD5tpPHnCuggcC+x9cJGxsblOgvEhOGiVsDx
	vC/c1xRO/OQOZ2P50tmpA/gOjUQbNDaJPBg==
X-Received: by 2002:a17:906:f584:b0:c16:a402:9d8a with SMTP id a640c23a62f3a-c20e6189f97mr217729666b.11.1786458340949;
        Tue, 11 Aug 2026 07:25:40 -0700 (PDT)
X-Received: by 2002:a17:906:f584:b0:c16:a402:9d8a with SMTP id a640c23a62f3a-c20e6189f97mr217727466b.11.1786458340566;
        Tue, 11 Aug 2026 07:25:40 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e435f1dfsm61790266b.50.2026.08.11.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:25:40 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: fs/ceph/super: document struct ceph_dentry_info and its flags
Date: Tue, 11 Aug 2026 14:25:38 +0000
Message-Id: <20260811142538.2701033-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708083455.78487-1-max.kellermann@ionos.com>
References: <20260708083455.78487-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [minor] fs/ceph/super.h:440: CEPH_DENTRY_REFERENCED comment is too narrow
     The comment says the bit is set when a dentry on the "shrink list"
     is touched again. In practice `__ceph_dentry_dir_lease_touch()`
     also sets it when a dentry already on `dentry_dir_leases` is
     touched — same second-chance concept, different list. The
     dispose-path consumer checks the bit to decide whether to requeue
     onto either list.
     Suggested fix: Widen to: "set when an already-listed dentry is
     touched again, so the walker spares it for another round instead of
     disposing of it."
  2. [minor] fs/ceph/super.h:422: time field comment says last touched but is insertion/requeue timestamp
  3. [nit] fs/ceph/super.h:399: lease_seq comment says REVOKE but client sends REVOKE_ACK

Documentation-only patch with two minor semantic inaccuracies (REFERENCED scope, time semantics) and one naming nit (REVOKE vs REVOKE_ACK); needs a v2.


-- 
Alex Markuze

