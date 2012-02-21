From: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: Problems after crash yesterday
Date: Tue, 21 Feb 2012 11:24:57 +0100
Message-ID: <4F4370F9.5030807@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:33566 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2BUKZA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 05:25:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@newdream.net

Hi sage,

sorry ... we have to disturb you again.

After the node crash (oli wrote about that) we have some problems.

The recovery process is stuck at:

2012-02-21 11:20:15.948527    pg v986715: 2046 pgs: 2035 active+clean,
10 active+clean+inconsistent, 1 active+recovering+remapped+backfill;
1988 GB data, 3823 GB used, 25970 GB / 29794 GB avail; 1/1121879
degraded (0.000%)

We also see this messages every few seconds:

2012-02-21 11:20:15.106958   log 2012-02-21 11:20:05.765762 osd.3
10.10.10.8:6803/29916 131581 : [WRN] old request pg_log(0.ea epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently started
2012-02-21 11:20:15.106958   log 2012-02-21 11:20:05.765775 osd.3
10.10.10.8:6803/29916 131582 : [WRN] old request pg_log(2.e8 epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently no
flag points reached
2012-02-21 11:20:15.106958   log 2012-02-21 11:20:06.765912 osd.3
10.10.10.8:6803/29916 131583 : [WRN] old request pg_log(0.ea epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently started
2012-02-21 11:20:15.106958   log 2012-02-21 11:20:06.765943 osd.3
10.10.10.8:6803/29916 131584 : [WRN] old request pg_log(2.e8 epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently no
flag points reached
2012-02-21 11:20:15.106958   log 2012-02-21 11:20:07.766312 osd.3
10.10.10.8:6803/29916 131585 : [WRN] old request pg_log(0.ea epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently started
2012-02-21 11:20:15.106958   log 2012-02-21 11:20:07.766324 osd.3
10.10.10.8:6803/29916 131586 : [WRN] old request pg_log(2.e8 epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently no
flag points reached
2012-02-21 11:20:15.106958   log 2012-02-21 11:20:08.766467 osd.3
10.10.10.8:6803/29916 131587 : [WRN] old request pg_log(0.ea epoch 849
query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently started

Any ideas how we can get the cluster back to consistent state  ?

Thank you !!

Jens
