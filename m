From: Anton VG <anton.vazir@gmail.com>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
	forever
Date: Tue, 27 Jul 2010 15:49:28 +0500
Message-ID: <AANLkTim20PWd_r2gabUy5fQfH=qKcrkQ6Xzcb=hwK+T5@mail.gmail.com>
References: <AANLkTi=EgtWA6+jGODrsVreODwFgDrKkfWcrnL15_K32@mail.gmail.com>
	<Pine.LNX.4.64.1007230947130.6095@cobra.newdream.net>
	<AANLkTi=OD0aheS+ShnLhucsmV5VrtHRHj0TuQbz+6ROP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48461 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab0G0Kta convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jul 2010 06:49:30 -0400
Received: by vws3 with SMTP id 3so3401606vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 03:49:28 -0700 (PDT)
In-Reply-To: <AANLkTi=OD0aheS+ShnLhucsmV5VrtHRHj0TuQbz+6ROP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Sage, is looks logical, that if the user issues "umount -l" - the code
should give up syncing and clear the state. Or possibly there should
be a /proc/...whatever or /sys/...whatever setting to define a default
timeout to give up syncing.

2010/7/24 S=E9bastien Paolacci <sebastien.paolacci@gmail.com>:
> Hello Sage,
>
> I was just trying to relive an old thread but I definitely agree that
> I didn't make my point clear enough, sorry for that.
>
> The global idea is that whatever happen server-side, the client shoul=
d
> be able to be left in a clean state. By clean I mean that, except dat=
a
> explicitly pushed to (pulled from) the tested ceph share, no other
> side effect from the test session should be visible.
>
> The real issue with hanged unmounts is obviously not with the console
> been frozen but with all the subsequent syncs that are going to follo=
w
> the same path (and syncs do happen in a real life scenarios, e.g. whe=
n
> softly halting/restarting a box).
>
> Explicitly aborting the sync (whatever the way) is indeed a seductive
> option that would almost solve the point without going so far from a
> sync decent safe behavior.
>
> As a matter of convenience, should I just have a few hundred nodes to
> restart, I would however expect the sync to automatically abort
> because a delay I take the responsibility for as expired and the
> kclient is still deeply confident with the ceph tragic dead.
>
> So let's go back to a concrete failure case that can bother a client =
box ;) :
> =A0- a fresh new and just formated ceph instance is started.
> =A0- the share is mounted on a separate box and one single file is
> created (touch /mnt/test).
> =A0- ceph daemons are hardly killed (pkill -9 on cosd, cmds, cmon) an=
d
> the share is unmonted.
>
> The umount hang "as expected", but If I wait long enough I'll eventua=
lly get a
>
> Jul 24 09:31:16: [ 1163.642060] ceph: loaded (mon/mds/osd proto
> 15/32/24, osdmap 5/5 5/5)
> Jul 24 09:31:16: [ 1163.646098] ceph: client4099 fsid
> b003239e-a249-7c47-f7ca-a9b75da2a445
> Jul 24 09:31:16: [ 1163.646353] ceph: mon0 192.168.0.3:6789 session e=
stablished
> Jul 24 09:32:05: [ 1213.290150] ceph: mon0 192.168.0.3:6789 session
> lost, hunting for new mon
> Jul 24 09:33:01: [ 1269.227827] ceph: mds0 caps stale
> Jul 24 09:33:16: [ 1284.219034] ceph: mds0 caps stale
> Jul 24 09:35:52: [ 1439.844419] umount =A0 =A0 =A0 =A0D 0000000000000=
000 =A0 =A0 0
> =A02819 =A0 2788 0x00000000
> Jul 24 09:35:52: [ 1439.844425] =A0ffff880127a5b880 0000000000000086
> 0000000000000000 0000000000015640
> Jul 24 09:35:52: [ 1439.844430] =A00000000000015640 0000000000015640
> 000000000000f8a0 ffff880124ef1fd8
> Jul 24 09:35:52: [ 1439.844435] =A00000000000015640 0000000000015640
> ffff880086c8b170 ffff880086c8b468
> Jul 24 09:35:52: [ 1439.844439] Call Trace:
> Jul 24 09:35:52: [ 1439.844455] =A0[<ffffffffa051b740>] ?
> ceph_mdsc_sync+0x1be/0x1da [ceph]
> Jul 24 09:35:52: [ 1439.844462] =A0[<ffffffff81064afa>] ?
> autoremove_wake_function+0x0/0x2e
> Jul 24 09:35:52: [ 1439.844473] =A0[<ffffffffa05210ac>] ?
> ceph_osdc_sync+0x1d/0xc1 [ceph]
> Jul 24 09:35:52: [ 1439.844479] =A0[<ffffffffa050931f>] ?
> ceph_syncfs+0x2a/0x2e [ceph]
> Jul 24 09:35:52: [ 1439.844485] =A0[<ffffffff8110b065>] ?
> __sync_filesystem+0x5f/0x70
> Jul 24 09:35:52: [ 1439.844489] =A0[<ffffffff8110b1de>] ?
> sync_filesystem+0x2e/0x44
> Jul 24 09:35:52: [ 1439.844494] =A0[<ffffffff810efdfa>] ?
> generic_shutdown_super+0x21/0xfa
> Jul 24 09:35:52: [ 1439.844498] =A0[<ffffffff810eff16>] ? kill_anon_s=
uper+0x9/0x40
> Jul 24 09:35:52: [ 1439.844505] =A0[<ffffffffa05082ab>] ?
> ceph_kill_sb+0x24/0x47 [ceph]
> Jul 24 09:35:52: [ 1439.844509] =A0[<ffffffff810f05c5>] ?
> deactivate_super+0x60/0x77
> Jul 24 09:35:52: [ 1439.844514] =A0[<ffffffff81102da3>] ? sys_umount+=
0x2c3/0x2f2
> Jul 24 09:35:52: [ 1439.844521] =A0[<ffffffff81010b42>] ?
> system_call_fastpath+0x16/0x1b
> Jul 24 09:37:06: [ 1514.085107] ceph: mds0 hung
> Jul 24 09:37:52: [ 1559.774508] umount =A0 =A0 =A0 =A0D 0000000000000=
000 =A0 =A0 0
> =A02819 =A0 2788 0x00000000
> Jul 24 09:37:52: [ 1559.774514] =A0ffff880127a5b880 0000000000000086
> 0000000000000000 0000000000015640
> Jul 24 09:37:52: [ 1559.774519] =A00000000000015640 0000000000015640
> 000000000000f8a0 ffff880124ef1fd8
> Jul 24 09:37:52: [ 1559.774524] =A00000000000015640 0000000000015640
> ffff880086c8b170 ffff880086c8b468
> Jul 24 09:37:52: [ 1559.774528] Call Trace:
> Jul 24 09:37:52: [ 1559.774545] =A0[<ffffffffa051b740>] ?
> ceph_mdsc_sync+0x1be/0x1da [ceph]
> Jul 24 09:37:52: [ 1559.774552] =A0[<ffffffff81064afa>] ?
> autoremove_wake_function+0x0/0x2e
> Jul 24 09:37:52: [ 1559.774562] =A0[<ffffffffa05210ac>] ?
> ceph_osdc_sync+0x1d/0xc1 [ceph]
> Jul 24 09:37:52: [ 1559.774569] =A0[<ffffffffa050931f>] ?
> ceph_syncfs+0x2a/0x2e [ceph]
> Jul 24 09:37:52: [ 1559.774574] =A0[<ffffffff8110b065>] ?
> __sync_filesystem+0x5f/0x70
> Jul 24 09:37:52: [ 1559.774578] =A0[<ffffffff8110b1de>] ?
> sync_filesystem+0x2e/0x44
> Jul 24 09:37:52: [ 1559.774584] =A0[<ffffffff810efdfa>] ?
> generic_shutdown_super+0x21/0xfa
> Jul 24 09:37:52: [ 1559.774589] =A0[<ffffffff810eff16>] ? kill_anon_s=
uper+0x9/0x40
> Jul 24 09:37:52: [ 1559.774595] =A0[<ffffffffa05082ab>] ?
> ceph_kill_sb+0x24/0x47 [ceph]
> Jul 24 09:37:52: [ 1559.774600] =A0[<ffffffff810f05c5>] ?
> deactivate_super+0x60/0x77
> Jul 24 09:37:52: [ 1559.774604] =A0[<ffffffff81102da3>] ? sys_umount+=
0x2c3/0x2f2
> Jul 24 09:37:52: [ 1559.774612] =A0[<ffffffff81010b42>] ?
> system_call_fastpath+0x16/0x1b
> (... repeating forever ...)
>
> The box now as to be hardly powered off and a fsck will possibly
> follow the restart...
>
> I'm not saying that this situation is not to be expected when testing
> a not prod ready system, I'm just trying to emphasize that client
> safety may actually be a blocking point for some more people to give =
a
> try.
>
> Hope this clarifies,
> Sebastien
>
>
> 2010/7/23 Sage Weil <sage@newdream.net>:
>> On Fri, 23 Jul 2010, S=E9bastien Paolacci wrote:
>>> Hello Sage,
>>>
>>> I would like to emphasize that this issue is somewhat annoying, eve=
n
>>> for experiment purpose: I definitely expect my test server to not
>>> behave safely, crash, burn or whatever, but having a client side
>>> impact as deep as needed a (hard) reboot to solved a hanged ceph
>>> really prevent me from testing with real life payloads.
>>
>> Maybe you can clarify for me exactly where the problem is. =A0'umoun=
t -f'
>> should work. =A0'umount -l' should do a lazy unmount (detach from
>> namespace), but the actual unmount code may currently hang. =A0It's
>> debateable how that can/should be solved, since it's the 'sync' stag=
e that
>> hangs, and it's not clear we should ever 'give up' on that without a=
n
>> administrator telling us to (*).
>>
>> What problem do you actually see, though? =A0Why does it matter, or =
why do
>> you care, if the 'umount -l' leaves some kernel threads trying to um=
ount?
>> Is it just annoying because it Shouldn't Do That, or does it actuall=
y
>> cause a problem for you?
>>
>> It may be that if you try to remount the same fs, the old superblock=
 gets
>> reused, and the mount fails somehow... I haven't tried that. =A0That=
 would
>> be an easy fix, though.
>>
>> Any clarification would be helpful! =A0Thanks-
>> sage
>>
>>
>> * Maybe a hook like /sys/kernel/debug/ceph/.../abort_sync that you c=
an
>> echo 1 to would be sufficient to make it give up on a sync (in the u=
mount
>> -l case, the sync prior to the actual unmount).
>>
>>
>>>
>>> I understand that it's not an easy point but a lot of my colleagues
>>> are not really whiling to sacrifice even their dev workstation to p=
lay
>>> during spare time... sad world ;)
>>>
>>> Sebastien
>>>
>>> On Wed, 16 Jun 2010, Peter Niemayer wrote:
>>> > Hi,
>>> >
>>> > trying to "umount" a formerly mounted ceph filesystem that has be=
come
>>> > unavailable (osd crashed, then msd/mon were shut down using /etc/=
init.d/ceph
>>> > stop) results in "umount" hanging forever in
>>> > "D" state.
>>> >
>>> > Strangely, "umount -f" started from another terminal reports
>>> > the ceph filesystem as not being mounted anymore, which is consis=
tent
>>> > with what the mount-table says.
>>> >
>>> > The kernel keeps emitting the following messages from time to tim=
e:
>>> > > Jun 16 17:25:29 gitega kernel: ceph: =A0tid 211912 timed out on=
 osd0, will
>>> > > reset osd
>>> > > Jun 16 17:25:35 gitega kernel: ceph: mon0 10.166.166.1:6789 con=
nection
>>> > > failed
>>> > > Jun 16 17:26:15 gitega last message repeated 4 times
>>> >
>>> > I would have expected the "umount" to terminate at least after so=
me generous
>>> > timeout.
>>> >
>>> > Ceph should probably support something like the "soft,intr" optio=
ns
>>> > of NFS, because if the only supported way of mounting is one wher=
e
>>> > a client is more or less stuck-until-reboot when the service fail=
s,
>>> > many potential test-configurations involving Ceph are way too dan=
gerous
>>> > to try...
>>>
>>> Yeah, being able to force it to shut down when servers are unrespon=
sive is
>>> definitely the intent. =A0'umount -f' should work. =A0It sounds lik=
e the
>>> problem is related to the initial 'umount' (which doesn't time out)
>>> followed by 'umount -f'.
>>>
>>> I'm hesitant to add a blanket umount timeout, as that could prevent=
 proper
>>> writeout of cached data/metadata in some cases. =A0So I think the g=
oal
>>> should be that if a normal umount hangs for some reason, you should=
 be
>>> able to intervene to add the 'force' if things don't go well.
>>>
>>> sage
>>> --
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
