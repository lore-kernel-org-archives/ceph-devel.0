From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 05 Jan 2013 19:05:11 +0100
Message-ID: <50E86B57.4090708@profihost.ag>
References: <50E85799.4060607@profihost.ag> <50E85CC9.9080503@profihost.ag> <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net> <50E85EB1.8060803@profihost.ag> <50E86008.30000@profihost.ag> <alpine.DEB.2.00.1301050939570.15430@cobra.newdream.net> <50E86708.6070909@profihost.ag> <alpine.DEB.2.00.1301050955150.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58980 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815Ab3AESFH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 13:05:07 -0500
In-Reply-To: <alpine.DEB.2.00.1301050955150.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 05.01.2013 18:56, schrieb Sage Weil:
>> But my rbd images are gone ?!
>>
>> [1202: ~]# rbd -p kvmpool1 ls
>> [1202: ~]#
>
> Oh.. I think this is related to the librados/librbd compatibility issue I
> mentioned yesterday.  Please make sure the clients (librados, librbd) are
> also running the latest testing branch.

ah OK  - thanks that's it - ceph has now also recovered completely with 
old crushmap.

OK now back to my original problem.

i wanted to change from this:
-----------------------------------------
...

rack D2-switchA {
         id -100         # do not change unnecessarily
         # weight 12.000
         alg straw
         hash 0  # rjenkins1
         item server1263 weight 4.000
         item server1264 weight 4.000
         item server1265 weight 4.000
}
rack D2-switchB {
         id -101         # do not change unnecessarily
         # weight 12.000
         alg straw
         hash 0  # rjenkins1
         item server1266 weight 4.000
         item server1267 weight 4.000
         item server1268 weight 4.000
}
root root {
         id -10000               # do not change unnecessarily
         # weight 24.000
         alg straw
         hash 0  # rjenkins1
         item D2-switchA weight 12.000
         item D2-switchB weight 12.000
}

...
-----------------------------------------

to this one:

-----------------------------------------
...

rack D2 {
         id -100         # do not change unnecessarily
         # weight 24.000
         alg straw
         hash 0  # rjenkins1
         item cloud1-1263 weight 4.000
         item cloud1-1264 weight 4.000
         item cloud1-1265 weight 4.000
         item cloud1-1266 weight 4.000
         item cloud1-1267 weight 4.000
         item cloud1-1268 weight 4.000
}
root root {
         id -10000               # do not change unnecessarily
         # weight 24.000
         alg straw
         hash 0  # rjenkins1
         item D2 weight 24.000
}

...
-----------------------------------------

This was where all problems started. Is this wrong? / not possible?

Greets,
Stefan
