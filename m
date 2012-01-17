From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: [PATCH] wrong unix timestamp calculation in hadoop lib
Date: Wed, 18 Jan 2012 01:37:58 +0400
Message-ID: <CAADCt4KR=wZ5V_O3Sq2s7DWJoTtrW7joj_H2Hsp3+Ap2e4JDXg@mail.gmail.com>
References: <1326467544-19913-1-git-send-email-octo47@gmail.com>
 <CAB2gnbVFEasWwccsj7FhffuOG3cxOC18u-oNzDtXhoF=iXVx1A@mail.gmail.com>
 <CAADCt4Lm91UdEiZUoBD7LTK33BDEZJMJNqcGmrZy81tP+nxy3g@mail.gmail.com>
 <CAB2gnbW8opiPaAYS7+x31AW2eVGVHqx+_-F_8JWD0V_4gB8e_Q@mail.gmail.com> <CAF3hT9AAnMsUgeOTzPt12WE8=ZHGkgVgzOOj=LJ5pQ_TxJO+uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39210 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2AQViU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 16:38:20 -0500
Received: by werb14 with SMTP id b14so1494564wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 13:38:19 -0800 (PST)
In-Reply-To: <CAF3hT9AAnMsUgeOTzPt12WE8=ZHGkgVgzOOj=LJ5pQ_TxJO+uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

2012/1/18 Gregory Farnum <gregory.farnum@dreamhost.com>:
> I pulled this patch into master. Thanks, Andrey!
>
> On Fri, Jan 13, 2012 at 4:04 PM, Noah Watkins <noahwatkins@gmail.com>=
 wrote:
>> On Fri, Jan 13, 2012 at 14:33, Andrey Stepachev <octo47@gmail.com> w=
rote:
>>> 2012/1/14 Noah Watkins <noahwatkins@gmail.com>:
>>>> On Fri, Jan 13, 2012 at 07:12, Andrey Stepachev <octo47@gmail.com>=
 wrote:
>>>>> From: Andrey Stepachev <octo@yandex-team.ru>
>>>>>
>>>>> Hadoop always see wrong dates due of wrong timestamp calculation.
>>>>> Possibly fixes #1666.
>>>>
>>>> Using coarse-grained timestamps might mask the problem in 1666. Bu=
t it
>>>> would only work in certain circumstances such as when clock sync s=
kew
>>>> is sufficiently small, and I think edge conditions would continue =
to
>>>> exist.
>>>
>>> No. It is really bug. Not a coarse grained solution.
>>> Here is really bug, because if we don't divide we get
>>> not milliseconds, we'll got seconds. In my test environment
>>> i have time difference up to several hours.
>>>
>>> Java uses millis, so we must divide nanos to get millis.
>>> =C2=A0java_mtime +=3D st.st_mtim.tv_nsec / 1000;
>>>
>>>> A more robust solution is probably needed for #1666 :(
>>>
>>> How about new function ceph_lstat_nocache, which
>>> in turn will call lstat with flags =3D=3D 0. In that case
>>> _get_attr always will query MDS (if I understand code,
>>> but I can be wrong). It is a performance hit, but
>>> hadoop should work.
>>> We can ever do lstat twice and get the biggest
>>> mtime.
>>
>> Yeh, we need some way to refresh the cached stats at the client (if =
i
>> remember 1666 correctly). If you are running into this issue there i=
s
>> a small hack for Hadoop that you an apply (it's on the wiki) until
>> something for 1666 is figured out. By the way, these JNI wrappers ar=
e
>> being rewritten to be Hadoop agnostic (pure libcephfs), and the code
>> is at github.com/noahdesu/java-cephfs -- I was just getting ready to
>> port the stat code, so it is nice you brought this issue back up :)
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Andrey Stepachev <octo@yandex-team.ru>
>>>>>
>>>>> ---
>>>>> =C2=A0src/client/hadoop/CephFSInterface.cc | =C2=A0 =C2=A08 ++++-=
---
>>>>> =C2=A01 files changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> - =C2=A0long long java_mtime(st.st_mtime);
>>>>> + =C2=A0long long java_mtime(st.st_mtim.tv_sec);
>>>>
>>>> mtime vs mtim: the later is non-portable?
>>>
>>> Yeah. Yes. This can be safely removed from patch.
>
> Is this something I should fix? It's presumably not a big problem
> since the older code had references to "tv_mtim", but I'm not too
> familiar with the history of *nix structs...

I'm not a big guru too, but st_atim.tv_nsec used in code,
so it looks more consistent to use st_atim.tv_sec, then
st_atime (which is a macro). Accroding to stat.h if
we havn't st_atim, code will not compile, because we try
to access st_mtim.tv_nsec.
So, I think that my original patch is preferable.

> -Greg



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
