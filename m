From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: SMART monitoring
Date: Thu, 22 May 2014 12:59:52 +0400
Message-ID: <CABYiri89LWX0uvyf9nmHuNRt5R-OmDTkHMT1JvZaFU4nkzyHrA@mail.gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B68565E03@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1312261807240.2168@cobra.newdream.net> <CAOGLoJPoS3WUUJuyRqkiUbT+DoDCochHZ-LThC4Ro8wUCdkD0g@mail.gmail.com>
 <52BDB45A.802@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:46402 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbaEVJAM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 05:00:12 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so3458994obc.35
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 02:00:12 -0700 (PDT)
In-Reply-To: <52BDB45A.802@xdel.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Justin Erenkrantz <justin@erenkrantz.com>
Cc: Sage Weil <sage@inktank.com>, James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 27, 2013 at 9:09 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On 12/27/2013 08:15 PM, Justin Erenkrantz wrote:
>> On Thu, Dec 26, 2013 at 9:17 PM, Sage Weil <sage@inktank.com> wrote:
>>> I think the question comes down to whether Ceph should take some internal
>>> action based on the information, or whether that is better handled by some
>>> external monitoring agent.  For example, an external agent might collect
>>> SMART info into graphite, and every so often do some predictive analysis
>>> and mark out disks that are expected to fail soon.
>>>
>>> I'd love to see some consensus form around what this should look like...
>>
>> My $.02 from the peanut gallery: at a minimum, set the HEALTH_WARN flag if
>> there is a SMART failure on a physical drive that contains an OSD.  Yes,
>> you could build the monitoring into a separate system, but I think it'd be
>> really useful to combine it into the cluster health assessment.  -- justin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Hi,
>
> Judging from my personal experience SMART failures can be dangerous if
> they are not bad enough to completely tear down an OSD therefore it will
> not flap and will not be marked as down in time, but cluster performance
> is greatly affected in this case. I don`t think that the SMART
> monitoring task is somehow related to Ceph because seperate monitoring
> of predictive failure counters can do its job well and in cause of
> sudden errors SMART query may not work at all since a lot of bus resets
> was made by the system and disk can be inaccessible at all. So I propose
> two set of strategies - do a regular scattered background checks and
> monitor OSD responsiveness to word around cases with performance
> degradation due to read/write errors.

Some necromant job for this thread..

Considering a year-long experience with Hitachi 4T disks, there are a
lot of failures which are cannot be handled by SMART completely -
speed degradation and sudden disk death. Although second case rules
out by itself by kicking out stuck OSD, it is not very easy to check
which disks are about to die without throughout dmesg monitoring for
bus errors and periodical speed calibration. Probably introducing such
thing as idle-priority speed measurement for OSDs without dramatically
increasing overall wearout may be useful enough to implement in couple
with additional OSD perf metric, like seek_time in SMART, though SMART
may return good value for it when performance already slowed down to
crawl, also it`ll handle most things impacting performance which can
be unexposable at all to the host OS - correctable bus errors and so
on. By the way, although 1T Seagates have way higher failure rate,
they always dying with an 'appropriate' set of attributes in SMART,
Hitachi tends to die without warning :) Hope that it`ll be helpful for
someone.
