From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Note about rbd_aio_write usage
Date: Fri, 7 Jul 2017 08:48:06 +0200
Message-ID: <ab66c7b1-772e-910f-839e-158224ef0525@corp.ovh.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
 <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
 <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
 <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
 <CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
 <e39eba47-ae4d-05bb-41cd-928565324d6c@corp.ovh.com>
 <CA+aFP1CXkF914u1qboCC1OnK3Qqqs7w0NctDxG82u=gpmUcxmA@mail.gmail.com>
 <20170706192508.GG9832@mailware>
 <CA+aFP1B4iDjCLtpLsdPseuVfrysiatr3Bwb-i5OfZP8dt-WRpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo302.mail-out.ovh.net ([137.74.110.75]:46438 "EHLO
        2.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdGGGsJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jul 2017 02:48:09 -0400
In-Reply-To: <CA+aFP1B4iDjCLtpLsdPseuVfrysiatr3Bwb-i5OfZP8dt-WRpg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On 17-07-06 09:39 PM, Jason Dillaman wrote:
> On Thu, Jul 6, 2017 at 3:25 PM, Piotr Dałek <branch@predictor.org.pl> wrote:
>> Is that deep copy an equivalent of what
>> Jewel librbd did at unspecified point of time, or extra one?
> 
> It's equivalent / replacement -- not an additional copy. This was
> changed to support scatter/gather IO API methods which the latest
> version of QEMU now directly utilizes (eliminating the need for a
> bounce-buffer copy on every IO).

OK, that makes more sense now.

> Once we get that librados issue resolved, that initial librbd IO
> buffer copy will be dropped and librbd will become zero-copy for IO
> (at least that's the goal). That's why I am recommending that you just
> assume normal AIO semantics and not try to optimize for Luminous since
> perhaps the next release will have that implementation detail of the
> extra copy removed.

Is this: 
https://github.com/yuyuyu101/ceph/commit/794b49b5b860c538a349bdadb16bb6ae97ad9c20#commitcomment-15707924 
the issue you mention? Because at this point I'm considering switching to 
C++ API and passing static bufferptr buried in my bufferlist instead of 
having extra copy done by C API rbd_aio_write (that way I'd at least control 
the allocations).

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
