From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Pgs distribution evenly across osds
Date: Mon, 13 Feb 2017 18:17:23 -0600
Message-ID: <adf8c055-15c1-94db-d4f6-61eefa82bef0@redhat.com>
References: <731B4B00-3D93-4E2B-9A32-5F50BDF84177@alibaba-inc.com>
 <32478390-b790-226f-59aa-15f76d1c247e@redhat.com>
 <36A35D18-3331-4B49-88C6-C7A181F12FC5@alibaba-inc.com>
 <753C3729-DF1E-4FEB-9448-4CEDF74D9195@alibaba-inc.com>
 <5de83f94-aab0-70ed-7b76-a41e047361c0@redhat.com>
 <CAAT80S67huScoCov-QttVQ6sH-7tt5zpB_K0t0T+C78tGqNKrA@mail.gmail.com>
 <9e117a01-6f97-af27-0db0-34e2f2f4ce1a@redhat.com>
 <CAAT80S6otSy=bRbS-DxEf+OMaAU9imqufwN9NUrOumnzFocDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdBNAR0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 19:17:26 -0500
In-Reply-To: <CAAT80S6otSy=bRbS-DxEf+OMaAU9imqufwN9NUrOumnzFocDEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hufh <hufh2004@gmail.com>
Cc: "LIU, Fei" <james.liu@alibaba-inc.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Tiger,

reweight-by-distribution is one option, but my thought is more generally 
to modify the pool creation step itself.  The idea is that you can't 
easily search through the entire space of possible topologies of a pool 
given the initial conditions, but you can at least look at the initial 
distribution that gets created.  A very brute force approach would be to 
just throw away distributions and recompute with different seeds until 
you hit a distribution you like.

It seems to me though that you could create a giant hadoop cluster who's 
sole purpose is to look for combinations of topologies and seeds that 
provide useful properties (good initial distribution, good 1-off 
distributions, potentially good doubling distributions).  Assuming you 
could replicate the initial conditions, a database of these seeds might 
allow folks to choose seeds with ideal properties.

Mark

On 02/13/2017 05:48 PM, hufh wrote:
> Mark,
>
> Thanks for the valuable suggestions. Yes, we did redistribute pg by
> command reweight, but it's very hard and slow process. I am wondering if
> we could add a new parameter for reweight to specify OSD's pg number. We
> could trade some scalability for pg distribution evenness. Thanks.
>
> Tiger
>
> 2017年2月14日星期二，Mark Nelson <mnelson@redhat.com
> <mailto:mnelson@redhat.com>> 写道：
>
>     You could do tricks like recreate a distribution until an OSD is
>     associated with the number of PGs you want, and you could even do it
>     until all OSDs match some pre-specified values, but you can't make
>     it persist beyond a topology change (well, you could, but it'd
>     become prohibitively expensive very quickly for all possible changes).
>
>     I still wonder if we should be throwing away really poor initial
>     distributions just as a quality-of-life thing, but we've never done it.
>
>     Mark
>
>     On 02/13/2017 05:29 PM, hufh wrote:
>
>         Hi Mark,
>
>         Do you think it's possible to directly specify how many PGs a
>         osd could
>         host? Thanks.
>
>         Tiger
>
>         2017年2月14日星期二，Mark Nelson <mnelson@redhat.com
>         <mailto:mnelson@redhat.com>> 写道：
>
>             Hi James,
>
>             Yes, it's not surprising.  Especially if you are primarily
>         targeting
>             a single pool and can reweight to achieve optimal distribution
>             specifically for that pool.  It's much harder to do this if
>         you have
>             lots of pools that are all used equally though.
>
>             I'm glad to hear that reweighting improved things!  I still am
>             hopeful that some day we can find a way to distribute
>         pgs/data/etc
>             evenly with something crush-like that does better than random
>             distributions, but I suspect it will be very difficult.
>         Crush is
>             already very clever at what it does.  We may have to trade away
>             something to get something.
>
>             Mark
>
>             On 02/13/2017 04:48 PM, LIU, Fei wrote:
>
>                 Hi Mark,
>                    After we periodically even out the pg distribution with
>                 reweight-by-pgs ,we can see our cluster performance(IOPS and
>                 bandwidth ) up almost 25%~40% and latency drop almost
>         25%.  It
>                 somehow prove pg distribution affect the whole cluster
>                 performance a lot.
>
>                   Regards,
>                   James
>
>                 本邮件及其附件含有阿里巴巴集团的商业秘密信息，仅限于发送
>         给上面地
>                 址中列出的个人和群组，禁止任何其他人以任何形式使用（包括
>         但不限于
>                 全部或部分地泄露、复制和散发）本邮件及其附件中的信息，如
>         果您错收
>                 本邮件，请您立即电话或邮件通知发件人并删除本邮件。
>                 This email and its attachments contain confidential
>         information
>                 from Alibaba Group.which is intended only for the person or
>                 entity whose address is listed above.Any use of information
>                 contained herein in any way(including,but not limited
>         to,total
>                 or partial disclosure,reproduction or dissemination)by
>         persons
>                 other than the intended recipient(s) is prohibited.If you
>                 receive this email in error,please notify the sender by
>         phone or
>                 email immediately and delete it.
>
>                 On 2/8/17, 4:57 AM, "LIU, Fei"
>         <ceph-devel-owner@vger.kernel.org
>                 on behalf of james.liu@alibaba-inc.com> wrote:
>
>                     Hi Mark,
>                        Thanks very much for sharing. We found as we
>         tested more
>                 , somehow the oversubscribed OSD node perform worse than
>         other
>                 OSD node with less PGs ,However , the CPU utilization
>         even in
>                 worst oversubscribed OSD node is around ~50%. We also
>         observed
>                 the apply latency and commit latency are pretty high
>         comparing
>                 to others with less PGs. The networking traffic is
>         reasonable .
>                 The disk utilization sometime is around 99%.but most of
>         time is
>                 around 60%. We see latency spike from time to time
>         caused by the
>                 oversubscribed OSD we guess. Any suggestions?
>
>                     Regards,
>                     James
>
>
>                     本邮件及其附件含有阿里巴巴集团的商业秘密信息，仅限于
>         发送给上
>                 面地址中列出的个人和群组，禁止任何其他人以任何形式使用
>         （包括但不
>                 限于全部或部分地泄露、复制和散发）本邮件及其附件中的信
>         息，如果您
>                 错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
>                     This email and its attachments contain confidential
>                 information from Alibaba Group.which is intended only
>         for the
>                 person or entity whose address is listed above.Any use of
>                 information contained herein in any way(including,but not
>                 limited to,total or partial disclosure,reproduction or
>                 dissemination)by persons other than the intended
>         recipient(s) is
>                 prohibited.If you receive this email in error,please
>         notify the
>                 sender by phone or email immediately and delete it.
>
>                     On 2/7/17, 6:48 PM, "Mark Nelson"
>         <mnelson@redhat.com> wrote:
>
>                         Hi James,
>
>                         I'm not sage, but I'll chime in since I spent
>         some time
>                 thinking about
>                         this stuff a while back when I was playing
>         around with
>                 halton
>                         distributions for PG placement.  It's very
>         difficult to
>                 get even
>                         distributions using random sampling unless you
>         have a
>                 *very* high number
>                         of samples.  The following equations give you a
>                 reasonable expectation
>                         of what the min/max should be assuming an evenly
>                 weighted random
>                         distribution:
>
>                         min = (pgs / osds) - sqrt(2*pgs*log(osds)/osds)
>                         max = (pgs / osds) + sqrt(2*pgs*log(osds)/osds)
>
>                         In your case that's:
>
>                         min = 49152/168 - sqrt(2*49152*log(168)/168) = 256
>                         max = 49152/168 + sqrt(2*49152*log(168)/168) = 329
>
>                         In terms of performance potential and data
>         distribution
>                 evenness, I'd
>                         argue you really want to know how bad your worst
>                 oversubscribed PG is vs
>                         the average:
>
>                         Expected: (49152/168)/329 = ~88.9%
>                         Actual: (49152/168)/333 = = ~87.9%
>
>                         Your numbers are a little worse, though
>         typically I see our
>                         distributions hover right around expected or just
>                 slightly better.  This
>                         particular roll of the dice might have just been a
>                 little worse.
>
>                         If you jumped up to say 100K PGs:
>
>                         min = 1000000/168 - sqrt(2*1000000*log(168)/168)
>         = 544
>                         max = 1000000/168 + sqrt(2*1000000*log(168)/168)
>         = 647
>
>                         Expected: (100000/168)/647 = ~92%
>
>                         Now if you jumped up to 1 million PGs:
>
>                         min = 1000000/168 - sqrt(2*1000000*log(168)/168)
>         = 5790
>                         max = 1000000/168 + sqrt(2*1000000*log(168)/168)
>         = 6115
>
>                         Expected: (1000000/168)/6115 = ~97.3%
>
>                         Thanks,
>                         Mark
>
>                         On 02/07/2017 06:14 PM, LIU, Fei wrote:
>                         > Hi Sage,
>                         >   We are trying to distribute pgs evenly
>         across osds.
>                 However, after certain tunes, we still got 30%
>         difference among
>                 max pgs  and min pg  of OSDs (OSD 9 has 13.8% more pgs than
>                 average and OSD 86 has 15.2% less pgs than average).
>         Any good
>                 suggestions to make PGs distributed evenly across OSDs?
>                         >
>                         >   Thanks,
>                         >   James
>                         >
>                         >
>                         > SUM :   49152   |
>                         > Osd :   168     |
>                         > AVE :   292.57  |
>                         > Max :   333     |
>                         > Osdid : osd.9   |
>                         > per:    13.8%   |
>                         > ------------------------
>                         > min :   248     |
>                         > osdid : osd.86  |
>                         > per:    -15.2%  |
>                         >
>                         > [james.liu@a18d13422.eu13 /home/james.liu]
>                         > $
>                         >
>                         >
>                         > 本邮件及其附件含有阿里巴巴集团的商业秘密信息，
>         仅限于发
>                 送给上面地址中列出的个人和群组，禁止任何其他人以任何形式
>         使用（包
>                 括但不限于全部或部分地泄露、复制和散发）本邮件及其附件中
>         的信息，
>                 如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
>                         > This email and its attachments contain
>         confidential
>                 information from Alibaba Group.which is intended only
>         for the
>                 person or entity whose address is listed above.Any use of
>                 information contained herein in any way(including,but not
>                 limited to,total or partial disclosure,reproduction or
>                 dissemination)by persons other than the intended
>         recipient(s) is
>                 prohibited.If you receive this email in error,please
>         notify the
>                 sender by phone or email immediately and delete it.
>                         >
>                         >
>                         > --
>                         > To unsubscribe from this list: send the line
>                 "unsubscribe ceph-devel" in
>                         > the body of a message to majordomo@vger.kernel.org
>                         > More majordomo info at
>                 http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>
>                 <http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>>
>                         >
>
>
>
>                     --
>                     To unsubscribe from this list: send the line
>         "unsubscribe
>                 ceph-devel" in
>                     the body of a message to majordomo@vger.kernel.org
>                     More majordomo info at
>                 http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>
>                 <http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>>
>
>
>
>                 --
>                 To unsubscribe from this list: send the line "unsubscribe
>                 ceph-devel" in
>                 the body of a message to majordomo@vger.kernel.org
>                 More majordomo info at
>                 http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>
>                 <http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>>
>
>             --
>             To unsubscribe from this list: send the line "unsubscribe
>         ceph-devel" in
>             the body of a message to majordomo@vger.kernel.org
>             More majordomo info at
>         http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>
>             <http://vger.kernel.org/majordomo-info.html
>         <http://vger.kernel.org/majordomo-info.html>>
>
