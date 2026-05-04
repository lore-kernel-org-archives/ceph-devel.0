Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9854E56A
	for <ceph-devel@vger.kernel.org>; Mon,  4 May 2026 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853611; cv=pass; b=RXMdxSYPKC6nvRl/o+TBO5/duw77ChFLykxEDbaCg7UklGzIOBgTz+S4tBgp9UOSlcfl2tI86J/WrW+fFEEARk4rc/M/E3fWFS/gPDFBoqTQS/BNhZV2r0vf93NqfQxF+pveIg//hojZ/8187+vf5vMPXnu5B7BmO4uS+8SC28c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853611; c=relaxed/simple;
	bh=GPccjSoVogRc3VcH07FrP/6QsLgLIPwic7Z0D7V2QP8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Bj1w5VddkfKpKMCte2+sJ2dS4VnJfLIc2xlh7g9Os/HhPf5pEq8graxuC7kFlFowDdrGUxOeoFtwOqPbLmZ+VsqIh/wrS/0Yun82A07hRwUctxS23W0Bt0rxOS/k2DDlWqgvVkVrfcRLge7WMzAOQ3GWubsEMh+vtGlJm1j5cfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atekie.com; spf=none smtp.mailfrom=atekie.com; dkim=pass (2048-bit key) header.d=atekie-com.20251104.gappssmtp.com header.i=@atekie-com.20251104.gappssmtp.com header.b=f7NHo6B1; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atekie.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=atekie.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atekie-com.20251104.gappssmtp.com header.i=@atekie-com.20251104.gappssmtp.com header.b="f7NHo6B1"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7de7c57b52cso3089774a34.3
        for <ceph-devel@vger.kernel.org>; Sun, 03 May 2026 17:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777853608; cv=none;
        d=google.com; s=arc-20240605;
        b=EvpSaC5XcdtbMBtPgUeM3LJc2PEwm+EaGIYn4nVyl5kODcjcbwhnoxvK4mUbev45xs
         UjgliZeYXWXTJfiFCci+QtNM1byBx2dRzcdCJxcav4TpqmVDLtAOOxoa7wG8hGU2vuWR
         BwUnuzL6U1wSYZqaJl0r52zHdyulr/15VhfkbR8xwZYhCl++t3P0TZUMtfcLtkqDaI44
         ap9mLZ6BYsZbWug2OSV5xU4c6j+bE6dPQrz0WC6Pc5JR7Y7kxPw16eSMvO3A2vTSe3WA
         njHfB+NvmxkqJZihm/4ylxpLIvubhNAmK10C3J4T1cEAOPxqwFaoJQs0+UQAyhib0Mj3
         L/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EaHEzIk9wo/4EoDMtypR96eyPeHkaCPKK3qHS8LvZWM=;
        fh=a5jHHmAD6bJhN+pYoxhPe39944wfAFgUWuPDtRoW6RM=;
        b=JqeoQ272f+11qEMifjGdk2LRAdQcSSLG9LxAI7uWkZfXopHh4uJUBOREwaG8BoMZ+4
         Ig0DV6/dePfBj4tmpEq0F7F0UJDCGVuyD0IIVLPlIj6nqpeHjWSbVhwHHG4a7EU1ouV3
         FWl0nS8z2G+mfK1uh+PVbRZW0jj3AIVD2TYiMAaOXRmFk4vra5Z2N0kOvYguBIekbB25
         SpP7YYwhO4bOhsf/PkixZNya0ZPtxXhwTBFyLJt7CR516fMuoT9967ZEBGoufLHYnKA/
         ETaDdb1NtPjgb0B7wxbOBevMTl+3vs8UqTdy9X7I2Wu3RcnlGelmI0NR99dcIkxenelm
         rWgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atekie-com.20251104.gappssmtp.com; s=20251104; t=1777853608; x=1778458408; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EaHEzIk9wo/4EoDMtypR96eyPeHkaCPKK3qHS8LvZWM=;
        b=f7NHo6B17Spp2UovufXFgPnmJ5/v2gfxcbJtHdEQZm8xckR1Q9qEa2bkR1S+MUyHit
         eKPYx6sjmP9f3QqzHQG/kZWkKuVlkk8ychsFhbAsp9Mw62YG78helIyVlIEoxW4HijaM
         nlDj5PGl+v5hIXSJatou8mlj5KH4PQtKfbkbniEQXvuUFtxdUerzdDz2vqUKAOvGk14a
         oPmAL4BdVhQBFwahC4C9ajBwcq7Z5nVc54fwklltgqVwLpp6UyvRpMK2/L0WyWAUe4nU
         OvmmwFEBbb7NNCPC+BRQiUVE+P3K9czrWRNsbUM5CbPzGECKCFimvOgPSSOZ5bXP93pJ
         S04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853608; x=1778458408;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaHEzIk9wo/4EoDMtypR96eyPeHkaCPKK3qHS8LvZWM=;
        b=XBYbd2K62NpGJ3cyrnBNaz4+tdr6YEOO/UqOp5SPZy2pfkH2KXBbnXhtb6ZwgYS5zf
         yL+xb77JuTqaw8mwj33TGxgMIM/s0vY9ZdGo08ZsL5ST0ZI08vXd52Y65ku4qDRxhR9/
         fwwafgJVUdPXCtAQEoEKtEmJQ/hYZksamDQQHfrzesO7976oTCw1xyW2DwAFPt5Q2Yal
         5LdBgySYyLmsLyqAFcdPJLBGmQbzhpGR2ss0RbnbY73zIFhrNELbkWMrSgRl3dof5q+j
         sFgWyCm+5FrqdyBGBKdmN3OrqhlCZwZ8ywRh/fOn4H3qUvoVemefYyDcmDLEqNU0knM1
         P3zg==
X-Gm-Message-State: AOJu0YyBRl9ZFEVECneqwN61RFvRbtgiDZItJ/Xb9rbKLXh1VVHga1m2
	KNc5APCpKCLFMJj54KOX2dDyiacamrDcgyIwdlglNUdaHVIRbL2h3F5fhd2r899wBnhk5xbKdAj
	AG2nnu2BbHRnQhe5NVro8nVy37DkS6Msph1rrBOfrd0yK+MzmzUbZPnsajA==
X-Gm-Gg: AeBDieuIlesM4I1t2ychzh44itxGB7lAYYld1e20xdclGSaPWfw3aKH/n5mxODydJ43
	c0XpkQlTuVLMoFJOz8MZfYCdwJiXNX0WsxoGcWeLSUZOUSPd3eg8tcawwVJTMNamm8w6DFmeS+P
	tXfxaEHD2iidW3YBJmqvbe2tZ/xCEHTNVKf1EzxyYAqTxrdvZ3/glpL7jbhYyx8k5zbnbe8eDUe
	q3C5w4wRnzZe/NuQbIq6KarDb6bv39tdI+7t3jN1a1T0tc6S3yGq6lwJGfsjiaXwFoOb+3uE+S4
	vub9puHOgmbRwy7r1GKY9Z1jYi833u7Qf+xvoWexyDtePlDCuRKaXOsvzUFFsE8YKMZCMFX4V8R
	fX9J6QCfP
X-Received: by 2002:a05:6820:82c:b0:696:622a:e75e with SMTP id
 006d021491bc7-6969799e92bmr4055627eaf.11.1777853608648; Sun, 03 May 2026
 17:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kevin Lott <kevin@atekie.com>
Date: Sun, 3 May 2026 17:13:17 -0700
X-Gm-Features: AVHnY4KRoyLWppZS5JIytndyTTtM7XBq4TIBehqai1Dymz7Gq57EUQOPY_b7Hxc
Message-ID: <CAPyngjxORZAvMcWxgY6mS3qcgyQz766KrhH2zXK6RSH=jhVE_w@mail.gmail.com>
Subject: [RFC] rgw/cloud-tier: add exponential backoff on 503 SlowDown
To: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've opened a draft PR fixing a bug where RGW cloud tiering fails
immediately on HTTP 503 SlowDown responses from remote S3-compatible
endpoints rather than backing off and retrying.

PR: https://github.com/ceph/ceph/pull/68726
Tracker: https://tracker.ceph.com/issues/76406

Happy to take feedback!

-- 
Kevin Lott
Owner/CEO
aTekie
m:480-239-0508
w:www.atekie.com  e: kevin@atekie.com
