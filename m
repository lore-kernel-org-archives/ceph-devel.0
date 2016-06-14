From: kefu chai <tchaikov@gmail.com>
Subject: Re: throttling reweight-by-utilization
Date: Tue, 14 Jun 2016 14:51:42 +0800
Message-ID: <CAJE9aON_TJr+QAGYi7r6iTLkRwB=aztaFhmp0tS_ZCAc=g1njA@mail.gmail.com>
References: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com>
 <alpine.DEB.2.11.1601180859180.26381@cpach.fuggernut.com> <CABZ+qqkCZEZcj99sXQw_hZzaBbLAJyaO48MLbbrA6JVhNYEFOQ@mail.gmail.com>
 <CABZ+qq=Cdeq83=Fihp+3NvjGmvtUeZm=YygvJEO2XBd8PHrYhw@mail.gmail.com> <alpine.DEB.2.11.1603021408350.1904@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36145 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbcFNGvo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2016 02:51:44 -0400
Received: by mail-yw0-f181.google.com with SMTP id v137so44849580ywa.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2016 23:51:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603021408350.1904@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 3, 2016 at 3:15 AM, Sage Weil <sage@newdream.net> wrote:
> Latest branch:
>
>         https://github.com/liewegas/ceph/commits/wip-reweight
>
> I made several changes:
>
> - new command, 'osd utilization'
>
> avg 51
> stddev 0.707107 (expected baseline 6.68019)

Sage, sorry for bringing this up again. I don't quite understand what
the "expected baseline" is for. per the code,

float edev = sqrt(avg_pg * (1.0 - (1.0 / (double)num_up_in)));

so it sounds sound sort of std dev, but the unit of std dev here is
the "number of pg", while edev's unit is
num_pg^{1/2}, so it's not comparable with avg_pg or the
{base,new}_stddev. so could you shed some light on how we shall use
this number as a reference?
and what's the meaning of this number?

thanks.

> min osd.3 with 52 pgs (1.01961 * mean)
> max osd.3 with 50 pgs (0.980392 * mean)
>
> (json version too)
>
> - new commands: osd test-reweight-by-{pg,utilization}
>
> same as osd reweight-by-*, but it doesn't actually to it--just shows the
> before and after stats:
>
> no change
> moved 2 / 408 (0.490196%)
> avg 51
> stddev 5.26783 -> 4.74342 (expected baseline 6.68019)
> min osd.3 with 59 -> 57 pgs (1.15686 -> 1.11765 * mean)
> max osd.3 with 41 -> 42 pgs (0.803922 -> 0.823529 * mean)
>
> oload 105
> max_change 0.05
> average 51.000000
> overload 53.550000
> osd.3 weight 1.000000 -> 0.950012
> osd.2 weight 1.000000 -> 0.950012
>
>


-- 
Regards
Kefu Chai
