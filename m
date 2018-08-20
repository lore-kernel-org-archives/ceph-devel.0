From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph balancer: further optimizations?
Date: Mon, 20 Aug 2018 16:41:19 -0400
Message-ID: <CAN-Gep+fyj65Y_CSMvyFKfDheD7N2HBSR+PKNU8xObo5f-Bu+Q@mail.gmail.com>
References: <c83c7687-90da-bfbb-3d17-5af8bb897334@profihost.ag>
 <alpine.DEB.2.11.1808201951330.7272@piezo.novalocal>
 <CAN-GepJiVxAwPMdS+EPDhUkDpF0sB+J4GBpFaYJ-5bz2pOhnCQ@mail.gmail.com>
 <242d9bd7-a6fb-683c-112d-72d45b085383@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4708021759378200475=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <242d9bd7-a6fb-683c-112d-72d45b085383-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4708021759378200475==
Content-Type: multipart/alternative; boundary="000000000000307b330573e3ef80"

--000000000000307b330573e3ef80
Content-Type: text/plain; charset="UTF-8"

I didn't ask how many PGs per OSD, I asked how large are your PGs in
comparison to your OSDs.  For instance my primary data pool in my home
cluster has 10914GB of data in it and has 256 PGs.  That means that each PG
accounts for 42GB of data.  I'm using 5TB disks in this cluster.  Each PG
on an OSD accounts for 0.8% of the total disk capacity on each OSD.  With
that % size per PG, I can get a really good balance in that cluster since
even if an OSD had 5 more PGs than another, it's only different by 4% total.

Now let's change the amount of PGs in my cluster.  The same amount of data
and the same size of disk, but only 32 PGs in the pool.  Each PG in that
pool takes up 6.8% of an OSD's available space.  Now even if I only have 2
more PGs on one osd than another, it's off by 13.4%.

On Mon, Aug 20, 2018 at 4:29 PM Stefan Priebe - Profihost AG <
s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:

>
> Am 20.08.2018 um 22:13 schrieb David Turner:
> > You might just have too much data per PG.  If a single PG can account
> > for 4% of your OSD, then 9% difference in used space on your OSDs is
> > caused by an OSD having only 2 more PGs than another OSD.  If you do
> > have very large PGs, increasing your PG count in those pools should
> > improve your data distribution.
>
> 4384 pgs
> 91 osds
> 3x replication
>
> 4384 / 91 * 3 => ~ 150 pgs which seems to be even too much - at least
> the doc says around 100 pgs / osd.
>
> >
> > On Mon, Aug 20, 2018 at 3:59 PM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org
> > <mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>> wrote:
> >
> >     On Mon, 20 Aug 2018, Stefan Priebe - Profihost AG wrote:
> >     > Hello,
> >     >
> >     > since loic seems to have left ceph development and his wunderful
> crush
> >     > optimization tool isn'T working anymore i'm trying to get a good
> >     > distribution with the ceph balancer.
> >     >
> >     > Sadly it does not work as good as i want.
> >     >
> >     > # ceph osd df | sort -k8
> >     >
> >     > show 75 to 83% Usage which is 8% difference which is too much for
> me.
> >     > I'm optimization by bytes.
> >     >
> >     > # ceph balancer eval
> >     > current cluster score 0.005420 (lower is better)
> >     >
> >     > # ceph balancer eval $OPT_NAME
> >     > plan spriebe_2018-08-20_19:36 final score 0.005456 (lower is
> better)
> >     >
> >     > I'm unable to optimize further ;-( Is there any chance to optimize
> >     > further even in case of more rebelancing?
> >
> >     The scoring that the balancer module is doing is currently a hybrid
> >     of pg
> >     count, bytes, and object count.  Picking a single metric might help
> >     a bit
> >     (as those 3 things are not always perfectly aligned).
> >
> >     s
> >     _______________________________________________
> >     ceph-users mailing list
> >     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>

--000000000000307b330573e3ef80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I didn&#39;t ask how many PGs per OSD, I asked how large a=
re your PGs in comparison to your OSDs.=C2=A0 For instance my primary data =
pool in my home cluster has 10914GB of data in it and has 256 PGs.=C2=A0 Th=
at means that each PG accounts for 42GB of data.=C2=A0 I&#39;m using 5TB di=
sks in this cluster.=C2=A0 Each PG on an OSD accounts for 0.8% of the total=
 disk capacity on each OSD.=C2=A0 With that % size per PG, I can get a real=
ly good balance in that cluster since even if an OSD had 5 more PGs than an=
other, it&#39;s only different by 4% total.<div><br></div><div>Now let&#39;=
s change the amount of PGs in my cluster.=C2=A0 The same amount of data and=
 the same size of disk, but only 32 PGs in the pool.=C2=A0 Each PG in that =
pool takes up 6.8% of an OSD&#39;s available space.=C2=A0 Now even if I onl=
y have 2 more PGs on one osd than another, it&#39;s off by 13.4%.</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Aug 20, 2018 at 4=
:29 PM Stefan Priebe - Profihost AG &lt;<a href=3D"mailto:s.priebe@profihos=
t.ag">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><br>
Am 20.08.2018 um 22:13 schrieb David Turner:<br>
&gt; You might just have too much data per PG.=C2=A0 If a single PG can acc=
ount<br>
&gt; for 4% of your OSD, then 9% difference in used space on your OSDs is<b=
r>
&gt; caused by an OSD having only 2 more PGs than another OSD.=C2=A0 If you=
 do<br>
&gt; have very large PGs, increasing your PG count in those pools should<br=
>
&gt; improve your data distribution.<br>
<br>
4384 pgs<br>
91 osds<br>
3x replication<br>
<br>
4384 / 91 * 3 =3D&gt; ~ 150 pgs which seems to be even too much - at least<=
br>
the doc says around 100 pgs / osd.<br>
<br>
&gt; <br>
&gt; On Mon, Aug 20, 2018 at 3:59 PM Sage Weil &lt;<a href=3D"mailto:sage@n=
ewdream.net" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">sage=
@newdream.net</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, 20 Aug 2018, Stefan Priebe - Profihost AG w=
rote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hello,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; since loic seems to have left ceph development=
 and his wunderful crush<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; optimization tool isn&#39;T working anymore i&=
#39;m trying to get a good<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; distribution with the ceph balancer.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Sadly it does not work as good as i want.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; # ceph osd df | sort -k8<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; show 75 to 83% Usage which is 8% difference wh=
ich is too much for me.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m optimization by bytes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; # ceph balancer eval<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; current cluster score 0.005420 (lower is bette=
r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; # ceph balancer eval $OPT_NAME<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; plan spriebe_2018-08-20_19:36 final score 0.00=
5456 (lower is better)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m unable to optimize further ;-( Is ther=
e any chance to optimize<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; further even in case of more rebelancing?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The scoring that the balancer module is doing is cu=
rrently a hybrid<br>
&gt;=C2=A0 =C2=A0 =C2=A0of pg<br>
&gt;=C2=A0 =C2=A0 =C2=A0count, bytes, and object count.=C2=A0 Picking a sin=
gle metric might help<br>
&gt;=C2=A0 =C2=A0 =C2=A0a bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0(as those 3 things are not always perfectly aligned=
).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0s<br>
&gt;=C2=A0 =C2=A0 =C2=A0_______________________________________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0ceph-users mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=
=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:ceph=
-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-=
users-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/=
listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; <br>
</blockquote></div>

--000000000000307b330573e3ef80--

--===============4708021759378200475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4708021759378200475==--
