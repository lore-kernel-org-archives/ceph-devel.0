From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Two questions
Date: Wed, 27 Jul 2011 07:58:30 +0200
Message-ID: <8685614628192678277@unknownmsgid>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38091 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab1G0F6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 01:58:38 -0400
Received: by ewy4 with SMTP id 4so1065108ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2011 22:58:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello. I have some questions.

1. Is there any chance to change default 4MB object size to for
example 1MB or less ??

2. I have create cluster of two mons, and 32 osd (1TB each) on two
machines. At this radosgw with apache2 for test. When i putting data
from s3 client to rados, everything is ok, but when one of osd is
going down all s3 clients going to be freeze for some seconds, before
ceph sign this osd as down, and then everything is starting working
again wit degraded osd. How can i tune this marking as a down for ms
or 0 :) and not for seconds freeze ??

My setup is debian 6.0, kernel 2.6.37.6  x86_64 and ceph version
0.31-10 from stable repo.

Best regards

Slawomir Skowron
