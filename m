Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8163C416B
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192055; cv=pass; b=SxLsBD1hX23z9U0Sr4rDUa/83clyCVOYQDEj4nkHQg/I/KcoC/QkS3OXdsJzu8WijimEl6qHiS+3RX1hyX9rjIx+21ElVeW6+Mv64Ps25+F6d2y22+y83Ech8Eyrj4lAzEr3PlQx6QlvhPufVyXQpw5whz7FRnEoQTML1oA5NIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192055; c=relaxed/simple;
	bh=rpZ2HRn8yDCkjqg/qobHlnCtwYoIgQM1/o7K0LE+uB8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lD6t0a0V/02tTLNrmtjbxdXkdWzA8oL2hh2yMy9gTYYEHb5z8TWVM2BR3HZAIN03ct/K/UgyPw7kVEFp2aeceBR68U3slxP8fqirLqIT9RwHcu242X2ovndAtY8YD+sTdraa4d2d89SJMFQPJC50TfcUqx4ViayE2r2Tmx2YARc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=aIwwgiqC; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="aIwwgiqC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1671ec8692so262427866b.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 01:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784192050; cv=none;
        d=google.com; s=arc-20260327;
        b=LJNZKiNRJCnJQ+EjFpXcBvwrZ2j7KO+S66NhYJZWJ3o4MkatwN4zcd7ixaUdEuK4iX
         p34FqLOjW0k/FqLUuFOmsLhK7D+jLJvJR/KfEmMnRmoRm5JAaTJmsGYdq9tQKyAqoDdo
         FaUvqQQuMvtzwk7fG18ZNmDjU3j9LdjlKfc56PkFDewmWvcZW2YQL0gNyR/6jkZ85jxa
         J6/yg3jYD/jb5OfYJ/VudOzClzDQD31o0Udi6w18MlhEvIF2rHXmS6v8LFaU55t+Ox6V
         7EL8Wb69ZTdiOy97CxGnOESwsV6UQT/OPD6VvIEW/R9oZYcz7vcFcfasbTw4W7LHceLG
         qFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=rpZ2HRn8yDCkjqg/qobHlnCtwYoIgQM1/o7K0LE+uB8=;
        fh=lIj2fP9TLY8J0+u4Z5gxpYmcsDjYZerPZxdPGefRbRM=;
        b=JkfD5AeaCJ9S5Ma6fSFKd/w5NzK6NS+8tM8mr5YOzsQc0Shpf6y3BCz1dAh+n+nRZe
         r6mWkuPvBiDY/bhRj8wdZDbUvmQOErEW09VWkib4Xp5RfnEU8MipF8qh/+B6aOxYf/LB
         R5kVan5vmf2o44JrN9h9PcOIDLcAZy+HEqP4d1IVmd3bD7jvLbAp2nnS0SVuXetmG934
         J5dvpJHuWBACoEw/7f9w02Z4t14vfcBJO1TliOUlH4W69YK3UlOPnRTekI9Z/s8vb0Ya
         M1ILG04oNRUomTfxS66rpLGmzDXdQfVCBQ7Q5UCc7BRueZ3fyx7ev5ZCApnExjRIcNIc
         Uo2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784192050; x=1784796850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpZ2HRn8yDCkjqg/qobHlnCtwYoIgQM1/o7K0LE+uB8=;
        b=aIwwgiqCnHlx8X3Bt/ACFBbf8K0JCYUiOg8FXGnSSI0Gnt/ONJJbbT4+oMZtBQz86m
         inI1507cJRYS/lOtZturH8jij/7CfukcWHJN2QtSzaHdstOEkOU2CUuBOKW8uxHCIIP4
         /fo7a8nNkT25HT5oA38MP8HEHUcwsyC7FQhE3Edeor2WxssojutS1e+QmeP0RGBVnaSx
         qUeUGiyxZlgZ688BNCE74I1wlYO5qjWYVjz8vsmAeE3waKqzO2TKMJ3Uaok9ONd7I1Ge
         EuNvOT8ad5ZtwVRZQt1zJLIlF+5/q/II84folZXeimFZcAAzMCw1szQnrrRnYXelwe5R
         XwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192050; x=1784796850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rpZ2HRn8yDCkjqg/qobHlnCtwYoIgQM1/o7K0LE+uB8=;
        b=Zc6+qnCwXPyPouWZnyqAiQRtE4ximuDkwnd2lYiXg+FC8fW4XtJ3z/2KClm12cyb1y
         dDE2ThVQro3AKRN4pJ7W9w65pzS0jZreD72n9O3+b4UHYiSd9qgRCMg0V95M3KGcpl59
         +Tbh2M4ml1A6PZKhEAGiYhCao+nMMT1TPXS1SwrZlONkUBh5JzMuI06BmEext1wpvs0T
         lwA0QDh8azzhjvM5JZOUb8WwBK1/vVpM2vtqkhwvByLlmdY8OZ65FikI9/x7FIqeqrJW
         1nNeGOg1/HMwwaZRXc2XkCwUruXVYVTWJO4Ti9CYetjFda4QX2n7rW94Ym9GXMs9J2lq
         eAkA==
X-Gm-Message-State: AOJu0YxKv7C5QplnipeNn6NGLra/EIQts/ToCd9yu/BmsOwm1Z7b+0UW
	hB2ne2LAKyG2DDST5boTKH6y4cByGYbESKKtFQhb1b/msMLokO5iF3xpm9oMZZo+/R/p5bTpXLL
	KNYvM+AYTdyRJeeLLxYLdiR1GdSI49S76IrAi5dq6sQ==
X-Gm-Gg: AfdE7clVuhO5jnzjo7s91bMVn1gVvLG+GCt/MDI5TYRBAuCiwf1l1wKPfe3HX4o7RzN
	DMr9qh9rrchcvRAH+0wzLA88XqoxpGBQI663MRJbH+hW0brdG3ga1d4C9GccBWHuLKFKysREBeF
	FD/iQ5GElitks+cLvc5hmT63lbMJQeprn/1vOVrdGszX0ChE5dMpfL2eujznjDW4BywaLPCDA6y
	BRbeh5ZwjoB5HiEhsKNCTr6jZnFfN9Gii7tP6vvdV7gJRZ/0206lmkq/Bo=
X-Received: by 2002:a17:907:d643:b0:bf0:2253:ad67 with SMTP id
 a640c23a62f3a-c16793109f4mr374067466b.46.1784192050005; Thu, 16 Jul 2026
 01:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 16:53:59 +0800
X-Gm-Features: AUfX_mwr1iYS_S5AhMW1IIPrEGzoUEEjjSFVp5Qc3XXmPpAI9L8P0a8GuxlSDQo
Message-ID: <CAOJNxR+9tBWfnQ3-wyBdYeJ-ipVM+0oyULtUGk15C5-xnXHqcg@mail.gmail.com>
Subject: Survey: Is anyone using 32-bit builds of the CephFS kernel client?
To: ceph-users@ceph.io
Cc: ceph-devel@vger.kernel.org, dev@ceph.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

We are considering a performance improvement for the CephFS kernel
client (kclient) that would be significantly simpler and cleaner to
implement as 64-bit-only. Supporting 32-bit in this case adds
non-trivial complexity and ongoing maintenance burden, so we'd like to
understand whether continuing 32-bit support is still necessary.

Before making any decision, we want to hear from the community:

- Are you currently using, or planning to use, 32-bit (arm/armhf,
i386/i686) builds of the CephFS kernel client?
- If yes, is this for production workloads? Or legacy/testing purposes?
- What is your platform (distribution, kernel version, architecture)?

If there are no active 32-bit users, we would proceed with a
64-bit-only implementation and clearly document the deprecation in the
release notes with appropriate warnings.

If 32-bit support is still needed, we will explore alternative
approaches =E2=80=94 for example, keeping the current code path for 32-bit
while the new fast path is 64-bit-only, or finding a way to cleanly
abstract the difference.

Please reply by August 6, 2026 so we can factor your feedback into the plan=
.

Thanks!
Xiubo Li
