From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: OSD replacement feature
Date: Sat, 21 Nov 2015 00:40:13 +0800
Message-ID: <CABF_e-FO87w1V7eB0nqGtxj4Lg+1xqyWw3KMY7cRtOusGXugoA@mail.gmail.com>
References: <564E04F9.20607@dachary.org>
	<CABF_e-EyHHse14RGJnHTipZ+uG+8d0LyLVuYYJAh-NOmDXnPfA@mail.gmail.com>
	<alpine.DEB.2.00.1511200336260.25088@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34713 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760748AbbKTQkO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 11:40:14 -0500
Received: by oies6 with SMTP id s6so68465133oie.1
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 08:40:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511200336260.25088@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2015-11-20 19:38 GMT+08:00 Sage Weil <sage@newdream.net>:
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
>
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

Hi sage,

If the osd on "DNE" status, its weight must be zero and trigger moving
object data?

In my test cases, I only remove the auth key and osd-id (osd is "DNE" status).
Then replace with new disk that re-uses the same osd-id.

The osd only has little time on the out status.
I think this operation could reduce some redundant data moving.
How you think this operation? or just like you say.
mark osd out (deactivate/destroy ...etc) and replace with new disk
that re-uses the same osd id?

btw, if we just use ceph-deploy/ceph-disk, we could not create osd
with specific osd-id.
that should we implement for it?

thanks!!!
vicente
