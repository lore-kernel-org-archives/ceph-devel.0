From: kefu chai <tchaikov@gmail.com>
Subject: Re: throttling reweight-by-utilization
Date: Thu, 16 Jun 2016 00:55:39 +0800
Message-ID: <CAJE9aOOr6rJA+4qJvGd2RmpQ7fbKe8PZHBJQvxeYVhXbvYuzYA@mail.gmail.com>
References: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com>
 <alpine.DEB.2.11.1601180859180.26381@cpach.fuggernut.com> <CABZ+qqkCZEZcj99sXQw_hZzaBbLAJyaO48MLbbrA6JVhNYEFOQ@mail.gmail.com>
 <CABZ+qq=Cdeq83=Fihp+3NvjGmvtUeZm=YygvJEO2XBd8PHrYhw@mail.gmail.com>
 <alpine.DEB.2.11.1603021408350.1904@cpach.fuggernut.com> <CAJE9aON_TJr+QAGYi7r6iTLkRwB=aztaFhmp0tS_ZCAc=g1njA@mail.gmail.com>
 <alpine.DEB.2.11.1606150441570.29071@cpach.fuggernut.com> <alpine.DEB.2.11.1606150451060.29071@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34243 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbcFOQzl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2016 12:55:41 -0400
Received: by mail-qk0-f172.google.com with SMTP id s186so27587529qkc.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2016 09:55:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606150451060.29071@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 15, 2016 at 4:53 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 15 Jun 2016, Sage Weil wrote:
>> On Tue, 14 Jun 2016, kefu chai wrote:
>> > On Thu, Mar 3, 2016 at 3:15 AM, Sage Weil <sage@newdream.net> wrote:
>> > > Latest branch:
>> > >
>> > >         https://github.com/liewegas/ceph/commits/wip-reweight
>> > >
>> > > I made several changes:
>> > >
>> > > - new command, 'osd utilization'
>> > >
>> > > avg 51
>> > > stddev 0.707107 (expected baseline 6.68019)
>> >
>> > Sage, sorry for bringing this up again. I don't quite understand what
>> > the "expected baseline" is for. per the code,
>> >
>> > float edev = sqrt(avg_pg * (1.0 - (1.0 / (double)num_up_in)));
>> >
>> > so it sounds sound sort of std dev, but the unit of std dev here is
>> > the "number of pg", while edev's unit is
>> > num_pg^{1/2}, so it's not comparable with avg_pg or the
>> > {base,new}_stddev. so could you shed some light on how we shall use
>> > this number as a reference?
>> > and what's the meaning of this number?
>>
>> (Re-reading 4.1 from the CRUSH paper... I always forget the math)
>>
>> The average osd utilization for the binomial placement process is mu = n*p
>> (p=1/num_osds, n=num pgs) = num_pgs/num_osds, and the standard deviation
>> is sqrt(n*p*(1-p)) = sqrt(avg_pgs*(1-p)) = sqrt(avg_pgs*(1-(1/num_osds))).


thanks Sage, I will read the paper again to understand it better.

>>
>> The units for standard deviation are weird, yep.
>>
>> In any case, the baseline is there to tell you what the statistically
>> expected std dev is so you can tell if something is awry...
>
> ...and reading the message you were quoting it looks like this value
>
>> > > stddev 0.707107 (expected baseline 6.68019)
>
> is wrong.  I'm not sure where it came from, though.  I checked the output
> on a real cluster (lab cluster) and it's not there (although our
> distribution on that cluster is all out of whack.. presumably for other
> reasons).
>
> sage



-- 
Regards
Kefu Chai
