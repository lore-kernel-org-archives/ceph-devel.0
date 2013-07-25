From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Flapping osd / continuously reported as failed
Date: Thu, 25 Jul 2013 10:32:23 -0700
Message-ID: <CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet>
	<CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet>
	<CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44798 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533Ab3GYRcY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 13:32:24 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so5922511wiw.5
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 10:32:23 -0700 (PDT)
In-Reply-To: <ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, =?ISO-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski@grupaonet.pl>

On Thu, Jul 25, 2013 at 12:47 AM, Mostowiec Dominik
<Dominik.Mostowiec@grupaonet.pl> wrote:
> Hi
> We found something else.
> After osd.72 flapp, one PG '3.54d' was recovering long time.
>
> --
> ceph health details
> HEALTH_WARN 1 pgs recovering; recovery 1/39821745 degraded (0.000%)
> pg 3.54d is active+recovering, acting [72,108,23]
> recovery 1/39821745 degraded (0.000%)
> --
>
> Last flap down/up osd.72 was 00:45.
> In logs we found:
> 2013-07-24 00:45:02.736740 7f8ac1e04700  0 log [INF] : 3.54d deep-scrub ok
> After this time is ok.
>
> It is possible that reason of flapping this osd was scrubbing?
>
> We have default scrubbing settings (ceph version 0.56.6).
> If scrubbig is the trouble-maker, can we make it a little more light by changing config?

It's possible, as deep scrub in particular will add a bit of load (it
goes through and compares the object contents). Are you not having any
flapping issues any more, and did you try and find when it started the
scrub to see if it matched up with your troubles?

I'd be hesitant to turn it off as scrubbing can uncover corrupt
objects etc, but you can configure it with the settings at
http://ceph.com/docs/master/rados/configuration/osd-config-ref/#scrubbing.
(Always check the surprisingly-helpful docs when you need to do some
config or operations work!)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
