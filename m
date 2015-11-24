From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: OSD replacement feature
Date: Tue, 24 Nov 2015 12:45:36 +0800
Message-ID: <CABF_e-EMtmQYANTMTcm5NP5-s1mPsHUXtrzXfeCMoHoV2LEELA@mail.gmail.com>
References: <564E04F9.20607@dachary.org>
	<CABF_e-EyHHse14RGJnHTipZ+uG+8d0LyLVuYYJAh-NOmDXnPfA@mail.gmail.com>
	<alpine.DEB.2.00.1511200336260.25088@cobra.newdream.net>
	<564F5E6A.5050407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34575 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbKXEpg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 23:45:36 -0500
Received: by oies6 with SMTP id s6so3424604oie.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 20:45:36 -0800 (PST)
In-Reply-To: <564F5E6A.5050407@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

2015-11-21 1:54 GMT+08:00 David Zafman <dzafman@redhat.com>:
>
> There are two reasons for having a ceph-disk replace feature.
>
> 1. To simplify the steps required to replace a disk
> 2. To allow a disk to be replaced proactively without causing any data
> movement.

Hi David,

It good to without causing any data movement when we want to replaced
failure osd.

But I don't have any idea to complete it, could you give some opinions?

I though if we want to replace failure we must move the object data on
failure osd to new(replacement) osd?

Or I got some misunderstanding?

thanks!!!
vicente

>
> So keeping the osd id the same is required and is what motivated the feature
> for me.
>
> David
>
>
> On 11/20/15 3:38 AM, Sage Weil wrote:
>>
>> On Fri, 20 Nov 2015, Wei-Chung Cheng wrote:
>>>
>>> Hi Loic and cephers,
>>>
>>> Sure, I have time to help (comment) on this feature replace a disk.
>>> This is a useful feature to handle disk failure :p
>>>
>>> An simple step is described on http://tracker.ceph.com/issues/13732 :
>>> 1. set noout flag - if the broken osd is primary osd, could we handle
>>> well?
>>> 2. stop osd daemon and we need to wait the osd actually down. (or
>>> maybe use deactivate option with ceph-disk)
>>>
>>> these two above step seems OK.
>>> about handle crush map, should we remove the broken osd out?
>>> If we do that, why we set noout flag? It still trigger re-balance
>>> after we remove osd from crushmap.
>>
>> Right--I think you generally want to do either one or the other:
>>
>> 1) mark osd out, leave failed disk in place.  or, replace with new disk
>> that re-uses the same osd id.
>>
>> or,
>>
>> 2) remove osd from crush map.  replace with new disk (which gets new osd
>> id).
>>
>> I think re-using the osd id is awkward currently, so doing 1 and replacing
>> the disk ends up moving data twice.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
