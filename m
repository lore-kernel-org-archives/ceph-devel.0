From: norbi <norbi@rocknob.de>
Subject: deleting non existing pgs ?
Date: Wed, 19 Dec 2012 21:43:18 +0100
Message-ID: <50D226E6.4020708@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:37726 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2LSUwn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 15:52:43 -0500
Received: from [80.67.16.214] (helo=[192.168.10.165])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <norbi@rocknob.de>)
	id 1TlQU0-0000O8-Et
	for ceph-devel@vger.kernel.org; Wed, 19 Dec 2012 21:43:16 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

how can i delete non existing PGs ?
the OSDs where the PGs was stored are crashed and now i see this

pg 2.80 is stuck stale for 38971.810705, current state 
stale+active+clean, last acting [2,0]
pg 0.82 is stuck stale for 38971.810712, current state 
stale+active+clean, last acting [2,0]
pg 1.81 is stuck stale for 38971.810712, current state 
stale+active+clean, last acting [2,0]


or the osd.log shows me this

2012-12-19 21:38:36.771016 7f2e5c518700  7 osd.2 3090 hit non-existent 
pg 0.82
2012-12-19 21:38:36.771024 7f2e5c518700  7 osd.2 3090 we are valid 
target for op, waiting
2012-12-19 21:38:36.771026 7f2e5c518700 15 osd.2 3090 
require_same_or_newer_map 3086 (i am 3090) 0x17eec00


how can i delete this pgs ?

norbert
