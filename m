From: Howard Chu <hyc@symas.com>
Subject: Re: Adding compression support for bluestore.
Date: Thu, 17 Mar 2016 17:29:16 +0000
Message-ID: <56EAE96C.2010502@symas.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <BLUPR0201MB1890D5927BA82CC2E7ED7132E88A0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <CA+z5DsxA9_LLozFrDOtnVRc7FcvN7S8OF12zswQZ4q4ysK_0BA@mail.gmail.com>
 <CA+z5DszDFj6d-=g9WWpfMOJCew=h7t2P4hOp0C7qei3=peTFZQ@mail.gmail.com>
 <CY1PR0201MB189742A1CE7B4922F2667F1CE88B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56EA805C.1020001@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zill.ext.symas.net ([69.43.206.106]:39369 "EHLO
	zill.ext.symas.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934742AbcCQR32 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2016 13:29:28 -0400
In-Reply-To: <56EA805C.1020001@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Allen Samuels <Allen.Samuels@sandisk.com>, Blair Bethwaite <blair.bethwaite@gmail.com>, Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Willem Jan Withagen wrote:
> And to just add something practical to this: recently lz4 compression has made
> it into ZFS and has become the standard advice for compression.
> It is considered the most efficient tradeoff between compression efficiency
> and cpu-cycle consumption, and it is supposed to keep up with the throughput
> that devices in the backingstore have. Not sure how that pans out with a full
> SSD array, but opinions about that will be there soon as SSD are getting cheap
> rapidly.
>
> There are plenty of choices:
> compression     on | off | lzjb | gzip | gzip-[1-9] | zle | lz4
> But using other compression algos is only recommended after due testing.

On the testing front, this will help
https://github.com/hyc/PolyZ

Then you only need to write your test code once, to a single API, and you can 
evaluate all of the different compression libraries just by changing LD_PRELOAD.

This is what I used for our own compression evaluation...
http://symas.com/mdb/inmem/compress/

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
