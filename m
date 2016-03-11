From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: [PATCH 0/2] ceph osd: initial VMware VAAI support
Date: Fri, 11 Mar 2016 10:16:47 +0530
Message-ID: <56E24DB7.6010302@redhat.com>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
 <1457591672-17430-1-git-send-email-mchristi@redhat.com>
 <56E11607.8070200@redhat.com> <20160310130423.1383631a@echidna.suse>
 <56E1F912.1000509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbcCKEqy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 23:46:54 -0500
In-Reply-To: <56E1F912.1000509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, David Disseldorp <ddiss@suse.de>, Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 03/11/2016 04:15 AM, Josh Durgin wrote:
> On 03/10/2016 04:04 AM, David Disseldorp wrote:
>> On Thu, 10 Mar 2016 00:36:55 -0600, Mike Christie wrote:
>>
>> ...
>>>> This does not include support for XCOPY/extended copy. I
>>>> am still looking into this, but it seems it might be
>>>> difficult to support due to rbd being more tuned to cloning
>>>> entire devices. When we implement VASA, the cloneVirtualVolume
>>>> might be something we can support though.
>>
>> I suppose the src-and-dest-in-same-pg requirement would complicate
>> things quite a bit, but wouldn't clonerange be an option for XCOPY
>> offloads?
>
> It's not a good fit, since with multiple clones putting data on the
> same set of osds, the workload and space utilization gets skewed for
> that set of osds compared to the rest of the cluster.
>
> It also won't give you fast cloning - it's a full copy on xfs, and
> you'd need to do one for every object affected.

Note that XFS is working on reflink code at the moment and that the kernel 
people are looking at new system calls that will allow copy offload generically.

Specifically, that will give XFS (and other file systems like btrfs) the ability 
to do a zero data movement pseudo copy (copy on write version) of a file.

That would make this interesting I think to think about doing...

Regards,

Ric

>
> Due to these limitations, lack of existing clonerange use, and the
> complications it brings to the osd as the only op affecting more than
> one object, we've talked about removing the clonerange op.
>
> Josh

