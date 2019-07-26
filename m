From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pools limit
Date: Fri, 26 Jul 2019 19:46:30 +0530
Message-ID: <CANA9Uk74YmjJfVqr5P1+QiFr-QrqjGvL0fHjvGrY1nuWtHXqig@mail.gmail.com>
References: <CANA9Uk6ZyYY1HuFXEjvs4aT3zaf7YvDdCH20Rhgb_5U89em0MQ@mail.gmail.com>
 <CAD9yTbHdKtre8ZjnXTxV_=mE513djznyFP-dgiG+9MpQZxx_Pg@mail.gmail.com>
 <CANA9Uk4Yt9oS7D31oR++f48ph8_KLAXH5ebeSeJAXUvyuF_NRQ@mail.gmail.com>
 <445eb2fe-4082-8c20-0848-2571f1ec3816@42on.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8522389710725143298=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <445eb2fe-4082-8c20-0848-2571f1ec3816-fspyXLx8qC4@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============8522389710725143298==
Content-Type: multipart/alternative; boundary="000000000000fe6fda058e9630c8"

--000000000000fe6fda058e9630c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ceph using for RBD only

On Wed, Jul 24, 2019 at 12:55 PM Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:

>
>
> On 7/16/19 6:53 PM, M Ranga Swami Reddy wrote:
> > Thanks for your reply..
> > Here, new pool creations and pg auto scale may cause rebalance..which
> > impact the ceph cluster performance..
> >
> > Please share name space detail like how to use etc
> >
>
> Would it be RBD, Rados, CephFS? What would you be using on top of Ceph?
>
> Wido
>
> >
> >
> > On Tue, 16 Jul, 2019, 9:30 PM Paul Emmerich, <paul.emmerich-iZXOWb+A65A@public.gmane.org
> > <mailto:paul.emmerich-iZXOWb+A65A@public.gmane.org>> wrote:
> >
> >     100+ pools work fine if you can get the PG count right (auto-scaler
> >     helps, there are some options that you'll need to tune for small-is=
h
> >     pools).
> >
> >     But it's not a "nice" setup. Have you considered using namespaces
> >     instead?
> >
> >
> >     Paul
> >
> >     --
> >     Paul Emmerich
> >
> >     Looking for help with your Ceph cluster? Contact us at
> https://croit.io
> >
> >     croit GmbH
> >     Freseniusstr. 31h
> >     81247 M=C3=BCnchen
> >     www.croit.io <http://www.croit.io>
> >     Tel: +49 89 1896585 90
> >
> >
> >     On Tue, Jul 16, 2019 at 4:17 PM M Ranga Swami Reddy
> >     <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >
> >         Hello - I have created 10 nodes ceph cluster with 14.x version.
> >         Can you please confirm below:
> >
> >         Q1 - Can I create 100+ pool (or more) on the cluster? (the
> >         reason is - creating a pool per project). Any limitation on poo=
l
> >         creation?
> >
> >         Q2 - In the above pool - I use 128 PG-NUM - to start with and
> >         enable autoscale for PG_NUM, so that based on the data in the
> >         pool, PG_NUM will increase by ceph itself.
> >
> >         Let me know if any limitations for the above and any fore see
> issue?
> >
> >         Thanks
> >         Swami
> >         _______________________________________________
> >         ceph-users mailing list
> >         ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >         http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>

--000000000000fe6fda058e9630c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ceph using for RBD only</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 24, 2019 at 12:55 PM Wi=
do den Hollander &lt;<a href=3D"mailto:wido-fspyXLx8qC4@public.gmane.org">wido-fspyXLx8qC4@public.gmane.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 7/16/19 6:53 PM, M Ranga Swami Reddy wrote:<br>
&gt; Thanks for=C2=A0your reply..<br>
&gt; Here, new pool creations and pg auto scale may cause rebalance..which<=
br>
&gt; impact the ceph cluster performance..<br>
&gt; <br>
&gt; Please share name space detail like how to use etc<br>
&gt; <br>
<br>
Would it be RBD, Rados, CephFS? What would you be using on top of Ceph?<br>
<br>
Wido<br>
<br>
&gt; <br>
&gt; <br>
&gt; On Tue, 16 Jul, 2019, 9:30 PM Paul Emmerich, &lt;<a href=3D"mailto:pau=
l.emmerich-iZXOWb+A65A@public.gmane.org" target=3D"_blank">paul.emmerich-iZXOWb+A65A@public.gmane.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:paul.emmerich-iZXOWb+A65A@public.gmane.org" target=3D"_blank"=
>paul.emmerich-iZXOWb+A65A@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0100+ pools work fine if you can get the PG count ri=
ght (auto-scaler<br>
&gt;=C2=A0 =C2=A0 =C2=A0helps, there are some options that you&#39;ll need =
to tune for small-ish<br>
&gt;=C2=A0 =C2=A0 =C2=A0pools).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But it&#39;s not a &quot;nice&quot; setup. Have you=
 considered using namespaces<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Paul<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0Paul Emmerich<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Looking for help with your Ceph cluster? Contact us=
 at <a href=3D"https://croit.io" rel=3D"noreferrer" target=3D"_blank">https=
://croit.io</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0croit GmbH<br>
&gt;=C2=A0 =C2=A0 =C2=A0Freseniusstr. 31h<br>
&gt;=C2=A0 =C2=A0 =C2=A081247 M=C3=BCnchen<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.croit.io" rel=3D"noreferrer" =
target=3D"_blank">www.croit.io</a> &lt;<a href=3D"http://www.croit.io" rel=
=3D"noreferrer" target=3D"_blank">http://www.croit.io</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Tel: +49 89 1896585 90<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Jul 16, 2019 at 4:17 PM M Ranga Swami Reddy=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:swamiredd=
y@gmail.com" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hello - I have created 10 nodes ceph =
cluster with 14.x version.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Can you please confirm below:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Q1 - Can I create 100+ pool (or more)=
 on the cluster? (the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reason is - creating a pool per proje=
ct). Any limitation on pool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creation?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Q2 - In the above pool - I use 128 PG=
-NUM - to start with and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable autoscale for PG_NUM, so that =
based on the data in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pool, PG_NUM will increase by ceph it=
self.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Let me know if any limitations for th=
e above and any fore see issue?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Swami<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_____________________________________=
__________<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ceph-users mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &lt;mailto:<a href=
=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://lists.ceph.com/list=
info.cgi/ceph-users-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://l=
ists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
&gt; <br>
</blockquote></div>

--000000000000fe6fda058e9630c8--

--===============8522389710725143298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8522389710725143298==--
