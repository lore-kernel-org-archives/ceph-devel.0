From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 70+  OSD are DOWN and not coming up
Date: Tue, 20 May 2014 08:18:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405200815570.1689@cobra.newdream.net>
References: <5396D45F-E87E-4F53-85D8-B4DC1F630B78@csc.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-90498034-1400599088=:1689"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5396D45F-E87E-4F53-85D8-B4DC1F630B78-Gn+qtVAUx6s@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-90498034-1400599088=:1689
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2014, Karan Singh wrote:
> Hello Cephers , need your suggestion for troubleshooting.
>=20
> My cluster is terribly struggling , 70+ osd are down out of 165
>=20
> Problem ?>OSD are getting marked out of cluster and are down. The clust=
er is
> degraded. On checking logs of failed OSD we are getting wired entries t=
hat
> are continuously getting generated.

Tracking this at http://tracker.ceph.com/issues/8387

The most recent bits you posted in the ticket don't quite make sense: the=
=20
OSD is trying to connect to an address for an OSD that is currently marke=
d=20
down.  I suspect this is just timing between when the logs were captured=20
and when teh ceph osd dump was captured.  To get a complete pictures,=20
please:

1) add

 debug osd =3D 20
 debug ms =3D 1

in [osd] and restart all osds

2) ceph osd set nodown

(to prevent flapping)

3) find some OSD that is showing these messages

4) capture a 'ceph osd dump' output.

Also happy to debug this interactively over IRC; that will likely be=20
faster!

Thanks-
sage



>=20
> Osd Debug logs :: =A0http://pastebin.com/agTKh6zB
>=20
>=20
>  1. 2014-05-20 10:19:03.699886 7f2328e237a0 =A00 osd.158 357532 done wi=
th
>     init, starting boot process
>  2. 2014-05-20 10:19:03.700093 7f22ff621700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 pg=
s=3D0 cs=3D0
>     l=3D0 c=3D0x83018c0).connect claims to be 192.168.1.109:6802/63896 =
not
>     192.168.1.109:6802/910005982 - wrong node!
>  3. 2014-05-20 10:19:03.700152 7f22ff621700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.109:6802/910005982 pipe(0x8698500 sd=3D35 :33500 s=3D1 pg=
s=3D0 cs=3D0
>     l=3D0 c=3D0x83018c0).fault with nothing to send, going to standby
>  4. 2014-05-20 10:19:09.551269 7f22fdd12700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 p=
gs=3D0 cs=3D0
>     l=3D0 c=3D0x533fd20).connect claims to be 192.168.1.109:6803/63896 =
not
>     192.168.1.109:6803/1176009454 - wrong node!
>  5. 2014-05-20 10:19:09.551347 7f22fdd12700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.109:6803/1176009454 pipe(0x56aee00 sd=3D53 :40060 s=3D1 p=
gs=3D0 cs=3D0
>     l=3D0 c=3D0x533fd20).fault with nothing to send, going to standby
>  6. 2014-05-20 10:19:09.703901 7f22fd80d700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 :42889 s=3D1 pgs=3D=
0 cs=3D0 l=3D0
>     c=3D0x8302aa0).connect claims to be 192.168.1.113:6802/24612 not
>     192.168.1.113:6802/13870 - wrong node!
>  7. 2014-05-20 10:19:09.704039 7f22fd80d700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.113:6802/13870 pipe(0x56adf00 sd=3D137 :42889 s=3D1 pgs=3D=
0 cs=3D0 l=3D0
>     c=3D0x8302aa0).fault with nothing to send, going to standby
>  8. 2014-05-20 10:19:10.243139 7f22fd005700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D=
0 cs=3D0 l=3D0
>     c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 not
>     192.168.1.112:6800/14114 - wrong node!
>  9. 2014-05-20 10:19:10.243190 7f22fd005700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D=
0 cs=3D0 l=3D0
>     c=3D0x8304780).fault with nothing to send, going to standby
> 10. 2014-05-20 10:19:10.349693 7f22fc7fd700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 c=
s=3D0 l=3D0
>     c=3D0x83070c0).fault with nothing to send, going to standby
>=20
>=20
>  1. ceph -v
>     ceph version 0.80-469-g991f7f1
>     (991f7f15a6e107b33a24bbef1169f21eb7fcce2c) #
>  1. ceph osd stat
>     osdmap e357073: 165 osds: 91 up, 165 in
>     flags noout #
>=20
> I have tried doing :
>=20
> 1. Restarting the problematic OSDs , but no luck
> 2. =A0i restarted entire host but no luck, still osds are down and gett=
ing the
> same mesage
>=20
>  1. 2014-05-20 10:19:10.243139 7f22fd005700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D=
0 cs=3D0 l=3D0
>     c=3D0x8304780).connect claims to be 192.168.1.112:6800/2852 not
>     192.168.1.112:6800/14114 - wrong node!
>  2. 2014-05-20 10:19:10.243190 7f22fd005700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.112:6800/14114 pipe(0x56a8f00 sd=3D146 :43726 s=3D1 pgs=3D=
0 cs=3D0 l=3D0
>     c=3D0x8304780).fault with nothing to send, going to standby
>  3. 2014-05-20 10:19:10.349693 7f22fc7fd700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.109:6800/13492 pipe(0x8698c80 sd=3D156 :0 s=3D1 pgs=3D0 c=
s=3D0 l=3D0
>     c=3D0x83070c0).fault with nothing to send, going to standby
>  4. 2014-05-20 10:22:23.312473 7f2307e61700 =A00 osd.158 357781 do_comm=
and r=3D0
>  5. 2014-05-20 10:22:23.326110 7f2307e61700 =A00 osd.158 357781 do_comm=
and r=3D0
>     debug_osd=3D0/5
>  6. 2014-05-20 10:22:23.326123 7f2307e61700 =A00 log [INF] : debug_osd=3D=
0/5
>  7. 2014-05-20 10:34:08.161864 7f230224d700 =A00 -- 192.168.1.112:6802/=
3807 >>
>     192.168.1.102:6808/13276 pipe(0x8698280 sd=3D22 :41078 s=3D2 pgs=3D=
603 cs=3D1
>     l=3D0 c=3D0x8301600).fault with nothing to send, going to standby
>=20
> 3. Disks do not have errors , no message in dmesg and /var/log/messages
>=20
> 4. there was a bug in the past=A0http://tracker.ceph.com/issues/4006=A0=
, dont
> know it again came bacin in Firefly
>=20
> 5. Recently no activity performed on cluster , except some pool and key=
s
> creation for cinder /glance integration
>=20
> 6. Nodes have enough free resources for osds.
>=20
> 7. No issues with network , osds are down on all cluster nodes. not fro=
m a
> single node.
>=20
>=20
> ****************************************************************
> Karan Singh=A0
> Systems Specialist ,=A0Storage Platforms
> CSC - IT Center for Science,
> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
> mobile: +358 503 812758
> tel. +358 9 4572001
> fax +358 9 4572302
> http://www.csc.fi/
> ****************************************************************
>=20
>=20
>=20
--557981400-90498034-1400599088=:1689
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-90498034-1400599088=:1689--
