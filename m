From: Milosz Tanski <milosz@adfin.com>
Subject: Re: MDS stuck in a crash loop
Date: Sun, 11 Oct 2015 18:01:00 -0400
Message-ID: <CANP1eJHnavBzJRnDLa9gQ93haJ2QzKJsLj4+ZbS_vd1kquV8Lw@mail.gmail.com>
References: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
	<CAJ4mKGY5uTZ6oiqZY4VbU5LdECXx5sko6VOd5aD2aEhtq74NDA@mail.gmail.com>
	<CANP1eJFNpLu3-HeqJ28L7xCTuKh-MhUT2j7A_tM7reofZ94FTQ@mail.gmail.com>
	<CANP1eJFGy4psfmUHpsgdPFT+UUW=NTzLTgAsnGqeuD6iWuF-cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36612 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbJKWBC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Oct 2015 18:01:02 -0400
Received: by lbcao8 with SMTP id ao8so126630621lbc.3
        for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2015 15:01:00 -0700 (PDT)
In-Reply-To: <CANP1eJFGy4psfmUHpsgdPFT+UUW=NTzLTgAsnGqeuD6iWuF-cQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Oct 11, 2015 at 5:33 PM, Milosz Tanski <milosz@adfin.com> wrote=
:
> On Sun, Oct 11, 2015 at 5:24 PM, Milosz Tanski <milosz@adfin.com> wro=
te:
>> On Sun, Oct 11, 2015 at 1:16 PM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
>>> On Sun, Oct 11, 2015 at 10:09 AM, Milosz Tanski <milosz@adfin.com> =
wrote:
>>>> About an hour ago my MDSs (primary and follower) started ping-pong
>>>> crashing with this message. I've spent about 30 minutes looking in=
to
>>>> it but nothing yet.
>>>>
>>>> This is from a 0.94.3 MDS
>>>>
>>>
>>>>      0> 2015-10-11 17:01:23.596008 7fd4f52ad700 -1 mds/SessionMap.=
cc:
>>>> In function 'virtual void C_IO_SM_Save::finish(int)' thread
>>>> 7fd4f52ad700 time 2015-10-11 17:01:23.594089
>>>> mds/SessionMap.cc: 120: FAILED assert(r =3D=3D 0)
>>>
>>> These "r =3D=3D 0" asserts pretty much always mean that the MDS did=
 did a
>>> read or write to RADOS (the OSDs) and got an error of some kind bac=
k.
>>> (Or in the case of the OSDs, access to the local filesystem returne=
d
>>> an error, etc.) I don't think these writes include any safety check=
s
>>> which would let the MDS break it which means that probably the OSD =
is
>>> actually returning an error =E2=80=94 odd, but not impossible.
>>>
>>> Notice that the assert happened in thread 7fd4f52ad700, and look fo=
r
>>> the stuff in that thread. You should be able to find an OSD op repl=
y
>>> (on the SessionMap object) coming in and reporting an error code.
>>> -Greg
>>
>> I only two error ops in that whole MDS session. Neither one happened
>> on the same thread (7f5ab6000700 in this file). But it looks like th=
e
>> only session map is the -90 "Message too long" one.
>>
>> mtanski@tiny:~$ cat single_crash.log | grep 'osd_op_reply' | grep -v
>> 'ondisk =3D 0'
>>  -3946> 2015-10-11 20:51:11.013965 7f5ab20f2700  1 --
>> 10.0.5.31:6802/27121 <=3D=3D osd.25 10.0.5.57:6804/32341 6163 =3D=3D=
=3D=3D
>> osd_op_reply(46349 mds0_sessionmap [writefull 0~95168363] v0'0 uv0
>> ondisk =3D -90 ((90) Message too long)) v6 =3D=3D=3D=3D 182+0+0 (295=
5408122 0 0)
>> 0x3a55d340 con 0x3d5a3c0
>>   -705> 2015-10-11 20:51:11.374132 7f5ab22f4700  1 --
>> 10.0.5.31:6802/27121 <=3D=3D osd.28 10.0.5.50:6801/1787 5297 =3D=3D=3D=
=3D
>> osd_op_reply(48004 300.0000e274 [delete] v0'0 uv1349638 ondisk =3D -=
2
>> ((2) No such file or directory)) v6 =3D=3D=3D=3D 179+0+0 (1182549251=
 0 0)
>> 0x66c5c80 con 0x3d5a7e0
>>
>> Any idea what this could be Greg?
>
> To follow this up I found this ticket from 9 months ago:
> http://tracker.ceph.com/issues/10449 In there Yan says:
>
> "it's a kernel bug. hang request prevents mds from trimming
> completed_requests in sessionmap. there is nothing to do with mds.
> (maybe we should add some code to MDS to show warning when this bug
> happens)"
>
> When I was debugging this I saw an OSD (not cephfs client) operation
> stuck for a long time along with the MDS error:
>
> HEALTH_WARN 1 requests are blocked > 32 sec; 1 osds have slow
> requests; mds cluster is degraded; mds0: Behind on trimming (709/30)
> 1 ops are blocked > 16777.2 sec
> 1 ops are blocked > 16777.2 sec on osd.28
>
> I did eventually bounce the OSD in question and it hasn't become stuc=
k
> since, but the MDS is still eating it every time with the "Message to=
o
> long" error on the session map.
>
> I'm not quite sure where to go from here.

=46irst time I had a chance to use the new recover tools. I was able to
reply the journal, reset it and then reset the sessionmap. MDS
returned back to life and so far everything looks good. Yay.

Triggering this a bug/issue is a pretty interesting set of steps.

>
>>
>>>
>>>>
>>>>  ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>> const*)+0x8b) [0x94cc1b]
>>>>  2: /usr/bin/ceph-mds() [0x7c7df1]
>>>>  3: (MDSIOContextBase::complete(int)+0x81) [0x7c83b1]
>>>>  4: (Finisher::finisher_thread_entry()+0x1a0) [0x87f490]
>>>>  5: (()+0x8182) [0x7fd4fd031182]
>>>>  6: (clone()+0x6d) [0x7fd4fb7a047d]
>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>> needed to interpret this.
>>
>> --
>> Milosz Tanski
>> CTO
>> 16 East 34th Street, 15th floor
>> New York, NY 10016
>>
>> p: 646-253-9055
>> e: milosz@adfin.com
>
>
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
