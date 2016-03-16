From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Bumping my jenkins builds to the wall in radable.sh
Date: Wed, 16 Mar 2016 21:17:34 +0100
Message-ID: <56E9BF5E.8050900@digiware.nl>
References: <56E9A585.9000309@digiware.nl>
 <CAJ4mKGY0ev0Du5JXj1JJTCX5hgp=mui1VN+egBV_XUZYTdGy8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:31842 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965644AbcCPUSG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Mar 2016 16:18:06 -0400
In-Reply-To: <CAJ4mKGY0ev0Du5JXj1JJTCX5hgp=mui1VN+egBV_XUZYTdGy8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

On 16-3-2016 20:34, Gregory Farnum wrote:
> On Wed, Mar 16, 2016 at 11:27 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketEnt
>>
>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo
>> error: buffer::end_of_buffer
>> **** failed to decode
>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/25f5ff183bba6da708243a0bbbe40a2e
>> ****
>> error: buffer::end_of_buffer
>> **** failed to decode
>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/54f53e3e301071f48247d59272b27b53
>> ****
>>
>> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/rgw_bucket_pending_info
>>
>> "Just" a matter of rebase?
>> Or does it need more tinkering.
> 
> Well, ceph-object-corpus is a bunch of old encoded versions of our
> objects, and it's validating that current code is still capable of
> decoding them. 0.61.4 is pretty old but I *think* should still work
> (maybe check that your submodules are all up to date; maybe some of
> them got dropped?). Assuming that still works on Linux, it's not a
> rebase problem; I would guess maybe these types just never worked
> because it wasn't BSD cross-compatible until more recently. You might
> want to explore how they're failing exactly; obviously it's running
> out of data to decode but the *why* is interesting.

As Josh actually points out these errors actually occur on the Ceph
jenkins platform (probably under CentOS7).
It has not yet hit my wip-trees.

--WjW




