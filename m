Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02983DB328
	for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2026 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634239; cv=pass; b=M6sRwJO1H2jRLRp2dYPng4hR7qHR3H7CJwe/kvUFY2BEyEYB0J7I9JVh5FDPZZcCRUo7NgRfS4YMD6npD5EgCW4yMzu11Q3e+V82lyMz5t+X8SQ90OF9l6eQr8UcgdWfzM5ZS5BOvvtW6GHQ4S2iDJJVccbCCrnWt9tOi7GHXFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634239; c=relaxed/simple;
	bh=Urn5Ng9z6dNaZ0WRNEPP94QqBI/b5cPB4/z1cIItuTM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L+LrLVvxLNc1b57VGb7AFAk4Qer9Je5fhHWnUz4y8jlu6M/pE15vEu3WyS+eNxBTlBsUq9Qw5Ip4mJ9qncaEqeKh7fZ4nwH2oHZMu6MPcKa1j0TNq4DYCO6DzykbtZZ0E8p/0T8SJUske3jLcn05Wjr0P2HoFL600DFVxieSbwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgstTtIf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6JadtfE; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgstTtIf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6JadtfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789634224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Urn5Ng9z6dNaZ0WRNEPP94QqBI/b5cPB4/z1cIItuTM=;
	b=VgstTtIfydApeIgQYd65P+XQqKOe4VkyMfb8w6a/1fMR30hanllmyGdOktxbcEDx5DDWgz
	Wp6w3ZG3sCcx7J2OCngzQ7ynuu/l1+wA16qeIUXH9WQFZLAje8935p1/KrRpja71XCv9if
	ZqXz19bTxpmdX3i0yBNj/rLlrACb7Uo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-H897kRk-M5OGtnqhGMJAuQ-1; Thu, 17 Sep 2026 04:37:00 -0400
X-MC-Unique: H897kRk-M5OGtnqhGMJAuQ-1
X-Mimecast-MFC-AGG-ID: H897kRk-M5OGtnqhGMJAuQ_1789634219
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a18e266026so660092a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2026 01:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789634219; cv=none;
        d=google.com; s=arc-20260327;
        b=MqBLIW6pnA4/bYJJdOTHbusAycGiSFOSRHXxJBsncwWi832ZznDUHbzhMUk3bNiAny
         SxVd74VjdjG2jOC5kuD0xfqq65OigPFZh0B4Zze63Za6Np4GLsb/BAQBuQTS5s0wAdG/
         1460xYUMNG3+VXXHe4Cm60MpsC6xRFXOmS11OaJKMf6jJAh91pIGDMDub8Y5jTiwXMEx
         ecFCbaWqCBZamGYW7VFCzl/zDnCK47aU/F8kf9tJlhcAU/16Gec4ipEN6CrNLB1Mgniw
         VthF+2vMMnhnE64hXFgN3ypwQnlIe8Do/eun7OTM6z1UjNTRq2eySn86j9fJN4vS5WiY
         MH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Urn5Ng9z6dNaZ0WRNEPP94QqBI/b5cPB4/z1cIItuTM=;
        fh=a5jHHmAD6bJhN+pYoxhPe39944wfAFgUWuPDtRoW6RM=;
        b=JcoFJKe1j4PJaro/3iqRtg6fnfSxguUxyiiP+/1g/dN0W6gYROKPV0LlMn/ISpWj6I
         /YSQXRHD+0pJrGtHIWbfNrQ5zYQkb7hqpC0f6FsjJx1rNulBkAHDOb1cnk88MPM9wm/M
         3uxYZhsU5hM/GO2tQB1qTF0E2lO4SayvTo3uAGppUW8O7jaoEIjM+to5kWApMUfBpZxE
         +cqcWCJ9gwpppHmw+EAerlRx3JLSxlee3najONbsllrZiwM5+Ij7PDRjrxBezCNWAIEd
         ZXJXaoPwER+XS2isW/cNSrfdO6nCiUunq859KWleZtLYdWTMwz1YW+cBAmbVan/XkUHy
         g1aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789634219; x=1790239019; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Urn5Ng9z6dNaZ0WRNEPP94QqBI/b5cPB4/z1cIItuTM=;
        b=U6JadtfEW3p0I1/13NQDIIn4hp6TCGQ9O1TcfsRG5Wd2p4afdPHRYkG+iASeW0NnTo
         fisjmaL/3CiPDVUGBD7ksZPAY51V59DFPzSXOsAZ76EXqE0O63fxc/TYrkLkgiXRjlB4
         mfnxAkEgsj82CTTfT6GUqKRlT7P/uhWQ7bLF1y5wehoNn81T/EGyh8mTJ+a9pgfFm9yv
         w0m6ym+MeIhut9efNLwMsg9i+yuVWqQ/bqzR7KDUf71HOHb6o93qULkLR2wG276NE2iw
         WyYpt8/QexqnCEe09qcY17Qw+aMZ0Un6aWHaBBU6Vdh5Ktnv+2HLpNjvgIrbZlhv4aXk
         5B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634219; x=1790239019;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Urn5Ng9z6dNaZ0WRNEPP94QqBI/b5cPB4/z1cIItuTM=;
        b=y8vhhB4TfcyMNXjv0Q3fCPv+IYYOXaKIdNYx6NtrOIaNlPnqfcVfXchngpa8MnRzob
         lwPTJebkQldDk+Q2ZfW2BvViyus+DgnzOCbLZUi55p4athyfBYDzz4WnuPMrlmUcvDyE
         0DVWi3IggL1SrxsThv8L6JHFZzsmGMKw0d6ODHLAeHtgLEIOatGGpLDH5Rih1CbVkAW1
         bv27PIW+SGJBMljWrH3Vpk2liYXILzPxtmtEb1/mIygiXHNu5zWJeZ8XMdIfUdT5E1zX
         mDFa3G2aLTJiQkWbZvc+vHSAfHC/uegZDuOtXulOsURz6fFpkJ/B/6hBcgZ1zOwuEMZN
         yPqg==
X-Gm-Message-State: AFuF++lEOczrjKX2SkVwsFZLoRQtaVM/fTQm1m1CW6kkPflhSCMl4sJ5
	3AePbEyz8DFgdQX0TesiQSFhrDwwN0as6yTTqje2UUeaHO5OAHHPOppCZQs9AZkR+sM9ICiCrvH
	G41xxHWDjUlw9tHoFj6uhh/rasfYqaiXTgCWq2AfJFWErU728Axt3f8LrxBViDlUrEW9O39r0I5
	WMreE8J9Cxfjf7JpG9v6AvBSzn7A1OCDs346esotKm7OL6Sq2g
X-Gm-Gg: AYBFou2YaSKOMuEu5bSk59IekWYCWkFt+veQfqDvpanoTbTAckneGEoPJO2KqGJG1hF
	V/JNUnuFW5ZwrJ92jMoqr++uHr4FLMnfgExo/ffzSihCaaMmWBJJNHS4dhw58jM5REdvapRxHvr
	TAWXDJst1phyfwGJLmhHYCoSb1v0lY1MSXNY1Ltbubudt7QavrHHWwlDerZHJ06jgYA5WqDUhyE
	yCH5anC+B29gRc=
X-Received: by 2002:a05:6402:4144:b0:6a9:948b:5190 with SMTP id 4fb4d7f45d1cf-6aa2241a320mr3855586a12.35.1789634218858;
        Thu, 17 Sep 2026 01:36:58 -0700 (PDT)
X-Received: by 2002:a05:6402:4144:b0:6a9:948b:5190 with SMTP id
 4fb4d7f45d1cf-6aa2241a320mr3855567a12.35.1789634218449; Thu, 17 Sep 2026
 01:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yael Azulay <yazulay@redhat.com>
Date: Thu, 17 Sep 2026 11:36:46 +0300
X-Gm-Features: AcwNN1VwCK-klBrVItXjXJm8qtQpyHohyIyRcnNI2iQotnUIh5ijwDEjNPMjQQg
Message-ID: <CAOCccuC+Z_MPiu5j1D8+yZWfQi0CEH7OiitnNfLnJ0q7nyw84w@mail.gmail.com>
Subject: [Ceph Tracker] Account Merge / Ticket Reassignment Request (User ID 10351)
To: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ceph Admins,

Could you please assist with merging/reassigning my legacy Ceph
Tracker account to my active Red Hat account?

Primary (Keep) Account: yazulay@redhat.com

Legacy Account to Merge/Reassign: yael.azulay (User ID 10351)

Action Needed: Please reassign all 18 tickets, reported issues, and
project Developer roles from User ID 10351 to yazulay@redhat.com, then
lock or disable User ID 10351.

Thank you,

Yael Azulay

