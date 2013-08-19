From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Flapping osd / continuously reported as failed
Date: Mon, 19 Aug 2013 12:55:43 -0700
Message-ID: <CAPYLRzi8YLvg=sRq06QS3ju1gLxvCONucsOufhFjcbBPU2Av4A@mail.gmail.com>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet>
	<CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet>
	<CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet>
	<CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34666 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab3HSTzo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 15:55:44 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so4012206wgg.24
        for <ceph-devel@vger.kernel.org>; Mon, 19 Aug 2013 12:55:43 -0700 (PDT)
In-Reply-To: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, =?ISO-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski@grupaonet.pl>, Sydor Bohdan <Bohdan.Sydor@grupaonet.pl>

On Fri, Aug 16, 2013 at 5:47 AM, Mostowiec Dominik
<Dominik.Mostowiec@grupaonet.pl> wrote:
> Hi,
> Thanks for your response.
>
>> It's possible, as deep scrub in particular will add a bit of load (it
>> goes through and compares the object contents).
>
> It is possible that the scrubbing blocks access(RW or only W) to bucket index when check .dir... file?
> When rgw index is very large I guess it take some time.

Yes, it definitely can as scrubbing takes locks on the PG, which will
prevent reads or writes while the message is being processed (which
will involve the rgw index being scanned).

>> Are you not having any
>> flapping issues any more, and did you try and find when it started the
>> scrub to see if it matched up with your troubles?
>
> No, I didn't.
> But on our second cluster with the same problem, disable scrubbing also helps.
>
>> I'd be hesitant to turn it off as scrubbing can uncover corrupt
>> objects etc, but you can configure it with the settings at
>> http://ceph.com/docs/master/rados/configuration/osd-config-ref/#scrubbing.
>> (Always check the surprisingly-helpful docs when you need to do some
>> config or operations work!)
>
> I think change config scrub timeout or interval don't full remove issues.
> Change "osd deep scrub stride" to small value make scrubbing lightest?
You probably don't want to change the scrub stride; that is used to
keep reads at an appropriate size for the internal control threads but
won't relate to the object read/write locking.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
