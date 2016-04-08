From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: RBD image name constraints
Date: Fri, 8 Apr 2016 14:23:32 +0200
Message-ID: <5707A2C4.3030102@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo174.mail-out.ovh.net ([178.33.109.103]:42292 "EHLO
	1.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbcDHOxY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 10:53:24 -0400
Received: from EX3.OVH.local (corp.ovh.com [5.196.251.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mo174.mail-out.ovh.net (Postfix) with ESMTPS id E0932FF8285
	for <ceph-devel@vger.kernel.org>; Fri,  8 Apr 2016 14:23:33 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

What are constraints regarding names of RBD images? I tried to look it=20
up but without success.

My tests show that maximum length is about 4089 bytes and the only=20
forbidden characters are '\0' and '@' but didn't get deep enough into=20
the code to figure out the length limit. Are my findings correct?

I also think I've found a regression introduced in v10.0.1 regarding=20
pool / image name constraints (introduced in=20
fa4e00f8c85603ed202bfef2f3be6086482fbbb2).

In newer versions there's regex that's parsing image name passed to rbd=
=20
command (in src/tools/rbd/Utils.cc, function: extract_spec):

     "^(?:([^/@]+)/)?([^/@]+)(?:@([^/@]+))?$"

It won't parse pool name with '@', image name with '/' nor snapshot nam=
e=20
with '/', which was allowed in previous implementation based on strchr.

Kind regards
Bart=C5=82omiej =C5=9Awi=C4=99cki
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
