From: Michael Kidd <linuxkidd-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-mon always election when change crushmap in
	firefly
Date: Wed, 23 Sep 2015 11:45:37 -0400
Message-ID: <CAND7sixgvyvAL8mM5c4VP9DCLMxeMTN3ma+R9L=4poakF9Pv6w@mail.gmail.com>
References: <CAA4r=YCZ+7jekicx6NqJ-+bzAcniMReMrLL-dYafCtrPGixpMg@mail.gmail.com>
	<alpine.DEB.2.00.1509230531150.11876@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0932107645=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1509230531150.11876-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: Alexander Yang <yangwanyuan8861-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0932107645==
Content-Type: multipart/alternative; boundary=001a113f2de8d6d14505206c032f

--001a113f2de8d6d14505206c032f
Content-Type: text/plain; charset=UTF-8

Hello Alexander,
  One other point on your email.. You indicate you desire each OSD to have
~100 PGs, but depending on your pool size, it seems you may have forgetting
about the additional PGs associated with replication itself.

Assuming 3x replication in your environment:
70,000 * 3
------------
800 OSDs

=~ 262.5 PGs per OSD on average

While this PG to OSD ratio shouldn't cause significant pain, I would not go
to any higher PG count without adding more spindles.

For more specific PG count guidance and modeling, please see:
http://ceph.com/pgcalc

Hope this helps,

Michael J. Kidd
Sr. Storage Consultant
Red Hat Global Storage Consulting
+1 919-442-8878

On Wed, Sep 23, 2015 at 8:34 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Wed, 23 Sep 2015, Alexander Yang wrote:
> > hello,
> >         We use Ceph+Openstack in our private cloud. In our cluster, we
> have
> > 5 mons and 800 osds, the Capacity is about 1Pb. And run about 700 vms and
> > 1100 volumes,
> >         recently, we increase our pg_num , now the cluster have about
> 70000
> > pgs. In my real intention? I want every osd have 100pgs. but after
> increase
> > pg_num, I find I'm wrong. Because the different crush weight for
> different
> > osd, the osd's pg_num is different, some osd have exceed  500pgs.
> >         Now, the problem is  appear?cause some reason when i want to
> change
> > some osd  weight, that means change the crushmap.  This change cause
> about
> > 0.03% data to migrate. the mon is always begin to election. It's will
> hung
> > the cluster, and when they end, the  original  leader still is the new
> > leader. And during the mon eclection?On the upper layer, vm have too many
> > slow request will appear. so now i dare to do any operation about change
> > crushmap. But i worry about an important thing, If  when our cluster
> down
> >  one host even down one rack.   By the time, the cluster curshmap will
> > change large, and the migrate data also large. I worry the cluster will
> > hung  long time. and result on upper layer, all vm became to  shutdown.
> >         In my opinion, I guess when I change the crushmap,* the leader
> mon
> > maybe calculate the too many information*, or* too many client want to
> get
> > the new crushmap from leader mon*.  It must be hung the mon thread, so
> the
> > leader mon can't heatbeat to other mons, the other mons think the leader
> is
> > down then begin the new election.  I am sorry if i guess is wrong.
> >         The crushmap in accessory. So who can give me some advice or
> guide,
> > Thanks very much!
>
> There were huge improvements made in hammer in terms of mon efficiency in
> these cases where it is under load.  I recommend upgrading as that will
> help.
>
> You can also mitigate the problem somewhat by adjusting the mon_lease and
> associated settings up.  Scale all of mon_lease, mon_lease_renew_interval,
> mon_lease_ack_timeout, mon_accept_timeout by 2x or 3x.
>
> It also sounds like you may be using some older tunables/settings
> for your pools or crush rules.  Can you attach the output of 'ceph osd
> dump' and 'ceph osd crush dump | tail -n 20' ?
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113f2de8d6d14505206c032f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div>Hello Alexand=
er,<br></div>=C2=A0 One other point on your email.. You indicate you desire=
 each OSD to have ~100 PGs, but depending on your pool size, it seems you m=
ay have forgetting about the additional PGs associated with replication its=
elf.<br><br></div>Assuming 3x replication in your environment:<br>70,000 * =
3<br>------------<br></div>800 OSDs<br><br></div>=3D~ 262.5 PGs per OSD on =
average<br><br></div>While this PG to OSD ratio shouldn&#39;t cause signifi=
cant pain, I would not go to any higher PG count without adding more spindl=
es.<br></div><br></div>For more specific PG count guidance and modeling, pl=
ease see:<br></div><a href=3D"http://ceph.com/pgcalc">http://ceph.com/pgcal=
c</a><br><br></div>Hope this helps,<br></div><div class=3D"gmail_extra"><br=
 clear=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Mi=
chael J. Kidd<br>Sr. Storage Consultant<br> Red Hat Global Storage Consulti=
ng<br></div>+1 919-442-8878</div></div></div>
<br><div class=3D"gmail_quote">On Wed, Sep 23, 2015 at 8:34 AM, Sage Weil <=
span dir=3D"ltr">&lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank"=
>sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Wed, 23 Sep 2015, Alexander Yang wrote:<br>
&gt; hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We use Ceph+Openstack in our private =
cloud. In our cluster, we have<br>
&gt; 5 mons and 800 osds, the Capacity is about 1Pb. And run about 700 vms =
and<br>
&gt; 1100 volumes,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recently, we increase our pg_num , no=
w the cluster have about 70000<br>
&gt; pgs. In my real intention? I want every osd have 100pgs. but after inc=
rease<br>
&gt; pg_num, I find I&#39;m wrong. Because the different crush weight for d=
ifferent<br>
&gt; osd, the osd&#39;s pg_num is different, some osd have exceed=C2=A0 500=
pgs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Now, the problem is=C2=A0 appear?caus=
e some reason when i want to change<br>
&gt; some osd=C2=A0 weight, that means change the crushmap.=C2=A0 This chan=
ge cause about<br>
&gt; 0.03% data to migrate. the mon is always begin to election. It&#39;s w=
ill hung<br>
&gt; the cluster, and when they end, the=C2=A0 original=C2=A0 leader still =
is the new<br>
&gt; leader. And during the mon eclection?On the upper layer, vm have too m=
any<br>
&gt; slow request will appear. so now i dare to do any operation about chan=
ge<br>
&gt; crushmap. But i worry about an important thing, If=C2=A0 when our clus=
ter=C2=A0 down<br>
&gt;=C2=A0 one host even down one rack.=C2=A0 =C2=A0By the time, the cluste=
r curshmap will<br>
&gt; change large, and the migrate data also large. I worry the cluster wil=
l<br>
&gt; hung=C2=A0 long time. and result on upper layer, all vm became to=C2=
=A0 shutdown.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In my opinion, I guess when I change =
the crushmap,* the leader mon<br>
&gt; maybe calculate the too many information*, or* too many client want to=
 get<br>
&gt; the new crushmap from leader mon*.=C2=A0 It must be hung the mon threa=
d, so the<br>
&gt; leader mon can&#39;t heatbeat to other mons, the other mons think the =
leader is<br>
&gt; down then begin the new election.=C2=A0 I am sorry if i guess is wrong=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The crushmap in accessory. So who can=
 give me some advice or guide,<br>
&gt; Thanks very much!<br>
<br>
There were huge improvements made in hammer in terms of mon efficiency in<b=
r>
these cases where it is under load.=C2=A0 I recommend upgrading as that wil=
l<br>
help.<br>
<br>
You can also mitigate the problem somewhat by adjusting the mon_lease and<b=
r>
associated settings up.=C2=A0 Scale all of mon_lease, mon_lease_renew_inter=
val,<br>
mon_lease_ack_timeout, mon_accept_timeout by 2x or 3x.<br>
<br>
It also sounds like you may be using some older tunables/settings<br>
for your pools or crush rules.=C2=A0 Can you attach the output of &#39;ceph=
 osd<br>
dump&#39; and &#39;ceph osd crush dump | tail -n 20&#39; ?<br>
<br>
sage<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div><br></div>

--001a113f2de8d6d14505206c032f--

--===============0932107645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0932107645==--
