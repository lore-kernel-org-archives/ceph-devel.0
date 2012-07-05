From: Gregory Farnum <greg@inktank.com>
Subject: Re: domino-style OSD crash
Date: Thu, 5 Jul 2012 14:32:08 -0700
Message-ID: <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr>
	<CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
	<CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
	<4FF2AFEB.1010403@univ-nantes.fr>
	<CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
	<4FF35C01.4070400@univ-nantes.fr>
	<CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
	<4FF3F98C.30602@univ-nantes.fr>
	<A1B0B821610446B587EA459CA7D88ECF@inktank.com>
	<4FF48317.5030802@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57210 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab2GEVcK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 17:32:10 -0400
Received: by lbbgm6 with SMTP id gm6so13541585lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 14:32:08 -0700 (PDT)
In-Reply-To: <4FF48317.5030802@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>, Sam Just <sam.just@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 4, 2012 at 10:53 AM, Yann Dupont <Yann.Dupont@univ-nantes.f=
r> wrote:
> Le 04/07/2012 18:21, Gregory Farnum a =E9crit :
>
>> On Wednesday, July 4, 2012 at 1:06 AM, Yann Dupont wrote:
>>>
>>> Le 03/07/2012 23:38, Tommi Virtanen a =E9crit :
>>>>
>>>> On Tue, Jul 3, 2012 at 1:54 PM, Yann Dupont <Yann.Dupont@univ-nant=
es.fr
>>>> (mailto:Yann.Dupont@univ-nantes.fr)> wrote:
>>>>>
>>>>> In the case I could repair, do you think a crashed FS as it is ri=
ght
>>>>> now is
>>>>> valuable for you, for future reference , as I saw you can't repro=
duce
>>>>> the
>>>>> problem ? I can make an archive (or a btrfs dump ?), but it will =
be
>>>>> quite
>>>>> big.
>>>>
>>>> =A0 =A0 At this point, it's more about the upstream developers (of=
 btrfs
>>>> etc)
>>>> than us; we're on good terms with them but not experts on the on-d=
isk
>>>> format(s). You might want to send an email to the relevant mailing
>>>> lists before wiping the disks.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> (mailto:majordomo@vger.kernel.org)
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>> =A0 =A0 Well, I probably wasn't clear enough. I talked about crashe=
d FS, but
>>> i
>>> was talking about ceph. The underlying FS (btrfs in that case) of 1=
 node
>>> (and only one) has PROBABLY crashed in the past, causing corruption=
 in
>>> ceph data on this node, and then the subsequent crash of other node=
s.
>>> =A0 RIGHT now btrfs on this node is OK. I can access the filesystem=
 without
>>> errors.
>>> =A0 For the moment, on 8 nodes, 4 refuse to restart .
>>> 1 of the 4 nodes was the crashed node , the 3 others didn't had bro=
blem
>>> with the underlying fs as far as I can tell.
>>> =A0 So I think the scenario is :
>>> =A0 One node had problem with btrfs, leading first to kernel proble=
m ,
>>> probably corruption (in disk/ in memory maybe ?) ,and ultimately to=
 a
>>> kernel oops. Before that ultimate kernel oops, bad data has been
>>> transmitted to other (sane) nodes, leading to ceph-osd crash on tho=
ses
>>> nodes.
>>
>> I don't think that's actually possible =97 the OSDs all do quite a l=
ot of
>> interpretation between what they get off the wire and what goes on d=
isk.
>> What you've got here are 4 corrupted LevelDB databases, and we prett=
y much
>> can't do that through the interfaces we have. :/
>
>
> ok, so as all nodes were identical, I probably have hit a btrfs bug (=
like a
> erroneous out of space ) in more or less the same time. And when 1 os=
d was
> out,
>
>>
>>>
>>> =A0 If you think this scenario is highly improbable in real life (t=
hat is,
>>> btrfs will probably be fixed for good, and then, corruption can't
>>> happen), it's ok.
>>> =A0 But I wonder if this scenario can be triggered with other probl=
em, and
>>> bad data can be transmitted to other sane nodes (power outage, out =
of
>>> memory condition, disk full... for example)
>>> =A0 That's why I proposed you a crashed ceph volume image (I should=
n't have
>>> talked about a crashed fs, sorry for the confusion)
>>
>> I appreciate the offer, but I don't think this will help much =97 it=
's a
>> disk state managed by somebody else, not our logical state, which ha=
s
>> broken. If we could figure out how that state got broken that'd be g=
ood, but
>> a "ceph image" won't really help in doing so.
>
> ok, no problem. I'll restart from scratch, freshly formated.
>
>>
>> I wonder if maybe there's a confounding factor here =97 are all your=
 nodes
>> similar to each other,
>
>
> Yes. I designed the cluster that way. All nodes are identical hardwar=
e
> (powerEdge M610, 10G intel ethernet + emulex fibre channel attached t=
o
> storage (1 Array for 2 OSD nodes, 1 controller dedicated for each OSD=
)

Oh, interesting. Are the broken nodes all on the same set of arrays?


>
>
>> =A0 or are they running on different kinds of hardware? How did you =
do your
>> Ceph upgrades? What's ceph -s display when the cluster is running as=
 best it
>> can?
>
>
> Ceph was running 0.47.2 at that time - (debian package for ceph). Aft=
er the
> crash I couldn't restart all the nodes. Tried 0.47.3 and now 0.48 wit=
hout
> success.
>
> Nothing particular for upgrades, because for the moment ceph is broke=
n, so
> just apt-get upgrade with new version.
>
>
> ceph -s show that :
>
> root@label5:~# ceph -s
> =A0 =A0health HEALTH_WARN 260 pgs degraded; 793 pgs down; 785 pgs pee=
ring; 32
> pgs recovering; 96 pgs stale; 793 pgs stuck inactive; 96 pgs stuck st=
ale;
> 1092 pgs stuck unclean; recovery 267286/2491140 degraded (10.729%);
> 1814/1245570 unfound (0.146%)
> =A0 =A0monmap e1: 3 mons at
> {chichibu=3D172.20.14.130:6789/0,glenesk=3D172.20.14.131:6789/0,karui=
zawa=3D172.20.14.133:6789/0},
> election epoch 12, quorum 0,1,2 chichibu,glenesk,karuizawa
> =A0 =A0osdmap e2404: 8 osds: 3 up, 3 in
> =A0 =A0 pgmap v173701: 1728 pgs: 604 active+clean, 8 down, 5
> active+recovering+remapped, 32 active+clean+replay, 11
> active+recovering+degraded, 25 active+remapped, 710 down+peering, 222
> active+degraded, 7 stale+active+recovering+degraded, 61 stale+down+pe=
ering,
> 20 stale+active+degraded, 6 down+remapped+peering, 8
> stale+down+remapped+peering, 9 active+recovering; 4786 GB data, 7495 =
GB
> used, 7280 GB / 15360 GB avail; 267286/2491140 degraded (10.729%);
> 1814/1245570 unfound (0.146%)
> =A0 =A0mdsmap e172: 1/1/1 up {0=3Dkaruizawa=3Dup:replay}, 2 up:standb=
y

Okay, that looks about how I'd expect if half your OSDs are down.

>
>
>
> BTW, After the 0.48 upgrade, there was a disk format conversion. 1 of=
 the 4
> surviving OSD didn't complete :
>
> 2012-07-04 10:13:27.291541 7f8711099780 -1 filestore(/CEPH/data/osd.1=
)
> FileStore::mount : stale version stamp detected: 2. Proceeding, do_up=
date is
> set, performing disk format upgrade.
> 2012-07-04 10:13:27.291618 7f8711099780 =A00 filestore(/CEPH/data/osd=
=2E1) mount
> found snaps <3744666,3746725>
>
> then , nothing happens for hours, iotop show constant disk usage :

> =A06069 be/4 root =A0 =A0 =A0 =A00.00 B/s =A0 32.09 M/s =A00.00 % 19.=
08 % ceph-osd -i 1
> --pid-file /var/run/ceph/osd.1.pid -c /etc/ceph/ceph.conf
>
> strace show lots of syscall like this :
>
> [pid =A06069] pread(25, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 41=
01,
> 94950) =3D 4101
> [pid =A06069] pread(23, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 41=
07,
> 49678) =3D 4107
> [pid =A06069] pread(36, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 41=
10,
> 99797) =3D 4110
> [pid =A06069] pread(37, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 41=
05, 8211)
> =3D 4105
> [pid =A06069] pread(25, "\0C\0_LEAF_\0002%e183%uTEMP.label5%u3"..., 4=
121,
> 99051) =3D 4121
> [pid =A06069] pread(36, "\0E\0_LEAF_\0002%e183%uTEMP.label5%u3"..., 4=
173,
> 103907) =3D 4173
> [pid =A06069] pread(37, "\0E\0_LEAF_\0002%e183%uTEMP.label5%u3"..., 4=
169,
> 12316) =3D 4169
> [pid =A06069] pread(37, "\0B\0_LEAF_\0002%e183%uTEMP.rb%e0%e1%"..., 4=
130,
> 16485) =3D 4130
> [pid =A06069] pread(36, "\0B\0_LEAF_\0002%e183%uTEMP.rb%e0%e1%"..., 4=
129,
> 108080) =3D 4129

Sam, does this look like something of ours to you?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
