From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Thu, 25 Jul 2013 20:27:00 +0800
Message-ID: <CAAM7YAnDKvGBsXxzbcsFHTbTo7-7AgNnRXRCK+gEbvkwGuj5cg@mail.gmail.com>
References: <201307250852310158703@gmail.com>
	<alpine.DEB.2.00.1307242252080.10870@cobra.newdream.net>
	<201307251455102701172@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47974 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab3GYM1D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 08:27:03 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so1490279lbi.15
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 05:27:01 -0700 (PDT)
In-Reply-To: <201307251455102701172@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 25, 2013 at 2:55 PM, majianpeng <majianpeng@gmail.com> wrote:
>>On Thu, 25 Jul 2013, majianpeng wrote:
>>> Hi all,
>>>      I met a problem and ask somebody could help me.
>>> In func striped_read()
>>> > if (ret > 0) {
>>> >                int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>>>
>>> >                if (read < pos - off) {
>>> >                       dout(" zero gap %llu to %llu\n", off + read, pos);
>>> >                        ceph_zero_page_vector_range(page_align + read,
>>> >                                                    pos - off - read, pages);
>>> >                }
>>> >                pos += ret;

I think you are right. probably above line should be 'pos += this_len'

regards
yan, zheng


>>> >               read = pos - off;
>>>
>>> At first , pos = off and off don't modify.
>>> Why does it judge 'read < pos -off ' ?
>>> Because the read = pos -off, so the read must equal pos -off.
>>
>>This block triggers if we hit a stripe.  off is always the original
>>starting offset.  pos is the current position that we just tried to read
>>from.  We might:
>>
>> - try to read a big extent from off == pos
>> - readpages truncates this to the end of the object
>> - we get a short read (not a complete object)
> What's the mean of not a complete object?
> FYI,a short read maybe  met the boundry of stripe(object) or the EOF of file.
> For the hole of file, i don't know how to handle.
>> - read is some partial amount
>> - pos is off + read + a gap
> From the code : read = pos - off; after that, the pos don't change.
> So the a gap where is from?
>
> Thanks!
> Jianpeng Ma
>> - we try to read from the next object and there is data
>>   => there was a hole and we need to zero the gap
>>
>>If, on the other hand, there isn't data in the next object, then we don't
>>want to zero the hole.. and least not until we decide where EOF is.
>>That's why this block is where it is, and never triggers on the first
>>iteration.
>>
>>Does that make sense?
>>sage
