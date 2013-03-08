From: Marco Aroldi <marco.aroldi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [solved] Changing CRUSH rule on a running cluster
Date: Fri, 8 Mar 2013 09:30:06 +0100
Message-ID: <CAHzdKUJX_Nb4rCo6LtuEGqPb9feE4Mixszm-1gt9RzGTrDX_Qw@mail.gmail.com>
References: <1362385148.30983.7.camel@localhost>
	<CAPYLRzj-9Hb=EdOLY6COOHcsKUujRqfCpUHqyp6tWS9UWzvf7Q@mail.gmail.com>
	<1362559176.30983.43.camel@localhost>
	<1362727086.10442.2.camel@boolette.noo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0739408847=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1362727086.10442.2.camel-T8w5uV9mOHF8I82lbrcXxg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0739408847==
Content-Type: multipart/alternative; boundary=20cf3074b46ed0d42804d765a343

--20cf3074b46ed0d42804d765a343
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Oliver,
can you post here on the mailing list the steps taken?
From the IRC logs you said "if I use "choose .... osd", it works -- but
"chooseleaf ... host" doesn't work"
So, to have data balanced between 2 rooms, is the rule "step chooseleaf
firstn 0 type room" correct?

Thanks

--=20
Marco


2013/3/8 Olivier Bonvalet <ceph.list-PaEMFeTk6C1QFI55V6+gNQ@public.gmane.org>

>
> >
> > Thanks for your answer. So I made some tests on a dedicated spool, I wa=
s
> > able to move data from =ABplatter=BB to =ABSSD=BB very well, it's great=
.
> >
> > But I can't obtain that per "network" neither per "host" setup :
> > with 2 hosts, each one with 2 OSD, and with a pool with use only 1
> > replica (so, 2 copies), I tried this rule :
> >
> >         rule rbdperhost {
> >               ruleset 5
> >               type replicated
> >               min_size 1
> >               max_size 10
> >               step take default
> >               step chooseleaf firstn 0 type host
> >               step emit
> >         }
> >
> >
> > As a result I obtain some PG which stuck in =ABactive+remapped=BB state=
.
> > When querying one of this PG, I see that CRUSH find only one OSD up for
> > this one and can't find an other OSD to set replica.
> >
> > If I well understand, in this case the "chooseleaf firstn 0 type host"
> > say to Ceph to choose 2 differents hosts, then in each of them choose
> > one OSD. So with 2 hosts, it should works, no ?
> >
> > Thanks,
> > Olivier B.
> >
> >
>
> So, as said on IRC, it's solved. My rules were not working, and after
> use of =ABtunables=BB it's ok.
>
> I love that feature of changing data spreading on live !
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--20cf3074b46ed0d42804d765a343
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Oliver,<br></div>can you post here =
on the mailing list the steps taken?<br></div>From the IRC logs you said &q=
uot;<span class=3D"">if I use &quot;choose .... osd&quot;, it works -- </sp=
an><span class=3D"">but &quot;chooseleaf ... host&quot; doesn&#39;t work&qu=
ot;<br>

</span></div><span class=3D"">So, to have data balanced between 2 rooms, is=
 the rule &quot;</span><span class=3D""><span class=3D"">step chooseleaf fi=
rstn 0 type room&quot; correct</span>? </span><span class=3D""><br><br></sp=
an></div>

<span class=3D"">Thanks<br><br>-- <br>Marco<br></span><div><div><div><div><=
div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/3/8 =
Olivier Bonvalet <span dir=3D"ltr">&lt;<a href=3D"mailto:ceph.list@daevel.f=
r" target=3D"_blank">ceph.list-PaEMFeTk6C1QFI55V6+gNQ@public.gmane.org</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt;<br>
&gt; Thanks for your answer. So I made some tests on a dedicated spool, I w=
as<br>
&gt; able to move data from =ABplatter=BB to =ABSSD=BB very well, it&#39;s =
great.<br>
&gt;<br>
&gt; But I can&#39;t obtain that per &quot;network&quot; neither per &quot;=
host&quot; setup :<br>
&gt; with 2 hosts, each one with 2 OSD, and with a pool with use only 1<br>
&gt; replica (so, 2 copies), I tried this rule :<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 rule rbdperhost {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ruleset 5<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 type replicated<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_size 1<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_size 10<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 step take default<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 step chooseleaf firstn 0 type host<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 step emit<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt;<br>
&gt; As a result I obtain some PG which stuck in =ABactive+remapped=BB stat=
e.<br>
&gt; When querying one of this PG, I see that CRUSH find only one OSD up fo=
r<br>
&gt; this one and can&#39;t find an other OSD to set replica.<br>
&gt;<br>
&gt; If I well understand, in this case the &quot;chooseleaf firstn 0 type =
host&quot;<br>
&gt; say to Ceph to choose 2 differents hosts, then in each of them choose<=
br>
&gt; one OSD. So with 2 hosts, it should works, no ?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Olivier B.<br>
&gt;<br>
&gt;<br>
<br>
So, as said on IRC, it&#39;s solved. My rules were not working, and after<b=
r>
use of =ABtunables=BB it&#39;s ok.<br>
<br>
I love that feature of changing data spreading on live !<br>
<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div></div></div></div></div></div></div>

--20cf3074b46ed0d42804d765a343--

--===============0739408847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0739408847==--
