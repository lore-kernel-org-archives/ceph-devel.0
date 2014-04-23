From: "Ahmed Ali (ahmeali)" <ahmeali@cisco.com>
Subject: ceph-deploy install error - Unhandled exception
Date: Wed, 23 Apr 2014 21:55:59 +0000
Message-ID: <20742D81FF40A2468E3FF071F3F15A2632B7CEBD@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:55426 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaDWWFl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Apr 2014 18:05:41 -0400
Received: from xhc-rcd-x10.cisco.com (xhc-rcd-x10.cisco.com [173.37.183.84])
	by rcdn-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id s3NLu0kF004396
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 23 Apr 2014 21:56:00 GMT
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I'm installing ceph using ceph-deploy and run into this error:

Unhandled exception in thread started by
sys.excepthook is missing
lost sys.stderr

Command used: ceph-deploy install cephnode01-os5 cephnode02-os5 cephnode03-os5

Last lines:
....
[cephnode03-os5][DEBUG ] Setting up ceph-fs-common (0.72.2-1precise) ...
[cephnode03-os5][DEBUG ] Setting up ceph-mds (0.72.2-1precise) ...
[cephnode03-os5][DEBUG ] ceph-mds-all start/running
[cephnode03-os5][DEBUG ] Processing triggers for libc-bin ...
[cephnode03-os5][DEBUG ] ldconfig deferred processing now taking place
[cephnode03-os5][INFO  ] Running command: sudo ceph --version
[cephnode03-os5][DEBUG ] ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
Unhandled exception in thread started by
sys.excepthook is missing
lost sys.stderr 

Following the quick install @ http://ceph.com/docs/master/start/quick-ceph-deploy/, step 3

Took a snapshot and continue install (assuming the error is harmless and related to python), I did run into it again when I did " ceph-deploy osd prepare ...", after all the ceph health is reporting "Health_OK".


Is that error harmless? If yes please advise.

Note: I'm Just exploring ceph for the first time

Thanks in advance!
Ahmed

 




