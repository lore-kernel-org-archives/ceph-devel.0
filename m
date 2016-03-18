From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Fri, 18 Mar 2016 16:00:57 +0300
Message-ID: <56EBFC09.1060008@mirantis.com>
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
 <BLUPR0201MB1890A352BFE71C1D74634ED2E88A0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <56EAC579.9060208@mirantis.com>
 <CY1PR0201MB18974651A4981E5F6889AFF7E88B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34177 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbcCRNAx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2016 09:00:53 -0400
Received: by mail-lb0-f174.google.com with SMTP id k12so87845024lbb.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2016 06:00:52 -0700 (PDT)
In-Reply-To: <CY1PR0201MB18974651A4981E5F6889AFF7E88B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 17.03.2016 18:28, Allen Samuels wrote:
>> flow for EC and replicated pools. The scheme that you propose means that
>> EC chunking boundaries become fluid and data-sensitive -- destroying the
>> "seek" capability (i.e., you no longer know which node has any given logical
>> address within the object). Essentially you'll need an entirely different
>> backend flow for EC pools (at this level) with a complicated metadata
>> mapping scheme. That seems MUCH more complicated and run-time
>> expensive to me.
>> Wouldn't agree with this statement.  Perhaps I improperly presented my
>> ideas or missing something...
>> IMHO current EC pool's write pattern is just a regular append only mode.
> This is where we diverge. Sam and I worked out a blueprint for doing non append-only writes into EC pools (i.e., partial and/or complete overwrites).
>
> See https://github.com/athanatos/ceph/blob/wip-ec-overwrites/doc/dev/osd_internals/ec_overwrites.rst
>
> This allows all of the current restrictions in the usages of EC Pools to be eliminated, enabling all protocols to directly utilize EC pools.
>
> If you do compression BEFORE you do EC, then you have a real problem with landing your data across the different nodes of an EC stripe in the non-append case.
>
> BTW, it's BlueStore itself that enables this new capability to be implemented efficiently, it's very expensive to do this with FileStore (an additional full copy of the data is required, i.e., 3x write-amp on FileStore)
>   
Got it.  That's where we diverge:
Actually speaking of compression layer segregation in this thread I 
meant having it AFTER EC/Replicated pools and BEFORE the bluestore. Not 
BEFORE pools ... IMO in my case such a layer is absolutely similar for 
both replicated and EC pools as EC write patterns are always (for both 
append only and overwrite modes) a subset of replicated pool one.

Anyway thanks a lot for your clarifications. I highly appreciate your 
help...

>
>> And read pattern is partially random - EC reads data in arbitrary order at
>> specific offsets only. As long as some layer is able to handle such patterns it's
>> probably OK for EC pool. And I don't see any reasons why compression layer
>> is unable to do that and what's the difference comparing to replicated pools.
>> Actually my idea  about segregation was mainly about reusing existing
>> bluestore rather than modifying it. Compression engine should somehow
>> (e.g. by inheriting from bluestore and overriding _do_write/_do_read
>> methods ) intercept write/read requests and maintain its OWN block
>> management independent from bluestore one. Bluestore is left untouched
>> and exposes its functionality ( via Read/Write handlers) AS-IS to the
>> compression layer instead of pools. The key thing is that compressed blocks
>> map and bluestore extents map use the same logical offset, i.e.
>> if some compressed block starts at offset X it's written to bluestore at offset
>> X too. But written block is shorter than original one and thus store space is
>> saved.
>> I would agree with the comment that this probably complicates metadata
>> handling - compression layer metadata has to be handled similar to bluestore
>> ones ( proper sync, WAL, transaction, etc). But I don't see any issues specific
>> to EC here...
>> Have I missed something?
> No doubt the metadata gets more complicated in the presence of compression. Especially if we want to enable the sort of lazy partial-overwrite with background cleanup that seems to be the most desirable.
Agree.

Thanks,
Igor
