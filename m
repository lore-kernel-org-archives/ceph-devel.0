From: Milosz Tanski <milosz@adfin.com>
Subject: Re: MDS stuck in a crash loop
Date: Sun, 11 Oct 2015 18:44:35 -0400
Message-ID: <CANP1eJGmjechy8ZkVarA-HWdL37scmHdQXToM6NdAXxU-_KVMw@mail.gmail.com>
References: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
	<CAJ4mKGY5uTZ6oiqZY4VbU5LdECXx5sko6VOd5aD2aEhtq74NDA@mail.gmail.com>
	<CANP1eJFNpLu3-HeqJ28L7xCTuKh-MhUT2j7A_tM7reofZ94FTQ@mail.gmail.com>
	<CANP1eJFGy4psfmUHpsgdPFT+UUW=NTzLTgAsnGqeuD6iWuF-cQ@mail.gmail.com>
	<CANP1eJHnavBzJRnDLa9gQ93haJ2QzKJsLj4+ZbS_vd1kquV8Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36536 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbbJKWoh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Oct 2015 18:44:37 -0400
Received: by lbcao8 with SMTP id ao8so127046841lbc.3
        for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2015 15:44:36 -0700 (PDT)
In-Reply-To: <CANP1eJHnavBzJRnDLa9gQ93haJ2QzKJsLj4+ZbS_vd1kquV8Lw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Oct 11, 2015 at 6:01 PM, Milosz Tanski <milosz@adfin.com> wrote=
:
> On Sun, Oct 11, 2015 at 5:33 PM, Milosz Tanski <milosz@adfin.com> wro=
te:
>> On Sun, Oct 11, 2015 at 5:24 PM, Milosz Tanski <milosz@adfin.com> wr=
ote:
>>> On Sun, Oct 11, 2015 at 1:16 PM, Gregory Farnum <gfarnum@redhat.com=
> wrote:
>>>> On Sun, Oct 11, 2015 at 10:09 AM, Milosz Tanski <milosz@adfin.com>=
 wrote:
>>>>> About an hour ago my MDSs (primary and follower) started ping-pon=
g
>>>>> crashing with this message. I've spent about 30 minutes looking i=
nto
>>>>> it but nothing yet.
>>>>>
>>>>> This is from a 0.94.3 MDS
>>>>>
>>>>
>>>>>      0> 2015-10-11 17:01:23.596008 7fd4f52ad700 -1 mds/SessionMap=
=2Ecc:
>>>>> In function 'virtual void C_IO_SM_Save::finish(int)' thread
>>>>> 7fd4f52ad700 time 2015-10-11 17:01:23.594089
>>>>> mds/SessionMap.cc: 120: FAILED assert(r =3D=3D 0)
>>>>
>>>> These "r =3D=3D 0" asserts pretty much always mean that the MDS di=
d did a
>>>> read or write to RADOS (the OSDs) and got an error of some kind ba=
ck.
>>>> (Or in the case of the OSDs, access to the local filesystem return=
ed
>>>> an error, etc.) I don't think these writes include any safety chec=
ks
>>>> which would let the MDS break it which means that probably the OSD=
 is
>>>> actually returning an error =E2=80=94 odd, but not impossible.
>>>>
>>>> Notice that the assert happened in thread 7fd4f52ad700, and look f=
or
>>>> the stuff in that thread. You should be able to find an OSD op rep=
ly
>>>> (on the SessionMap object) coming in and reporting an error code.
>>>> -Greg
>>>
>>> I only two error ops in that whole MDS session. Neither one happene=
d
>>> on the same thread (7f5ab6000700 in this file). But it looks like t=
he
>>> only session map is the -90 "Message too long" one.
>>>
>>> mtanski@tiny:~$ cat single_crash.log | grep 'osd_op_reply' | grep -=
v
>>> 'ondisk =3D 0'
>>>  -3946> 2015-10-11 20:51:11.013965 7f5ab20f2700  1 --
>>> 10.0.5.31:6802/27121 <=3D=3D osd.25 10.0.5.57:6804/32341 6163 =3D=3D=
=3D=3D
>>> osd_op_reply(46349 mds0_sessionmap [writefull 0~95168363] v0'0 uv0
>>> ondisk =3D -90 ((90) Message too long)) v6 =3D=3D=3D=3D 182+0+0 (29=
55408122 0 0)
>>> 0x3a55d340 con 0x3d5a3c0
>>>   -705> 2015-10-11 20:51:11.374132 7f5ab22f4700  1 --
>>> 10.0.5.31:6802/27121 <=3D=3D osd.28 10.0.5.50:6801/1787 5297 =3D=3D=
=3D=3D
>>> osd_op_reply(48004 300.0000e274 [delete] v0'0 uv1349638 ondisk =3D =
-2
>>> ((2) No such file or directory)) v6 =3D=3D=3D=3D 179+0+0 (118254925=
1 0 0)
>>> 0x66c5c80 con 0x3d5a7e0
>>>
>>> Any idea what this could be Greg?
>>
>> To follow this up I found this ticket from 9 months ago:
>> http://tracker.ceph.com/issues/10449 In there Yan says:
>>
>> "it's a kernel bug. hang request prevents mds from trimming
>> completed_requests in sessionmap. there is nothing to do with mds.
>> (maybe we should add some code to MDS to show warning when this bug
>> happens)"
>>
>> When I was debugging this I saw an OSD (not cephfs client) operation
>> stuck for a long time along with the MDS error:
>>
>> HEALTH_WARN 1 requests are blocked > 32 sec; 1 osds have slow
>> requests; mds cluster is degraded; mds0: Behind on trimming (709/30)
>> 1 ops are blocked > 16777.2 sec
>> 1 ops are blocked > 16777.2 sec on osd.28
>>
>> I did eventually bounce the OSD in question and it hasn't become stu=
ck
>> since, but the MDS is still eating it every time with the "Message t=
oo
>> long" error on the session map.
>>
>> I'm not quite sure where to go from here.
>
> First time I had a chance to use the new recover tools. I was able to
> reply the journal, reset it and then reset the sessionmap. MDS
> returned back to life and so far everything looks good. Yay.
>
> Triggering this a bug/issue is a pretty interesting set of steps.

Spoke too soon, a missing dir is now causing MDS to restart it self.

    -6> 2015-10-11 22:40:47.300169 7f580c7b9700  5 -- op tracker --
seq: 4, time: 2015-10-11 22:40:47.300168, event: finishing request,
op: client_request(client.3597476:21480382 rmdir #100015e0be2/58
2015-10-11 21:34:49.224905 RETRY=3D36)
    -5> 2015-10-11 22:40:47.300208 7f580c7b9700  5 -- op tracker --
seq: 4, time: 2015-10-11 22:40:47.300208, event: cleaned up request,
op: client_request(client.3597476:21480382 rmdir #100015e0be2/58
2015-10-11 21:34:49.224905 RETRY=3D36)
    -4> 2015-10-11 22:40:47.300231 7f580c7b9700  5 -- op tracker --
seq: 4, time: 2015-10-11 22:40:47.300231, event: done, op:
client_request(client.3597476:21480382 rmdir #100015e0be2/58
2015-10-11 21:34:49.224905 RETRY=3D36)
    -3> 2015-10-11 22:40:47.300284 7f580e0bd700  0
mds.0.cache.dir(100048df076) _fetched missing object for [dir
100048df076 /petabucket/beta/6d/f6/ [2,head] auth v=3D0 cv=3D0/0 ap=3D1=
+0+0
state=3D1073741952 f() n() hs=3D0+0,ss=3D0+0 | waiter=3D1 authpin=3D1 0=
x6debcf8]
    -2> 2015-10-11 22:40:47.300313 7f580e0bd700 -1
log_channel(cluster) log [ERR] : dir 100048df076 object missing on
disk; some files may be lost
    -1> 2015-10-11 22:40:47.300549 7f580c7b9700  5 -- op tracker --
seq: 6, time: 2015-10-11 22:40:47.300549, event: acquired locks, op:
client_request(client.3710941:1805 mkdir
#100048df076/1dd4c66b916cf55f19beafc0574ac2dd923bc7efcc5b7757198f323e04=
d0.dl
2015-10-11 22:36:32.489705 RETRY=3D33)
     0> 2015-10-11 22:40:47.303770 7f580c7b9700 -1 mds/CDir.cc: In
function 'fnode_t* CDir::project_fnode()' thread 7f580c7b9700 time
2015-10-11 22:40:47.300581
mds/CDir.cc: 1267: FAILED assert(get_version() !=3D 0)

 ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0x94cc1b]
 2: (CDir::project_fnode()+0x2da) [0x75da1a]



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
