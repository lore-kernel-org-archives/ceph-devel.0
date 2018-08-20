From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph balancer: further optimizations?
Date: Mon, 20 Aug 2018 16:13:42 -0400
Message-ID: <CAN-GepJiVxAwPMdS+EPDhUkDpF0sB+J4GBpFaYJ-5bz2pOhnCQ@mail.gmail.com>
References: <c83c7687-90da-bfbb-3d17-5af8bb897334@profihost.ag>
 <alpine.DEB.2.11.1808201951330.7272@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3543910510614302548=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1808201951330.7272-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3543910510614302548==
Content-Type: multipart/alternative; boundary="0000000000006764510573e38c03"

--0000000000006764510573e38c03
Content-Type: text/plain; charset="UTF-8"

You might just have too much data per PG.  If a single PG can account for
4% of your OSD, then 9% difference in used space on your OSDs is caused by
an OSD having only 2 more PGs than another OSD.  If you do have very large
PGs, increasing your PG count in those pools should improve your data
distribution.

On Mon, Aug 20, 2018 at 3:59 PM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Mon, 20 Aug 2018, Stefan Priebe - Profihost AG wrote:
> > Hello,
> >
> > since loic seems to have left ceph development and his wunderful crush
> > optimization tool isn'T working anymore i'm trying to get a good
> > distribution with the ceph balancer.
> >
> > Sadly it does not work as good as i want.
> >
> > # ceph osd df | sort -k8
> >
> > show 75 to 83% Usage which is 8% difference which is too much for me.
> > I'm optimization by bytes.
> >
> > # ceph balancer eval
> > current cluster score 0.005420 (lower is better)
> >
> > # ceph balancer eval $OPT_NAME
> > plan spriebe_2018-08-20_19:36 final score 0.005456 (lower is better)
> >
> > I'm unable to optimize further ;-( Is there any chance to optimize
> > further even in case of more rebelancing?
>
> The scoring that the balancer module is doing is currently a hybrid of pg
> count, bytes, and object count.  Picking a single metric might help a bit
> (as those 3 things are not always perfectly aligned).
>
> s
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000006764510573e38c03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You might just have too much data per PG.=C2=A0 If a singl=
e PG can account for 4% of your OSD, then 9% difference in used space on yo=
ur OSDs is caused by an OSD having only 2 more PGs than another OSD.=C2=A0 =
If you do have very large PGs, increasing your PG count in those pools shou=
ld improve your data distribution.</div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr">On Mon, Aug 20, 2018 at 3:59 PM Sage Weil &lt;<a href=3D"mailt=
o:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On Mon, 20 Aug 2018, Stefan Priebe - Profihost AG wrote:=
<br>
&gt; Hello,<br>
&gt; <br>
&gt; since loic seems to have left ceph development and his wunderful crush=
<br>
&gt; optimization tool isn&#39;T working anymore i&#39;m trying to get a go=
od<br>
&gt; distribution with the ceph balancer.<br>
&gt; <br>
&gt; Sadly it does not work as good as i want.<br>
&gt; <br>
&gt; # ceph osd df | sort -k8<br>
&gt; <br>
&gt; show 75 to 83% Usage which is 8% difference which is too much for me.<=
br>
&gt; I&#39;m optimization by bytes.<br>
&gt; <br>
&gt; # ceph balancer eval<br>
&gt; current cluster score 0.005420 (lower is better)<br>
&gt; <br>
&gt; # ceph balancer eval $OPT_NAME<br>
&gt; plan spriebe_2018-08-20_19:36 final score 0.005456 (lower is better)<b=
r>
&gt; <br>
&gt; I&#39;m unable to optimize further ;-( Is there any chance to optimize=
<br>
&gt; further even in case of more rebelancing?<br>
<br>
The scoring that the balancer module is doing is currently a hybrid of pg <=
br>
count, bytes, and object count.=C2=A0 Picking a single metric might help a =
bit <br>
(as those 3 things are not always perfectly aligned).<br>
<br>
s<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--0000000000006764510573e38c03--

--===============3543910510614302548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3543910510614302548==--
