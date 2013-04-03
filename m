From: Dewan Shamsul Alam <dewan.shamsul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Cluster Map Problems
Date: Wed, 3 Apr 2013 20:37:21 +0600
Message-ID: <CAMj00WYMrEJqbXMhcYhb=ycnOr5RpwuqoakbNoWXNFxGc=r-ig@mail.gmail.com>
References: <514B5958.8050902@tuxadero.com> <51539550.70806@tuxadero.com>
	<CAM2gkg7h59X1u0L7P2Z9er+da3OoMw2Tmdbf=afWbUy8gKi+tA@mail.gmail.com>
	<5153A218.1060402@tuxadero.com>
	<CABZ+qq=LYqOC0o1S4-7iR-L2XweRQuBL6maoVz3LXwKKrJ90gg@mail.gmail.com>
	<51542952.3020502@tuxadero.com>
	<CAPYLRzhd2zLEQM=hgfLQWF5snSMn=NX=71b5kN+AYspAD24Q-g@mail.gmail.com>
	<51547F73.9090303@tuxadero.com>
	<CAPYLRzjeb5qeJGkeP+vxuWjwmh2KufKfJW8nMc7fVRPm+b3MHw@mail.gmail.com>
	<515483CA.2080904@tuxadero.com>
	<CAPYLRzi_CvAjEGYof=eWZ+9z3fC6hjfAyhPQ1fxgc2CNqYNsaA@mail.gmail.com>
	<51548810.709@tuxadero.com>
	<CAM2gkg7z3i9gzdo-ceDSJ5kZ_xhif7QieKLoS1YpvtbPt9w4PA@mail.gmail.com>
	<51549AF3.3080903@tuxadero.com>
	<CAPYLRzgyr5M8aWbtpdCn4ge6zcmgPS2k91k5-t4PyEiTernGaQ@mail.gmail.com>
	<5154A267.4010207@tuxadero.com>
	<CAM2gkg4fLE_N4kXdVX_2_suAy8-EuK=4ZTT0xqB0znjzYEB_5Q@mail.gmail.com>
	<5154C339.7070705@tuxadero.com>
	<CAM2gkg628PRNUye9poNJZ+fMNUpgRL=6CwoEXg6y=TqbtY3YhQ@mail.gmail.com>
	<515C3D76.1060302@tuxadero.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0758254521=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <515C3D76.1060302-64xna6+0MClWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0758254521==
Content-Type: multipart/alternative; boundary=f46d040714d5abeab904d975ca23

--f46d040714d5abeab904d975ca23
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've seen this in 0.56. In my case I shutdown one server then bring it
back. I have to run /etc/init.d/ceph -a restart to make it healthy.  It
doesn't impact the running VM I have in that cluster though.


On Wed, Apr 3, 2013 at 8:32 PM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org> wrote:

> Hi,
>
> I still have this problem in v0.60.
> If I stop one OSD, the OSD get set down after 20 seconds. But after 300
> seconds the OSD get not set out, there for the ceph stays degraded for
> ever.
> I can reproduce it with a fresh created cluster.
>
> root@store1:~# ceph -s
>    health HEALTH_WARN 405 pgs degraded; 405 pgs stuck unclean; recovery
> 10603/259576 degraded (4.085%); 1/24 in osds are down
>    monmap e1: 3 mons at
> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
> election epoch 10, quorum 0,1,2 a,b,c
>    osdmap e150: 24 osds: 23 up, 24 in
>     pgmap v12028: 4800 pgs: 4395 active+clean, 405 active+degraded; 505
> GB data, 1017 GB used, 173 TB / 174 TB avail; 0B/s rd, 6303B/s wr,
> 2op/s; 10603/259576 degraded (4.085%)
>    mdsmap e1: 0/0/1 up
>
>
> -martin
>
>
> On 28.03.2013 23:45, John Wilkins wrote:
> > Martin,
> >
> > I'm just speculating: since I just rewrote the networking section and
> > there is an empty mon_host value, and I do recall a chat last week
> > where mon_host was considered a different setting now, maybe you might
> > try specifying:
> >
> > [mon.a]
> >         mon host = store1
> >         mon addr = 192.168.195.31:6789
> >
> > etc. for monitors. I'm assuming that's not the case, but I want to
> > make sure my docs are right on this point.
> >
> >
> > On Thu, Mar 28, 2013 at 3:24 PM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
> wrote:
> >> Hi John,
> >>
> >> my ceph.conf is a bit further down in this email.
> >>
> >> -martin
> >>
> >> Am 28.03.2013 23:21, schrieb John Wilkins:
> >>
> >>> Martin,
> >>>
> >>> Would you mind posting your Ceph configuration file too?  I don't see
> >>> any value set for "mon_host": ""
> >>>
> >>> On Thu, Mar 28, 2013 at 1:04 PM, Martin Mailand <martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
> >>> wrote:
> >>>>
> >>>> Hi Greg,
> >>>>
> >>>> the dump from mon.a is attached.
> >>>>
> >>>> -martin
> >>>>
> >>>> On 28.03.2013 20:55, Gregory Farnum wrote:
> >>>>>
> >>>>> Hmm. The monitor code for checking this all looks good to me. Can you
> >>>>> go to one of your monitor nodes and dump the config?
> >>>>>
> >>>>> (
> http://ceph.com/docs/master/rados/configuration/ceph-conf/?highlight=admin%20socket#viewing-a-configuration-at-runtime
> )
> >>>>> -Greg
> >>>>>
> >>>>> On Thu, Mar 28, 2013 at 12:33 PM, Martin Mailand <
> martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
> >>>>> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I get the same behavior an new created cluster as well, no changes
> to
> >>>>>> the cluster config at all.
> >>>>>> I stop the osd.1, after 20 seconds it got marked down. But it never
> get
> >>>>>> marked out.
> >>>>>>
> >>>>>> ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e759)
> >>>>>>
> >>>>>> -martin
> >>>>>>
> >>>>>> On 28.03.2013 19:48, John Wilkins wrote:
> >>>>>>>
> >>>>>>> Martin,
> >>>>>>>
> >>>>>>> Greg is talking about noout. With Ceph, you can specifically
> preclude
> >>>>>>> OSDs from being marked out when down to prevent rebalancing--e.g.,
> >>>>>>> during upgrades, short-term maintenance, etc.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> http://ceph.com/docs/master/rados/operations/troubleshooting-osd/#stopping-w-out-rebalancing
> >>>>>>>
> >>>>>>> On Thu, Mar 28, 2013 at 11:12 AM, Martin Mailand <
> martin-64xna6+0MClWk0Htik3J/w@public.gmane.org>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> Hi Greg,
> >>>>>>>>
> >>>>>>>> setting the osd manually out triggered the recovery.
> >>>>>>>> But now it is the question, why is the osd not marked out after
> 300
> >>>>>>>> seconds? That's a default cluster, I use the 0.59 build from your
> >>>>>>>> site.
> >>>>>>>> And I didn't change any value, except for the crushmap.
> >>>>>>>>
> >>>>>>>> That's my ceph.conf.
> >>>>>>>>
> >>>>>>>> -martin
> >>>>>>>>
> >>>>>>>> [global]
> >>>>>>>>          auth cluster requierd = none
> >>>>>>>>          auth service required = none
> >>>>>>>>          auth client required = none
> >>>>>>>> #       log file = ""
> >>>>>>>>          log_max_recent=100
> >>>>>>>>          log_max_new=100
> >>>>>>>>
> >>>>>>>> [mon]
> >>>>>>>>          mon data = /data/mon.$id
> >>>>>>>> [mon.a]
> >>>>>>>>          host = store1
> >>>>>>>>          mon addr = 192.168.195.31:6789
> >>>>>>>> [mon.b]
> >>>>>>>>          host = store3
> >>>>>>>>          mon addr = 192.168.195.33:6789
> >>>>>>>> [mon.c]
> >>>>>>>>          host = store5
> >>>>>>>>          mon addr = 192.168.195.35:6789
> >>>>>>>> [osd]
> >>>>>>>>          journal aio = true
> >>>>>>>>          osd data = /data/osd.$id
> >>>>>>>>          osd mount options btrfs =
> rw,noatime,nodiratime,autodefrag
> >>>>>>>>          osd mkfs options btrfs = -n 32k -l 32k
> >>>>>>>>
> >>>>>>>> [osd.0]
> >>>>>>>>          host = store1
> >>>>>>>>          osd journal = /dev/sdg1
> >>>>>>>>          btrfs devs = /dev/sdc
> >>>>>>>> [osd.1]
> >>>>>>>>          host = store1
> >>>>>>>>          osd journal = /dev/sdh1
> >>>>>>>>          btrfs devs = /dev/sdd
> >>>>>>>> [osd.2]
> >>>>>>>>          host = store1
> >>>>>>>>          osd journal = /dev/sdi1
> >>>>>>>>          btrfs devs = /dev/sde
> >>>>>>>> [osd.3]
> >>>>>>>>          host = store1
> >>>>>>>>          osd journal = /dev/sdj1
> >>>>>>>>          btrfs devs = /dev/sdf
> >>>>>>>> [osd.4]
> >>>>>>>>          host = store2
> >>>>>>>>          osd journal = /dev/sdg1
> >>>>>>>>          btrfs devs = /dev/sdc
> >>>>>>>> [osd.5]
> >>>>>>>>          host = store2
> >>>>>>>>          osd journal = /dev/sdh1
> >>>>>>>>          btrfs devs = /dev/sdd
> >>>>>>>> [osd.6]
> >>>>>>>>          host = store2
> >>>>>>>>          osd journal = /dev/sdi1
> >>>>>>>>          btrfs devs = /dev/sde
> >>>>>>>> [osd.7]
> >>>>>>>>          host = store2
> >>>>>>>>          osd journal = /dev/sdj1
> >>>>>>>>          btrfs devs = /dev/sdf
> >>>>>>>> [osd.8]
> >>>>>>>>          host = store3
> >>>>>>>>          osd journal = /dev/sdg1
> >>>>>>>>          btrfs devs = /dev/sdc
> >>>>>>>> [osd.9]
> >>>>>>>>          host = store3
> >>>>>>>>          osd journal = /dev/sdh1
> >>>>>>>>          btrfs devs = /dev/sdd
> >>>>>>>> [osd.10]
> >>>>>>>>          host = store3
> >>>>>>>>          osd journal = /dev/sdi1
> >>>>>>>>          btrfs devs = /dev/sde
> >>>>>>>> [osd.11]
> >>>>>>>>          host = store3
> >>>>>>>>          osd journal = /dev/sdj1
> >>>>>>>>          btrfs devs = /dev/sdf
> >>>>>>>> [osd.12]
> >>>>>>>>          host = store4
> >>>>>>>>          osd journal = /dev/sdg1
> >>>>>>>>          btrfs devs = /dev/sdc
> >>>>>>>> [osd.13]
> >>>>>>>>          host = store4
> >>>>>>>>          osd journal = /dev/sdh1
> >>>>>>>>          btrfs devs = /dev/sdd
> >>>>>>>> [osd.14]
> >>>>>>>>          host = store4
> >>>>>>>>          osd journal = /dev/sdi1
> >>>>>>>>          btrfs devs = /dev/sde
> >>>>>>>> [osd.15]
> >>>>>>>>          host = store4
> >>>>>>>>          osd journal = /dev/sdj1
> >>>>>>>>          btrfs devs = /dev/sdf
> >>>>>>>> [osd.16]
> >>>>>>>>          host = store5
> >>>>>>>>          osd journal = /dev/sdg1
> >>>>>>>>          btrfs devs = /dev/sdc
> >>>>>>>> [osd.17]
> >>>>>>>>          host = store5
> >>>>>>>>          osd journal = /dev/sdh1
> >>>>>>>>          btrfs devs = /dev/sdd
> >>>>>>>> [osd.18]
> >>>>>>>>          host = store5
> >>>>>>>>          osd journal = /dev/sdi1
> >>>>>>>>          btrfs devs = /dev/sde
> >>>>>>>> [osd.19]
> >>>>>>>>          host = store5
> >>>>>>>>          osd journal = /dev/sdj1
> >>>>>>>>          btrfs devs = /dev/sdf
> >>>>>>>> [osd.20]
> >>>>>>>>          host = store6
> >>>>>>>>          osd journal = /dev/sdg1
> >>>>>>>>          btrfs devs = /dev/sdc
> >>>>>>>> [osd.21]
> >>>>>>>>          host = store6
> >>>>>>>>          osd journal = /dev/sdh1
> >>>>>>>>          btrfs devs = /dev/sdd
> >>>>>>>> [osd.22]
> >>>>>>>>          host = store6
> >>>>>>>>          osd journal = /dev/sdi1
> >>>>>>>>          btrfs devs = /dev/sde
> >>>>>>>> [osd.23]
> >>>>>>>>          host = store6
> >>>>>>>>          osd journal = /dev/sdj1
> >>>>>>>>          btrfs devs = /dev/sdf
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 28.03.2013 19:01, Gregory Farnum wrote:
> >>>>>>>>>
> >>>>>>>>> Your crush map looks fine to me. I'm saying that your ceph -s
> output
> >>>>>>>>> showed the OSD still hadn't been marked out. No data will be
> >>>>>>>>> migrated
> >>>>>>>>> until it's marked out.
> >>>>>>>>> After ten minutes it should have been marked out, but that's
> based
> >>>>>>>>> on
> >>>>>>>>> a number of factors you have some control over. If you just want
> a
> >>>>>>>>> quick check of your crush map you can mark it out manually, too.
> >>>>>>>>> -Greg
> >>>>>>>>
> >>>>>>>> _______________________________________________
> >>>>>>>> ceph-users mailing list
> >>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>
> >>>
> >>>
> >>
> >
> >
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--f46d040714d5abeab904d975ca23
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div>I&#39;ve seen this in 0.56. In my ca=
se I shutdown one server then bring it back. I have to run /etc/init.d/ceph=
 -a restart to make it healthy.=A0 It doesn&#39;t impact the running VM I h=
ave in that cluster though.<br>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed,=
 Apr 3, 2013 at 8:32 PM, Martin Mailand <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:martin-64xna6+0MClWk0Htik3J/w@public.gmane.org" target=3D"_blank">martin-64xna6+0MClWk0Htik3J/w@public.gmane.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
I still have this problem in v0.60.<br>
If I stop one OSD, the OSD get set down after 20 seconds. But after 300<br>
seconds the OSD get not set out, there for the ceph stays degraded for ever=
.<br>
I can reproduce it with a fresh created cluster.<br>
<br>
root@store1:~# ceph -s<br>
=A0 =A0health HEALTH_WARN 405 pgs degraded; 405 pgs stuck unclean; recovery=
<br>
10603/259576 degraded (4.085%); 1/24 in osds are down<br>
=A0 =A0monmap e1: 3 mons at<br>
{a=3D<a href=3D"http://192.168.195.31:6789/0,b=3D192.168.195.33:6789/0,c=3D=
192.168.195.35:6789/0" target=3D"_blank">192.168.195.31:6789/0,b=3D192.168.=
195.33:6789/0,c=3D192.168.195.35:6789/0</a>},<br>
election epoch 10, quorum 0,1,2 a,b,c<br>
=A0 =A0osdmap e150: 24 osds: 23 up, 24 in<br>
=A0 =A0 pgmap v12028: 4800 pgs: 4395 active+clean, 405 active+degraded; 505=
<br>
GB data, 1017 GB used, 173 TB / 174 TB avail; 0B/s rd, 6303B/s wr,<br>
2op/s; 10603/259576 degraded (4.085%)<br>
=A0 =A0mdsmap e1: 0/0/1 up<br>
<br>
<br>
-martin<br>
<br>
<br>
On 28.03.2013 23:45, John Wilkins wrote:<br>
&gt; Martin,<br>
&gt;<br>
&gt; I&#39;m just speculating: since I just rewrote the networking section =
and<br>
&gt; there is an empty mon_host value, and I do recall a chat last week<br>
&gt; where mon_host was considered a different setting now, maybe you might=
<br>
&gt; try specifying:<br>
&gt;<br>
&gt; [mon.a]<br>
&gt; =A0 =A0 =A0 =A0 mon host =3D store1<br>
&gt; =A0 =A0 =A0 =A0 mon addr =3D <a href=3D"http://192.168.195.31:6789" ta=
rget=3D"_blank">192.168.195.31:6789</a><br>
&gt;<br>
&gt; etc. for monitors. I&#39;m assuming that&#39;s not the case, but I wan=
t to<br>
&gt; make sure my docs are right on this point.<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Mar 28, 2013 at 3:24 PM, Martin Mailand &lt;<a href=3D"mailto:=
martin-64xna6+0MClWk0Htik3J/w@public.gmane.org">martin-64xna6+0MClWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; Hi John,<br>
&gt;&gt;<br>
&gt;&gt; my ceph.conf is a bit further down in this email.<br>
&gt;&gt;<br>
&gt;&gt; -martin<br>
&gt;&gt;<br>
&gt;&gt; Am 28.03.2013 23:21, schrieb John Wilkins:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Martin,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Would you mind posting your Ceph configuration file too? =A0I =
don&#39;t see<br>
&gt;&gt;&gt; any value set for &quot;mon_host&quot;: &quot;&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Thu, Mar 28, 2013 at 1:04 PM, Martin Mailand &lt;<a href=3D=
"mailto:martin-64xna6+0MClWk0Htik3J/w@public.gmane.org">martin-64xna6+0MClWk0Htik3J/w@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Greg,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; the dump from mon.a is attached.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -martin<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 28.03.2013 20:55, Gregory Farnum wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hmm. The monitor code for checking this all looks good=
 to me. Can you<br>
&gt;&gt;&gt;&gt;&gt; go to one of your monitor nodes and dump the config?<b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; (<a href=3D"http://ceph.com/docs/master/rados/configur=
ation/ceph-conf/?highlight=3Dadmin%20socket#viewing-a-configuration-at-runt=
ime" target=3D"_blank">http://ceph.com/docs/master/rados/configuration/ceph=
-conf/?highlight=3Dadmin%20socket#viewing-a-configuration-at-runtime</a>)<b=
r>

&gt;&gt;&gt;&gt;&gt; -Greg<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Thu, Mar 28, 2013 at 12:33 PM, Martin Mailand &lt;<=
a href=3D"mailto:martin-64xna6+0MClWk0Htik3J/w@public.gmane.org">martin-64xna6+0MClWk0Htik3J/w@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I get the same behavior an new created cluster as =
well, no changes to<br>
&gt;&gt;&gt;&gt;&gt;&gt; the cluster config at all.<br>
&gt;&gt;&gt;&gt;&gt;&gt; I stop the osd.1, after 20 seconds it got marked d=
own. But it never get<br>
&gt;&gt;&gt;&gt;&gt;&gt; marked out.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ceph version 0.59 (cbae6a435c62899f857775f66659de0=
52fb0e759)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; -martin<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 28.03.2013 19:48, John Wilkins wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Martin,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Greg is talking about noout. With Ceph, you ca=
n specifically preclude<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; OSDs from being marked out when down to preven=
t rebalancing--e.g.,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; during upgrades, short-term maintenance, etc.<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://ceph.com/docs/master/rados/o=
perations/troubleshooting-osd/#stopping-w-out-rebalancing" target=3D"_blank=
">http://ceph.com/docs/master/rados/operations/troubleshooting-osd/#stoppin=
g-w-out-rebalancing</a><br>

&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Thu, Mar 28, 2013 at 11:12 AM, Martin Maila=
nd &lt;<a href=3D"mailto:martin-64xna6+0MClWk0Htik3J/w@public.gmane.org">martin-64xna6+0MClWk0Htik3J/w@public.gmane.org</a>&gt;<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Greg,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; setting the osd manually out triggered the=
 recovery.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; But now it is the question, why is the osd=
 not marked out after 300<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; seconds? That&#39;s a default cluster, I u=
se the 0.59 build from your<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; site.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; And I didn&#39;t change any value, except =
for the crushmap.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s my ceph.conf.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -martin<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [global]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0auth cluster requierd =
=3D none<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0auth service required =
=3D none<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0auth client required =
=3D none<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; # =A0 =A0 =A0 log file =3D &quot;&quot;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0log_max_recent=3D100<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0log_max_new=3D100<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [mon]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0mon data =3D /data/mon.=
$id<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [mon.a]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0mon addr =3D <a href=3D=
"http://192.168.195.31:6789" target=3D"_blank">192.168.195.31:6789</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [mon.b]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store3<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0mon addr =3D <a href=3D=
"http://192.168.195.33:6789" target=3D"_blank">192.168.195.33:6789</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [mon.c]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store5<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0mon addr =3D <a href=3D=
"http://192.168.195.35:6789" target=3D"_blank">192.168.195.35:6789</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0journal aio =3D true<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd data =3D /data/osd.=
$id<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd mount options btrfs=
 =3D rw,noatime,nodiratime,autodefrag<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd mkfs options btrfs =
=3D -n 32k -l 32k<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.0]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
g1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.1]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
h1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.2]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
i1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.3]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
j1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.4]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
g1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.5]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
h1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.6]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
i1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.7]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
j1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.8]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store3<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
g1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.9]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store3<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
h1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.10]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store3<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
i1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.11]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store3<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
j1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.12]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store4<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
g1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.13]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store4<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
h1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.14]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store4<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
i1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.15]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store4<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
j1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.16]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store5<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
g1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.17]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store5<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
h1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.18]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store5<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
i1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.19]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store5<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
j1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.20]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store6<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
g1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.21]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store6<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
h1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.22]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store6<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
i1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [osd.23]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0host =3D store6<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sd=
j1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 28.03.2013 19:01, Gregory Farnum wrote:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Your crush map looks fine to me. I&#39=
;m saying that your ceph -s output<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; showed the OSD still hadn&#39;t been m=
arked out. No data will be<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; migrated<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; until it&#39;s marked out.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; After ten minutes it should have been =
marked out, but that&#39;s based<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; on<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; a number of factors you have some cont=
rol over. If you just want a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; quick check of your crush map you can =
mark it out manually, too.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Greg<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; __________________________________________=
_____<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFLNfb0M+mGrxg@public.gmane.org=
m">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.=
cgi/ceph-users-ceph.com" target=3D"_blank">http://lists.ceph.com/listinfo.c=
gi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--f46d040714d5abeab904d975ca23--

--===============0758254521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0758254521==--
