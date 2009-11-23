From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: help regarding ceph test cluster
Date: Mon, 23 Nov 2009 14:19:28 -0800
Message-ID: <1471eea70911231419x3aa54181n7e42759770e2decd@mail.gmail.com>
References: <1471eea70911211143u3e034644r98b8597fab461ef1@mail.gmail.com>
	<589813.77965.qm@web7907.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <589813.77965.qm@web7907.mail.in.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Amarnath BS <bsamarnath@yahoo.co.in>, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Amarnath:
How are you starting up each of the processes? Individually, or via
init-ceph? If you're doing it individually (not recommended; init-ceph
is a lot simpler!) is each process getting the appropriate ceph.conf
file to use? When you run csyn are you passing it the appropriate
ceph.conf file to use?
-Greg
PS: You will get faster answers if you send everything to the
ceph-devel list rather than directly to me. :)

On Mon, Nov 23, 2009 at 12:41 AM, Amarnath BS <bsamarnath@yahoo.co.in> wrot=
e:
>
> hi,
> =A0My ceph .conf=A0 is
> [global]
> =A0=A0=A0=A0=A0=A0 pid file =3D /var/run/ceph/$name.pid
> =A0=A0=A0=A0=A0=A0 debug ms =3D 1
> [mon]
> =A0=A0=A0=A0=A0=A0 mon data =3D dev/mon$id
> [mon0]
> =A0=A0=A0=A0=A0=A0 host =3D shani.local
> =A0=A0=A0=A0=A0=A0 mon addr =3D 192.168.1.140:6789
> [mon1]
> =A0=A0=A0=A0=A0=A0 host =3D shani.local
> =A0=A0=A0=A0=A0=A0 mon addr =3D 192.168.1.140:6790
> [mds]
> [mds0]
> =A0=A0=A0=A0=A0=A0 host =3D shani.local
> [osd]
> =A0=A0=A0=A0=A0=A0 osd data =3D /mnt/btrfs/osd$id
> [osd0]
> =A0=A0=A0=A0=A0=A0 host =3D srimugunthan-desktop.local
> [osd1]
> =A0=A0=A0=A0=A0=A0 host =3D surya-desktop.local
> [group everyone]
> =A0=A0=A0=A0=A0=A0 addr =3D 192.168.1.*
> [mount /]
> =A0=A0=A0=A0=A0=A0 allow =3D %everyone
> I have my ceph code running on one node(shani.local) and in other two nod=
es i have mounted the ceph code using NFS.( srimugunthan-desktop.local , su=
rya-desktop.local)
> I have created two btrfs mounted OSD's in=A0 srimugunthan-desktop.local ,=
 surya-desktop.local
> I have started the mds ,monitors on shani.local.I have ran cosd at the OS=
D's side.
> But when i run csyn to write a file at shani.local i am getting an error =
like:
> 192.168.1.140:6790/0/0 pipe(0x8245750 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault=
 first fault
>
> The exact error is that when i use vstart.sh -l(ie all subsystems reside =
on local host )to initialize subsystems i am able to use csyn to write file=
s but when i want to setup the mds,osd manually with different hostnames i =
am getting this error.Can u please tell me the procedure to set up ceph on =
multiple nodes.
>
> --- On Sun, 22/11/09, Gregory Farnum <gregf@hq.newdream.net> wrote:
>
> From: Gregory Farnum <gregf@hq.newdream.net>
> Subject: Re: [ceph-devel] help regarding ceph test cluster
> To: "Amarnath BS" <bsamarnath@yahoo.co.in>
> Cc: ceph-devel@lists.sourceforge.net
> Date: Sunday, 22 November, 2009, 1:13 AM
>
> Can you give us more details? What does your ceph.conf look like?
> What's the exact error?
> -Greg
>
> On Fri, Nov 20, 2009 at 10:56 AM, Amarnath BS <bsamarnath@yahoo.co.in> wr=
ote:
> >
> > hello every one,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 I have tried to setup ceph using three nodes.one node acting as mds+cli=
ent and other two as OSD's,but when try to run csyn at client side i get an=
 error denoting client as client? .I am unable to understand why the client=
 is not getting recognized.
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Can you please tell me=
 how to deal with this error
> > =A0=A0=A0=A0=A0=A0 --Amarnath
> _______________________________________________
> > Ceph-devel mailing list
> > Ceph-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ceph-devel
> >
>
> ________________________________
> The INTERNET now has a personality. YOURS! See your Yahoo! Homepage.

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
