From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial newstore vs filestore results
Date: Wed, 08 Apr 2015 22:19:40 -0500
Message-ID: <5525EFCC.3070607@redhat.com>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com> <55248856.1010808@redhat.com> <alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54438 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbbDIDTn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Apr 2015 23:19:43 -0400
In-Reply-To: <alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/07/2015 09:58 PM, Sage Weil wrote:
> On Tue, 7 Apr 2015, Mark Nelson wrote:
>> On 04/07/2015 02:16 PM, Mark Nelson wrote:
>>> On 04/07/2015 09:57 AM, Mark Nelson wrote:
>>>> Hi Guys,
>>>>
>>>> I ran some quick tests on Sage's newstore branch.  So far given that
>>>> this is a prototype, things are looking pretty good imho.  The 4MB
>>>> object rados bench read/write and small read performance looks
>>>> especially good.  Keep in mind that this is not using the SSD journals
>>>> in any way, so 640MB/s sequential writes is actually really good
>>>> compared to filestore without SSD journals.
>>>>
>>>> small write performance appears to be fairly bad, especially in the RBD
>>>> case where it's small writes to larger objects.  I'm going to sit down
>>>> and see if I can figure out what's going on.  It's bad enough that I
>>>> suspect there's just something odd going on.
>>>>
>>>> Mark
>>>
>>> Seekwatcher/blktrace graphs of a 4 OSD cluster using newstore for those
>>> interested:
>>>
>>> http://nhm.ceph.com/newstore/
>>>
>>> Interestingly small object write/read performance with 4 OSDs was about
>>> 1/3-1/4 the speed of the same cluster with 36 OSDs.
>>>
>>> Note: Thanks Dan for fixing the directory column width!
>>>
>>> Mark
>>
>> New fio/librbd results using Sage's latest code that attempts to keep small
>> overwrite extents in the db.  This is 4 OSD so not directly comparable to the
>> 36 OSD tests above, but does include seekwatcher graphs.  Results in MB/s:
>>
>> 	write	read	randw	randr
>> 4MB	57.9	319.6	55.2	285.9
>> 128KB	2.5	230.6	2.4	125.4
>> 4KB	0.46	55.65	1.11	3.56
>
> What would be very interesting would be to see the 4KB performance
> with the defaults (newstore overlay max = 32) vs overlays disabled
> (newstore overlay max = 0) and see if/how much it is helping.

And here we go.  1 OSD, 1X replication.  16GB RBD volume.

4MB		write	read	randw	randr
default overlay	36.13	106.61	34.49	92.69
no overlay	36.29	105.61	34.49	93.55
				
128KB		write	read	randw	randr
default overlay	1.71	97.90	1.65	25.79
no overlay	1.72	97.80	1.66	25.78
				
4KB		write	read	randw	randr
default overlay	0.40	61.88	1.29	1.11
no overlay	0.05	61.26	0.05	1.10

seekwatcher movies generating now, but I'm going to bed soon so I'll 
have to wait until tomorrow morning to post them. :)

>
> The latest branch also has open-by-handle.  It's on by default (newstore
> open by handle = true).  I think for most workloads it won't be very
> noticeable... I think there are two questions we need to answer though:
>
> 1) Does it have any impact on a creation workload (say, 4kb objects).  It
> shouldn't, but we should confirm.
>
> 2) Does it impact small object random reads with a cold cache.  I think to
> see the effect we'll probably need to pile a ton of objects into the
> store, drop caches, and then do random reads.  In the best case the
> effect will be small, but hopefully noticeable: we should go from
> a directory lookup (1+ seeks) + inode lookup (1+ seek) + data
> read, to inode lookup (1+ seek) + data read.  So, 3 -> 2 seeks best case?
> I'm not really sure what XFS is doing under the covers here...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
