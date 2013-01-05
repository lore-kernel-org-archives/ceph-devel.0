From: Stefan Priebe <s.priebe@profihost.ag>
Subject: ceph stays degraded after crushmap rearrangement
Date: Sat, 05 Jan 2013 17:40:57 +0100
Message-ID: <50E85799.4060607@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44892 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab3AEQkw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 11:40:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi list,

i've rearranged my crushmap. Ceph was degraded about 18% and was 
recovering / rearranging fine.

But now it stays still and degraded status is rising??

2013-01-05 17:35:40.906587 mon.0 [INF] pgmap v2211269: 7632 pgs: 7632 
active+remapped; 152 GB data, 312 GB used, 5023 GB / 5336 GB avail; 
22/79086 degraded (0.028%)

...

2013-01-05 17:37:50.142106 mon.0 [INF] pgmap v2211386: 7632 pgs: 7632 
active+remapped; 152 GB data, 312 GB used, 5023 GB / 5336 GB avail; 
24/79090 degraded (0.030%)

..

2013-01-05 17:40:35.292054 mon.0 [INF] pgmap v2211526: 7632 pgs: 7632 
active+remapped; 152 GB data, 313 GB used, 5023 GB / 5336 GB avail; 
32/79106 degraded (0.040%)

I'm on currect testing branch.

Greets,
Stefan
