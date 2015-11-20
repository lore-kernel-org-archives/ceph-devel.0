From: David Zafman <dzafman@redhat.com>
Subject: Re: OSD replacement feature
Date: Fri, 20 Nov 2015 09:54:50 -0800
Message-ID: <564F5E6A.5050407@redhat.com>
References: <564E04F9.20607@dachary.org>
 <CABF_e-EyHHse14RGJnHTipZ+uG+8d0LyLVuYYJAh-NOmDXnPfA@mail.gmail.com>
 <alpine.DEB.2.00.1511200336260.25088@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49136 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934659AbbKTRyw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Nov 2015 12:54:52 -0500
In-Reply-To: <alpine.DEB.2.00.1511200336260.25088@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


There are two reasons for having a ceph-disk replace feature.

1. To simplify the steps required to replace a disk
2. To allow a disk to be replaced proactively without causing any data 
movement.

So keeping the osd id the same is required and is what motivated the 
feature for me.

David

On 11/20/15 3:38 AM, Sage Weil wrote:
> On Fri, 20 Nov 2015, Wei-Chung Cheng wrote:
>> Hi Loic and cephers,
>>
>> Sure, I have time to help (comment) on this feature replace a disk.
>> This is a useful feature to handle disk failure :p
>>
>> An simple step is described on http://tracker.ceph.com/issues/13732 :
>> 1. set noout flag - if the broken osd is primary osd, could we handle well?
>> 2. stop osd daemon and we need to wait the osd actually down. (or
>> maybe use deactivate option with ceph-disk)
>>
>> these two above step seems OK.
>> about handle crush map, should we remove the broken osd out?
>> If we do that, why we set noout flag? It still trigger re-balance
>> after we remove osd from crushmap.
> Right--I think you generally want to do either one or the other:
>
> 1) mark osd out, leave failed disk in place.  or, replace with new disk
> that re-uses the same osd id.
>
> or,
>
> 2) remove osd from crush map.  replace with new disk (which gets new osd
> id).
>
> I think re-using the osd id is awkward currently, so doing 1 and replacing
> the disk ends up moving data twice.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

