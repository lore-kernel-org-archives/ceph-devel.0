Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23420322B7B
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634291; cv=pass; b=b2GmEUfm4pdbY1r9pUhLLlmWjkLsTnqQ5eSfYtnBy/0Wpwu+jpDHflHa0bfq7AOKI4fnnKDxvr+1R4aerGsrEN1H84Puzq/7Z9zrOddvs/caWcQBqXigAD2GJiAOUQKdY/HatOCJ1WWdJ1vAML8f6zS0vIGM0K1D2u1zCpk+s+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634291; c=relaxed/simple;
	bh=1tw8rxb1GuOoCN0wlxjcsAj+qs9gRZdD4TNyCtxunzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QckWdGG+5eAWNgddK3RNkPeA3eQKpwNW+c1Lz7hzHVjDlraoYilY37+6rIF7DCfFKl3MH+k59L2WqSsUZ8k1P4XhdomxwWMmnW2sveSQ1C89BtSzTFNp499+PPGw3UkfLEKVItxUHqFRhHFp8O6zQ/wYqQJtJMmaGKvEbUg/Cc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de4DuHaT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLp11ugg; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de4DuHaT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLp11ugg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769634289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
	b=de4DuHaTc0OKGeVRxjCHscwYtJwUWZiOx61GI74KigWbTWvfMlwytJ1rSNLbtXVwOEh95N
	S1wN4PQiRMHffINWRVoP7jGS52tSmuhltlcRb06QnPM4LPBJDqZOa5gD9Y5DdAeQ26fhzA
	gZabT0Cc00/9+f1dfyCgy/v7K8ienGA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Vc509OptOpOGi4KTukvKdQ-1; Wed, 28 Jan 2026 16:04:47 -0500
X-MC-Unique: Vc509OptOpOGi4KTukvKdQ-1
X-Mimecast-MFC-AGG-ID: Vc509OptOpOGi4KTukvKdQ_1769634287
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50355952ac2so9550571cf.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 13:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769634287; cv=none;
        d=google.com; s=arc-20240605;
        b=H9fAWnxGNZr/dpv28YCdk7tH31n/ej7K1rt7qbVojaSg+fP4p68IJszZwSt8rbRXBM
         kAGdBw68TK0RXLh4hnxjqOABSM8Dh6ak9kHROTcx7BqCor5q/OH9xzBl3CkS0n/kCIBj
         aayK3Tm/HTAJFFj5X1HtSzBZdjyy7iCAEdmTOdfRhHHHYbMvFOmPevZAdtGDpS4h/7cm
         xekRJ3exzAhwuHGjlu2OlXCZL2cP6SCKHSN1OTVinx4zDeLucBWkklf4N90HlV8wpCIg
         umx3PANYJZW45lstG2dp58WsCU3sSKvbqmgNV+Cm3eK+jyIotI7OM+xayBCeVrOeLHLB
         hR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
        fh=vopScuzGpLL7iUfSj9MI4vopRpvozIyjA4NHaYaKMCk=;
        b=X3J0+G75QPSN5Fz7+SG1nTGs8ruWb0xIlpLk//rc6fxa7W3fJY3XGjDs+zbJOcIMTa
         jC1R5Q78AQRkUBa8P8K6gZeb1CnfMGMEk/Hm8bX7++MtNsy4y70uq5rD8aQA+Y3iZxo1
         TrUeKI/8fcZzHtIlAbcSXDEjnik3aTlO0DgqByKoyj4BFrvL6uKV+HIgsFbC11AP9ChU
         8Z+u5LrNKjvfmaxUMKHg4ZZ8wrpGYvoDON4GpKQj0nRy/WCjppV2/smKx92I6cF41X9E
         Y21C1PYdECaaZcH9RbqBktnoNDiipwXPNPUfYPGcFXUcVkP0R51/vnSCjNnReKEhv1sK
         VUmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769634287; x=1770239087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
        b=LLp11uggIgkapT/dBlvre4HZI1xUSfEV/rd1cN12ytm1icK4HUOmYRnEXs3gNT9sQO
         mdHZhdojTcDpK2O3LljwZQmku/Yh9ktk6G/Uu/HTSiQAmZ8M7eQYBpsVr13epHLAL2a6
         bNbqRCetre4Nz5rFxQevwSwPC4z30JPt4I2jbtWpHJVTcN2y5Ki1WHXHgOgk8zmqJUKa
         AwY+GrsXiW4PKnA90gU2cB6xDcNiM7mBtp8v2Yq3ulKPeJIfHWBh3MPzRuyVqJn23DvG
         8Dpu7Cqg4MexrZcgVMxa0/Wab/ioPSL7w4l6sSizH1ED9o+uv6P30+QXDePnOf1Zgptr
         tXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634287; x=1770239087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSyZFhDYkhERhl5uxyC/RBX/tFaJguEWGIA1mpdbxjs=;
        b=SuMiItjJft6hOOHzrnzFiAoEkkbLY6gYiu3Fzt8DuMT3BDCai3knmDgA/QgsVMHlo1
         a0/4UG4VfHF9oejlWIpkk3ldA+CgxrFmzi68ZeVEvnbmkei6EFi0Vs2BCuMoYu/dayVp
         ua4957lxaH87BIl4/+h1sDt3DSsgZPhsKLIbEfJkNZ6mk7m+FM4e+OtMW/3MV6+f7Hrd
         e1j209uRX1LvT7C0Kv3b49SRDtd06Rx0SoTcG4Df4TIl3ow64I7JkAVfdA6NtRLH3kA8
         2IpS9gdiB397cBUzIiGfsaK6buaX6cRubgSCGWAWJjmWb9j78GZgVfRJFPVldiFoUw7R
         SsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFy2wo9YiR8u4K6SWZbMI4fKTQDydrYj/uXtKJHflamB22l14UVI+YbLp0p3bBVlU6N6DicOKv4b08@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0yu8So3sGTC4PbUyElvKQYUxvHX3JBRGR57x4ak89aENG3mE
	sj7vg8oyHTF9dqE2s31ZY2D0VGTM28hjGdl1mm/X1TwOpuT9XlxOO8yQ4nhuMWOg/0J6vCcVk94
	0xdqW2iZNQQVyJuuIN/uLBNKU8hWmfL8s1wJksJNkAqeTQ9TJkQ7b7sb9vddNxH0hc+xph5k8sU
	mg9SC2yKZBwr2ysgLU8f7Gl2nutkSm9Wfmd6IsOhwWQB11Sg==
X-Gm-Gg: AZuq6aLyjW8Fy91li5PmPGAVt/qkt6GF2P/ZUt0RBX1PM8sXSmxfmxHI1jmsylBukq7
	CqlDDNrvgVmPFUmyF2X4EraJxz3p58ARFdT5sIQqGhg2MxekqGvUGM0HWHOp9TKcUaAb+0/d/0z
	dVSLGMXdTy87JKrZbGb+vkgUWsbfgA3s8dH2u1jIriGfftQK7RAM9jjXm7Bttj2Sx0VbOA46TUe
	mhDZvHdCSw/K0SXk7g1gLBsWQ==
X-Received: by 2002:a05:622a:118e:b0:4f1:af84:f1f8 with SMTP id d75a77b69052e-503612676e4mr11419461cf.12.1769634286793;
        Wed, 28 Jan 2026 13:04:46 -0800 (PST)
X-Received: by 2002:a05:622a:118e:b0:4f1:af84:f1f8 with SMTP id
 d75a77b69052e-503612676e4mr11419171cf.12.1769634286428; Wed, 28 Jan 2026
 13:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
 <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
 <CAOi1vP-CAYAKykctYWAQNab7tU93nQQwnobBn3pJw+ZqUJCh7A@mail.gmail.com> <764e96d344ad558ff0b8620b29a427641d52d85b.camel@redhat.com>
In-Reply-To: <764e96d344ad558ff0b8620b29a427641d52d85b.camel@redhat.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 16:04:20 -0500
X-Gm-Features: AZwV_QiLtV6QPz1gjrKz6Ps6NoTyd4P6i05_Yuzl6K9jM28Y4tZcYnfU3Bx6AQ0
Message-ID: <CA+2bHPZMdGPi=g=oXFS38444D1sn_pyg3BZ41_HkZssPET6D-w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 3:22=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Wed, 2026-01-28 at 19:37 +0100, Ilya Dryomov wrote:
> > I'd expect that the manual steps quoted in commit 22c73d52a6d0 ("ceph:
> > fix multifs mds auth caps issue") as well the automated tests added in
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_ceph_=
ceph_pull_64550&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_=
RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3D-RKqmT80mqztmazmh-jahx70DEvPkJZRpkLlPXPBvbDd=
utZZKxyg6BDU5Z04AOF7&s=3DflpYs6_1sBk-MBf0SCwdyOABcYR-h7pBadLy1SLyaho&e=3D  =
would be run, at the very least.
> >
> > On top of that I'd recommend devising some ad-hoc test cases for
> > CEPH_NAMESPACE_WILDCARD and mds_namespace mount option handling as that
> > has been a recurrent source of problems throughout all postings.
> >
> > "./check -g quick" barely scratches the surface on any of this...
> >
> >
>
> So, it sounds that we have not enough Ceph dedicated test-cases in xfstes=
ts.

I don't think Ilya necessarily cares where the tests so long as that
(a) they exist; and (b), they are run regularly. Perhaps these tests
should go in the cpeh.git QA suite?

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

