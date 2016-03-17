From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Thu, 17 Mar 2016 17:55:53 +0300
Message-ID: <56EAC579.9060208@mirantis.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34818 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030201AbcCQOzs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2016 10:55:48 -0400
Received: by mail-lb0-f169.google.com with SMTP id bc4so70255547lbc.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2016 07:55:47 -0700 (PDT)
In-Reply-To: <BLUPR0201MB1890A352BFE71C1D74634ED2E88A0@BLUPR0201MB1890.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Allen,

On 16.03.2016 22:02, Allen Samuels wrote:
>
>> Compression support approach:
>> The aim is to provide generic compression support allowing random
>> object read/write.
>> To do that compression engine to be placed (logically - actual
>> implementation may be discussed later) on top of bluestore to
>> "intercept" read-write requests and modify them as needed.
>>> I think it is going to make the most sense to do the compression and
>>> decompression in _do_write and _do_read (or helpers), within
>>> bluestore--not in some layer that sits above it but communicates
>>> metadata down to it.
>> My original intention was to minimize bluestore modifications needed to add
>> compression support. Particularly this helps to avoid additional bluestore
>> complication.
>> Another point for a segregation is a potential ability to move compression
>> engine out of store level to a pool one in the future.
>> Remember we still have 200% CPU utilization overhead for current approach
>> with replicated pools as each replica is compressed independently.
> One advantage of the current scheme is that you can use the same basic flow for EC and replicated pools. The scheme that you propose means that EC chunking boundaries become fluid and data-sensitive -- destroying the "seek" capability (i.e., you no longer know which node has any given logical address within the object). Essentially you'll need an entirely different backend flow for EC pools (at this level) with a complicated metadata mapping scheme. That seems MUCH more complicated and run-time expensive to me.
Wouldn't agree with this statement.  Perhaps I improperly presented my 
ideas or missing something...
IMHO current EC pool's write pattern is just a regular append only mode. 
And read pattern is partially random - EC reads data in arbitrary order 
at specific offsets only. As long as some layer is able to handle such 
patterns it's probably OK for EC pool. And I don't see any reasons why 
compression layer is unable to do that and what's the difference 
comparing to replicated pools.
Actually my idea  about segregation was mainly about reusing existing 
bluestore rather than modifying it. Compression engine should somehow 
(e.g. by inheriting from bluestore and overriding _do_write/_do_read 
methods ) intercept write/read requests and maintain its OWN block 
management independent from bluestore one. Bluestore is left untouched 
and exposes its functionality ( via Read/Write handlers) AS-IS to the 
compression layer instead of pools. The key thing is that compressed 
blocks map and bluestore extents map use the same logical offset, i.e. 
if some compressed block starts at offset X it's written to bluestore at 
offset X too. But written block is shorter than original one and thus 
store space is saved.
I would agree with the comment that this probably complicates metadata 
handling - compression layer metadata has to be handled similar to 
bluestore ones ( proper sync, WAL, transaction, etc). But I don't see 
any issues specific to EC here...
Have I missed something?

PS. This is rather academic question to better understand the difference 
in our POVs. Please ignore if you find it obtrusive or don't have enough 
time for detailed explanation. It looks like we wouldn't go this way in 
any case.

Thanks,
Igor
