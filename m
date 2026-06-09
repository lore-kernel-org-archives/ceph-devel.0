Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D11E492D
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jun 2026 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046250; cv=none; b=PnpSvs+F/9f7vQDiaaUB9hV/13nYwX65xOUp0EfIkWe1rHdwwqVgo0OnvmFXpURmoQUPBGWGuhFrytphbASO7i1pPxr/ujHiVZ50hNMEYjGVtGcj7A4BZs+eWLPjww66Nav2QucvqxgJQzfAaR0sWJqq2ZEVJm1XuM7CIbNDMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046250; c=relaxed/simple;
	bh=frk8YsbVVZ59W+pOrN0FPvPVFDQF2wGDYJf3km/zZBs=;
	h=References:In-Reply-To:From:To:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KvorHPc/QB8jsm0va1BHxcsmjPSDthu16kDjEkbb/iLCb+l+jU/P7R1YqNDZHeAVUu/IEAhxNYWgK5YZBqy+MzMtVV433Xq2fwTqS7xaVF2l+LzEBoaz9KmHENwM/0wZ0CbzxkQG8/ao5i4wRnQiqRSsjXc0K13/QLXXRlpDf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=weblinkconsultant.com; spf=pass smtp.mailfrom=weblinkconsultant.com; dkim=pass (2048-bit key) header.d=weblinkconsultant-com.20251104.gappssmtp.com header.i=@weblinkconsultant-com.20251104.gappssmtp.com header.b=w0TWxSxX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=weblinkconsultant.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weblinkconsultant.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weblinkconsultant-com.20251104.gappssmtp.com header.i=@weblinkconsultant-com.20251104.gappssmtp.com header.b="w0TWxSxX"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51758478240so30440191cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2026 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=weblinkconsultant-com.20251104.gappssmtp.com; s=20251104; t=1781046248; x=1781651048; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject:to
         :from:in-reply-to:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frk8YsbVVZ59W+pOrN0FPvPVFDQF2wGDYJf3km/zZBs=;
        b=w0TWxSxXlS1t/M0l7ym4Y0TPn7ZiYdgVUJGJvO/EjPlnuLBw5aOFEOcgZu5MEHCusf
         b8sALPI/bmbMM+aYWggCDxt0LhgTbvfooPMP28biOMIOL0/pQSq61U2W7nSoQt54t7RN
         m/Ozf8RNWa9rNPVGeap5T1qn41LEiAxnJTslJitHgkCQQtW613JPlgehM5z6i1KL64xa
         z/S+R7Y2IH078V9TMpMcpmD2HSNSRx4oUefC0CdSdO2sw3/xfKCeFXbfDvirchMV6d1q
         PbAebfnpsHZYdpn79YdtKdDiTWNP6U+Cdj5jjI6Wl7P9adoe8QdrxDeQZ0kgVsMvuKF5
         i1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046248; x=1781651048;
        h=mime-version:date:content-transfer-encoding:message-id:subject:to
         :from:in-reply-to:references:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frk8YsbVVZ59W+pOrN0FPvPVFDQF2wGDYJf3km/zZBs=;
        b=Uj2H65eQdKiMNXbqwv45/r501rwSRciU6Nu5v1se6JqwVo1+HREVpPUFneDsDflVp9
         LEdUdBUfy3bdsj+hpB6VVH1kp76TZ7bn1jVzzLD9dX/iyKSZvRsbL/o5WB0praWtN+99
         dsWGUbncZr0sFmXe+0JgPYK2qj8SunCCiQpUTBxGst5MTORbucflLTRQCfZ29Xg3QMtE
         LkGOnjsBtIBn3Jh9t+4b7EZZQ6bfyD1WBtzregS1QE9ucw5FsUQ4nwetlxvPMN7ug4xb
         ja/nP5b9n7d6SynwROWfv2KEoUX/6qu/EdrQXbQmJMVr8+c9zPhCY0fAfO6lVdG7Q9u4
         i6dQ==
X-Gm-Message-State: AOJu0Yz9B6bxYnyuMKZ1T/X8ORbqLVMtnILmOdBUVgps0BSWrf9PBwO7
	qt72NHorKs7QgauQH1N0VphfUl0UobPC+JA0M+9hMzOC5O5HOBijR2BPXQ/XU70e3+d3mDbT3tW
	RrydHnuE=
X-Gm-Gg: Acq92OGuOHbuHvN3cpb/0JtHeHKouGGL1eCL6s438XcxSiYMRTSk/CNH1df1fG851bC
	Sz3SG6SPwpXDaE3W6V0JOO2fnEIfIct4A8qGWNpsyTh/SVph8kn7vOBb9DCBhCcZQNx9Z7N8LrB
	T0GSbjTWNbSsZGLNZJpZM2g6qnTb/Fwrr2ic91ZaNHL/BEKRwZicFuwj5OL4a0Xo3l3ArIwifMq
	VW7qLcy3yMQDdQl1AFdx2VykGcb4/LYrV/43YAGk542srSkYv+uD3doeqrJsSVy1P971WYisG0K
	966o3lsBmmlzDubR1zmYNpe4F0Iv9CtEiYZuhGG9Q2PKz0iyCbrzW/fnjFWnMr1LUN1X2wyYDhE
	ZsB1ehZjQKVTnh1Bz8wsINSGN4YWoWHB1nzu7QqOd04dcOk4t+K/aGQk/3INltNhsu4kyGxQeAp
	5Kk0k0jfjVBhkpz6zZ7sVoRj5P1Wv8HNyE4cBMckM/x6dM8BT3qjcKxCpry7bJPo2eRnMNSBYBN
	r+moDY7IEzdFw==
X-Received: by 2002:a05:622a:164d:b0:517:9afa:8f93 with SMTP id d75a77b69052e-5179afa953amr317456651cf.46.1781046248161;
        Tue, 09 Jun 2026 16:04:08 -0700 (PDT)
Received: from [127.0.0.1] (ec2-32-199-165-46.compute-1.amazonaws.com. [32.199.165.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2682f8sm216308946d6.43.2026.06.09.16.04.05
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:04:06 -0700 (PDT)
References: <6584ea0f-269e-95d4-7839-139b36c3f67c@weblinkconsultant.com>
 <29e8a9b7-84a3-0bca-c4fa-381bc02469d3@weblinkconsultant.com>
In-Reply-To: <29e8a9b7-84a3-0bca-c4fa-381bc02469d3@weblinkconsultant.com>
From: Ruth J <ruth@weblinkconsultant.com>
To: ceph-devel@vger.kernel.org
Subject: Partnership Inquiry - Link Insertion & Guest Post Rates for
 ceph.io
Message-ID: <f48f89b1-4d44-7907-6c0e-1a9dd54092d1@weblinkconsultant.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 23:04:05 +0000
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hello again,


This is my final follow-up regarding niche edit and =
sponsored posts services on ceph.io.


We're prepared to move forward with =
several projects and need to confirm our partner rates.


Specifically, could you please share:


1. Link insertion: $?
2. Guest post: $?
3. Link validity: Permanent or time-limited?
4. Link type: Dofollow or nofollow?
5. Sponsored marking: Yes or no?
6. Guidelines: Any restrictions?
7. Grey niches: Yes or no?
8. TAT: Days to publish?


A quick rate sheet would be appreciated.


If you're unable to collaborate at the moment, just reply "no thanks" and =
I'll take you out of our list.


Awaiting your reply.


Best Regards,
Ruth J


P.S. Need immediate help or have quick questions? Message us =
directly on Telegram @ArchSeoSG - we respond fast.


P.P.S. For every reply&mdash;yes or no&mdash;we donate a pack of dog food =
to a local shelter. Even a &ldquo;not interested&rdquo; can help a furry =
friend.
