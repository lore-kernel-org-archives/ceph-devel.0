From: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Subject: Re: pools limit
Date: Tue, 16 Jul 2019 18:00:12 +0200
Message-ID: <CAD9yTbHdKtre8ZjnXTxV_=mE513djznyFP-dgiG+9MpQZxx_Pg@mail.gmail.com>
References: <CANA9Uk6ZyYY1HuFXEjvs4aT3zaf7YvDdCH20Rhgb_5U89em0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4229743404385861956=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk6ZyYY1HuFXEjvs4aT3zaf7YvDdCH20Rhgb_5U89em0MQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4229743404385861956==
Content-Type: multipart/alternative; boundary="0000000000006624a2058dce795e"

--0000000000006624a2058dce795e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

100+ pools work fine if you can get the PG count right (auto-scaler helps,
there are some options that you'll need to tune for small-ish pools).

But it's not a "nice" setup. Have you considered using namespaces instead?


Paul

--=20
Paul Emmerich

Looking for help with your Ceph cluster? Contact us at https://croit.io

croit GmbH
Freseniusstr. 31h
81247 M=C3=BCnchen
www.croit.io
Tel: +49 89 1896585 90


On Tue, Jul 16, 2019 at 4:17 PM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hello - I have created 10 nodes ceph cluster with 14.x version. Can you
> please confirm below:
>
> Q1 - Can I create 100+ pool (or more) on the cluster? (the reason is -
> creating a pool per project). Any limitation on pool creation?
>
> Q2 - In the above pool - I use 128 PG-NUM - to start with and enable
> autoscale for PG_NUM, so that based on the data in the pool, PG_NUM will
> increase by ceph itself.
>
> Let me know if any limitations for the above and any fore see issue?
>
> Thanks
> Swami
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000006624a2058dce795e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>100+ pools work fine if you can get the PG count righ=
t (auto-scaler helps, there are some options that you&#39;ll need to tune f=
or small-ish pools).</div><div><br></div><div><span class=3D"gmail-contract=
-type"> <span class=3D"gmail-contract-type"> <span class=3D"gmail-contract-=
type"> </span></span></span></div><div>But it&#39;s not a &quot;nice&quot; =
setup. Have you considered using namespaces instead?<br></div><div><br></di=
v><div><br></div><div>Paul</div><div><br></div><div><div><div><div><div><di=
v><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure">-- <br>Paul Emmerich<br><br>Looking for help with your Ceph cluster? C=
ontact us at <a href=3D"https://croit.io" target=3D"_blank">https://croit.i=
o</a><br><br>croit GmbH<br>Freseniusstr. 31h<br>81247 M=C3=BCnchen<br><a hr=
ef=3D"http://www.croit.io" target=3D"_blank">www.croit.io</a><br>Tel: +49 8=
9 1896585 90</div></div><br></div></div></div></div></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 16, 2=
019 at 4:17 PM M Ranga Swami Reddy &lt;<a href=3D"mailto:swamireddy@gmail.c=
om">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr">Hello - I have created 10 nodes ce=
ph cluster with 14.x version. Can you please confirm below:<div><br></div><=
div>Q1 - Can I create 100+ pool (or more) on the cluster? (the reason is - =
creating a pool per project). Any limitation on pool creation?</div><div><b=
r></div><div>Q2 - In the above pool - I use 128 PG-NUM - to start with and =
enable autoscale for PG_NUM, so that based on the data in the pool, PG_NUM =
will increase by ceph itself.</div><div><br></div><div>Let me know if any l=
imitations for the above and any fore see issue?</div><div><br></div><div>T=
hanks</div><div>Swami</div></div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--0000000000006624a2058dce795e--

--===============4229743404385861956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4229743404385861956==--
