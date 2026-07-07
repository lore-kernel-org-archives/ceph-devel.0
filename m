Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADF2E03E4
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431764; cv=none; b=pxsgKTZ9/YJuiEx44UVl/5BeOLqVHiu/HnL9CO8yMugHA3KMI5mT58sIPo04FKYeekf0Cphmf8tuggdr2IINN0lfBxdwtNSnnkaiqRUBXF+3Ux1xWZEl2sZfsUikG1mR7bJzUFsi3GMvuO2rfnshs3ieDtvYHEnak0qIcAHV5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431764; c=relaxed/simple;
	bh=2iSqJrhybkl2X9Qzkw6+JnhCIcDlGA613iANe6q7Qb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmFlGTGbQENO7PPsQWZtWf7XiCDJ4ZV28/Rysi8jKBY09UwXrcdAnFQieFCq+O+6go+Tc0dhj0V5kMqWFaux0MweDNIY2EN5DT41CzEg5HUkSI+TKx6WdVgtlqPznUqAHoT5TIlv1v6wP0K+e0qtxwz/1XGY+EcF4Ki6O3rbC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nu4ZH4TS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ozUrglX5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nu4ZH4TS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ozUrglX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783431761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th9p+kXXIbFIPhMusnRxzwc8SwStagvVDkw1qMpNP9E=;
	b=Nu4ZH4TScpTtaT3cyJ7q/k3jOU2JVmHgqm9g+I6J9VRZY4H7woyx5d6pLeRlu1sGQOaCGH
	RPEv6G+i+smim9PAfZtDrP2++KTRIKiDZgC6WGT07liGQSGP3MRVKDZCe8lFXar1mwAlkv
	o4JAQ2Da/QWd6HeeFqwGZnHCwI3+6xI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-keyvCz60Mbiat6VmDjB79A-1; Tue, 07 Jul 2026 09:42:40 -0400
X-MC-Unique: keyvCz60Mbiat6VmDjB79A-1
X-Mimecast-MFC-AGG-ID: keyvCz60Mbiat6VmDjB79A_1783431759
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6983880a958so3515136a12.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783431759; x=1784036559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=th9p+kXXIbFIPhMusnRxzwc8SwStagvVDkw1qMpNP9E=;
        b=ozUrglX5Gjfc0ejW6GIdAPov+DVSDslTts6xAbeXljcrfeytRc59WPq4U1xwH9Gh6J
         O8S7mJgYSOZy2RJInO+c5QFvuDVjgK+757QfSOtdsio3HJXbw5dRCK4t3EW/k8FBvbkf
         yqnI5uL64T2+j3q3tAqIaW6ZiggJXMA/0ZozolT5Ma9X23QubxnvjxGtdsD9FonoH4oe
         shAjGaA9kQrw90j6vJbZAa6VsNotoNR5aHLutShvaNvOU0IMUuivbBdL/YL+OvOtJYol
         r7OF/epWPZr1ggSAfnRNWgGe+ty6nLhIoXZyPF/Vqf3Mg4CnXbTAU45B15Xl2oSp5Lw4
         JhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431759; x=1784036559;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=th9p+kXXIbFIPhMusnRxzwc8SwStagvVDkw1qMpNP9E=;
        b=MqOvmom3zE+TNWF+J5xFoLLm3T5OtMrdguDAJAZ3mIcXl2wwEpYxT9+ikFocRvvDVB
         3reQrJ/hQvhvrHqBTU8VattiSpPBDTB3F83WK5NhvqPwzGJSlJdMIsVBpVenrGZjhFJd
         rdu6vFpbTo/XQPZkw4fXGcG7xd7urZiVPp6Z9ZX2ctJmnXt+4QPX3DHdKIKpjVnZxJ/K
         JwxN23wFnwVzV01xAtg+4vWmpqRtReIMMZuxvubrgh3DG8ictLRqNd4P3gBkgQXLis6g
         G0C4gyC1u5hKQZ63kC9GoWHE+aAE6KNhtrS3VyFoGk9/guJJJe3kYVSBdkGXIS3R+6i5
         NUsQ==
X-Gm-Message-State: AOJu0YxTfVIREG4GXc1yVULHygHw4CqEaZxYlLQcyv73hTjPFnXvHvDA
	dYu4U4qQkOkZkrgc9VzdnOS1dMtrR8g3f91EUp4l3tA7DOhptVibKlmUR2tsnrcKEPdLzgZTQfD
	VbjmEeAouovOTYwKtdZwsQgdQ1in9V100lWU/Y0vNx4lPLawADcaqqUAIDeq4q3xG6C32y7hnkw
	==
X-Gm-Gg: AfdE7cmPN0Tkxw0nQhJaKQLecqVg1onvxPP33EOJmMwt40KB42K+OWuqkv+Bso+8X6g
	W6kzlz8rrtascei+HD0iujCTsTaretF/PQctTL1mOVuKsva8kyqFWfSwn6CS9x4I6EDmUo1U6+Q
	zaukhZq1IrGowuPOkTDdwRRVUqQuRqqrRO468Mp7z6LV52l4tH2aOlAbqBUhcvZ16xjd+5IbJ2r
	wz/9Gpra73H9LUwSERk2JPHmhcBI4iYbb5bI0u2QCG3cTcWg7OBCcrqL41Zr4Ob/x7wBXwbX3N5
	Xo9rJkG4uUor8gejH0UK7bvI+TbwdraDQzcHsJGA0Tj0AIeQMqHFAdhY19LvL3ElUi11rtoOsHD
	R7TLI8/krpuFIRWx5vr7ernxyGxNd518rutPBf4iEvL4n
X-Received: by 2002:a05:6402:11cc:b0:698:c0d8:e40a with SMTP id 4fb4d7f45d1cf-69a85c3f126mr2764090a12.38.1783431758163;
        Tue, 07 Jul 2026 06:42:38 -0700 (PDT)
X-Received: by 2002:a05:6402:11cc:b0:698:c0d8:e40a with SMTP id 4fb4d7f45d1cf-69a85c3f126mr2764070a12.38.1783431757756;
        Tue, 07 Jul 2026 06:42:37 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19db05ecsm5722143a12.28.2026.07.07.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:42:37 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: Re: [PATCH v2 00/15] ceph: add binary logging (BLOG) for CephFS
Date: Tue,  7 Jul 2026 13:42:35 +0000
Message-Id: <20260707134235.2235224-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706143843.1980879-1-amarkuze@redhat.com>
References: <20260706143843.1980879-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

The series is based on ceph-client/testing, not mainline. Patch 9/15
touches mds_client.c which has several patches in testing that haven't
gone upstream yet, so it won't apply to 7.2-rc2.

To apply:

  git clone https://github.com/ceph/ceph-client.git -b testing
  b4 shazam <msgid>

or just pull ceph-client/testing directly — the series applies clean
there.

Thanks,
Alex

--
Alex Markuze

