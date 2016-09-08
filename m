From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore memory leak
Date: Wed, 7 Sep 2016 21:03:52 -0500
Message-ID: <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
References: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbcIHCD4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Sep 2016 22:03:56 -0400
In-Reply-To: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,

I complained loudly and often enough to get Sage to take a look and he 
fixed a bunch of stuff. :)  The following PR dramatically improves 
things, though I haven't verified that it's totally fixed yet:

https://github.com/ceph/ceph/pull/11011

Mark

On 09/07/2016 08:08 PM, Somnath Roy wrote:
> Sage,
> As Mark said, the latest code has severe memory leak , my system memory (64GB) started swapping after 3 min of 4K RW run.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
