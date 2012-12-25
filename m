From: Stefan Priebe <s.priebe@profihost.ag>
Subject: automatic repair of inconsistent pg?
Date: Tue, 25 Dec 2012 03:01:30 +0100
Message-ID: <50D908FA.7010907@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52102 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2LYCBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Dec 2012 21:01:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

today i got the following ceph status output:
2012-12-25 02:57:00.632945 mon.0 [INF] pgmap v1394388: 7632 pgs: 7631 
active+clean, 1 active+clean+inconsistent; 151 GB data, 307 GB used, 
5028 GB / 5336 GB avail


i then grepped the inconsistent pg by:
# ceph pg dump - | grep inconsistent
3.ccf   10      0       0       0       41037824        155930  155930 
active+clean+inconsistent       2012-12-25 01:51:35.318459 6243'2107 
     6190'9847       [14,42] [14,42] 6243'2107       2012-12-25 
01:51:35.318436      6007'2074       2012-12-23 01:51:24.386366

and initiated a repair:
#  ceph pg repair 3.ccf
instructing pg 3.ccf on osd.14 to repair

The log output then was:
2012-12-25 02:56:59.056382 osd.14 [ERR] 3.ccf osd.42 missing 
1c602ccf/rbd_data.4904d6b8b4567.0000000000000b84/head//3
2012-12-25 02:56:59.056385 osd.14 [ERR] 3.ccf osd.42 missing 
ceb55ccf/rbd_data.48cc66b8b4567.0000000000001538/head//3
2012-12-25 02:56:59.097989 osd.14 [ERR] 3.ccf osd.42 missing 
dba6bccf/rbd_data.4797d6b8b4567.00000000000015ad/head//3
2012-12-25 02:56:59.097991 osd.14 [ERR] 3.ccf osd.42 missing 
a4deccf/rbd_data.45f956b8b4567.00000000000003d5/head//3
2012-12-25 02:56:59.098022 osd.14 [ERR] 3.ccf repair 4 missing, 0 
inconsistent objects
2012-12-25 02:56:59.098046 osd.14 [ERR] 3.ccf repair 4 errors, 4 fixed

Why doesn't ceph repair this automatically? Ho could this happen at all?

Stefan
