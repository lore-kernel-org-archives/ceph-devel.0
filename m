Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57455392C21
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624305; cv=none; b=eyElowAb/6TszQiFo03DX3S1eut5RKnDYXDM9VY/oS0iaT/XtALHKM3E0Ymz4D8eUxnO+kMw7m2UEnzO0ObNwtvXW7JNLIROqboFjh29EtvoQhYRR10zS9Ay1lOlYEBf/NaSq2tpFc74HPJmegIeAFYxDl49C2gqibvltr30H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624305; c=relaxed/simple;
	bh=2yTULJDU9yjrb9OjJjyBogymcDFhC+YPaqY351jw+9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odw9HOYSoeW6e9LHNYY2MYml2+0ealNERqAwPFyimsjJcQpqFp2YhlgScPx4cRXJD+r246wH3Uu+kG2jexwc9mndPprYRj6cqnIGve2oXVBGIC5YAnXezStbrZsU5/AN+c6jut4yjDeZgjiJDYXG3grvIhJYWhqgLT7KS/9fZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2CGPfvY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdDmCfH3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2CGPfvY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdDmCfH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786624303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yTULJDU9yjrb9OjJjyBogymcDFhC+YPaqY351jw+9M=;
	b=J2CGPfvYZJoZMJfrHKIC93HwOZ2ddXJSzXS+anvyTRWompemcL1UlAIfBnf1KIqNxLArRn
	xwHT9x4NloJvBaw8C68opFcvHVrOL1InGfDwDJfMkHxBBKbR3N6S5xCguUmydwG+v3LknG
	inWaVvTnTri+dupY3V+HUCOaKJkc6ZM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-OVba8ZnHMoyFtFUs-ppaNQ-1; Thu, 13 Aug 2026 08:31:42 -0400
X-MC-Unique: OVba8ZnHMoyFtFUs-ppaNQ-1
X-Mimecast-MFC-AGG-ID: OVba8ZnHMoyFtFUs-ppaNQ_1786624302
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907c59bd65aso13579696d6.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786624302; x=1787229102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2yTULJDU9yjrb9OjJjyBogymcDFhC+YPaqY351jw+9M=;
        b=RdDmCfH3U7nwhOMRltZ1NP42ZgKTvnPD8vgBiPEfrzx6T5bLmHZRnkZw/dP8dygO7m
         uQYwd7BJI6RSfCCGBIbQ1AghVd0u+omCDuo9aoWhbMYncFDTGSCqLuEuUwN3XZZr0OVX
         Gs3EHnKXdKkYfYeSFOITiXohPTHofyhmqZgczLluVdYiJwUoO6CiFQ/kTxuWhvF6/WUK
         ZjF9C99nWcWHkN4xTT5261Agm3TIdbJdnLKi4891Kc6tPKih7tfUgjpCe/UkasVWy8Fp
         HcIHBq35krJfse2PGfqg+s3d+3BR97wLJUrCNU63eUO3xHufvV28tpMC0UksxV+dbcV2
         qUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786624302; x=1787229102;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yTULJDU9yjrb9OjJjyBogymcDFhC+YPaqY351jw+9M=;
        b=Rw/Li5K4MOp/rXr6Dq9l/P7FuZDoY0UWtAHf8L1UeIJt6nbqleWhDITXpUxUkHNLP2
         BvpzjaiG6qZEEj2jl5c2osszFBmrOXelVaf+IlAwc0lCcJqx+Yj4bmrn9tQvqYsVHBmJ
         0MNYAgsPlVLESI250RSgKoPWkidinC2AculBD5C7yf0VZJE+bWYfAlVIchS8ipsorI5w
         ZAAdQO1hRGKyj5oPxwhM/2jxiH83o1a/7/JuTOGp5+ZVX+d8SOUED6Nx4yIsxCO2xsf0
         EmBi/RjwlRySFEscCTIKlQSgsIjB1nbC+BhTXcxe0dMow4YvoDfdttBvFFkX7fXuouGF
         +BmA==
X-Gm-Message-State: AOJu0YzRqpfZL7p9Z6vifGXbGE+hRfTi6zYkBZqQpmpc8xpFbv9/rw/P
	Lv/39eEMV+gznBGN51YMJZZ4qnf4IQoQq52SGPbjEI3NPvQdkfQrUoTcAONhHgN0gbUABNHOxB3
	5PTEaGnPkmTlsjWmnevwCZ3v8a2/1TRRVkagWmVdRzSPP+b8RqDvI1h7lr0UdMDec6ZPIQF3ydQ
	==
X-Gm-Gg: AR+sD100JIKRpU0dbLHVbBYu5WZhACbcIgv8RdQqUeeMK8LM79+D4oxx/uzSVc3+ji+
	B5dgZS2Qrp3JdhgjJw04C9cfLGfFTsCC8rW27iKSC5AcC2P3e5JTyvx5EI1tdztvLnI16k5TPkr
	fg/rUEum0tDW1u3rGVW4ocmDNLjD6UnSU8WVVcJQouYaJ78dx+ZmSiFAinuJ/uPgZN6DNhn5Ct0
	pV8KgOB23eeUCcrcRv5Xld0oaf0oT3/BSbhJenf/m5cQRVSVkHRP+pxyq41xLFOTtlu5ofEWo8u
	wuxW37B1ZB/tdySp4LgvliWpgHkI6C1vLpmDXNzOc9f5G6xQswT0Lao/WU2KtO3d9PxRzBEgKwT
	ttSRvnmIMU2LKzElygYUH5u/FKmzDCrWlbw==
X-Received: by 2002:a05:6214:3010:b0:908:23fd:813e with SMTP id 6a1803df08f44-90a80c20669mr53627466d6.18.1786624301643;
        Thu, 13 Aug 2026 05:31:41 -0700 (PDT)
X-Received: by 2002:a05:6214:3010:b0:908:23fd:813e with SMTP id 6a1803df08f44-90a80c20669mr53626566d6.18.1786624301196;
        Thu, 13 Aug 2026 05:31:41 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a814a9c06sm14188706d6.0.2026.08.13.05.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:31:40 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] fs/ceph/super: document struct ceph_dentry_info and its flags
Date: Thu, 13 Aug 2026 12:31:37 +0000
Message-Id: <20260813123137.4005275-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812204920.1805545-1-max.kellermann@ionos.com>
References: <20260812204920.1805545-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

The /** before struct ceph_dentry_info and before the CEPH_DENTRY_*
macro definitions isn't valid kernel-doc — it generates a dozen new
scripts/kernel-doc warnings where there were none before. Either use
a proper "struct ceph_dentry_info - description" header with @field:
entries, or drop to plain /* */ for the struct-level and macro comments.

The dir-lease time field description still says "last touched" — that's
still wrong from v1. It's the insert/requeue timestamp used for aging
against dir_lease_ttl, not a last-touch time.

Could you respin?

--
Alex Markuze

