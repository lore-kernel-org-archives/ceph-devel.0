From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2] ceph: set io_pages bdi hint
Date: Mon, 9 Jan 2017 09:54:48 +0800
Message-ID: <774F5CAC-5D5B-42D0-BDF2-D9AB5F042293@redhat.com>
References: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com>
 <1483622696-30353-1-git-send-email-andreas.gerstmayr@catalysts.cc>
 <CAOi1vP9b9=magMgdgW+tfwL2CW2ZEFLao7fAOSxnOfNiYbT2uA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbdAIByy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 8 Jan 2017 20:54:54 -0500
In-Reply-To: <CAOi1vP9b9=magMgdgW+tfwL2CW2ZEFLao7fAOSxnOfNiYbT2uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Cc: Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, andreas.gerstmayr@gmail.com, Sage Weil <sage@redhat.com>


> On 8 Jan 2017, at 00:31, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Thu, Jan 5, 2017 at 4:23 PM, Andreas Gerstmayr
> <andreas.gerstmayr@catalysts.cc> wrote:
>> This patch sets the io_pages bdi hint based on the rvsize mount option.
>> Without this patch large buffered reads (request size > max readahead)
>> are processed sequentially in chunks of the readahead size (i.e. read
>> requests are sent out up to the readahead size, then the
>> do_generic_file_read() function waits until the first page is received).
>> 
>> With this patch read requests are sent out up to the size specified in
>> the new rvsize mount option at once (default: 64 MB).
>> 
>> Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
>> ---
>> 
>> Thanks for your review.
>> On second thought, I think I should not reuse the rsize mount option
>> (maximum read size per OSD request), therefore I created a new mount
>> option rvsize with a default value of 64 MB (as you suggested).
>> 
>> (Note: This patch depends on kernel version 4.10-rc1)
> 
> I'll defer to Zheng's judgement, but a separate mount option for this
> seems overkill to me.  We should be able to work something out between
> the existing rsize and rasize.

I agree with Ilya. I think we can user rsize here.

Regards
Yan, Zheng

> 
> Thanks,
> 
>                Ilya

