From: Loic Dachary <loic@dachary.org>
Subject: jewel v10.2.1 status update
Date: Tue, 10 May 2016 12:21:02 +0200
Message-ID: <5731B60E.3090603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp26.services.sfr.fr ([93.17.128.10]:61290 "EHLO
	smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcEJKVF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 06:21:05 -0400
Received: from [172.16.121.96] (rea75-2-78-193-202-57.fbxo.proxad.net [78.193.202.57])
	by msfrf2627.sfr.fr (SMTP Server) with ESMTP id 6B47F1C015C70
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 12:21:03 +0200 (CEST)
Received: from [172.16.121.96] (rea75-2-78-193-202-57.fbxo.proxad.net [78.193.202.57])	(using TLSv1
	with cipher ECDHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)	(Authenticated sender: loic.dachary@sfr.fr)
	by msfrf2627.sfr.fr (SMTP Server) with ESMTPSA
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 12:21:02 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

All jewel pull requests ( https://github.com/ceph/ceph/pulls?q=3Dis%3Ao=
pen+is%3Apr+milestone%3Ajewel ) except two ( https://github.com/ceph/ce=
ph/pull/8868 and https://github.com/ceph/ceph/pull/9010 ) have been mer=
ged into the jewel-backports integration branch ( http://tracker.ceph.c=
om/issues/15317#note-4 ). They include all backports done by Yehuda and=
 Jason (except 9010) in the past 24h hours. The suites are going to be =
scheduled later today (when gitbuilder is done creating the packages) a=
nd their progress can be tracked at http://tracker.ceph.com/issues/1531=
7#note-5 etc.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
