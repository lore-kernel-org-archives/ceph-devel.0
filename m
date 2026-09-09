Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89552378B
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950334; cv=none; b=C8PycJp2rGd2bfSBll3Iln2UX3u70PeSQqSUCOE5+Q/KLiTv8QIL/61bpr3xLrLoV3SPy78AkEe7QcFFOkf6iGscvE9Qf7bRTMluHZUKUmq+lbgEJjWN4GVx2ee+wLtqzMzHWH0ynSrAqINc276Mf9vEMGDWVvTl1Vay42J3EaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950334; c=relaxed/simple;
	bh=YjiRvmyXdPc/h1XDyaWzrcukd6boTGWKBfGf/jTc/Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmYGnpk0vSaJyssTnfS3GE4WNiqr9H7VlkiVEZHqPhSuMkHkjTHlNHhlfkQQmofIaupWVFJfXMUoJ1A+2wBN4MkSr1zgbGRzosz/lIVmyooYQAVI38DWQ1H9s+huPw3KR7XnMBDtHD4Cb5vu1iSF+cZCXJWFxXUaQVcfaFGY7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjSVYTNn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aInlolOb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjSVYTNn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aInlolOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788950331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4imwOPLyjOICYmZIRccp/He11m0CyfxnZxzyx6PkSk=;
	b=hjSVYTNnpVg2DSF6mjSZln9h8hbyKEA7RC/IB14MicOYje0rHzppkvdjv35RPDhqEJmuqv
	hcBZ3TXzhAi8b46rVaEJnKR/RvZ4VhBiq85pwXQe1+pDoEPrmYKNhFTQ2kJWLd9Y3UkPU5
	5491Tyn/mo3rIqEgHwc/VtTfNHcHdQQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Q7Sa_lnhP1CCv_F8JVATug-1; Wed, 09 Sep 2026 06:38:50 -0400
X-MC-Unique: Q7Sa_lnhP1CCv_F8JVATug-1
X-Mimecast-MFC-AGG-ID: Q7Sa_lnhP1CCv_F8JVATug_1788950330
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e7db8d191so126078646d6.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788950330; x=1789555130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4imwOPLyjOICYmZIRccp/He11m0CyfxnZxzyx6PkSk=;
        b=aInlolOb6N7s+DeELeCe3FzmbsNG/EXElX9Age9HiKkAtaAfcqZ1nXyFtnz3GqR4FX
         m8RIVQ3kLA0KZvwuuXoQWS8er6U7wgGZrN0CFn4WrkoXrzbCpITJVD2IiWqQAwjgoNIV
         Ls8QgOimwwWgiX/YW2h5s6QKaagp0fljkuakYN7j9WdpRtYlFAHswcukK6vOix8++XHC
         HJDCwRMwbNMHMHxiUfzDV1vhoM1By2bywhZYAoaPC6Mm8tDMGstxMYYrOQjTtkImvk7A
         nYVAgGlJV+Gt3LK7zxKUGIki58jY+DlzD+mI/Wv0V7Ot9g0Oa0u8JNVuzMO7NV6pQD4z
         jdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950330; x=1789555130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o4imwOPLyjOICYmZIRccp/He11m0CyfxnZxzyx6PkSk=;
        b=ctBlk9OcEZPlX0Q5ybrytvru8hah0hp3HbeiUUoJIkYuYCmFvUl6h1Usjgw3ABNLtf
         zLupf1vudgV1pEAOPFwSnmqIuKxN80WRwkOy0nmeJzCSD/fFPViBatOgK5DdWnhc1KcV
         s6QKxtY1fA10rod69o1pcNwnWXXnuCh+dP6fZ5yAQvrrLWoWcXWd5Dw3gK+1HwVnqtBE
         jwJmbtJ1tHmddENClfXKzgywGqw+Pkg5MDnlmN8NGXiTP6S5B1WTYEkLtJiSnGtRoFaI
         tNTyJfJqd/aCyKC30a8ocKzhSavZyGDZ/RiKYYEE8z85u7RpzA4U8hOed+JNGDQ0ODdG
         75qQ==
X-Gm-Message-State: AFuF++ntrmHOEZ/TAWZTcXsHRo1zxmWGjr4mW1hCzM3tSt2AyB3kG3xd
	bgTd07tfpXbS8hziDusuhUogH0G1A3oJMVgrok6YGz+RWDHoFLt1RlBpuMBgr1j5vJvooHkSz8e
	GbMqJKqahYpHhRWgnZndhgMklu1j9y736dnusF9paCWtOAx19dxpbIyAKwFwxLzZUWhQDnas=
X-Gm-Gg: AYBFou3HyhmInlRsJgzMm9CCfbP1L2g6sniUqHzXJKYQ4mIUswuwuE/CBhaKQdWw2pe
	IJePpL9zjMp4fHEshmhIBy9l20GaNaZlcnn28+FUZwWMO6VjgTTAlhCZvwl+8QFggd/ZvQq77OY
	fUq4e+sXirEb0M290wO5SnMvd1HdCc+nQrDJSA4TQmEhcqgvtPrPvJ7lDevxLANjghEJjgPUVRZ
	Dk9SErqvjGqrvdmb2jvag04GtW/VFQ2MzVdUywQuJNCU3enbJHolt9/CyEqgtAWKoXUxRbHxawO
	Wcx8re9NCrCQT7Xqw4KZ5VwtdI0xjD7c0j0zdwdI9bLk5eqO2Hq4YqNxn6ERbP3Qwl5Sh4Boqnv
	FyIUff7WrdRMzF2TlVOt7d0llU32Dy2CPVBW6kzGkfqUjtQzQPJbHzrjWVK6AyNS1tW3jV+U1Kn
	QWI52cvCamerhtow==
X-Received: by 2002:a05:6214:4287:b0:90e:7bee:9a6c with SMTP id 6a1803df08f44-9103ef88de7mr461331056d6.19.1788950329698;
        Wed, 09 Sep 2026 03:38:49 -0700 (PDT)
X-Received: by 2002:a05:6214:4287:b0:90e:7bee:9a6c with SMTP id 6a1803df08f44-9103ef88de7mr461330586d6.19.1788950329284;
        Wed, 09 Sep 2026 03:38:49 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040694c35sm140245206d6.36.2026.09.09.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:38:48 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: skip alias lookup when trimming non-directory caps
Date: Wed,  9 Sep 2026 10:38:45 +0000
Message-Id: <20260909103845.3959496-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907212325.508739-1-max.kellermann@ionos.com>
References: <20260907212325.508739-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK. Please respin.

The skip-alias idea is still worth doing. Please rebase it onto
current trim_caps_cb (after 6b039a71d37a "ceph: keep the inode, not
the name, when a dentry lease expires") and keep that later prune
path intact.

-- 
Alex Markuze

