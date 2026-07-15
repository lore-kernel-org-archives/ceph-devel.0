Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E94CA28E
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140016; cv=none; b=bni1Ws8y2TQFgz57/xq7pusa/U7KOkHUA+TCXvouDoiINQZ6ZaNIr3FN3puvE+pPbge1X0weFF4TgIMsiK2Br+ywt7bMDawyOlesTj3HLnpt/75rbFAs1wtpCLS3zMtv4hadiEOqtGBbBKMNnve0Lmbpehc18iM3c/aHJeTHNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140016; c=relaxed/simple;
	bh=6OBPu0xIRv3yqu6pLsaLIdomyvaoNkIx8y7JrDLhiXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4TwLR0e5h9bnb4nSayIGINMuPIgZlZdOEGgAuy3JybCUMAfmukWraSq+AJNBWCqDcutbOHFFU0EBNzBLQql2ojzZL5DYfAZR5h8ScBKyFkeIL+INwXjDByHq7h9dtnn/w4CCGXjcYKKDZCXxxDwKsXm5qojQIKINv/vZcqRQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnM8tuC/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnM8tuC/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cea3004256so63358535ad.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784140009; x=1784744809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6OBPu0xIRv3yqu6pLsaLIdomyvaoNkIx8y7JrDLhiXw=;
        b=CnM8tuC/ZsDa+uwpEyUxv0LIq6JkPNmoHt/7HHVstDb0aahknA6aCc2wr6Rb+uZUlF
         64U6HOdoPXAvCkn9+lywND2zq2YuyBryQlb2kQ8qp0TYaBhdlPZYO1Q3Mxpxka8t3Tcz
         1x2gjgTxE5eeyDBLuiXADhlCYP/4jsAtmaJqOjO5zjOmUkIMGi7blWwlamaepYl1vctd
         Bdjq+E7UR7TfAwp1TaVHBPEpO0Tas+RPs8JmPxzXe4PN2Zdt36YBWMEj4t9VQwuinB9N
         cXqI+d62lM8P2RZUCFAkzKYDDRjdSgev0OBtAduoW+G1abR9G/Ciy3pKS9UCmloeRXXF
         RYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140009; x=1784744809;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OBPu0xIRv3yqu6pLsaLIdomyvaoNkIx8y7JrDLhiXw=;
        b=buiXCl/yJ0EyslpLe5o8mpiiE1nUuHxR8WoMPBo008j91CsNpezIpUlHBdovlaj5XQ
         pJGmapavzd0p0/4bpMWCQymaehwr1b5MOlalz67XLMOQO0E9wPD5/svwyGkCbnhkcMGv
         +6yjG0Qv3znEbcGxbj/WjYNyHiddv8twMTYsfx0rNi0ddRcE0wLFIEiFq+vJjjWyIECg
         hZN9iGErP+eUF/Fd+Ukc3r2lnagS9aIf2euyvknCTD/a1ze98X7qNuTifacAaZuvEvzm
         +auvkcoTDVX/LNKeIHPP/AgVz6eRev522T2LTAlxVhBbzyNe5sOW4Raf70Fu57qpT/Lq
         AIow==
X-Gm-Message-State: AOJu0Yx9IDYlD3gK/a7t66iLS9RDwUC6Y+LPzJzp8brP3XV8NLh7SGd1
	LW3rgkeIFCMHzToOqY/X/37q073VNN0WFtVYlS6Sbsw0/1DE9197aIMj
X-Gm-Gg: AfdE7cmoDHgLud/IPxpFygNkJGTkgXAIfBZ1MjItg3+Ez8FlnxhA2e9SQJrqFfAE8Hd
	VCf9ouqHAaQs+NYkTdknfyoJdllpU+tn2ZHfT+mC4FhAyb7gpDwHxTtUcFQz8NAPG04u8+7gRbp
	F3Ee/tOKcCtuId4nv/cZVUtlPWLwCu+XPHxv2GK8oZx48X3j6K/tti3u2QzKvM1l36ce6YHaie6
	ERiSF879YLcxfGRHrXF88qr+Qn8sypxl35PDbBlEqUR0kQ74MUhwnc4xKuvSGNzi8PRz5P8Pac0
	8Iulx66Wi7GcR+1GN/FmrtiMPF06yG/g4nneq4WcmNmCrcz6akFpA6io6yAtExq3ooAto78j87d
	0hMDe8/pe+O9unNpy2O7ylE3IuQnqLVuzCk/anAWtpFkrfnWz9ELoCfYe0OUxzXQs6OayspZYkC
	uUbAdLNncdbepoyjmD6TDwsehBMfyFQuVZBPVAJLY+qB4pBX9R5HTWmqEBbHYrBA==
X-Received: by 2002:a05:6a21:9a4a:b0:39b:ba95:b14c with SMTP id adf61e73a8af0-3c3570141a9mr8237885637.24.1784140008885;
        Wed, 15 Jul 2026 11:26:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4341a37sm2960209c88.12.2026.07.15.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:26:48 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakroag <gaikwad.dcg@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Subject: Re: [PATCH 4/4] fix: release unused ceph cap reservation on readdir error
Date: Wed, 15 Jul 2026 23:56:41 +0530
Message-ID: <20260715182641.34280-1-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715181625.18677-1-gaikwad.dcg@gmail.com>
References: <20260715143646.15828-4-gaikwad.dcg@gmail.com> <00fbda82bd63f3c7560898531b97a1b061fa6e2b.camel@dubeyko.com> <20260715181612.18192-1-gaikwad.dcg@gmail.com> <20260715181625.18677-1-gaikwad.dcg@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

A quick clarification on my testing note from the previous reply — I worded
it poorly.

Testing: I compile-smoke-tested this change via ./scripts/vm-test.sh quick
in a Lima Ubuntu 24.04 arm64 VM before sending (checkpatch on the commit
plus building fs/ceph/inode.o along with the other touched objects in that
script). The run passed on 2026-07-15T18:25:58Z (2026-07-15 23:55:58 IST).

I do not have a Ceph cluster/MicroCeph environment to runtime-reproduce the
readdir error path or observe cap unreservation behavior under failure —
that remains static analysis from code review.

No further patch changes from this; the [PATCH 1/1] submission stands.

Thanks,
Deepak Rao Gaikwad
