From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: v0.38 released
Date: Tue, 15 Nov 2011 11:53:51 -0800
Message-ID: <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
	<20111115164254.GJ13394@systemlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51563 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab1KOTxv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 14:53:51 -0500
Received: by iage36 with SMTP id e36so8867674iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2011 11:53:51 -0800 (PST)
In-Reply-To: <20111115164254.GJ13394@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Nov 15, 2011 at 8:42 AM, Andre Noll <maan@systemlinux.org> wrot=
e:
> On Thu, Nov 10, 21:14, Sage Weil wrote:
>> =A0* osd: some peering refactoring
>> =A0* osd: 'replay' period is per-pool (now only affects fs data pool=
)
>> =A0* osd: clean up old osdmaps
>> =A0* osd: allow admin to revert lost objects to prior versions (or d=
elete)
>> =A0* mkcephfs: generate reasonable crush map based on 'host' and 'ra=
ck'
>> =A0 =A0fields in [osd.NN] sections of ceph.conf
>> =A0* radosgw: bucket index improvements
>> =A0* radosgw: improved swift support
>> =A0* rbd: misc command line tool fixes
>> =A0* debian: misc packaging fixes (including dependency breakage on =
upgrades)
>> =A0* ceph: query daemon perfcounters via command line tool
>>
>> The big upcoming items for v0.39 are RBD layering (image cloning), f=
urther
>> improvements to radosgw's Swift support, and some monitor failure re=
covery
>> and bootstrapping improvements. =A0We're also continuing work on the
>> automation bits that the Chef cookbooks and Juju charms will use, an=
d a
>> Crowbar barclamp was also just posted on github. =A0Several patches =
are
>> still working their way into libvirt and qemu to improve support for=
 RBD
>> authentication.
>
> Any plans to address the ENOSPC issue? I gave v0.38 a try and the
> file system behaves like the older (<=3D 0.36) versions I've tried
> before when it fills up: The ceph mounts hang on all clients.

This is something we hope to address in the future, but we haven't
come up with a good solution yet. (I haven't seen a good solution in
other distributed systems either...)

> But there is progress: Sync is now interuptable (it used to block
> in D state so that it could not be killed even with SIGKILL), and
> umount works even if the file system is full. However, subsequent
> mount attempts then fail with "mount error 5 =3D Input/output error".
Yay!

> Our test setup consists of one mds, one monitor and 8 osds. mds and
> monitor are on the same node, and this node is not not an osd. All
> nodes are running Linux-3.0.9 ATM, but I would be willing to upgrade
> to 3.1.1 if this is expected to make a difference.
>
> Here's some output of "ceph -w". Funny enough it reports 770G of free
> disk space space although the writing process terminated with ENOSPC.
Right now RADOS (the object store under the Ceph FS) is pretty
conservative about reporting ENOSPC. Since btrfs is also pretty
unhappy when its disk fills up, an OSD marks itself as "full" once
it's reached 95% of its capacity, and once a single OSD goes full then
RADOS marks itself that way so you don't overfill a disk and have
really bad things happen. (Hung mounts suck but are a lot better than
mysterious data loss.)

Looking at your ceph -s I'm surprised by a few things, though...
1) Why do you have so many PGs? 8k/OSD is rather a lot
2) I wouldn't expect your OSDs to have become so unbalanced that one
of them hits 95% full when the cluster's only at 84% capacity.

What is this cluster used for? Are you running anything besides the
Ceph FS on it? (radosgw, maybe?)
-Greg

> 2011-11-15 12:12:45.388535 =A0 =A0pg v38805: 65940 pgs: 1956 creating=
, 63984 active+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avai=
l
> 2011-11-15 12:12:45.589228 =A0 mds e4: 1/1/1 up {0=3D0=3Dup:active}
> 2011-11-15 12:12:45.589326 =A0 osd e11: 8 osds: 8 up, 8 in full
> 2011-11-15 12:12:45.589908 =A0 log 2011-11-15 12:12:19.599894 osd.326=
 192.168.3.26:6800/1673 168 : [INF] 0.593 scrub ok
> 2011-11-15 12:12:45.590000 =A0 mon e1: 1 mons at {0=3D192.168.3.34:67=
89/0}
> 2011-11-15 12:12:49.554163 =A0 =A0pg v38806: 65940 pgs: 1956 creating=
, 63984 active+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avai=
l
> 2011-11-15 12:12:54.526661 =A0 =A0pg v38807: 65940 pgs: 1956 creating=
, 63984 active+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avai=
l
> 2011-11-15 12:12:56.309292 =A0 =A0pg v38808: 65940 pgs: 1956 creating=
, 63984 active+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avai=
l
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
