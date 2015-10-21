From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: MDS stuck in a crash loop
Date: Wed, 21 Oct 2015 11:29:40 -0700
Message-ID: <CAJ4mKGYHDew0LdQ65vNODiBw6u_jBrmyL3fzOWhB1TxKP8XidQ@mail.gmail.com>
References: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
	<CAJ4mKGY5uTZ6oiqZY4VbU5LdECXx5sko6VOd5aD2aEhtq74NDA@mail.gmail.com>
	<CANP1eJFNpLu3-HeqJ28L7xCTuKh-MhUT2j7A_tM7reofZ94FTQ@mail.gmail.com>
	<CANP1eJFGy4psfmUHpsgdPFT+UUW=NTzLTgAsnGqeuD6iWuF-cQ@mail.gmail.com>
	<CANP1eJHnavBzJRnDLa9gQ93haJ2QzKJsLj4+ZbS_vd1kquV8Lw@mail.gmail.com>
	<CANP1eJGmjechy8ZkVarA-HWdL37scmHdQXToM6NdAXxU-_KVMw@mail.gmail.com>
	<CANP1eJHYvgUKDCKrVYY=XkJsgcdVGn6T=drvEA8hofHyVX+0YA@mail.gmail.com>
	<CAJ4mKGYyza=MqV8zRS3cGA0EfbB=h=UhYbwO7QBgTb6FfzXSQw@mail.gmail.com>
	<CANP1eJGiPEx49nNyQgv3qo9ugVRAWnsh_WAHt33jHXX23S=0GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34941 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbbJUS3m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2015 14:29:42 -0400
Received: by wicll6 with SMTP id ll6so103612978wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 11:29:40 -0700 (PDT)
In-Reply-To: <CANP1eJGiPEx49nNyQgv3qo9ugVRAWnsh_WAHt33jHXX23S=0GQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 19, 2015 at 8:31 AM, Milosz Tanski <milosz@adfin.com> wrote=
:
> On Wed, Oct 14, 2015 at 12:46 AM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
>> On Sun, Oct 11, 2015 at 7:36 PM, Milosz Tanski <milosz@adfin.com> wr=
ote:
>>> On Sun, Oct 11, 2015 at 6:44 PM, Milosz Tanski <milosz@adfin.com> w=
rote:
>>>> On Sun, Oct 11, 2015 at 6:01 PM, Milosz Tanski <milosz@adfin.com> =
wrote:
>>>>> On Sun, Oct 11, 2015 at 5:33 PM, Milosz Tanski <milosz@adfin.com>=
 wrote:
>>>>>> On Sun, Oct 11, 2015 at 5:24 PM, Milosz Tanski <milosz@adfin.com=
> wrote:
>>>>>>> On Sun, Oct 11, 2015 at 1:16 PM, Gregory Farnum <gfarnum@redhat=
=2Ecom> wrote:
>>>>>>>> On Sun, Oct 11, 2015 at 10:09 AM, Milosz Tanski <milosz@adfin.=
com> wrote:
>>>>>>>>> About an hour ago my MDSs (primary and follower) started ping=
-pong
>>>>>>>>> crashing with this message. I've spent about 30 minutes looki=
ng into
>>>>>>>>> it but nothing yet.
>>>>>>>>>
>>>>>>>>> This is from a 0.94.3 MDS
>>>>>>>>>
>>>>>>>>
>>>>>>>>>      0> 2015-10-11 17:01:23.596008 7fd4f52ad700 -1 mds/Sessio=
nMap.cc:
>>>>>>>>> In function 'virtual void C_IO_SM_Save::finish(int)' thread
>>>>>>>>> 7fd4f52ad700 time 2015-10-11 17:01:23.594089
>>>>>>>>> mds/SessionMap.cc: 120: FAILED assert(r =3D=3D 0)
>>>>>>>>
>>>>>>>> These "r =3D=3D 0" asserts pretty much always mean that the MD=
S did did a
>>>>>>>> read or write to RADOS (the OSDs) and got an error of some kin=
d back.
>>>>>>>> (Or in the case of the OSDs, access to the local filesystem re=
turned
>>>>>>>> an error, etc.) I don't think these writes include any safety =
checks
>>>>>>>> which would let the MDS break it which means that probably the=
 OSD is
>>>>>>>> actually returning an error =E2=80=94 odd, but not impossible.
>>>>>>>>
>>>>>>>> Notice that the assert happened in thread 7fd4f52ad700, and lo=
ok for
>>>>>>>> the stuff in that thread. You should be able to find an OSD op=
 reply
>>>>>>>> (on the SessionMap object) coming in and reporting an error co=
de.
>>>>>>>> -Greg
>>>>>>>
>>>>>>> I only two error ops in that whole MDS session. Neither one hap=
pened
>>>>>>> on the same thread (7f5ab6000700 in this file). But it looks li=
ke the
>>>>>>> only session map is the -90 "Message too long" one.
>>>>>>>
>>>>>>> mtanski@tiny:~$ cat single_crash.log | grep 'osd_op_reply' | gr=
ep -v
>>>>>>> 'ondisk =3D 0'
>>>>>>>  -3946> 2015-10-11 20:51:11.013965 7f5ab20f2700  1 --
>>>>>>> 10.0.5.31:6802/27121 <=3D=3D osd.25 10.0.5.57:6804/32341 6163 =3D=
=3D=3D=3D
>>>>>>> osd_op_reply(46349 mds0_sessionmap [writefull 0~95168363] v0'0 =
uv0
>>>>>>> ondisk =3D -90 ((90) Message too long)) v6 =3D=3D=3D=3D 182+0+0=
 (2955408122 0 0)
>>>>>>> 0x3a55d340 con 0x3d5a3c0
>>>>>>>   -705> 2015-10-11 20:51:11.374132 7f5ab22f4700  1 --
>>>>>>> 10.0.5.31:6802/27121 <=3D=3D osd.28 10.0.5.50:6801/1787 5297 =3D=
=3D=3D=3D
>>>>>>> osd_op_reply(48004 300.0000e274 [delete] v0'0 uv1349638 ondisk =
=3D -2
>>>>>>> ((2) No such file or directory)) v6 =3D=3D=3D=3D 179+0+0 (11825=
49251 0 0)
>>>>>>> 0x66c5c80 con 0x3d5a7e0
>>>>>>>
>>>>>>> Any idea what this could be Greg?
>>>>>>
>>>>>> To follow this up I found this ticket from 9 months ago:
>>>>>> http://tracker.ceph.com/issues/10449 In there Yan says:
>>>>>>
>>>>>> "it's a kernel bug. hang request prevents mds from trimming
>>>>>> completed_requests in sessionmap. there is nothing to do with md=
s.
>>>>>> (maybe we should add some code to MDS to show warning when this =
bug
>>>>>> happens)"
>>>>>>
>>>>>> When I was debugging this I saw an OSD (not cephfs client) opera=
tion
>>>>>> stuck for a long time along with the MDS error:
>>>>>>
>>>>>> HEALTH_WARN 1 requests are blocked > 32 sec; 1 osds have slow
>>>>>> requests; mds cluster is degraded; mds0: Behind on trimming (709=
/30)
>>>>>> 1 ops are blocked > 16777.2 sec
>>>>>> 1 ops are blocked > 16777.2 sec on osd.28
>>>>>>
>>>>>> I did eventually bounce the OSD in question and it hasn't become=
 stuck
>>>>>> since, but the MDS is still eating it every time with the "Messa=
ge too
>>>>>> long" error on the session map.
>>>>>>
>>>>>> I'm not quite sure where to go from here.
>>>>>
>>>>> First time I had a chance to use the new recover tools. I was abl=
e to
>>>>> reply the journal, reset it and then reset the sessionmap. MDS
>>>>> returned back to life and so far everything looks good. Yay.
>>>>>
>>>>> Triggering this a bug/issue is a pretty interesting set of steps.
>>>>
>>>> Spoke too soon, a missing dir is now causing MDS to restart it sel=
f.
>>>>
>>>>     -6> 2015-10-11 22:40:47.300169 7f580c7b9700  5 -- op tracker -=
-
>>>> seq: 4, time: 2015-10-11 22:40:47.300168, event: finishing request=
,
>>>> op: client_request(client.3597476:21480382 rmdir #100015e0be2/58
>>>> 2015-10-11 21:34:49.224905 RETRY=3D36)
>>>>     -5> 2015-10-11 22:40:47.300208 7f580c7b9700  5 -- op tracker -=
-
>>>> seq: 4, time: 2015-10-11 22:40:47.300208, event: cleaned up reques=
t,
>>>> op: client_request(client.3597476:21480382 rmdir #100015e0be2/58
>>>> 2015-10-11 21:34:49.224905 RETRY=3D36)
>>>>     -4> 2015-10-11 22:40:47.300231 7f580c7b9700  5 -- op tracker -=
-
>>>> seq: 4, time: 2015-10-11 22:40:47.300231, event: done, op:
>>>> client_request(client.3597476:21480382 rmdir #100015e0be2/58
>>>> 2015-10-11 21:34:49.224905 RETRY=3D36)
>>>>     -3> 2015-10-11 22:40:47.300284 7f580e0bd700  0
>>>> mds.0.cache.dir(100048df076) _fetched missing object for [dir
>>>> 100048df076 /petabucket/beta/6d/f6/ [2,head] auth v=3D0 cv=3D0/0 a=
p=3D1+0+0
>>>> state=3D1073741952 f() n() hs=3D0+0,ss=3D0+0 | waiter=3D1 authpin=3D=
1 0x6debcf8]
>>>>     -2> 2015-10-11 22:40:47.300313 7f580e0bd700 -1
>>>> log_channel(cluster) log [ERR] : dir 100048df076 object missing on
>>>> disk; some files may be lost
>>>>     -1> 2015-10-11 22:40:47.300549 7f580c7b9700  5 -- op tracker -=
-
>>>> seq: 6, time: 2015-10-11 22:40:47.300549, event: acquired locks, o=
p:
>>>> client_request(client.3710941:1805 mkdir
>>>> #100048df076/1dd4c66b916cf55f19beafc0574ac2dd923bc7efcc5b7757198f3=
23e04d0.dl
>>>> 2015-10-11 22:36:32.489705 RETRY=3D33)
>>>>      0> 2015-10-11 22:40:47.303770 7f580c7b9700 -1 mds/CDir.cc: In
>>>> function 'fnode_t* CDir::project_fnode()' thread 7f580c7b9700 time
>>>> 2015-10-11 22:40:47.300581
>>>> mds/CDir.cc: 1267: FAILED assert(get_version() !=3D 0)
>>>>
>>>>  ceph version 0.94.3 (95cefea9fd9ab740263bf8bb4796fd864d9afe2b)
>>>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>> const*)+0x8b) [0x94cc1b]
>>>>  2: (CDir::project_fnode()+0x2da) [0x75da1a]
>>>
>>> Worked around this as well. Stopped the client that was trying to
>>> access this dir (or delete it, not sure) and move it somewhere else
>>> (because I can't delete it).
>>>
>>> A series of steps that happened today (not sure if all are related)=
 in
>>> case the postmortem is interesting to anybody following at home.
>>>
>>> 1. One (of 5) monitors somehow gets OOM killed after eating up 10gi=
gs of ram.
>>> 2. An OSD blocks on an IO request
>>> 3. This is when the MSD starts growing it's SessionMap to a place
>>> where eventually it gets to big. This is related to bug:
>>> http://tracker.ceph.com/issues/10449 (not the client bug, but the t=
oo
>>> large Session)
>>> 4. MDS suicides and then two MDS machines start ping ponging in
>>> recovery but always fail to save SessionMap.
>>> 5. I stop the MDS, recover the journal and reset the session map.
>>
>> Exactly what did you do in this step? I have a suspicion you didn't
>> recover and flush out the journal all the way, and that's what cause=
d
>> your directory to go bad.
>> -Greg
>
> I followed the directions from the hammer recovery page on cephfs. Th=
e
> backup steps, recovery, truncation and the session clear in order.

John, I know you've got
https://github.com/ceph/ceph-qa-suite/pull/647. I think that's
supposed to be for this, but I'm not sure if you spotted any issues
with it or if we need to do some more diagnosing?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
