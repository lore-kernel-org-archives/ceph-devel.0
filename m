Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806E7080D
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378589; cv=none; b=u+91DDRlDmmdNayxU8+W6rhqeDINXliP/cVSzdhnTOVxE0zSuVH3euaPOkcgLkBItqTI8MDcX9CIuRIp7FtpFtkRWlvVvZfdifzjGwS2KeN3xsGfNvPzALznS7ekHip9tZNF2QwT0BOCjDALwMoU/tgvXkg1BU020eYn4C+aZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378589; c=relaxed/simple;
	bh=HsDZjMzquy88+BTDR4fcbEML0Y2n+zffQlh4t+kDmaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8Nq0nUnep3R6tt3FIxVkHsEEDfNs6Kt1fhEoLTYdR07U1Fhs/4yHqcpZLdQth48zPlcOZlP3bRF/uUwRaD+Fw83RuaKzXWNBMx4GfPIkSamGNDbvYFtPyjT5qz51Kkj17cT1gFVsh+0XXNnpUSeZkxX5+wHDsGMyl4222gF76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcr0ZR3L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRTgo70s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcr0ZR3L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRTgo70s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788378582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abJwaDwwItG/15iUfXoPokfBnWruzKGAmptUdifQFSQ=;
	b=fcr0ZR3LHqgORUr0EGppDvthJ8Am4xgygGqu0qfbEX2q2uPgGBAUK9xCAKg/6aEkirldBh
	l+xxh9G8FC2rNb95jSWiLxqYp/KHUwiS28sAhSjyNGBW7k9mvludAH6KkonLKMfX3ElLfC
	C4e9K3DKUe4e7Um0ZUc7ud7AnzIsqLM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-D35aheYtM1m02yoJouUV6g-1; Wed, 02 Sep 2026 15:49:40 -0400
X-MC-Unique: D35aheYtM1m02yoJouUV6g-1
X-Mimecast-MFC-AGG-ID: D35aheYtM1m02yoJouUV6g_1788378579
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c217f249fa1so141686066b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788378579; x=1788983379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abJwaDwwItG/15iUfXoPokfBnWruzKGAmptUdifQFSQ=;
        b=bRTgo70sMH8XoTFH4bgawBTaGJfhOAxOmzmdVIvAhoPuZlkuKcwpkhFfT0Jm0P72lK
         g9tGsZnn/n8CilHdcpF+F1j4kYTqqN7dCdifUK3LiFr7XmCiysGAGtmQzyXLl6m3q5bC
         /m5BgjQwl8HS4pFebFn1Qg3FJgjV4GQB1ffXp1ELzGHjNsdc6ZlAXbBGixslkL/c8tl3
         78JoTVpI7ZDj7Ys101vw61vISZjwePemw+SYZrA+nSwNsm6nZ9C4FeK32EqZfCYFDl+q
         jhTot6ycFITrtyGUeFzg1fX+NNkR24TIbTzosYeBt/RugtgMSuvGf35PkOIkOHDWqras
         2ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378579; x=1788983379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abJwaDwwItG/15iUfXoPokfBnWruzKGAmptUdifQFSQ=;
        b=sz5cfT/8UkNj51Iqe7FM3CKyam2RWSGT5SrNeqizTstrzYU5F4ekPmy7qNP8QU1dZd
         CQml6jetTQKzuZhGYSSNng2lnSRptVq9LKsxJMGNVrKfq2vYy51/B4/u0YkVI4/Mb0lk
         gpwHKbmtwB3eoejyaZN03WEfttJfkW3y+zY53xLfcH+Mg/v3KswlRMb2n0TBnHoZN5cc
         elDlqf0o2MYYuak9iwDqZLzhKvfMYkgX4IJMsYEb4FenYqqV175URlc5S1c3xUGDlfJ9
         HspCVbK0iWnGTUktiRbxSx8a6cdYAjVm+ge9Dp+6Wy2ztwOOg1lsihidEU6qPdyDg5up
         kQyQ==
X-Gm-Message-State: AFuF++neSdrGaMkwHQKKvKIXg20YrIVCiTDT5bNLSG9vYAx+gkoEh5XX
	d/kzSwRyiVTWZxytkcTVG5w7DJqB1f4uiMEk7ScYWqkWExkH5uGx4SjdncLEZwVMQ+vnPKYCYZs
	cmvs/KfPhl8Xh8e27iE5ZaKHuc5JBGxQZro0FnYbo1QBSFkoFHjJ68YWZD8WTFwDuxU4R3FVY9A
	==
X-Gm-Gg: AYBFou1hvNkz4aRovOogi20fmOB8rbxenj4ylw5T/rM2bI0EkXIciktefGOlJnrCVIj
	+pafcI0+vVT4Ev9brw8/RWiKO4NpNwOPjzEjtQ/tW7p1QfxvpaZeD7OCj7WR+RIJSX8ZsdPE/Fl
	1G1PvYBJcC+9My14hEHKVaAk3OWWBw4OxCMwI/Xb7Ilr5wwLGCM7Xv7fsUd7m58tbGyTXdJd2lO
	f7ZGLsKm47r9zOo+iLEqLxfR12/Zy299d+dubGUU3rjZTCbRv6kOiaEBTOW2MBcyNAlhecJiXLu
	ZSS372rCnlINSv4VNRTbo8GIdN7t5ruBMSENOLLBx4qa/b1QYW7E4I0wPvAAAmVvrqv+tf+60hp
	bWsSi4msqXDXCwG1Dxr88m65juHItoiKiTzLErut8p1BO4cXp7hVpReqxTQnktstRN6kpYXUy/i
	rxSXOFyfDQg2NcYw==
X-Received: by 2002:a17:907:d89:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c25d547b88amr434894166b.7.1788378579532;
        Wed, 02 Sep 2026 12:49:39 -0700 (PDT)
X-Received: by 2002:a17:907:d89:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c25d547b88amr434890466b.7.1788378579136;
        Wed, 02 Sep 2026 12:49:39 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f3eecf0bsm5494666b.3.2026.09.02.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:49:38 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v3,1/3] ceph/mds_client: pin sessions while checking a new MDS map
Date: Wed,  2 Sep 2026 19:49:37 +0000
Message-Id: <20260902194937.3210958-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828174504.1247038-2-max.kellermann@ionos.com>
References: <20260828174504.1247038-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK. Please respin.

  1. fs/ceph/mds_client.c:5191: send_mds_reconnect() overwrites CLOSED and reconnects a session CLOSE will purge
     Max, v3's CLOSED skips after the address-change mutex gap and the
     export-target rank wait are the right shape, but
     `send_mds_reconnect()` still has a hole.
     In `send_mds_reconnect()`, keep `mdsc->mutex` until after the state
     store, and skip if `s_state` is CLOSED (or the session is no longer
     registered).

-- 
Alex Markuze

