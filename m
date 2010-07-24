From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
	forever
Date: Sat, 24 Jul 2010 10:36:56 +0200
Message-ID: <AANLkTi=OD0aheS+ShnLhucsmV5VrtHRHj0TuQbz+6ROP@mail.gmail.com>
References: <AANLkTi=EgtWA6+jGODrsVreODwFgDrKkfWcrnL15_K32@mail.gmail.com>
	<Pine.LNX.4.64.1007230947130.6095@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46431 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab0GXIg6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Jul 2010 04:36:58 -0400
Received: by wyf19 with SMTP id 19so921938wyf.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Jul 2010 01:36:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1007230947130.6095@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello Sage,

I was just trying to relive an old thread but I definitely agree that
I didn't make my point clear enough, sorry for that.

The global idea is that whatever happen server-side, the client should
be able to be left in a clean state. By clean I mean that, except data
explicitly pushed to (pulled from) the tested ceph share, no other
side effect from the test session should be visible.

The real issue with hanged unmounts is obviously not with the console
been frozen but with all the subsequent syncs that are going to follow
the same path (and syncs do happen in a real life scenarios, e.g. when
softly halting/restarting a box).

Explicitly aborting the sync (whatever the way) is indeed a seductive
option that would almost solve the point without going so far from a
sync decent safe behavior.

As a matter of convenience, should I just have a few hundred nodes to
restart, I would however expect the sync to automatically abort
because a delay I take the responsibility for as expired and the
kclient is still deeply confident with the ceph tragic dead.

So let's go back to a concrete failure case that can bother a client bo=
x ;) :
 - a fresh new and just formated ceph instance is started.
 - the share is mounted on a separate box and one single file is
created (touch /mnt/test).
 - ceph daemons are hardly killed (pkill -9 on cosd, cmds, cmon) and
the share is unmonted.

The umount hang "as expected", but If I wait long enough I'll eventuall=
y get a

Jul 24 09:31:16: [ 1163.642060] ceph: loaded (mon/mds/osd proto
15/32/24, osdmap 5/5 5/5)
Jul 24 09:31:16: [ 1163.646098] ceph: client4099 fsid
b003239e-a249-7c47-f7ca-a9b75da2a445
Jul 24 09:31:16: [ 1163.646353] ceph: mon0 192.168.0.3:6789 session est=
ablished
Jul 24 09:32:05: [ 1213.290150] ceph: mon0 192.168.0.3:6789 session
lost, hunting for new mon
Jul 24 09:33:01: [ 1269.227827] ceph: mds0 caps stale
Jul 24 09:33:16: [ 1284.219034] ceph: mds0 caps stale
Jul 24 09:35:52: [ 1439.844419] umount        D 0000000000000000     0
 2819   2788 0x00000000
Jul 24 09:35:52: [ 1439.844425]  ffff880127a5b880 0000000000000086
0000000000000000 0000000000015640
Jul 24 09:35:52: [ 1439.844430]  0000000000015640 0000000000015640
000000000000f8a0 ffff880124ef1fd8
Jul 24 09:35:52: [ 1439.844435]  0000000000015640 0000000000015640
ffff880086c8b170 ffff880086c8b468
Jul 24 09:35:52: [ 1439.844439] Call Trace:
Jul 24 09:35:52: [ 1439.844455]  [<ffffffffa051b740>] ?
ceph_mdsc_sync+0x1be/0x1da [ceph]
Jul 24 09:35:52: [ 1439.844462]  [<ffffffff81064afa>] ?
autoremove_wake_function+0x0/0x2e
Jul 24 09:35:52: [ 1439.844473]  [<ffffffffa05210ac>] ?
ceph_osdc_sync+0x1d/0xc1 [ceph]
Jul 24 09:35:52: [ 1439.844479]  [<ffffffffa050931f>] ?
ceph_syncfs+0x2a/0x2e [ceph]
Jul 24 09:35:52: [ 1439.844485]  [<ffffffff8110b065>] ?
__sync_filesystem+0x5f/0x70
Jul 24 09:35:52: [ 1439.844489]  [<ffffffff8110b1de>] ?
sync_filesystem+0x2e/0x44
Jul 24 09:35:52: [ 1439.844494]  [<ffffffff810efdfa>] ?
generic_shutdown_super+0x21/0xfa
Jul 24 09:35:52: [ 1439.844498]  [<ffffffff810eff16>] ? kill_anon_super=
+0x9/0x40
Jul 24 09:35:52: [ 1439.844505]  [<ffffffffa05082ab>] ?
ceph_kill_sb+0x24/0x47 [ceph]
Jul 24 09:35:52: [ 1439.844509]  [<ffffffff810f05c5>] ?
deactivate_super+0x60/0x77
Jul 24 09:35:52: [ 1439.844514]  [<ffffffff81102da3>] ? sys_umount+0x2c=
3/0x2f2
Jul 24 09:35:52: [ 1439.844521]  [<ffffffff81010b42>] ?
system_call_fastpath+0x16/0x1b
Jul 24 09:37:06: [ 1514.085107] ceph: mds0 hung
Jul 24 09:37:52: [ 1559.774508] umount        D 0000000000000000     0
 2819   2788 0x00000000
Jul 24 09:37:52: [ 1559.774514]  ffff880127a5b880 0000000000000086
0000000000000000 0000000000015640
Jul 24 09:37:52: [ 1559.774519]  0000000000015640 0000000000015640
000000000000f8a0 ffff880124ef1fd8
Jul 24 09:37:52: [ 1559.774524]  0000000000015640 0000000000015640
ffff880086c8b170 ffff880086c8b468
Jul 24 09:37:52: [ 1559.774528] Call Trace:
Jul 24 09:37:52: [ 1559.774545]  [<ffffffffa051b740>] ?
ceph_mdsc_sync+0x1be/0x1da [ceph]
Jul 24 09:37:52: [ 1559.774552]  [<ffffffff81064afa>] ?
autoremove_wake_function+0x0/0x2e
Jul 24 09:37:52: [ 1559.774562]  [<ffffffffa05210ac>] ?
ceph_osdc_sync+0x1d/0xc1 [ceph]
Jul 24 09:37:52: [ 1559.774569]  [<ffffffffa050931f>] ?
ceph_syncfs+0x2a/0x2e [ceph]
Jul 24 09:37:52: [ 1559.774574]  [<ffffffff8110b065>] ?
__sync_filesystem+0x5f/0x70
Jul 24 09:37:52: [ 1559.774578]  [<ffffffff8110b1de>] ?
sync_filesystem+0x2e/0x44
Jul 24 09:37:52: [ 1559.774584]  [<ffffffff810efdfa>] ?
generic_shutdown_super+0x21/0xfa
Jul 24 09:37:52: [ 1559.774589]  [<ffffffff810eff16>] ? kill_anon_super=
+0x9/0x40
Jul 24 09:37:52: [ 1559.774595]  [<ffffffffa05082ab>] ?
ceph_kill_sb+0x24/0x47 [ceph]
Jul 24 09:37:52: [ 1559.774600]  [<ffffffff810f05c5>] ?
deactivate_super+0x60/0x77
Jul 24 09:37:52: [ 1559.774604]  [<ffffffff81102da3>] ? sys_umount+0x2c=
3/0x2f2
Jul 24 09:37:52: [ 1559.774612]  [<ffffffff81010b42>] ?
system_call_fastpath+0x16/0x1b
(... repeating forever ...)

The box now as to be hardly powered off and a fsck will possibly
follow the restart...

I'm not saying that this situation is not to be expected when testing
a not prod ready system, I'm just trying to emphasize that client
safety may actually be a blocking point for some more people to give a
try.

Hope this clarifies,
Sebastien


2010/7/23 Sage Weil <sage@newdream.net>:
> On Fri, 23 Jul 2010, S=E9bastien Paolacci wrote:
>> Hello Sage,
>>
>> I would like to emphasize that this issue is somewhat annoying, even
>> for experiment purpose: I definitely expect my test server to not
>> behave safely, crash, burn or whatever, but having a client side
>> impact as deep as needed a (hard) reboot to solved a hanged ceph
>> really prevent me from testing with real life payloads.
>
> Maybe you can clarify for me exactly where the problem is. =A0'umount=
 -f'
> should work. =A0'umount -l' should do a lazy unmount (detach from
> namespace), but the actual unmount code may currently hang. =A0It's
> debateable how that can/should be solved, since it's the 'sync' stage=
 that
> hangs, and it's not clear we should ever 'give up' on that without an
> administrator telling us to (*).
>
> What problem do you actually see, though? =A0Why does it matter, or w=
hy do
> you care, if the 'umount -l' leaves some kernel threads trying to umo=
unt?
> Is it just annoying because it Shouldn't Do That, or does it actually
> cause a problem for you?
>
> It may be that if you try to remount the same fs, the old superblock =
gets
> reused, and the mount fails somehow... I haven't tried that. =A0That =
would
> be an easy fix, though.
>
> Any clarification would be helpful! =A0Thanks-
> sage
>
>
> * Maybe a hook like /sys/kernel/debug/ceph/.../abort_sync that you ca=
n
> echo 1 to would be sufficient to make it give up on a sync (in the um=
ount
> -l case, the sync prior to the actual unmount).
>
>
>>
>> I understand that it's not an easy point but a lot of my colleagues
>> are not really whiling to sacrifice even their dev workstation to pl=
ay
>> during spare time... sad world ;)
>>
>> Sebastien
>>
>> On Wed, 16 Jun 2010, Peter Niemayer wrote:
>> > Hi,
>> >
>> > trying to "umount" a formerly mounted ceph filesystem that has bec=
ome
>> > unavailable (osd crashed, then msd/mon were shut down using /etc/i=
nit.d/ceph
>> > stop) results in "umount" hanging forever in
>> > "D" state.
>> >
>> > Strangely, "umount -f" started from another terminal reports
>> > the ceph filesystem as not being mounted anymore, which is consist=
ent
>> > with what the mount-table says.
>> >
>> > The kernel keeps emitting the following messages from time to time=
:
>> > > Jun 16 17:25:29 gitega kernel: ceph: =A0tid 211912 timed out on =
osd0, will
>> > > reset osd
>> > > Jun 16 17:25:35 gitega kernel: ceph: mon0 10.166.166.1:6789 conn=
ection
>> > > failed
>> > > Jun 16 17:26:15 gitega last message repeated 4 times
>> >
>> > I would have expected the "umount" to terminate at least after som=
e generous
>> > timeout.
>> >
>> > Ceph should probably support something like the "soft,intr" option=
s
>> > of NFS, because if the only supported way of mounting is one where
>> > a client is more or less stuck-until-reboot when the service fails=
,
>> > many potential test-configurations involving Ceph are way too dang=
erous
>> > to try...
>>
>> Yeah, being able to force it to shut down when servers are unrespons=
ive is
>> definitely the intent. =A0'umount -f' should work. =A0It sounds like=
 the
>> problem is related to the initial 'umount' (which doesn't time out)
>> followed by 'umount -f'.
>>
>> I'm hesitant to add a blanket umount timeout, as that could prevent =
proper
>> writeout of cached data/metadata in some cases. =A0So I think the go=
al
>> should be that if a normal umount hangs for some reason, you should =
be
>> able to intervene to add the 'force' if things don't go well.
>>
>> sage
>> --
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
