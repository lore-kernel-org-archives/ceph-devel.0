From: Andrew Thrift <andyonfire@gmail.com>
Subject: Re: Large numbers of OSD per node
Date: Tue, 06 Nov 2012 15:05:30 +1300
Message-ID: <5098706A.9040506@gmail.com>
References: <5097676B.5020200@gmail.com> <50979CA3.3060005@widodh.nl> <5097B4E5.8070706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cps.hostingdirect.co.nz ([210.79.48.6]:45733 "EHLO
	cps.hd.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933421Ab2KFCFp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Nov 2012 21:05:45 -0500
In-Reply-To: <5097B4E5.8070706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, mark.nelson@inktank.com, wido@widodh.nl

Mark, Wido,

Thank you very much for your informed responses.

What you have mentioned makes a lot of sense.

If we had a single node completely fail, we would have 72TB of data that 
needed to be replicated to a new OSD.  This would take approximately 
10.5 hours to complete over 2x Bonded 10gig connections, and would put 
the other two nodes under significant load while the data is replicated.

We were looking at using CEPH "Heads" with SAS enclosres as a lower cost 
solution than buying more nodes.  I can however see the IO/resiliency 
benefits of more nodes.



Regards,




Andrew






On 11/6/2012 1:45 AM, Mark Nelson wrote:
> On 11/05/2012 05:01 AM, Wido den Hollander wrote:
>> Hi,
>>
>> On 05-11-12 08:14, Andrew Thrift wrote:
>>> Hi,
>>>
>>> We are evaluating CEPH for deployment.
>>>
>>> I was wondering if there are any current "best practices" around the
>>> number of OSD's per node ?
>>>
>>>
>>> e.g. We are looking at deploying 3 nodes, each with 72x SAS disks, and
>>> 2x 10gigabit Ethernet bonded.
>>>
>>> Would this best be configured as 72 OSD's per node.
>>>
>>> Or would we be better to using raid5 to have 18 OSD's per node ?
>>>
>>
>> You should be aware of a large data movement when using 3 nodes.
>>
>> I myself am I fan of going with a lot of smaller nodes instead of
>> building big nodes.
>>
>> With 3 such nodes you'd probably be going 2x replication? Otherwise you
>> can never recover when one of the 3 nodes completely burns down to the
>> ground.
>>
>> If you have 72 1TB disks in such a node you could in theory be moving
>> 72TB, that would put a lot of stress on the other two nodes and you
>> would need a lot of memory and CPU power.
>>
>> You might be better of by going for 27 nodes with 8 disks each, or have
>> 18 nodes with 12 disks?
>>
>> When a node fails the recovery will be much easier on your cluster.
>>
>> You can also take out a node for maintenance when needed.
>>
>> Another thing you should be aware of is status "D". What if a filesystem
>> inside one of your big machines hangs and one of the OSDs hangs in
>> status "D", waiting for I/O which will never come?
>>
>> You'd be forced to reboot that node and that would again take 72TB of
>> data offline.
>>
>> I am not aware of anybody using such big nodes in production. It could
>> work, but you will need a lot of memory and a lot of CPU.
>>
>> The recommendation is 1GB/1Ghz per OSD, so you'd be looking at at least
>> 72GB of memory and 72Ghz of CPU power.
>>
>> Wido
>
>
>
> To echo what Wido is saying here, we've not really extensively tested
> configurations with nodes that big at Inktank either.  The biggest test
> node we have in-house is a 36-drive SC847a, and that was a pretty recent
> acquisition.  Nodes that large are definitely bigger than what most
> people are looking at right now.
>
> For a deployment of the size you are talking about, I think you'd
> probably be better served with 24 disk or less nodes and picking up more
> of them.  You'll likely have better performance and fewer problems if a
> node goes down.  It is lower density, but I think in this case using up
> a few extra U will be worth it.
>
> Having said that, my guess is that if you were to use 72 drive nodes,
> you'd probably be best off doing a raid-5 or raid-6 and doing something
> like 12 6-drive OSDs.  Be mindful of what drives, expanders, and
> controllers you pick.
>

