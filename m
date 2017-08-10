From: Dan van der Ster <dan@vanderster.com>
Subject: Re: default debug_client level is too high
Date: Thu, 10 Aug 2017 09:10:35 +0200
Message-ID: <CABZ+qqmQyODWL_Df2yKFSt3DSH+eCiJDdD5J0AXCVFc6MG3_FA@mail.gmail.com>
References: <CABZ+qq=cNRn+18bLM6_T_weeEAweg9jKe2n8jjitsDz7bgtpNQ@mail.gmail.com>
 <CALe9h7fXYc_nLB-rybtoz7QNaXVwHsMF5k+XH_sgLS7e+ndV+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37234 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdHJHLR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Aug 2017 03:11:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id j194so7786813oib.4
        for <ceph-devel@vger.kernel.org>; Thu, 10 Aug 2017 00:11:16 -0700 (PDT)
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id c22sm6052204oig.27.2017.08.10.00.11.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 00:11:15 -0700 (PDT)
Received: by mail-oi0-f51.google.com with SMTP id x3so82471950oia.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Aug 2017 00:11:15 -0700 (PDT)
In-Reply-To: <CALe9h7fXYc_nLB-rybtoz7QNaXVwHsMF5k+XH_sgLS7e+ndV+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 9, 2017 at 6:42 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, Aug 9, 2017 at 5:32 PM, Dan van der Ster <dan@vanderster.com> wrote:
>> Hi all,
>>
>> During some ceph-fuse perf testing I've noticed that small buffered
>> write throughput is slowed down by the debug_client ldout logs.
>> At the default 0/5, the in mem log is filled with, e.g.:
>>
>>  -9760> 2017-08-09 18:16:10.487511 7f848c1a5700  3 client.407554315
>> xattr_permission 0x7f84a52c8a00 = 0
>>  -9759> 2017-08-09 18:16:10.487515 7f848c1a5700  3 client.407554315
>> _getxattr(10003284f73, "security.capability", 0) = -61
>>  -9758> 2017-08-09 18:16:10.487525 7f848c1a5700  3 client.407554315
>> ll_forget 10003284f73 1
>>  -9757> 2017-08-09 18:16:10.487542 7f848b9a4700  3 client.407554315
>> ll_write 0x7f84a5147680 10003284f73 71824~1
>>  -9756> 2017-08-09 18:16:10.487566 7f848b9a4700  3 client.407554315
>> ll_write 0x7f84a5147680 71824~1 = 1
>>  -9755> 2017-08-09 18:16:10.487599 7f848c9a6700  3 client.407554315
>> ll_getxattr 10003284f73.head security.capability size 0
>>  -9754> 2017-08-09 18:16:10.487609 7f848c9a6700  3 client.407554315
>> xattr_permission 0x7f84a52c8a00 = 0
>>  -9753> 2017-08-09 18:16:10.487612 7f848c9a6700  3 client.407554315
>> _getxattr(10003284f73, "security.capability", 0) = -61
>>
>> (so even tiny 1 byte buffered writes result in huge amounts of logging work).
>>
>> In a simple test [1], I found that 100000 one byte writes takes
>> ~10-11s with the default client log level, and ~5 to 6s with
>> debug_client=0/2.
>
> Wow, I had no idea the overhead was so high!
>
>> I would therefore propose either increasing the ldout level for these
>> ll_* client ops to 6, or decreasing the default debug_client level to
>> 0/2.
>
> Hmm.  I'm not sure what would be left in the memory log at 0/2 though?
>  For example in the case of a crash would we even have the message
> from the start of the operation that crashed?

AFAICT only mount/umount get logged at level 2.

-- Dan


>
> John
>
>>
>> Any opinions?
>>
>> Cheers, Dan
>>
>> [1]
>> for i in xrange(100000):
>>   f.write('x')
>>   f.flush()
>> f.close()
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
