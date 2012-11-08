From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: clock syncronisation
Date: Thu, 8 Nov 2012 15:19:05 +0300
Message-ID: <CABYiri9y8+Wt5-3qi94-n-HUy80OVqEKZz4-HwJSmwwOUYtc_w@mail.gmail.com>
References: <509B7595.1010809@profihost.ag> <509B9ED8.6010907@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45987 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab2KHMT0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 07:19:26 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2754220oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 04:19:26 -0800 (PST)
In-Reply-To: <509B9ED8.6010907@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 8, 2012 at 4:00 PM, Wido den Hollander <wido@widodh.nl> wrote:
>
>
> On 08-11-12 10:04, Stefan Priebe - Profihost AG wrote:
>>
>> Hello list,
>>
>> is there any prefered way to use clock syncronisation?
>>
>> I've tried running openntpd and ntpd on all servers but i'm still getting:
>> 2012-11-08 09:55:38.255928 mon.0 [WRN] message from mon.2 was stamped
>> 0.063136s in the future, clocks not synchronized
>> 2012-11-08 09:55:39.328639 mon.0 [WRN] message from mon.2 was stamped
>> 0.063285s in the future, clocks not synchronized
>> 2012-11-08 09:55:39.328833 mon.0 [WRN] message from mon.2 was stamped
>> 0.063301s in the future, clocks not synchronized
>> 2012-11-08 09:55:40.819975 mon.0 [WRN] message from mon.2 was stamped
>> 0.063360s in the future, clocks not synchronized
>>
>
> What NTP server are you using? Network latency might cause the clocks not to
> be synchronised.
>

There is no real reason to worry about, quorum may suffer only large
desync delays as some seconds or more. If you have unsynchronized
clocks on mon hodes with such big delays, requests which have issued
from cli, e.g. creating new connection may wait as long as delay
itself, depend of clock value of selected monitor node.

Clock drift caused mostly by heavy load, but of course playing with
clocksources may have some effect(since most systems already use HPET
timer, there is only one way, to sync with ntp server as frequent as
you want to prevent drift).


>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
