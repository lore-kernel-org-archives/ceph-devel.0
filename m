From: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Subject: Re: [PATCH v2] ceph: set io_pages bdi hint
Date: Mon, 9 Jan 2017 10:29:36 +0100
Message-ID: <3a636d32-e277-9e8b-97c5-f004ae2a4643@catalysts.cc>
References: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com>
 <1483622696-30353-1-git-send-email-andreas.gerstmayr@catalysts.cc>
 <CAOi1vP9b9=magMgdgW+tfwL2CW2ZEFLao7fAOSxnOfNiYbT2uA@mail.gmail.com>
 <774F5CAC-5D5B-42D0-BDF2-D9AB5F042293@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from exchange.catalysts.cc ([81.10.172.115]:30362 "EHLO
        mail01-vie.catalysts.cc" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753051AbdAIK3j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 05:29:39 -0500
In-Reply-To: <774F5CAC-5D5B-42D0-BDF2-D9AB5F042293@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, andreas.gerstmayr@gmail.com, Sage Weil <sage@redhat.com>

Am 09.01.2017 um 02:54 schrieb Yan, Zheng:
>
>> On 8 Jan 2017, at 00:31, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Thu, Jan 5, 2017 at 4:23 PM, Andreas Gerstmayr
>> <andreas.gerstmayr@catalysts.cc> wrote:
>>> This patch sets the io_pages bdi hint based on the rvsize mount option.
>>> Without this patch large buffered reads (request size > max readahead)
>>> are processed sequentially in chunks of the readahead size (i.e. read
>>> requests are sent out up to the readahead size, then the
>>> do_generic_file_read() function waits until the first page is received).
>>>
>>> With this patch read requests are sent out up to the size specified in
>>> the new rvsize mount option at once (default: 64 MB).
>>>
>>> Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
>>> ---
>>>
>>> Thanks for your review.
>>> On second thought, I think I should not reuse the rsize mount option
>>> (maximum read size per OSD request), therefore I created a new mount
>>> option rvsize with a default value of 64 MB (as you suggested).
>>>
>>> (Note: This patch depends on kernel version 4.10-rc1)
>>
>> I'll defer to Zheng's judgement, but a separate mount option for this
>> seems overkill to me.  We should be able to work something out between
>> the existing rsize and rasize.
>
> I agree with Ilya. I think we can user rsize here.

But then we are using a single config option for two different purposes?
- to specify the maximum size of a single read request to an OSD
- to specify the maximum cumulative size of read requests sent out at
   once

In general the latter will be a multiple of the former.


Regards,
Andreas
