From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
	forever
Date: Fri, 23 Jul 2010 14:08:42 +0200
Message-ID: <AANLkTimszjeT66r3rC9rYZK1p==Cfs14t-n3BJRSNksE@mail.gmail.com>
References: <201007231643.37780.anton.vazir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41183 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab0GWMIn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jul 2010 08:08:43 -0400
Received: by wwj40 with SMTP id 40so4485785wwj.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jul 2010 05:08:42 -0700 (PDT)
In-Reply-To: <201007231643.37780.anton.vazir@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anton <anton.vazir@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello Anton,

Thanks for the tip, I'll give a try. I'm however afraid that it won't
solve all hard ceph deaths since some umount eventually end with a
weird

Jul 23 13:36:34 kernel: [ 2188.974338] ceph: mds0 caps stale
Jul 23 13:36:49 kernel: [ 2203.969716] ceph: mds0 caps stale
Jul 23 13:38:05 kernel: [ 2279.665552] umount        D
ffff88000524f8e0     0  3042   2635 0x00000000
Jul 23 13:38:05 kernel: [ 2279.665558]  ffff880127a5b880
0000000000000086 0000000000000000 0000000000015640
Jul 23 13:38:05 kernel: [ 2279.665563]  0000000000015640
0000000000015640 000000000000f8a0 ffff880095e07fd8
Jul 23 13:38:05 kernel: [ 2279.665568]  0000000000015640
0000000000015640 ffff880084c1f810 ffff880084c1fb08
Jul 23 13:38:05 kernel: [ 2279.665572] Call Trace:
Jul 23 13:38:05 kernel: [ 2279.665588]  [<ffffffffa050b740>] ?
ceph_mdsc_sync+0x1be/0x1da [ceph]
Jul 23 13:38:05 kernel: [ 2279.665596]  [<ffffffff81064afa>] ?
autoremove_wake_function+0x0/0x2e
Jul 23 13:38:05 kernel: [ 2279.665606]  [<ffffffffa05110ac>] ?
ceph_osdc_sync+0x1d/0xc1 [ceph]
Jul 23 13:38:05 kernel: [ 2279.665613]  [<ffffffffa04f931f>] ?
ceph_syncfs+0x2a/0x2e [ceph]
Jul 23 13:38:05 kernel: [ 2279.665618]  [<ffffffff8110b065>] ?
__sync_filesystem+0x5f/0x70
Jul 23 13:38:05 kernel: [ 2279.665622]  [<ffffffff8110b1de>] ?
sync_filesystem+0x2e/0x44
Jul 23 13:38:05 kernel: [ 2279.665627]  [<ffffffff810efdfa>] ?
generic_shutdown_super+0x21/0xfa
Jul 23 13:38:05 kernel: [ 2279.665631]  [<ffffffff810eff16>] ?
kill_anon_super+0x9/0x40
Jul 23 13:38:05 kernel: [ 2279.665638]  [<ffffffffa04f82ab>] ?
ceph_kill_sb+0x24/0x47 [ceph]
Jul 23 13:38:05 kernel: [ 2279.665642]  [<ffffffff810f05c5>] ?
deactivate_super+0x60/0x77
Jul 23 13:38:05 kernel: [ 2279.665647]  [<ffffffff81102da3>] ?
sys_umount+0x2c3/0x2f2
Jul 23 13:38:05 kernel: [ 2279.665654]  [<ffffffff81010b42>] ?
system_call_fastpath+0x16/0x1b

It should however possibly helps in the ceph clean shutdown case.

Thanks,
Sebastien

2010/7/23 Anton <anton.vazir@gmail.com>:
> Did you try an umount -l (lasy umount) - should just
> disconnect the fs - as I experienced with other network FS -
> like NFS or Gluster - you may always have difficulties with
> any of them - so "-l" helps me. Not sure for CEPH though.
>
> On Friday 23 July 2010, S=E9bastien Paolacci wrote:
>> Hello Sage,
>>
>> I would like to emphasize that this issue is somewhat
>> annoying, even for experiment purpose: I definitely
>> expect my test server to not behave safely, crash, burn
>> or whatever, but having a client side impact as deep as
>> needed a (hard) reboot to solved a hanged ceph really
>> prevent me from testing with real life payloads.
>>
>> I understand that it's not an easy point but a lot of my
>> colleagues are not really whiling to sacrifice even
>> their dev workstation to play during spare time... sad
>> world ;)
>>
>> Sebastien
>>
>> On Wed, 16 Jun 2010, Peter Niemayer wrote:
>> > Hi,
>> >
>> > trying to "umount" a formerly mounted ceph filesystem
>> > that has become unavailable (osd crashed, then msd/mon
>> > were shut down using /etc/init.d/ceph stop) results in
>> > "umount" hanging forever in
>> > "D" state.
>> >
>> > Strangely, "umount -f" started from another terminal
>> > reports the ceph filesystem as not being mounted
>> > anymore, which is consistent with what the mount-table
>> > says.
>> >
>> > The kernel keeps emitting the following messages from
> time to time:
>> > > Jun 16 17:25:29 gitega kernel: ceph: =A0tid 211912
>> > > timed out on osd0, will reset osd
>> > > Jun 16 17:25:35 gitega kernel: ceph: mon0
>> > > 10.166.166.1:6789 connection failed
>> > > Jun 16 17:26:15 gitega last message repeated 4 times
>> >
>> > I would have expected the "umount" to terminate at
>> > least after some generous timeout.
>> >
>> > Ceph should probably support something like the
>> > "soft,intr" options of NFS, because if the only
>> > supported way of mounting is one where a client is
>> > more or less stuck-until-reboot when the service
>> > fails, many potential test-configurations involving
>> > Ceph are way too dangerous to try...
>>
>> Yeah, being able to force it to shut down when servers
>> are unresponsive is definitely the intent. =A0'umount -f'
>> should work. =A0It sounds like the problem is related to
>> the initial 'umount' (which doesn't time out) followed
>> by 'umount -f'.
>>
>> I'm hesitant to add a blanket umount timeout, as that
>> could prevent proper writeout of cached data/metadata in
>> some cases. =A0So I think the goal should be that if a
>> normal umount hangs for some reason, you should be able
>> to intervene to add the 'force' if things don't go well.
>>
>> sage
>> --
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
