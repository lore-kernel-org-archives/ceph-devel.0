From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: do not return -ERANGE on auth failure
Date: Thu, 11 Sep 2014 11:24:05 -0500
Message-ID: <5411CCA5.1070900@ieee.org>
References: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>	<5411BE6F.1040202@ieee.org> <CALFYKtAH_9nQWWyOEcEectWzWQxsNBVHRSPVt_QbU8rfG1_YFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:43726 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaIKQYH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 12:24:07 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar1so6225885iec.7
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 09:24:06 -0700 (PDT)
In-Reply-To: <CALFYKtAH_9nQWWyOEcEectWzWQxsNBVHRSPVt_QbU8rfG1_YFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 09/11/2014 11:17 AM, Ilya Dryomov wrote:
> On Thu, Sep 11, 2014 at 7:23 PM, Alex Elder <elder@ieee.org> wrote:
>> On 09/11/2014 10:10 AM, Ilya Dryomov wrote:
>>> Trying to map an image out of a pool for which we don't have an 'x'
>>> permission bit fails with -ERANGE from ceph_extract_encoded_string()
>>> due to an unsigned vs signed bug.  Fix it and get rid of the -ENIVAL
>>> sink, thus exposing rbd::get_id cls method return value.  (I've seen
>>> a bunch of unexplained -ERANGE reports, I bet this is it).
>>>
>>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>>
>> I often think people are annoyed by my explicit type casts
>> all over the place.  This (missed) one matters a lot.
>>
>> I think the -EINVAL was to ensure an error code that was
>> expected by a write() call would be returned.
> 
> Yeah, the way it's written it's possible in theory to get a positive
> return value from rbd_dev_image_id().  Looking deeper, this sizeof() is
> not needed at all - ceph_extract_encoded_string() deals with short
> buffers as it should.  As for the ret == sizeof(u32) (i.e. an empty
> string), neither userspace nor us check against empty strings in
> similar cases (object prefix, snapshot name, etc).

I should have asked this before.  Why is a permission error
leading to ceph_extract_encoded_string() finding a short
buffer?  I didn't take the time to trace the error path
you're talking about here all the way back.

(I'm looking at your new patch in the mean time.)

					-Alex
