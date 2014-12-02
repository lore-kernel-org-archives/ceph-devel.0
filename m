From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: LTTng tracing: hitting the message throttle
Date: Tue, 2 Dec 2014 19:00:04 +0100
Message-ID: <20141202190004.5c308f20@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:33368 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381AbaLBSAN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 13:00:13 -0500
Received: from itxmail.itxperts.de (qgate_dmz.itxperts.de [192.168.160.1])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id sB2I1M59011648
	for <ceph-devel@vger.kernel.org>; Tue, 2 Dec 2014 19:01:23 +0100
Received: from doppio (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id 4EA0913F02
	for <ceph-devel@vger.kernel.org>; Tue,  2 Dec 2014 18:52:14 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

while running tests to collect data using LTTng, I was hitting
the message throttle in ceph-osd, which is controlled by configuration
option osd_map_message_max, default 100.

If I am not mistaken, then this throttle hits when more than
100 messages received via SimpleMessenger are not yet destructed,
i.e. are still under processing within the affected ceph-osd daemon.

I was running a fio test, random writes of 4 KByte with 16 parallel
IO's. The storage cluster consists of 12 osds on 3 storage nodes,
replication level 3.

I wonder why I hit that message throttle with my load profile:
the 16 parallel IO's should at most generate 48 data messages and also
48 acknowledges across the cluster - so I would not expect anything
even close to a 100 message limit on a single osd in my cluster.

Did anybody else experience such issues?

Are there other throttle values which I should look at?


Regards

Andreas Bluemle


-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
