From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Osd load and timeout when recovering
Date: Mon, 22 Oct 2012 13:59:59 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C53F659762@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C53F6582FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
 <508535DC.5070506@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:3483
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753279Ab2JVOAE convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Oct 2012 10:00:04 -0400
Received: from mail154-ch1 (localhost [127.0.0.1])	by
 mail154-ch1-R.bigfish.com (Postfix) with ESMTP id 8C5EB40124	for
 <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 14:00:03 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail154-ch1.bigfish.com (Postfix) with ESMTP id
 5FFDE4000E2	for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 14:00:01 +0000
 (UTC)
In-Reply-To: <508535DC.5070506@widodh.nl>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>>
>> After looking at the osd, we saw a very high load on osd (450 of load), some were down.
>> Ceph -s displayed that we were having down pg, peering+down pg, remapped pg. etc.
>>
>
>Could you tell us a bit more?
>
When the load was 450, was this mainly due to disk I/O wait?
Did the machines start to swap?

All disk were 100% busy. And server was swapping.

> Could it be that the swapping was actually causing the machines to die even more?

> Although a OSD could run with 100M of memory, during recovery it can grow quite fast.

Is there a way to estimate the needed memory ?

>
> So basically the cluster was under load because we was recovering... but because it was under load recovering could not complete.
>
>
>FileStore aborts indicate that it couldn't get the work done quickly enough. I've seen this with btrfs, but you say you are using XFS.
>
>You say you are storing small files. What exactly is "small"?

In average 120ko.


-- 
Yann ROBIN
www.YouScribe.com



