From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Bumping my jenkins builds to the wall in radable.sh
Date: Wed, 16 Mar 2016 13:06:46 -0700
Message-ID: <CAJ4mKGbKaSt=r8ZFp+cX+11nB_gKdjMPgT1+2AeMm8G1Np830A@mail.gmail.com>
References: <56E9A585.9000309@digiware.nl>
	<CAJ4mKGY0ev0Du5JXj1JJTCX5hgp=mui1VN+egBV_XUZYTdGy8A@mail.gmail.com>
	<56E9BBD2.5050700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34429 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965520AbcCPUGr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 16:06:47 -0400
Received: by mail-vk0-f50.google.com with SMTP id e185so76350234vkb.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 13:06:46 -0700 (PDT)
In-Reply-To: <56E9BBD2.5050700@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

On Wed, Mar 16, 2016 at 1:02 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 03/16/2016 12:34 PM, Gregory Farnum wrote:
>>
>> On Wed, Mar 16, 2016 at 11:27 AM, Willem Jan Withagen <wjw@digiware.nl>
>> wrote:
>>>
>>>
>>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketEnt
>>>
>>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo
>>> error: buffer::end_of_buffer
>>> **** failed to decode
>>>
>>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/25f5ff183bba6da708243a0bbbe40a2e
>>> ****
>>> error: buffer::end_of_buffer
>>> **** failed to decode
>>>
>>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/54f53e3e301071f48247d59272b27b53
>>> ****
>>>
>>>
>>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/rgw_bucket_pending_info
>>>
>>> "Just" a matter of rebase?
>>> Or does it need more tinkering.
>>
>>
>> Well, ceph-object-corpus is a bunch of old encoded versions of our
>> objects, and it's validating that current code is still capable of
>> decoding them. 0.61.4 is pretty old but I *think* should still work
>> (maybe check that your submodules are all up to date; maybe some of
>> them got dropped?). Assuming that still works on Linux, it's not a
>> rebase problem; I would guess maybe these types just never worked
>> because it wasn't BSD cross-compatible until more recently. You might
>> want to explore how they're failing exactly; obviously it's running
>> out of data to decode but the *why* is interesting.
>
>
> It's broken on linux on master:
>
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-amd64-basic/log.cgi?log=188644cb753fe304d941051b75b9eac49ede1086
> https://jenkins.ceph.com/job/ceph-pull-requests/3220/console
>
> Probably snuck in while 'make check' was broken from the crush update.

Oh, and the very next commit after that is the fix, so yes, a rebase
should fix it. (Thanks Kefu+Casey!)
