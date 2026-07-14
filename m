Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276A3921E0
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029907; cv=none; b=cMlfZVVqvPXd7ZjDh0UMLBd1tZw0YDuHp43M5cNnKbG+ecmpJB4THllr2KfRifipoak/TKxAacBIhd6TJe4Z8TJRxJBUr3TflYdwxSrD+YVxasHcsX01x+m97Q87GWocYT5y+3wBo3/Ypr346F004oZogbqKKXhEIpOjrf/nXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029907; c=relaxed/simple;
	bh=vl3jDc1g7GWPDBQYE9IRz43uzIH+JdTPGZ6uFY1GAqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjc4CAcx/db62chMP9pGaknn1nSEYwqNhUx/myxT21hbPZ0KTz41DyaZc8fegYimlkMtIbFI2Q9gzDMa5QxmEa6pJqq7m/+H7p18DA3eWGZhVSMTmG8IHNqYhfa8MbaKzG/C4de5lH9+I67pJIUcDpmgAu9wxhqgFVe7i1e3ZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK7VWKZJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK7VWKZJ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92c7a0a701aso275915185a.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029905; x=1784634705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zzvk+OtxgX2+/Xe80MvgZXwO6U2S4TROVRo8PLXigpg=;
        b=fK7VWKZJAmq41EYuW0FErPL2mQyKth8bRAaRz+fZlG/18nj3TwaX9JtRnqNOahAn0F
         nNiLuaTCCvgGgX6j6t+FqfcrkDUFBSedrh02tVDVJ2sMbP6kqQBr/szhTaKTAFbkfVkE
         aFsFLmHDqd6grEy5MLS1cv3tWpztuirxGy06cF17Xq0K9c7Ub+LpGAVhhCUoNWrk8Tph
         lw5rkyzVZQqf6YX+ip0P006YE9BuQHe9QzpCCYYQpa//BeUZNKwIGAXlPzst58rPgsxz
         +6I0nFWo0SQZDkOzkHPfgZWZm3QQVLCiDFAPj8gNGZTFGKptkblOu+DQLfPFHoPz+IRA
         O1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029905; x=1784634705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zzvk+OtxgX2+/Xe80MvgZXwO6U2S4TROVRo8PLXigpg=;
        b=jG1/0l9xbkxF7F/fPVvdgzVpsdpuR/P6cDHWg+3aHlo0Z/2ONmFSoBr6lp7Ts0vIoU
         fYA9qpzcoOAAP9s0lfJcxPXIGeq4UWFZTcRnH9GyjiK+A0YYIY6NJ6KLzyyy8gPdEEQj
         uwwEYXYLfo68XZeBLaZEVHVIwQWTFp83kQH8z8f/jjbwHge5yTq5W80KtuZoDtJch3Nu
         m2MFH6x8RyMLVd8vgsKJW/CslMwj9w0N5CPqICjNbz/ugCigL+BjayuH/glXWu1Gx6Gy
         Q8XSEn0FJGKjc8fJweSJv/2nWoRZs979Ei0laCTFzBGwXA17MBBmVjTGL3Hnr5UajpD8
         VXZg==
X-Forwarded-Encrypted: i=1; AHgh+Rp58jcQzk712IzbH9YPTaraX3fXKoQt13qY9loiXql9tfCY52qGY+FwldmNgX09Vimk/Eos9flsfWtz@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdYU2bIv1K8LTO1QzpdpVESORU6kp2Ofnlqc+HFYGVmwdL34I
	H5xom0K24MumHS7lVQpN/5gqsKs00zGjC+6dHsri2JAqmiAKIH6CJ6bp
X-Gm-Gg: AfdE7cm43NiNBl9HQxpA0+yW5LtEiyMMjmLXgdRXIO+WA6JN/PZHq2IFB9R2Dig3h7q
	wjk4mxnBwOwOBHewIsALuoi32gYfUiyYqE6ItLQuSDMzbCc3sdbWjI66QnPGXzOjKr90aJloY3s
	cGy132lNsppeyLWhICLOcQhDYplk4SbSJx0Tq9OZ7sOocGNPzXNbsC6HAO96rz4Rr/2xRkYyvTG
	Xiy9DKduV1i7GLoSjDQ4NsmVFGuA91N/AjrIzQkYeXeA5EW0SunnCx+X1qCvJUOeagO2JySuoIz
	yjRqZKj60y+JDDW1XTyVo/EaqpiycIIpJimHvP3tYLlOX3rwgYCJmhH5+rrNohQANtFC9ohHPJG
	TjpmRIlVTu8iXtc9WVMxxwK0wToLJa0R3WSDDKdqDvI4knx4w8skEixFtTCJNK7cud/UVBblBR4
	IVrGvRw7wne3H9dOumt3I1jfrW43oMgUZ9059AMg05+i5FawBMCcwfCeLjBAFY5Y8Ldj4DlRq4J
	EydqY8Ca73iq8a9wAS5
X-Received: by 2002:a05:620a:11aa:b0:92e:745c:6c5a with SMTP id af79cd13be357-93083c2788cmr204459085a.14.1784029904930;
        Tue, 14 Jul 2026 04:51:44 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1479415585a.46.2026.07.14.04.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:51:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] libceph: validate OSD sparse-read extent maps (+KUnit)
Date: Tue, 14 Jul 2026 07:51:38 -0400
Message-ID: <20260714115141.3768034-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Patch 1 is the fix from v1 (unchanged), now carrying Viacheslav Dubeyko's
Reviewed-by. Patch 2 adds the KUnit coverage he asked for.

osd_sparse_read() checks that the sparse-read data length matches the summed
extent lengths but never checks that each OSD-supplied extent is monotonic
and stays inside the original request range, so a malformed authenticated
OSD reply can advance the message-data cursor past the request buffer and
hit the BUG_ON(!*length) in ceph_msg_data_next(). Patch 1 rejects such maps
before advancing the cursor.

The KUnit suite in patch 2 drives the real osd_sparse_read() state machine
over a synthesized reply (no OSD, no network). Confirmed before/after on
v7.2-rc3: without patch 1 the out-of-range case faults in
ceph_msg_data_next() while the in-range control passes (1 pass, 1 fail);
with patch 1 both pass.

v1: https://lore.kernel.org/ceph-devel/20260710022837.libceph-sparse-v1@bommarito/

Michael Bommarito (2):
  libceph: validate OSD extent maps before cursor advance
  libceph: add KUnit coverage for OSD sparse-read extent validation

 net/ceph/Kconfig            |  12 +++
 net/ceph/osd_client-kunit.c | 146 ++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c       |  34 +++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 net/ceph/osd_client-kunit.c

-- 
2.53.0

