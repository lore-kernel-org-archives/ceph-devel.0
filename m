From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: OSD weighting
Date: Fri, 20 Apr 2012 16:53:47 +0930
Message-ID: <4F910F03.6070604@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:55181 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab2DTHYC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 03:24:02 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q3K7Nlaq019515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 20 Apr 2012 16:53:49 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear devs,

Playing around with ceph and gradually moving it from a toy thing into 
production I wanted ceph to actually make its run for the money (so to 
speak). I have assembled number of OSDs which are really built on 
different hardware: starting from old P4 with 512MB of RAM and ending up 
with high end Dell server, including mixture of 100 and 1000 mbit 
networks. I will not really speak about performance of MONs and MDSes as 
they do fairly well does not matter what I throw to them. But with OSDs 
it is different story. Even one full OSD will stall whole ceph - I've 
read that it is normal and good way of fighting it is to have periodic 
health check to see that no OSD is approaching full status. However I 
believe it would be better if ceph will reduce weighting for OSDs 
approaching full status so it will effectively prevent OSD getting full. 
Should be reasonably simple to implement and will not cause major grief 
if some OSD will go past near full status to full status quickly and 
unnoticed. I guess reweight-by-utilization is an attempt to address the 
issue based on CPU performance.

In the mean time I have reverted back to manual weighting of OSDs and I 
found that there no clear explanation on how weights actually applied. 
I've seen suggestion to keep weight equivalent to number of TBs on OSD. 
Doing so in single rack has achieved expected result: data has spread 
itself proportionally to OSDs sizes. But when I started to move OSDs 
from toy rack into production rack I also have changed weights for racks 
in pool. So I had 6 OSDs and I moved 2 of them. I have changed toyrack 
weight to 4.000 and productionrack to 2.000. Waited for data to settle 
just to find out that disk use is no longer proportional. Then I have 
changed rack weights to total amount of TBs in the rack, data reshuffled 
and settled but again did not achieved expected result. So I guess 
function of weights: racks, hosts and devices is not straight forward as 
I thought originally. This begs clear explanation of how weights are 
used in case of straw algo.

Regards,
Vladimir
