Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BF340406
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364045; cv=none; b=WL0YaSsVAnzobrVIlSKiRmeGklrksyecqnhfCOCzW6eIyQrliy3+pp61i4hmAhTqf+EEg0HyZ/s2J+45/D3XFIpso5uNCyArISA1z4JZDT0klYCt4V+OcjJ9oKVWclDPUqumIH+l5iajPvvEWfOIR4S+v64LlYAwefeA601pFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364045; c=relaxed/simple;
	bh=inmEUQN4fUOcT+nRsjssmyjioe2I/qMOERdCK2sckQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMRPz9Y51b0an9pVwz8/c2nPcR03bRW6mcYFhNb836xwhpNpQNoAp/ImZYP8aIdmd0fGbNNoG6DVbCpmOJXJw7xmLzcd7iSX7VCD2SxDayDwBGqJD8T8ke10i5O622eIZ2S8UuIJC22gckco8vZ0Gy/9tIpfDJfP3jlS66hlKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edyaDpE7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnZ0z/sZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edyaDpE7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnZ0z/sZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789364043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AOqMHBxhB9mtWXmsLwReqD268EPiROOnBHem+c6dbk=;
	b=edyaDpE7g0PZGOLZZ935UGlBgJ2Q8XrMj+FYniUFCQRr0OjUhTQ55lLRv9d20/X3PWbtxk
	AHGE1Hp0yt2jaev3MllwNMtrn50l/aBLWsjVyzpcTF0aG8S4jg9DuGH6EY32NU7vumlBMu
	gDm8a4VuNG2tWCzHJbxtybP7skquV7U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-87R6IP7RMVuPnqVrjSr_yA-1; Mon, 14 Sep 2026 01:34:02 -0400
X-MC-Unique: 87R6IP7RMVuPnqVrjSr_yA-1
X-Mimecast-MFC-AGG-ID: 87R6IP7RMVuPnqVrjSr_yA_1789364042
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530256c61b4so61869751cf.3
        for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789364042; x=1789968842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AOqMHBxhB9mtWXmsLwReqD268EPiROOnBHem+c6dbk=;
        b=MnZ0z/sZWh6GP7gIZMzSjSt0oadpghxtst50oQt/BD9Au+prFTQC6v0faWMq9B1fG5
         AQ6uG7oBo2grtK01O4PvWmsOEmfcQ9NU9DE9uc5NR5hBEfwvKhB/kJYmkoWqsbGYho4Q
         0zivQPZ3+jQGuiQ/a5oHn4zrhxYSJJbH5HOOVmxoqlx/sbWEg65AIzrA3RxpQplEATT+
         sJ9hCvUOtmDCgJy6Tbt49Pf+PrKBVSqWs+Y7dj7jln/AnAoV2N/MwRy0Wwn1Yy08zk+G
         BwSdLIFK+JgEQkeh9mUwJBsCQ2PQnmQ5BDrZ5MGj+ar+9KCehXr37/csZexZCcQSdxP/
         yKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364042; x=1789968842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4AOqMHBxhB9mtWXmsLwReqD268EPiROOnBHem+c6dbk=;
        b=XQQlTouXaweosVCWawzYvCgwFemu6Hs6Gd3lv9iqvkBRgpMPuI2+J5NAh7AlJhckh3
         NwD9XkVPCLyH3ue2PIh1uttXAaQADt/jOIulCPhO1ZvTcLGR1vRpSlMbj4UIT5x16P6U
         2m54pLzqlNAKh6Mk392Nf5eIkHYXbrYzeASVOZd493pRt+T0jPU6zi/LO8kbczClzOBL
         GrsEEqjbvNQG0ucDSH211lnxS6ZckU7qoDL9n4qlJcVYzo1bKrJ/effYibKz0dH83dxX
         Seo7/RNyDEyCpqKoGWAd5NffsWuW4w1cgvMJF12jpSKE0c4+m3+iCQImb1N+QgZ98TZI
         K4hA==
X-Gm-Message-State: AFuF++nrAmirTKbkuqFRBt3gjh4G9z0AMBEnAyrg16cxcHkob3JdFrgd
	H6sVBtZ51gGh2kVjMy8yXXWGPuVkdnJu7NP5rjNzVmM9FXCfEa0Z7bY/84F9VmNKY6yAcu1FgJx
	tFg7obRg5NcTtUnEwujk8znC7IZlbxrEV2z7wbNadLN6YyfqLzeOxSDyva9Kj+kGIjgPjUIBMsA
	==
X-Gm-Gg: AYBFou0ktax7evTW0nimbYNGU3cDrVZYE9BxbYQISHjmX/L89YDK44oY3kinSmr+BsD
	w25z4uss6BR/pBQtnKg8BWdYahMQiKBep6r8obcdtKWdfN3CE15YQAmeeDgXqcgj5jn9NthfoQH
	x1zg/JI9xS2LOOdzN1aOP2QM6t5yO16YlEc3ph2h8RskoejSJel4ohhHWJEuIiJUZb8u8281BSv
	B/wHYRqjOjYXDnH7CKcBrT3X92NLfI1nDCMaF57w+rrXkCXwfh5kG+gl4lwfUopGYoZcAgfdbBw
	25/iymEYeWWHYHMfYJ7e3Nbf2ckS+5M7fXmXxN20TscLWVGzQ0aVSmCPja7D1WihF/gaSqJgsU6
	iUOw9DvcHM3MrKEVQIGJS6AhiwWtmAX064kUqq3oM9VuIAD8N80ypGavRfHWJY0Tmk51bb3XOy1
	bn1iFyjWzaC+T0ug==
X-Received: by 2002:ac8:7c49:0:b0:530:80ba:effa with SMTP id d75a77b69052e-5310cff8e31mr14488961cf.34.1789364036816;
        Sun, 13 Sep 2026 22:33:56 -0700 (PDT)
X-Received: by 2002:ac8:7c49:0:b0:530:80ba:effa with SMTP id d75a77b69052e-5310cff8e31mr14488701cf.34.1789364036379;
        Sun, 13 Sep 2026 22:33:56 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530fe289627sm31838851cf.31.2026.09.13.22.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:33:55 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: acquire write lock only if snap trace has really changed
Date: Mon, 14 Sep 2026 05:33:53 +0000
Message-Id: <20260914053353.132489-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911185244.1420485-1-max.kellermann@ionos.com>
References: <20260911185244.1420485-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK. Please respin.

  1. fs/ceph/snap.c:963: Fast path rejects the global realm, so the write lock is never skipped
     `get_snap_trace_if_unmodified()` treats a NULL `realm->parent` as
     "must update".
     Match `adjust_snap_realm_parent()` and compare `realm->parent_ino`
     to `ri->parent`.

-- 
Alex Markuze

