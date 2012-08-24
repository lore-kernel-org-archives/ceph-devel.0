From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph performance improvement
Date: Fri, 24 Aug 2012 19:42:12 +0200
Message-ID: <5037BCF4.3070502@widodh.nl>
References: <50349E62.90405@ledeuns.net> <5034D210.8060109@inktank.com> <5037AEB8.5030905@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:34774 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759048Ab2HXRmO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 13:42:14 -0400
In-Reply-To: <5037AEB8.5030905@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org



On 08/24/2012 06:41 PM, Denis Fondras wrote:
>
> In my opinions, performances from RBD client are decent.
> Unfortunately I need concurrent access and CephFS is really appealing in
> that respect.
>
>>
>> Ouch, that's taking a while!  In addition to the comments that David
>> made, be aware that you are also testing the metadata server with
>> cephFS.  Right now that's not getting a lot of attention as we are
>> primarily focusing on RADOS performance at the moment.  For this kind of
>> test though, distributed filesystems will never be as good as local
>> disks...
>>
>
> Yes, it may be the MDS that is the bottleneck. Perhaps I should have a
> lot of them...
>

Multi-MDS isn't working that great yet. In fact, CephFS hasn't gotten 
that much attention lately.

Most of the work went into RADOS and RBD. In the next iterations the 
focus will go to CephFS again, but right now it's not that well maintained.

>>
>> Are you putting both journals on the SSD when you add an OSD?  If so,
>> what's the throughput your SSD can sustain?
>>
>
> Both journals are on the SSD. It seems that when I do "ceph-osd -i $id
> --mkfs --mkkey" it creates the journal according to the settings in
> ceph.conf.
> I did some tests and my SSD drive is somewhat broken... Crucial C300 is
> a bit old and can only do 80MB/s writing.
>
>>
>> You may want to check and see how big the IOs going to disk are on the
>> OSD node, and how quickly you are filling up the journal vs writing out
>> to disk.  "collectl -sD -oT" will give you a nice report.  Iostat can
>> probably tell you all of the same stuff with the right flags.
>>
>
> Thank you for that tool.
>
> Denis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
