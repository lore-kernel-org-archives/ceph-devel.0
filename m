From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: Performance test on Ceph cluster
Date: Fri, 24 Feb 2012 08:58:42 +0000 (UTC)
Message-ID: <loom.20120224T062854-915@post.gmane.org>
References: <loom.20120222T102830-526@post.gmane.org> <CAORUGqC4Nof1d0V1K-ntNuRMh6c27AC+cB67HCxsKR-fWa+qPg@mail.gmail.com> <loom.20120223T080047-368@post.gmane.org> <CAORUGqBF-o7o_izZMoT1dNvrSES0owiGtd-9w1u_wYtqoH4AQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49483 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755747Ab2BXI6y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Feb 2012 03:58:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S0qzL-0004lY-Ny
	for ceph-devel@vger.kernel.org; Fri, 24 Feb 2012 09:58:52 +0100
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2012 09:58:51 +0100
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2012 09:58:51 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tommi.virtanen <at> dreamhost.com> writes:

>=20
> On Wed, Feb 22, 2012 at 23:12, madhusudhana
> <madhusudhana.u.acharya <at> gmail.com> wrote:
> > 1. can you please let me know how I can make only 1 MDS active ?
>=20
> You can see that in "ceph -s" output, the "mds" line should have just
> one entry like "0=3Da=3Dup:active" with the word active.
>=20
> You can control that with the "max mds" config option, and at runtime
> with "ceph mds set_max_mds NUM" and "ceph mds stop ID".
>=20
> Note, decreasing the number of active MDSes is not currently well
> tested. You might be better off with a fresh cluster, that only ever
> ran one ceph-mds process.
>=20
> > 2. BTRFS for all OSD's
>=20
> There is currently one known case where btrfs's internal structured
> get fragmented, and its performance starts degrading. You might want
> to make sure you start your test with freshly-mkfs'ed btrfses.
>=20
> > 3. All hosts (including OSD) in my ceph cluster are running 3.0.9 v=
er
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[root <at> c=
eph-node-8 ~]# uname -r
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.0.9
>=20
> Well, that's at least in the 3.x series.. Btrfs has had a steady
> stream of fixes, so in general we recommend running the latest stable
> kernel. You might want to try that.
>=20
> > 4. All 9 machines are replica of each other. I have imaged them usi=
ng
> > systemimager. Only difference is 9th node is not a part of CEPH
> > cluster. I mounted ceph cluster to this node using mount -t ceph
> > command
>=20
> That's good.
>=20
> > 5. All 9 clients are running same version of CentOS and Kernel with
> > 1GigE interface
>=20
> > You mean to say, I can have ceph mon/OSD's running in the
> > same machine ? but, in ceph wiki, i have read that its better to
> > have different machines for each mds/mon/osd.
>=20
> Yes, I just wanted to make sure you have it set up like that.
>=20
> > I assume that ceph uses whatever ethernet interface i have (1GigE)
> > in my system to load balance the cluster in case of node failure an=
d
> > node addition. Won't this uses entire bandwidth during load
> > balancing ? won't this cause bandwidth saturation for clients ?
>=20
> Yes. That's why you can set up a separate network for cluster-interna=
l
> communication. See "cluster network" or "cluster addr" vs "public
> network" or "public addr".
>=20
> > I would like to know what benchmark I should use to test CEPH ?
> > I want to present the data to my management how CEPH can perform wh=
en
> > compared with other file systems (like GlusterFS/NetApp/Lustre)
>=20
> You should use the benchmark that matches your actual workload best.
>=20
> Please stay active on the mailing list until your results start
> looking good. The more information you can provide, the better we can
> help you.
>=20
> We're looking forward to get one of our new hires going, he'll be
> benchmarking Ceph on pretty decent hardware & 10gig network with
> whatever loads we can come up with. That should give you a better ide=
a
> of what to expect, and us what to keep working on.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
Thank you Tommi for your response.=20

1. In my cluster, all OSD's are mkfs'ed with btrfs
2. Below is what i can see with ceph -s output. Is that mean, only one =
MDS
is operation and another one is standby ?
          mds e5: 1/1/1 up {0=3Dceph-node-1=3Dup:active}, 1 up:standby
3. I will not be able to use new stable kernel bcz of company policy :-=
(
4. If you don't mind, can you please give me a bit of insight on cluste=
r
network, what it is and how i can configure one for my ceph cluster ?
Will there be a significant performance improvement with this ?
5. I have done some testing with dd on ceph. Below are the results

CASE 1:[root@ceph-node-9 ~]# dd if=3D/dev/zero of=3D/mnt/ceph-test/wtes=
t bs=3D4k=20
count=3D1000000
1000000+0 records in
1000000+0 records out
4096000000 bytes (4.1 GB) copied, 4.04089 seconds, 1.0 GB/s

CASE 2:[root@ceph-node-9 ~]# dd if=3D/dev/zero of=3D/mnt/ceph-test/wtes=
t bs=3D4k=20
count=3D10000000
10000000+0 records in
10000000+0 records out
40960000000 bytes (41 GB) copied, 445.786 seconds, 91.9 MB/s

CASE 3:[root@ceph-node-9 ~]# dd if=3D/dev/zero of=3D/mnt/ceph-test/wtes=
t bs=3D4k=20
count=3D100000000
71414032+0 records in
71414032+0 records out
292511875072 bytes (293 GB) copied, 4116.59 seconds, 71.1 MB/s

As you can see from above output, for 4G file of 4k blocks, speed clock=
ed at=20
1GB/s, it gradually decreased when i increased the file size above 10G.
And also, if i run back to back dd with CASE 1 option, the write will=20
slow down from 1GB/s to 90MB/s.=20

can you please explain whether this behaviour is expected ? if yes, why=
 ?
if not, how i can achieve 1GB/s for all file sizes ?





--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
