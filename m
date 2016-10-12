From: agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: How do I restart node that I've killed in
 development mode
Date: Wed, 12 Oct 2016 14:08:07 +0700
Message-ID: <CAJ+86MMkXLUZBOAyDF9Ydk2V2i9fHZmtbKebbuSJrrJo9CCRjA@mail.gmail.com>
References: <CAJ+86MPR6Ux6RW_JyX4vmAWjMygCbV6SHf1YuSJnzrmUFBeYCQ@mail.gmail.com>
	<CABAwU-b_a437kTm5pWm-qJmcPTphBS5Msmjj8q1CQ9gBpop-FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0800650608=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABAwU-b_a437kTm5pWm-qJmcPTphBS5Msmjj8q1CQ9gBpop-FQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: huang jun <hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0800650608==
Content-Type: multipart/alternative; boundary=001a114446f4bb357e053ea5a7bb

--001a114446f4bb357e053ea5a7bb
Content-Type: text/plain; charset=UTF-8

Thanks Huang jun.

I will try it.

On Wed, Oct 12, 2016 at 2:06 PM, huang jun <hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> ./init-ceph start mon.a
>
> 2016-10-12 14:54 GMT+08:00 agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Hi Ceph Users,
> >
> > I deploy development cluster using vstart with 3 MONs and 3 OSDs.
> > On my experiment, Kill one of the monitor nodes by its pid. like this:
> >
> >   $ kill -SIGSEGV 27557
> >
> > After a new monitor leader is chosen, I would like to re-run the monitor
> > that I've killed in the previous step. How do I do this?
> >
> >
> > Thanks
> >
> > --
> > Cheers,
> >
> > Agung Laksono
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>
>
>
> --
> Thank you!
> HuangJun
>



-- 
Cheers,

Agung Laksono

--001a114446f4bb357e053ea5a7bb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Huang jun.<div><br></div><div>I will try it.</div><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Oct =
12, 2016 at 2:06 PM, huang jun <span dir=3D"ltr">&lt;<a href=3D"mailto:hjws=
m1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">./init-ceph start mon.a<br>
<div><div class=3D"h5"><br>
2016-10-12 14:54 GMT+08:00 agung Laksono &lt;<a href=3D"mailto:agung.smarts=
@gmail.com">agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt; Hi Ceph Users,<br>
&gt;<br>
&gt; I deploy development cluster using vstart with 3 MONs and 3 OSDs.<br>
&gt; On my experiment, Kill one of the monitor nodes by its pid. like this:=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0$ kill -SIGSEGV 27557<br>
&gt;<br>
&gt; After a new monitor leader is chosen, I would like to re-run the monit=
or<br>
&gt; that I&#39;ve killed in the previous step. How do I do this?<br>
&gt;<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; --<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Agung Laksono<br>
&gt;<br>
&gt;<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/c=
eph-users-ceph.<wbr>com</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Thank you!<br>
HuangJun<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div>Cheers,</div><div><br></div>Agung Laks=
ono<br><br></div></div></div></div>
</div>

--001a114446f4bb357e053ea5a7bb--

--===============0800650608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0800650608==--
