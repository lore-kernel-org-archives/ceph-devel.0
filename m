From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Haven't been paying attention: Gperf missing
Date: Tue, 23 May 2017 10:05:47 +0200
Message-ID: <b226809a-b527-1b54-d34f-2ac8ebf1c160@digiware.nl>
References: <9cc2b255-f617-e109-b9b9-23a32ea8509f@digiware.nl>
 <CAF-wwdFP4Wy-4Bx+wkW=btjCQokTW3QaLSaVudJJyBM=2XmaLA@mail.gmail.com>
 <9c1c2403-c114-bec9-d37b-e217d2d23e69@digiware.nl>
 <CAF-wwdFRzGxAdtXAAoieUYADZ7YQrf8u9Zkwqxs2FCk+bgwaSQ@mail.gmail.com>
 <20170523041850.GA28714@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:62136 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757355AbdEWIFv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 04:05:51 -0400
In-Reply-To: <20170523041850.GA28714@ultraspiritum.eng.arb.redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>

On 23-05-17 06:18, Adam C. Emerson wrote:
> On 23/05/2017, Brad Hubbard wrote:
>> I had to install gperf myself when this change came in (which wasn't
>> an issue for me).
>>
>> Kefu may have further input.
> 
> It's only needed if you're building RGW, at least for the moment. I use
> it as part of the S3 Bucket Policy support. (Someone else might use it
> for something else later.)

I'm trying to bld as mch as I can under FreeBSD.
And RGW was building until this sneaked in. :)
I'll add it to the depends

--WjW
