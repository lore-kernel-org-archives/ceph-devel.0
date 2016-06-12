From: van <chaofanyu@owtware.com>
Subject: Re: Does mon skew really matters?
Date: Sun, 12 Jun 2016 14:25:06 +0800
Message-ID: <C9D4F5AC-A41F-49B2-B1D5-BCE3AC9C52BC@owtware.com>
References: <CALZt5jypeXGhVhhjur8dpC5KPDqFN-HRC+HbUzOEmVtzO6N1vQ@mail.gmail.com> <CAPpSHbW_bz9b-+BUmX+hJJodh-hF428-2KA9UZ3mcNOUR303gQ@mail.gmail.com> <alpine.DEB.2.11.1606042234410.6221@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [180.166.44.171] ([180.166.44.171]:43079 "EHLO
	owshcpma01.owtware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751242AbcFLGZX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 12 Jun 2016 02:25:23 -0400
In-Reply-To: <alpine.DEB.2.11.1606042234410.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wei Jin <wjin.cn@gmail.com>, Ning Yao <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Can I ask why the default drift allowed (50 milliseconds) is so small ?=
 .


It seems that the default monitor lease is about 5 seconds. And auth ti=
cket expiration time should also be more than 5 seconds.


In my practice, even if I=E2=80=99m using NTP, I still got clock skew w=
arnings from time to time.


Can I just increase the mon_clock_drift_allowed to 1 second?


I assume the impact is when the monitor quorum issue a new voting (one =
of the monitors is down), there might be two leaders simultaneously wor=
king in one second instead of 50 milliseconds ?

How to measure the impact if I increase the mon_clock_drift_allowed to =
one second?


van
chaofanyu@owtware.com



> On Jun 5, 2016, at 10:35 AM, Sage Weil <sage@newdream.net> wrote:
>=20
> On Sat, 4 Jun 2016, Wei Jin wrote:
>> In my opinion, if clock drift is too heavy, the lease protocol insid=
e
>> paxos won't work. Lease may be timeout and then triggers monitor to
>> bootstrap.
>=20
> Exactly.
>=20
>> You could try to shift clock back on the leader node to see what wil=
l happen.
>>=20
>> Time check mechanism gives us warning message so that we may take
>> actions if possible before things getting worse.
>=20
> You can also get into situations where the clients loop trying to get=
 a=20
> new ticket because the one they are issued appears to be expired.
>=20
> sage
>=20
>>=20
>> On Sat, Jun 4, 2016 at 12:06 PM, Ning Yao <zay11022@gmail.com> wrote=
:
>>> Hi, all
>>>=20
>>> I find that even if I have mon clock skew warning, under most cases=
,
>>> my cluster still can work properly as expected.
>>>=20
>>> I go through the code in mon but do not find any related issue with=
out
>>> time_check() to update whether clock skew periodically.
>>>=20
>>> can any one tell what is the design purpose of the clock skew betwe=
en
>>> mon and when it will really matter the cluster?
>>>=20
>>> Thanks a lots!
>>>=20
>>> Regards
>>> Ning Yao
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
