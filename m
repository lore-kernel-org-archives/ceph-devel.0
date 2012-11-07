From: Wido den Hollander <wido@widodh.nl>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Wed, 07 Nov 2012 08:35:17 +0100
Message-ID: <509A0F35.2000801@widodh.nl>
References: <5097F3BD.2000904@conversis.de> <50985677.6090708@inktank.com> <50987AB9.9030905@conversis.de> <50996548.1030602@inktank.com> <5099BAEB.3060905@conversis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:46923 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2KGHpP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 02:45:15 -0500
In-Reply-To: <5099BAEB.3060905@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org



On 07-11-12 02:35, Dennis Jacobfeuerborn wrote:
> On 11/06/2012 08:30 PM, Josh Durgin wrote:
>> On 11/05/2012 06:49 PM, Dennis Jacobfeuerborn wrote:
>>> On 11/06/2012 01:14 AM, Josh Durgin wrote:
>>>> On 11/05/2012 09:13 AM, Dennis Jacobfeuerborn wrote:
>>>>> Hi,
>>>>> I'm thinking about building a ceph cluster and I'm wondering what a good
>>>>> configuration would look like for 4-8 (and maybe more) 2HU 8-disk or 3HU
>>>>> 16-disk systems.
>>>>> Would it make sense to make each disk an individual OSD or should I
>>>>> perhaps
>>>>> create several raid-0 and create OSDs from those?
>>>>
>>>> This mainly depends on your ratio of disks to cpu/ram. Generally we
>>>> recommend 1GB ram and 1Ghz per OSD. If you've got enough cpu/ram,
>>>> running 1 OSD/disk is pretty common. It makes recovering from a
>>>> single disk failure faster.
>>>
>>> So basically a 2Ghz quad-core CPU and 8GB RAM would be sufficient for 8
>>> OSDs?
>>
>> Yes, although more RAM will be better (providing more page cache).
>>
>>>>> Also what is the best setup for the journal? If I understand it correctly
>>>>> then each OSD needs its own journal and that should be a separate disk but
>>>>> that would be quite wasteful it seems. Would it make sense to put in two
>>>>> small SSD disks in a raid-1 configuration and create a filesystem for each
>>>>> OSD journal on it?
>>>>
>>>> This is certainly possible. It's a bit less overhead if you give each
>>>> osd it's own partition of the ssd(s) instead of going through another
>>>> filesystem.
>>>>
>>>> I suspect it would be better to not use raid-1, since these ssds will be
>>>> receiving all the data the osds write as well. If they're in raid-1 instead
>>>> of being used independently, their lifetimes might be much
>>>> shorter.
>>>
>>> My primary concern here is fault tolerance. What happens when the journal
>>> disk dies? Can ceph cope with that and write directly to the OSDs or would
>>> that mean that with a single shared disk for all OSDs a failure would mean
>>> the entire system is effectively offline for ceph?
>>
>> I'm going to point to some messages in the archives to avoid repetition:
>>
>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6377
>>
>>>>> How does the number of OSDs/Nodes affect the performance of say a
>>>>> single dd
>>>>> operation? Will blocks be distributed over the cluster and written/read in
>>>>> parallel or does the number only improve concurrency rather than benefit
>>>>> single threaded workloads?
>>>>
>>>> In cephfs and rbd, objects are distributed over the cluster, but the
>>>> OSDs/node ratio doesn't really affect the performance. It's more
>>>> dependent on the workload and striping policy. For example, with
>>>> a small stripe size, small sequential writes will benefit from more
>>>> osds, but the number per node isn't particularly important.
>>>
>>> By OSDs/Nodes I really meant "OSDs or nodes" and not the ratio. What I'm
>>> trying to understand is if a) the number of nodes plays a significant role
>>> when it comes to performance (e.g. a 4 node cluster with large disks vs. a
>>> 16 node cluster with smaller disks) and b) how much of an impact the number
>>> of OSDs has on the cluster e.g. an 8 node cluster with each node being a
>>> single OSD (with all disks as raid-0) vs. an 8 node cluster with say 64
>>> OSDs (each node with 8 disks as individual OSDs).
>>
>> Generally more smaller nodes will recover faster from a node or disk
>> failure than a few larger node, since the remaining OSDs recover in
>> parallel. There are some other advantages of many small nodes. Wido and
>> Stefan covered this well in this thread:
>>
>> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/10212
>>
>
> So that sound like a raid-1 (or potentially a raid-10) is pretty much a
> must when using a shared ssd disk for the journals for more than one OSD.
> Without redundancy the failure of a single disk (the journal one) would
> take down all OSDs on that node making a multi OSD per node setup pointless.
>

Except that SSDs will mainly fail due to the amount of write cycles they 
had to endure.

So in RAID-1 your SSDs will fail at almost the same time.

With for example 8 OSDs in a server you better spread them out 50/50 
over two SSDs.

Wido

> Regards,
>    Dennis
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
