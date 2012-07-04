From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Wed, 04 Jul 2012 19:53:27 +0200
Message-ID: <4FF48317.5030802@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com> <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:35215 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752932Ab2GDRxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 13:53:36 -0400
In-Reply-To: <A1B0B821610446B587EA459CA7D88ECF@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 04/07/2012 18:21, Gregory Farnum a =C3=A9crit :
> On Wednesday, July 4, 2012 at 1:06 AM, Yann Dupont wrote:
>> Le 03/07/2012 23:38, Tommi Virtanen a =C3=A9crit :
>>> On Tue, Jul 3, 2012 at 1:54 PM, Yann Dupont <Yann.Dupont@univ-nante=
s.fr (mailto:Yann.Dupont@univ-nantes.fr)> wrote:
>>>> In the case I could repair, do you think a crashed FS as it is rig=
ht now is
>>>> valuable for you, for future reference , as I saw you can't reprod=
uce the
>>>> problem ? I can make an archive (or a btrfs dump ?), but it will b=
e quite
>>>> big.
>>>  =20
>>>  =20
>>> At this point, it's more about the upstream developers (of btrfs et=
c)
>>> than us; we're on good terms with them but not experts on the on-di=
sk
>>> format(s). You might want to send an email to the relevant mailing
>>> lists before wiping the disks.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org (mailto:majordom=
o@vger.kernel.org)
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>  =20
>>  =20
>> Well, I probably wasn't clear enough. I talked about crashed FS, but=
 i
>> was talking about ceph. The underlying FS (btrfs in that case) of 1 =
node
>> (and only one) has PROBABLY crashed in the past, causing corruption =
in
>> ceph data on this node, and then the subsequent crash of other nodes=
=2E
>>  =20
>> RIGHT now btrfs on this node is OK. I can access the filesystem with=
out
>> errors.
>>  =20
>> For the moment, on 8 nodes, 4 refuse to restart .
>> 1 of the 4 nodes was the crashed node , the 3 others didn't had brob=
lem
>> with the underlying fs as far as I can tell.
>>  =20
>> So I think the scenario is :
>>  =20
>> One node had problem with btrfs, leading first to kernel problem ,
>> probably corruption (in disk/ in memory maybe ?) ,and ultimately to =
a
>> kernel oops. Before that ultimate kernel oops, bad data has been
>> transmitted to other (sane) nodes, leading to ceph-osd crash on thos=
es
>> nodes.
> I don't think that's actually possible =E2=80=94 the OSDs all do quit=
e a lot of interpretation between what they get off the wire and what g=
oes on disk. What you've got here are 4 corrupted LevelDB databases, an=
d we pretty much can't do that through the interfaces we have. :/

ok, so as all nodes were identical, I probably have hit a btrfs bug=20
(like a erroneous out of space ) in more or less the same time. And whe=
n=20
1 osd was out,
>   =20
>>  =20
>> If you think this scenario is highly improbable in real life (that i=
s,
>> btrfs will probably be fixed for good, and then, corruption can't
>> happen), it's ok.
>>  =20
>> But I wonder if this scenario can be triggered with other problem, a=
nd
>> bad data can be transmitted to other sane nodes (power outage, out o=
f
>> memory condition, disk full... for example)
>>  =20
>> That's why I proposed you a crashed ceph volume image (I shouldn't h=
ave
>> talked about a crashed fs, sorry for the confusion)
> I appreciate the offer, but I don't think this will help much =E2=80=94=
 it's a disk state managed by somebody else, not our logical state, whi=
ch has broken. If we could figure out how that state got broken that'd =
be good, but a "ceph image" won't really help in doing so.
ok, no problem. I'll restart from scratch, freshly formated.
>
> I wonder if maybe there's a confounding factor here =E2=80=94 are all=
 your nodes similar to each other,

Yes. I designed the cluster that way. All nodes are identical hardware=20
(powerEdge M610, 10G intel ethernet + emulex fibre channel attached to=20
storage (1 Array for 2 OSD nodes, 1 controller dedicated for each OSD)

>   or are they running on different kinds of hardware? How did you do =
your Ceph upgrades? What's ceph -s display when the cluster is running =
as best it can?

Ceph was running 0.47.2 at that time - (debian package for ceph). After=
=20
the crash I couldn't restart all the nodes. Tried 0.47.3 and now 0.48=20
without success.

Nothing particular for upgrades, because for the moment ceph is broken,=
=20
so just apt-get upgrade with new version.


ceph -s show that :

root@label5:~# ceph -s
    health HEALTH_WARN 260 pgs degraded; 793 pgs down; 785 pgs peering;=
=20
32 pgs recovering; 96 pgs stale; 793 pgs stuck inactive; 96 pgs stuck=20
stale; 1092 pgs stuck unclean; recovery 267286/2491140 degraded=20
(10.729%); 1814/1245570 unfound (0.146%)
    monmap e1: 3 mons at=20
{chichibu=3D172.20.14.130:6789/0,glenesk=3D172.20.14.131:6789/0,karuiza=
wa=3D172.20.14.133:6789/0},=20
election epoch 12, quorum 0,1,2 chichibu,glenesk,karuizawa
    osdmap e2404: 8 osds: 3 up, 3 in
     pgmap v173701: 1728 pgs: 604 active+clean, 8 down, 5=20
active+recovering+remapped, 32 active+clean+replay, 11=20
active+recovering+degraded, 25 active+remapped, 710 down+peering, 222=20
active+degraded, 7 stale+active+recovering+degraded, 61=20
stale+down+peering, 20 stale+active+degraded, 6 down+remapped+peering, =
8=20
stale+down+remapped+peering, 9 active+recovering; 4786 GB data, 7495 GB=
=20
used, 7280 GB / 15360 GB avail; 267286/2491140 degraded (10.729%);=20
1814/1245570 unfound (0.146%)
    mdsmap e172: 1/1/1 up {0=3Dkaruizawa=3Dup:replay}, 2 up:standby



BTW, After the 0.48 upgrade, there was a disk format conversion. 1 of=20
the 4 surviving OSD didn't complete :

2012-07-04 10:13:27.291541 7f8711099780 -1 filestore(/CEPH/data/osd.1)=20
=46ileStore::mount : stale version stamp detected: 2. Proceeding,=20
do_update is set, performing disk format upgrade.
2012-07-04 10:13:27.291618 7f8711099780  0 filestore(/CEPH/data/osd.1)=20
mount found snaps <3744666,3746725>

then , nothing happens for hours, iotop show constant disk usage :

  6069 be/4 root        0.00 B/s   32.09 M/s  0.00 % 19.08 % ceph-osd -=
i=20
1 --pid-file /var/run/ceph/osd.1.pid -c /etc/ceph/ceph.conf

strace show lots of syscall like this :

[pid  6069] pread(25, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 4101,=20
94950) =3D 4101
[pid  6069] pread(23, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 4107,=20
49678) =3D 4107
[pid  6069] pread(36, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 4110,=20
99797) =3D 4110
[pid  6069] pread(37, "\0EB_LEAF_\0002%e183%uTEMP.label5%u2"..., 4105,=20
8211) =3D 4105
[pid  6069] pread(25, "\0C\0_LEAF_\0002%e183%uTEMP.label5%u3"..., 4121,=
=20
99051) =3D 4121
[pid  6069] pread(36, "\0E\0_LEAF_\0002%e183%uTEMP.label5%u3"..., 4173,=
=20
103907) =3D 4173
[pid  6069] pread(37, "\0E\0_LEAF_\0002%e183%uTEMP.label5%u3"..., 4169,=
=20
12316) =3D 4169
[pid  6069] pread(37, "\0B\0_LEAF_\0002%e183%uTEMP.rb%e0%e1%"..., 4130,=
=20
16485) =3D 4130
[pid  6069] pread(36, "\0B\0_LEAF_\0002%e183%uTEMP.rb%e0%e1%"..., 4129,=
=20
108080) =3D 4129


Seeems to loop indefinitely.

But It's another problem I guess, maybe a consequence of the others pro=
blems

Cheers.

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
