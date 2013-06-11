From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: radosrgw performance problems
Date: Tue, 11 Jun 2013 13:27:25 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko1.compugroup.com ([193.47.161.177]:47313 "EHLO
	SMXKO1.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab3FKN1e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jun 2013 09:27:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by SMXKO1.compugroup.com (Postfix) with ESMTP id 68F86613B
	for <ceph-devel@vger.kernel.org>; Tue, 11 Jun 2013 15:27:27 +0200 (CEST)
Received: from SMXKO1.compugroup.com ([127.0.0.1])
	by localhost (smxko1.compugroup.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QopiECf2nY9J for <ceph-devel@vger.kernel.org>;
	Tue, 11 Jun 2013 15:27:27 +0200 (CEST)
Received: from SCASKO1.cgm.ag (scasko1.cgm.ag [10.0.0.81])
	by SMXKO1.compugroup.com (Postfix) with ESMTPS id 3769E6120
	for <ceph-devel@vger.kernel.org>; Tue, 11 Jun 2013 15:27:27 +0200 (CEST)
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

we have a performance problem with radosrgw.
Only 8mb/s-9 per upload, also tested with s3cmd on the rgw itself. 
(2 uploads at the same time: combined 15mb/s, 3 uploads at the same time: comb. 21mb/s)
But when putting a file via rados rbd , we get 40mb/s upload, so no network or other problem in general.

Same speed with the inktank apache/fastcgi and the original one. Hardware also fast enough. We use Ubuntu 12.04 lts, ceph 0.61.2

So have you any idea why the rgw is so slow? How can we identify where the problem is?

(I've heard something about the rgw admin socket to check perfcounters, but it seems that this is deprecated? Because when i type ceph --admin-daemon ... it says unknown command and I cannot find it in the ceph docu. Then i wanted to bench via rest-bench, but it says "ERROR: failed to create bucket: XmlParseFailure -failed initializing benchmark", so I could not bench the speed.)

Ceph.conf- rgw part:

[client.radosgw.connect2]
host = hcrgwko2
rgw socket path = /tmp/connect2.sock
log file = /var/log/ceph/connect2.log
rgw dns name =  FQDN

Thank you very much.


Regards

Philipp
