Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9AC33031C
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150082; cv=none; b=o7eWkAs5IbqK6kbqjwLeQlzbwaElyx85zpTMwde7r4IlJ9wOk0k7m8yaw/EzTcNa1UabQwzqNRnGHUUKeytI1gaFBNSgbqPkwNXh55Kzsztr1fkmq/1Mwq9va0Rvc3UP1H2DpLgzWd/eGJ5b9TleHLkmRI7VHTM02vAQS0wVqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150082; c=relaxed/simple;
	bh=YUVV5r6Rj2+lifVBLCv26L8g4xPnTIBA5GAEh/PWfRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DiGsT31EQ1T9JR41tcLe30CwPe1jhbJWKZ2P/+znROy9I5YNlS/i046VI1cO4tce9r56uNxb/F8Y+3l+wx+WKn+GKGm5mvI/2NBH/keuhadXBcXrsNYyI6MxjR9OdHPTHb2NbFc95nzQS8giY8W22jQxNjgGpdXg6v3YIrYTlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=FDEURRt7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="FDEURRt7"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39697a4e16cso71427261fa.3
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781150079; x=1781754879; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YUVV5r6Rj2+lifVBLCv26L8g4xPnTIBA5GAEh/PWfRc=;
        b=FDEURRt7EqsTsbRrhNBWkTAEn0sC1BcyzGs/QST92fMcVH2+Nf/pd5ya077al1kQar
         rynIZpBbIvRkeauOtDpA71+86svY5iSUwFAv8JeVsbnqeU6utm1x8afh2LaeREqiPjfe
         912DjAWxERN/TERDrgxe9HxQSMj3rd8PEsSJKuj2/foDpraW90FqF/9jk9UEQLcswRfh
         Up70UapOa87DJR1QrbCLDiKfMXQ/gKJ7dP+yLj8LwelffbztZQ/qPCTKxOxmpmKpOz+m
         GKv5fc/0/c3f2jDrlk5pICdRspAQ7Y5uUH9om5plNYqzF0vDSZ3o5f4VZ0F/f1oLR6+d
         Q1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150079; x=1781754879;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUVV5r6Rj2+lifVBLCv26L8g4xPnTIBA5GAEh/PWfRc=;
        b=JkPgUgPcL18J5dC0SiktbyIuLp6HDbcpVSNu/cex3XhTFQ/mHYeNtDlM16sl1AqP3k
         M50Abfsk1eNxYAyew2X6sgO1A58GCtDhH+agS1rIHboA5pPqhk90S2tBMeG7g9Gx3GSK
         Fnxfo34Vy+mflDDRzOSONcqNfbm5J7f0JZS7/YmtSuiQ6tBGLr0uJC8wyBQLsTjlnVuq
         jvEF3q44tNCID15xZCTWCS6qd3jYL2Vxw8e/XZ8wSkD8Uc8csCIuAW3vccIwg6owzM6V
         sxL+t12/6WK70GWVCfVKt2cn5ckFq6jzJnp32qtbzM3b9KlNB7lkPcymsJuBhHwuQSVi
         GC5A==
X-Gm-Message-State: AOJu0YzGrRl0kwfHHxee/2wd5iKbhKCP/tFbtbIT2r+/0w0s7NQoFuJp
	v257uyM/AFvYAmpSuzmuSsJV9cnNOxuR+5dZ62oRgcZ8SxBcSc7IFSKRm7xz2LypWztNMg5wZOA
	wV/+2wjTi7A==
X-Gm-Gg: Acq92OFSJDQImYt327llrgAx9TF735lzDWnF+gey23mHJbI78Z6MT3BoYSDfPgM+UP2
	EdpHXB5mRIIGhvoF2ZzVjt8dlZZsxWk1XZKiYhAG8Ep5SidzMEDBHww4ozyNZvHd6KvNaydTvKy
	6/MTYr+GmIFxmCvj+WBk2XP+4RmyAu3MEthCiidXHIOCqKm60YCmyXG7E/aW1fkXgWFz0c28T9d
	h6weZkhcnHL5ZJwKEWg/AfTDia8YS/qlVQxv1xdrNrqu93Ztgz5nk9dxf6HkjFAAn9lLMcCv6Dk
	ukrDvhIfrH1NR6y4hEjZLbSLBvXh9HRNpJ94W9e+WIJB4Wd0Um9ZtkEoIk4YFExMqVkWYvgqPd0
	y8/guXklWk0geuJkFxFERCbt034K622yEEiwVVh8BvjyuroXwzsjIdyvyzVuRPKTUgEXmQaS9Co
	huVawtxCMSYRw31EYlbTrD6Am4/j7zo1DGwVS8ReecZj5aa+xajJZthtzMaFYR+yKP/zQf1e0Hg
	JfTGWYauA2EhnxxJWBL4TR0YFMX489nuCmICl0raQqfQb5/n1NY+odGatqZoL9ML3Q=
X-Received: by 2002:a05:651c:211f:b0:396:7e35:f810 with SMTP id 38308e7fff4ca-39919ec8719mr1931171fa.0.1781150079318;
        Wed, 10 Jun 2026 20:54:39 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991ad911d7sm1030371fa.28.2026.06.10.20.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:54:38 -0700 (PDT)
Message-ID: <347ef54d24d5c215c7bceeaad794729191da2761.camel@dubeyko.com>
Subject: Re: [bug report] libceph: potential out-of-bounds access in
 reopen_osd()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 10 Jun 2026 20:54:34 -0700
In-Reply-To: <f26c5b29-f72d-4c7f-a87a-0aa5e53cbfbc@tu-ilmenau.de>
References: <f26c5b29-f72d-4c7f-a87a-0aa5e53cbfbc@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-08 at 10:45 +0200, Raphael Zimmer wrote:
> Hi,
>=20
> I encountered a bug in the libceph module. The bug manifests as an
> out-of-bounds memory access when attempting to access the osd_addr
> array
> in an osdmap. The out-of-bounds access can occur in reopen_osd()
> (net/ceph/osd_client.c).
>=20
> The problem seems to be as follows:
> An osdmap contains information about the OSDs in the cluster. Its
> array
> fields, such as osd_addr, are allocated with a length that
> corresponds
> to the max_osd value in the osdmap.
> If a Ceph monitor or OSD sends a new (incremental) osdmap in a
> message
> of type CEPH_MSG_OSD_MAP, the max_osd value is updated, and the array
> fields of the current osdmap are reallocated.
> If the osdmap contains fewer OSDs than the previous one, the size of
> the
> arrays shrinks. This can result in having a connection to an OSD with
> an
> ID greater than max_osd, which is therefore not represented in the
> updated osdmap. If subsequently a connection fault is triggered,
> e.g.,
> by a malformed message, osd_fault() -> reopen_osd() is called. If
> there
> are still pending requests for this OSD, an attempt is made to read
> the
> OSD's address from the osd_addr array in the current osdmap,
> resulting
> in an out-of-bounds access.
>=20
> I suggest fixing the problem by adding a check to reopen_osd() that
> verifies the osd exists in the osdmap before continuing to reopen the
> connection.
> I will send a proposed patch in reply to this email.
>=20
> Best regards,
> Raphael
