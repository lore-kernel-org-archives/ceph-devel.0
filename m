From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: SMART monitoring
Date: Fri, 27 Dec 2013 21:09:46 +0400
Message-ID: <52BDB45A.802@xdel.ru>
References: <6035A0D088A63A46850C3988ED045A4B68565E03@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1312261807240.2168@cobra.newdream.net> <CAOGLoJPoS3WUUJuyRqkiUbT+DoDCochHZ-LThC4Ro8wUCdkD0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:61347 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab3L0RLX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Dec 2013 12:11:23 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so4350584lam.39
        for <ceph-devel@vger.kernel.org>; Fri, 27 Dec 2013 09:11:21 -0800 (PST)
In-Reply-To: <CAOGLoJPoS3WUUJuyRqkiUbT+DoDCochHZ-LThC4Ro8wUCdkD0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Justin Erenkrantz <justin@erenkrantz.com>
Cc: Sage Weil <sage@inktank.com>, James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/27/2013 08:15 PM, Justin Erenkrantz wrote:
> On Thu, Dec 26, 2013 at 9:17 PM, Sage Weil <sage@inktank.com> wrote:
>> I think the question comes down to whether Ceph should take some internal
>> action based on the information, or whether that is better handled by some
>> external monitoring agent.  For example, an external agent might collect
>> SMART info into graphite, and every so often do some predictive analysis
>> and mark out disks that are expected to fail soon.
>>
>> I'd love to see some consensus form around what this should look like...
> 
> My $.02 from the peanut gallery: at a minimum, set the HEALTH_WARN flag if
> there is a SMART failure on a physical drive that contains an OSD.  Yes,
> you could build the monitoring into a separate system, but I think it'd be
> really useful to combine it into the cluster health assessment.  -- justin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi,

Judging from my personal experience SMART failures can be dangerous if
they are not bad enough to completely tear down an OSD therefore it will
not flap and will not be marked as down in time, but cluster performance
is greatly affected in this case. I don`t think that the SMART
monitoring task is somehow related to Ceph because seperate monitoring
of predictive failure counters can do its job well and in cause of
sudden errors SMART query may not work at all since a lot of bus resets
was made by the system and disk can be inaccessible at all. So I propose
two set of strategies - do a regular scattered background checks and
monitor OSD responsiveness to word around cases with performance
degradation due to read/write errors.
