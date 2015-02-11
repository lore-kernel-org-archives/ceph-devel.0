From: Samuel Just <sam.just@inktank.com>
Subject: Re: Standardization of perf counters comments
Date: Wed, 11 Feb 2015 10:24:48 -0800
Message-ID: <CA+4uBUZzaMPhkJdhenmb3GnwsxFpmzTJCtDmofx+JX+8_h=adQ@mail.gmail.com>
References: <loom.20150211T183150-492@post.gmane.org>
	<CAC6JEv-YDNstmoGBFG0yNhgw5DOkTCDY2=2bKK1z-5Az4hqfKQ@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:56230 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbbBKSYt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 13:24:49 -0500
Received: by mail-lb0-f178.google.com with SMTP id w7so4876385lbi.9
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 10:24:48 -0800 (PST)
In-Reply-To: <CAC6JEv-YDNstmoGBFG0yNhgw5DOkTCDY2=2bKK1z-5Az4hqfKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Alyona Kiseleva <akiselyova@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I agree with the non-optional part.
-Sam

On Wed, Feb 11, 2015 at 10:02 AM, Gregory Farnum <greg@gregs42.com> wrote:
> On Wed, Feb 11, 2015 at 9:33 AM, Alyona Kiseleva
> <akiselyova@mirantis.com> wrote:
>> Hi,
>> I would like to propose something.
>>
>> There are a lot of perf counters in different places in code, but the most
>> of them are undocumented. I found only one commented counter in OSD.cc code,
>> but not for all metrics. Name of counter is not very clear as it's
>> description, sometimes isn't at all.
>>
>> So, I have an idea, that it would be great, if perf schema would contain not
>> only the counter type, but some description too. It can be added in
>> PerfCountersBuilder methods - at first as optional parameter with empty
>> string by default, later, may be, as required parameter. This short
>> description could be saved in perf_counter_data_any_d struct together with
>> other counter properties and appear in perf schema as the second counter
>> property.
>
> I actually suspect that we'll be more successful if the description is
> not optional. That way people are forced to provide a string of some
> kind, instead of not knowing that it's even an option to do so. It's
> more up-front work to provide a description for all the counters but
> should make everything a lot more accessible to users than saying
> "well, *some* of them have descriptions, if we were feeling
> conscientious that day and knew about doing so". ;)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
