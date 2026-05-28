Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045F3E714C
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992306; cv=none; b=klO08oJUUBqhw5XOkufSCZfOnlqUdSxtYhmI9GK51GsT0UaeFHWsZ9VSFyPi2h906WfGQjKFJ9QiTeY8tP27sGSb1qMzyTWv4NUC+7lav3UjVpSCiAyN0bbCe7Lvaj7WMauXQENvI1W0741QZV5TKCXtQvxhMY+O85mYE+rIm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992306; c=relaxed/simple;
	bh=Z9mUKXiFMeHB0rQaBpHPpPm5OrbDjN0t7uWm4dendnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTd4K6tfQ7reHofFhsUmQ6hiHCalpbE1KO1+11DX2ObIkS/H2/V8YcCKkWW9sz9dBGWx10+4Hf7R/M7i+dPBBTsX9bRM5Q9fOmiIHLC1WcYS0ExdkznpSH2+kz6AZ/+dWrGwKszfjwSbT7G6kHE5X5gi/UFK6NvZ+Yeg2FvxQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGVLDZma; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGVLDZma"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9a1896db5so20547105ad.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779992303; x=1780597103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm8Ai00GQkKOLkj5phYZQ5dpFj147opmWg3JCHk5dlA=;
        b=jGVLDZmaD4p6pKHTGanAQTr/MLE7Y2lemO3L6tA1FxYVW64Z442JbYFY5WQ3ZiJvJu
         VvMz5KrMfnAMLuodOgr4zTrbWOvMW+Bhp5PNQCUWma3Xt/Kq3fOT6U7uuw0V/or1M4Yu
         PBu5lnFl7EajKv45iw8Hmrlg1+nK5L/GN8u4Xb5xmnttqkADb+wwiDwwaVB6kacPqb9Y
         h5SOSAy3Pr/LKt6UfGLZfnde15lzmhyM3NDJ2Eu66lXZsvHRtiZqr4Gq3WmV2BD0cMZd
         VhUm/H5YZybVtFBjDgsgglU2UmGQSTkptnnBenMrXNPvOyPrBoIera4E9JUjNpC5SqGp
         XbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992303; x=1780597103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pm8Ai00GQkKOLkj5phYZQ5dpFj147opmWg3JCHk5dlA=;
        b=N1p6eHVysdl7Go1dfwzBscq1TAcG50xfHpzs2VXqk2nkenfEjF1ncZZCC2JPeqOnvL
         wPWzwpi9EHR5qnBeFBLQxBamDKFaT8f60YvUWCc70oOQN/mnaKAVA1matY7k5mB8zQtU
         hy2+zmrZFzBmnHyVLdrs93V/V/3o89XzEHLZdo+qjVhYWCvWf7HqCAl3sTMUvvaUHsB3
         0loiFf9I0KlhJGHMddrrxr4uuGK0BAyNdRMBe6JA6tUzuhWeykBg2VoROffNhnET1XNd
         DPzZQsCe8fiPnbbK/XKLboeUvkGgKVwL3LtJQ12pOhoF0ddO+iWa63+zBAm9FUBJm7f4
         kW/A==
X-Forwarded-Encrypted: i=1; AFNElJ8mRbBv64Lnp0sbfKKBsy2D73U++jeuVDjqrtrixaFW8l4baj6lFOJiqW1bT4CsSd8YCU1irzf8cXvC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrb9DoxZCb8IMf+fhEYSRfnGkrdbidNTfkoCglqDSZV7u12Afj
	llIUK/5LHJzHNdWrkfwok06ZUfxCFKoTyKUaYuveOFel99eJo0mzvmFq
X-Gm-Gg: Acq92OGnKsFJUonwyhtQRN1kXBx2yWoVu1h8F8D7i9egXECyqfvSifR6m/eUq9ABl8j
	Ah2fmniUDDRi9GaaHEQQMYjuM8wAfBGueTtp9xI7B/cEIn4FRjYH5lp3S2ZwBB1SHALJNu/Z9kN
	6llSjmoh0WM9HgABxGtOBNRdc8KCRRyH7khA+b1RjggDy4oKE1je4/b8m/o42LmfxHNxImgTqBX
	PQc/ccqDva1+yvyqlj8CHdQaFYux1q/1DqQczbf6fqQvnPhcMmn1qDQFbbthEUvdfSebExJBs7O
	PQH+suNO58Gmj/46wOa1elL6+aRcyPBCOQjzKaIb1p2GiEx8vj4eokRWOa2O2Ych9uw8jq+OSVl
	3p0eelvIirca0CMV/+idDvT2uRAxxjCwv/wZ71fkhiBSYkbqVBHCUdPhlN4ah7zISV9zE32yNJT
	0OVZ5YS4Ccf4I3+LwZTJtiqacv82sp
X-Received: by 2002:a17:903:3c2d:b0:2bd:de3c:a026 with SMTP id d9443c01a7336-2beb066c2bfmr165194085ad.4.1779992303386;
        Thu, 28 May 2026 11:18:23 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1b22986dsm3145435ad.60.2026.05.28.11.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:18:23 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: Slava.Dubeyko@ibm.com
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()
Date: Thu, 28 May 2026 14:17:41 -0400
Message-ID: <20260528181741.880777-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Sorry for the confusion here.

The original patch fixing:

*num_lockers = ceph_decode_32(p);

and the later fix for:

*type = ceph_decode_8(p);

were intended as two separate incremental fixes, 

not as replacement versions of the same patch.

I mistakenly labeled the second one as "[PATCH v2]" and also 

sent it as a separate thread, which made the relationship unclear.

I'll resend this properly as a clean patch series.

Thanks,
Pavitra
