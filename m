From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Pgs distribution evenly across osds
Date: Tue, 7 Feb 2017 20:48:15 -0600
Message-ID: <32478390-b790-226f-59aa-15f76d1c247e@redhat.com>
References: <731B4B00-3D93-4E2B-9A32-5F50BDF84177@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752968AbdBHCsQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 21:48:16 -0500
In-Reply-To: <731B4B00-3D93-4E2B-9A32-5F50BDF84177@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi James,

I'm not sage, but I'll chime in since I spent some time thinking about 
this stuff a while back when I was playing around with halton 
distributions for PG placement.  It's very difficult to get even 
distributions using random sampling unless you have a *very* high number 
of samples.  The following equations give you a reasonable expectation 
of what the min/max should be assuming an evenly weighted random 
distribution:

min = (pgs / osds) - sqrt(2*pgs*log(osds)/osds)
max = (pgs / osds) + sqrt(2*pgs*log(osds)/osds)

In your case that's:

min = 49152/168 - sqrt(2*49152*log(168)/168) = 256
max = 49152/168 + sqrt(2*49152*log(168)/168) = 329

In terms of performance potential and data distribution evenness, I'd 
argue you really want to know how bad your worst oversubscribed PG is vs 
the average:

Expected: (49152/168)/329 = ~88.9%
Actual: (49152/168)/333 = = ~87.9%

Your numbers are a little worse, though typically I see our 
distributions hover right around expected or just slightly better.  This 
particular roll of the dice might have just been a little worse.

If you jumped up to say 100K PGs:

min = 1000000/168 - sqrt(2*1000000*log(168)/168) = 544
max = 1000000/168 + sqrt(2*1000000*log(168)/168) = 647

Expected: (100000/168)/647 = ~92%

Now if you jumped up to 1 million PGs:

min = 1000000/168 - sqrt(2*1000000*log(168)/168) = 5790
max = 1000000/168 + sqrt(2*1000000*log(168)/168) = 6115

Expected: (1000000/168)/6115 = ~97.3%

Thanks,
Mark

On 02/07/2017 06:14 PM, LIU, Fei wrote:
> Hi Sage,
>   We are trying to distribute pgs evenly across osds. However, after certain tunes, we still got 30% difference among max pgs  and min pg  of OSDs (OSD 9 has 13.8% more pgs than average and OSD 86 has 15.2% less pgs than average).  Any good suggestions to make PGs distributed evenly across OSDs?
>
>   Thanks,
>   James
>
>
> SUM :   49152   |
> Osd :   168     |
> AVE :   292.57  |
> Max :   333     |
> Osdid : osd.9   |
> per:    13.8%   |
> ------------------------
> min :   248     |
> osdid : osd.86  |
> per:    -15.2%  |
>
> [james.liu@a18d13422.eu13 /home/james.liu]
> $
>
>
> 本邮件及其附件含有阿里巴巴集团的商业秘密信息，仅限于发送给上面地址中列出的个人和群组，禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制和散发）本邮件及其附件中的信息，如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
> This email and its attachments contain confidential information from Alibaba Group.which is intended only for the person or entity whose address is listed above.Any use of information contained herein in any way(including,but not limited to,total or partial disclosure,reproduction or dissemination)by persons other than the intended recipient(s) is prohibited.If you receive this email in error,please notify the sender by phone or email immediately and delete it.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
