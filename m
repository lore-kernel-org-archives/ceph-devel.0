From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Fri, 2 Dec 2011 11:29:41 -0800
Message-ID: <CACLRD_0mb_PxqmZUqgTnjXJARKw6NV34QEF_fqCtXZ4UJ7C9GQ@mail.gmail.com>
References: <4366451.BU1d1YAr76@pc10>
	<4ECFE472.9020603@widodh.nl>
	<2356347.ajsbJfnmVK@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48895 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1LBT3m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2011 14:29:42 -0500
Received: by wgbdr13 with SMTP id dr13so1724192wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 02 Dec 2011 11:29:41 -0800 (PST)
In-Reply-To: <2356347.ajsbJfnmVK@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Guido,

Sorry for the confusion, you hit a bug where the default map for a
cluster with one osd contains no pgs.  0.39 (which will be released
today) will have a fix.

-Sam

On Fri, Dec 2, 2011 at 8:24 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Hi,
>
> Am Freitag, 25. November 2011, 19:54:42 schrieb Wido den Hollander:
>> Hi Guido,
>>
>> On 11/25/2011 05:53 PM, Guido Winkelmann wrote:
>> > Hi,
>> >
>> > When trying to mount a Ceph filesystem with "mount.ceph 10.3.1.33:=
6789:/
>> > /mnt", the command hangs for several minutes and then fails with t=
he
>> > message
>> >
>> > mount error 5 =3D Input/output error
>>
>> Does "ceph -s" work? If so, what is the output?
>
> It works. This is the output:
>
> # ceph -s
> 2011-11-28 18:51:32.018383 =C2=A0 =C2=A0pg v60: 6 pgs: 6 active+clean=
+degraded; 0 KB
> data, 1292 KB used, 1750 GB / 1752 GB avail
> 2011-11-28 18:51:32.018610 =C2=A0 mds e11: 1/1/1 up {0=3Dalpha=3Dup:c=
reating}
> 2011-11-28 18:51:32.018698 =C2=A0 osd e22: 1 osds: 1 up, 1 in
> 2011-11-28 18:51:32.018767 =C2=A0 log 2011-11-28 18:50:16.299822 mon.=
0
> 10.3.1.33:6789/0 3 : [INF] mds.? 10.3.1.33:6800/21218 up:boot
> 2011-11-28 18:51:32.018833 =C2=A0 mon e1: 1 mons at {ceph1=3D10.3.1.3=
3:6789/0}
>
>>
>> > Background:
>> >
>> > I'm trying to set up a small 3-machine Ceph cluster, to be used fo=
r
>> > network- transparent block- and file storage for Qemu server
>> > virtualization. This is the first time I'm doing anything at all w=
ith
>> > Ceph, so many of the concepts are still new and a bit confusing to=
 me.
>> >
>> > My plan was to set up each of the three machines equally with one =
mon,
>> > one osd and one mds, and to add more servers, or replace the exist=
ing
>> > ones with bigger machines, as need arises.
>>
>> If should be enough to have 3 OSD's and 1 MON and 1 MDS, for basic
>> testing that is all you'd need.
>
> Well as long as I have three machines, I might as well go for some mo=
re
> redundancy... No need to have the whole cluster fail just because the=
 one node
> with the mon or mds daemon goes down.
>
> [...]
>> > - make&& =C2=A0make install
>> > - Copy src/init-ceph to /etc/init.d/
>> > - Create /usr/local/etc/ceph/ceph.conf with this content:
>> >
>> > [global]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max open files =3D 131072
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log file =3D /var/log/ceph/$name=
=2Elog
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_to_syslog =3D true
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid file =3D /var/run/ceph/$name=
=2Epid
>>
>> You want to log to syslog and files simultaneously? That will cause
>> double the I/O on that system.
>
> Well, I've switched off the syslog part now.
>
>> > [mon]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mon data =3D /mondata/$name
>> >
>> > [mon.ceph1]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D ceph1
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mon addr =3D 10.3.1.33:6789
>> >
>> > [mds]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keyring =3D /cephxdata/keyring.$=
name
>>
>> Why did you specify a keyring here? You did not enable the cephx
>> authentication.
>
> I suppose I just forgot that particular part. It doesn't seem to make=
 any
> difference though - I tried removing that line and restart ceph, it d=
id not
> change anything.
>
> At first, I tried starting with Cephx, but that let to other errors, =
so I
> disabled it to remove one variable when looking for the problem.
> The biggest problem I still have with Cephx is lacking documentation.=
 So far,
> the best I have found is some offhand mention in the "Cluster_configu=
ration"
> page on the wiki and the man page to ceph-authtool. Maybe I've missed
> something, but so far, I haven't anything that really explains how th=
is is
> supposed to work.
>
> One thing in particular I don't get yet is why all example config fil=
es seem to
> give each component a different keyring file. As far as I understood =
the design,
> each client will have to connect directly to every component (mon/mds=
/osd)
> directly, so how can authentication still work if they each have thei=
r own
> keyring?
>
>> > [mds.alpha]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D ceph1
>> >
>> > [osd]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0osd data =3D /data/$name
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal =3D /data/$name/jour=
nal
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal size =3D 1000 ; jour=
nal size, in megabytes
>> >
>> > [osd.0]
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D ceph1
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs devs =3D /dev/sda5 /dev/sd=
b5
>>
>> Does that actually work? Never tested with specifying to devices. Wh=
at
>> are you trying to do? Create a striped filesystem?
>
> Well, mostly I was just trying to use the storage space from both har=
ddisks in
> this machine. Since the built-in multi-device capability of btrfs is =
one of
> the most advertised features, this looked like the logical solution t=
o me.
>
> It looks like it's working, too. btrfs-show shows me a filesystem wit=
h two
> devices, and twice the storage space of just one of them. The mounted
> filesystem under /data can be used like any other filesystem...
>
> Would you say I should go about this differently?
>
>> > (Slightly adjusted from src/sample.ceph.conf, comments removed for
>> > brevity)
>> >
>> > - Run mkcephfs -c /usr/local/etc/ceph/ceph.conf --mkbtrfs -a -k \
>> > /usr/local/etc/ceph/keyring.bin
>> > - Run /etc/init.d/ceph start
>> >
>> > After these steps, I tried to mount the ceph filesystem (on the sa=
me
>> > machine) with "mount.ceph 10.3.1.33:6789:/ /mnt" and got the
>> > aforementioned error.
>> Mounting the Ceph filesystem on the same host as where your OSD is
>> running is not recommended. Although it should probably work, you co=
uld
>> run into some trouble.
>
> Really? That's the first I've heard of that, and it seems quite count=
er-
> intuitive, too.
>
> Anyway, I've tried mounting the ceph filesystem from a different host=
, and the
> result is exactly the same.
>
> BTW, when I'm issuing the mount command, I can see these lines in dme=
sg:
>
> libceph: client4602 fsid c8dd60a6-3dc7-6188-3f84-c58ff04f244a
> libceph: mon0 10.3.1.33:6789 session established
>
>> You could take a look at my ceph.conf: http://zooi.widodh.nl/ceph/ce=
ph.conf
>>
>> That might give you some more clues!
>
> Hm, I'm afraid it doesn't. It's neat to see a working cluster with 10=
 storage
> nodes and IPv6, but it gives me no pointers as to why /my/ installati=
on isn't
> working.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Guido
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
