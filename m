From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: do not return -ERANGE on auth failure
Date: Thu, 11 Sep 2014 20:27:53 +0400
Message-ID: <CALFYKtAyR_hNMa92UL7v3bkHx6gCQ-O1G=98Ls08Cq8Ly_imbg@mail.gmail.com>
References: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>
	<5411BE6F.1040202@ieee.org>
	<CALFYKtAH_9nQWWyOEcEectWzWQxsNBVHRSPVt_QbU8rfG1_YFA@mail.gmail.com>
	<5411CCA5.1070900@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:61980 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259AbaIKQ15 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 12:27:57 -0400
Received: by mail-qg0-f44.google.com with SMTP id f51so9141827qge.31
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 09:27:54 -0700 (PDT)
In-Reply-To: <5411CCA5.1070900@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 11, 2014 at 8:24 PM, Alex Elder <elder@ieee.org> wrote:
> On 09/11/2014 11:17 AM, Ilya Dryomov wrote:
>> On Thu, Sep 11, 2014 at 7:23 PM, Alex Elder <elder@ieee.org> wrote:
>>> On 09/11/2014 10:10 AM, Ilya Dryomov wrote:
>>>> Trying to map an image out of a pool for which we don't have an 'x'
>>>> permission bit fails with -ERANGE from ceph_extract_encoded_string()
>>>> due to an unsigned vs signed bug.  Fix it and get rid of the -ENIVAL
>>>> sink, thus exposing rbd::get_id cls method return value.  (I've seen
>>>> a bunch of unexplained -ERANGE reports, I bet this is it).
>>>>
>>>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>>>
>>> I often think people are annoyed by my explicit type casts
>>> all over the place.  This (missed) one matters a lot.
>>>
>>> I think the -EINVAL was to ensure an error code that was
>>> expected by a write() call would be returned.
>>
>> Yeah, the way it's written it's possible in theory to get a positive
>> return value from rbd_dev_image_id().  Looking deeper, this sizeof() is
>> not needed at all - ceph_extract_encoded_string() deals with short
>> buffers as it should.  As for the ret == sizeof(u32) (i.e. an empty
>> string), neither userspace nor us check against empty strings in
>> similar cases (object prefix, snapshot name, etc).
>
> I should have asked this before.  Why is a permission error
> leading to ceph_extract_encoded_string() finding a short
> buffer?  I didn't take the time to trace the error path
> you're talking about here all the way back.

rbd_obj_method_sync() returns -EPERM, which when compared with size_t
from sizeof() ends up a big positive.  ceph_extract_encoded_string() is
then called and the safe decode macro kicks in..

Thanks,

                Ilya
