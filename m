From: Lorieri <lorieri@gmail.com>
Subject: [radosgw] absolute uri
Date: Thu, 27 Aug 2015 01:36:37 -0300
Message-ID: <CAPHxCcTAA4sPXmbCxkMo8gFH_=d5AW8BvzVgGuGVJpZ5+N1CKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36322 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbH0Egi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 00:36:38 -0400
Received: by oiev193 with SMTP id v193so4673227oie.3
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2015 21:36:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm debugging a golang aws client and I've noticed it makes absolute
uri requests on amazon.
http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html#sec5.1.2

it would be great if radosgw implement it.

cheers,
-lorieri
