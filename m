From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2] ceph: set io_pages bdi hint
Date: Tue, 10 Jan 2017 14:42:13 +0800
Message-ID: <7C9D4085-7D14-4BFB-B675-8FE3C661B1C3@redhat.com>
References: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com>
 <1483622696-30353-1-git-send-email-andreas.gerstmayr@catalysts.cc>
 <CAOi1vP9b9=magMgdgW+tfwL2CW2ZEFLao7fAOSxnOfNiYbT2uA@mail.gmail.com>
 <774F5CAC-5D5B-42D0-BDF2-D9AB5F042293@redhat.com>
 <3a636d32-e277-9e8b-97c5-f004ae2a4643@catalysts.cc>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdAJGmX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Jan 2017 01:42:23 -0500
In-Reply-To: <3a636d32-e277-9e8b-97c5-f004ae2a4643@catalysts.cc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, andreas.gerstmayr@gmail.com, Sage Weil <sage@redhat.com>


> On 9 Jan 2017, at 17:29, Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc> wrote:
> 
> Am 09.01.2017 um 02:54 schrieb Yan, Zheng:
>> 
>>> On 8 Jan 2017, at 00:31, Ilya Dryomov <idryomov@gmail.com> wrote:
>>> 
>>> On Thu, Jan 5, 2017 at 4:23 PM, Andreas Gerstmayr
>>> <andreas.gerstmayr@catalysts.cc> wrote:
>>>> This patch sets the io_pages bdi hint based on the rvsize mount option.
>>>> Without this patch large buffered reads (request size > max readahead)
>>>> are processed sequentially in chunks of the readahead size (i.e. read
>>>> requests are sent out up to the readahead size, then the
>>>> do_generic_file_read() function waits until the first page is received).
>>>> 
>>>> With this patch read requests are sent out up to the size specified in
>>>> the new rvsize mount option at once (default: 64 MB).
>>>> 
>>>> Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
>>>> ---
>>>> 
>>>> Thanks for your review.
>>>> On second thought, I think I should not reuse the rsize mount option
>>>> (maximum read size per OSD request), therefore I created a new mount
>>>> option rvsize with a default value of 64 MB (as you suggested).
>>>> 
>>>> (Note: This patch depends on kernel version 4.10-rc1)
>>> 
>>> I'll defer to Zheng's judgement, but a separate mount option for this
>>> seems overkill to me.  We should be able to work something out between
>>> the existing rsize and rasize.
>> 
>> I agree with Ilya. I think we can user rsize here.
> 
> But then we are using a single config option for two different purposes?
> - to specify the maximum size of a single read request to an OSD
> - to specify the maximum cumulative size of read requests sent out at
>  once

limit max size of single request does not make much sense. The only case
I can think of is system has limited memory. For that case, it does not make
sense to send parallel requests.

Regards
Yan, Zheng

> 
> In general the latter will be a multiple of the former.
> 
> 
> Regards,
> Andreas

