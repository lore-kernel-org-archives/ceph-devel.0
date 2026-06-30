Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04115358360
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844584; cv=none; b=XFh1Sx3Yd+YOvc6rmgyHKAaKcFamIw3CLk2+zU9Q1xO2IedSB1EvLPjoaYBuek2lKDwxCzSQd1hrcMvGQESSnYpThmd0K+1KE64+Sx5ODtD40lGe14D95onpoOV3FBmUe+Z3XWMWP4KqdiLQZQNKeL7MPPV7Syse3t+TuUDPb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844584; c=relaxed/simple;
	bh=Wv/0pP1dXfAdTgswab/cinfyqT4T1jDhCXVn6rw4Crs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEv7aAR5lmKuxnkVr/rnRqnSi8cG+QL+WsyH5HN9WcVdQF7jIDcEtky740Jg5iy/eiqYZaKpqGIqTnQ6SCHF5ypwtsZUY2aQ0CzxaCpSjZ2F6xv8OHP1Xg5dRFhjUgNWNGvPeL/KzRc0a1QB2iACCcjhPxK1tHIAhke8ikKXVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+jz9HCI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vz2jLfEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+jz9HCI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz2jLfEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782844582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LgRMtXoI4N203/mrDjfn6/CJFX2SSCplPAxDZM3z0Y=;
	b=g+jz9HCIFeM5LbArVPJNucNGCgyW2aNJ7tTWOjStj6mPNNpaGyaEGqjdVUOVUwGNTHn4Tb
	ZDnNRRr3qrNYu6ZxhZZ0WOUjVqc0qgn2pw1Z8VOv8ePAv/ZlcRDEUBmZEKL5ABnU7YPLkC
	DegdmC1Klle1mFtXuWzT+doWVa6ZMFA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-p4yhN6dHOMi88Ih1QxqDhA-1; Tue, 30 Jun 2026 14:36:20 -0400
X-MC-Unique: p4yhN6dHOMi88Ih1QxqDhA-1
X-Mimecast-MFC-AGG-ID: p4yhN6dHOMi88Ih1QxqDhA_1782844579
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9e741693bso1945419a34.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782844579; x=1783449379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LgRMtXoI4N203/mrDjfn6/CJFX2SSCplPAxDZM3z0Y=;
        b=Vz2jLfErwhragqj9Aj57PV7EpEwdTuiY5TyN/FG0gsaWHjzuFnVrrdzI+ejnzX983U
         mDRDRm7ek+PokrVpeQB3VXuhcznDORtz+LpCWyTeNVoigO1zQcoscE2wm04es6s6HQnw
         JaJFcTi2X4UyKYXDizQiuQgBq7VLVq4M8lniDBCBiNIEtRWyN2+kKj0BENPxLcIpSgiB
         m5fC35Nc1IoDtoEg3VKbfopU0bA61DJbYs45dzP20PXpG2oyhcVbnA2hldJZlxxuFzF0
         tgEv5pxWS5QcaFQr2WS1HZhDbro/6BoIL+YTf0ombzEQZMP/IPeoWoNUwk6Pmjoz2ish
         gsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844579; x=1783449379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LgRMtXoI4N203/mrDjfn6/CJFX2SSCplPAxDZM3z0Y=;
        b=bkRbaZJuVQKB30S3l3mz7GkZgsFw6hNejcXg++s1ZhT8TeRiX35FyFhJNMPUWjhnpw
         jcqni/AMOmd1mUOgySE6rrWsr2F7Ae6VjaovdFkWqhBlvRlehkPhAn3J9sZhUoX/jFgG
         IKqjzuJNGHc/apUefTIuhpEo6rlxZAV/dAO6w1v+uUNmFuZKVfEPIKKLarO3f9yRd0zo
         Jxr6APaellCK8mZDOPf8jQXmF8Nl5sBDbYKjhvDk9eRsAh7auDCHYyiSbuJ0bXoRDEBe
         EZtEO3ioL8fXM3BGNKttSbL5/BQQ50MQF3XUEk6soJ5GFsPdYg+C290qKuCtPhw6ETx1
         dJxQ==
X-Gm-Message-State: AOJu0YzER1Mc3ZMHwn5Oon7IAHejNE06vWT+1KVpe3di0uCax3NxZqdp
	2R2Tn0S+ivnu7QB2KBUOAzpS06rkFtJfXbTzSA1A+qrMCLaB3Kxpy03gb/mtUcRwJqu//YdEFeh
	4+ARQ4vUcn+/b2BgXi6skyAoz3lYvo6hZ3zmTBp1x4XHHkwdR03KNhieyZLOyHeo=
X-Gm-Gg: AfdE7clo5o6Of2qBzxNhiKUGHU+sFuzFpUfDjxcm4yRbR6PSF+K+cIf2J6cTUpW5g91
	rRqDFzwqXnBjuIE3bxI5/n5LqbHDo2oNCbr6/MUaRoAE2NhZULqGm7YX3k0OI3x4dTveAyb+Xxn
	06/orsSo28etj/Te+iTRVxtRXdJShMEKXR0q6VhDDl8ugLMrlhTwOLLAXaLtZJE2E7HUqd7MI5k
	0f3ZTbZZyd/eVAiWOgIFoXXV8icwGaiop7Z0c4Xst4yU7DPPvWGV9yiNNwc+XHe9pGMJc1V8SON
	FTtXOpr/BTeaqJB7nR+HiK/nBr7E5Kq2Y5n63eG+ahJyrGhCLGKqr6o0IQU/AwhbwfIT4UjBdPk
	vEJGWeB14F0TBQ7WUNgSRVllgM34fgLWt6kdf5wS7yZrf
X-Received: by 2002:a05:6830:3692:b0:7e9:e342:3e0 with SMTP id 46e09a7af769-7e9ec6ec624mr4178571a34.18.1782844579469;
        Tue, 30 Jun 2026 11:36:19 -0700 (PDT)
X-Received: by 2002:a05:6830:3692:b0:7e9:e342:3e0 with SMTP id 46e09a7af769-7e9ec6ec624mr4178552a34.18.1782844579085;
        Tue, 30 Jun 2026 11:36:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2ba18esm3063210a34.16.2026.06.30.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:36:18 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Bounce buffer for mds client decryption when vmalloc() buffers
Date: Tue, 30 Jun 2026 18:36:14 +0000
Message-Id: <20260630183615.455635-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260530030646.85589-1-CFSworks@gmail.com>
References: <20260530030646.85589-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sam,

This series looks good to me.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

