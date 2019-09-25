From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph; pg scrub errors
Date: Wed, 25 Sep 2019 12:32:38 +0530
Message-ID: <CANA9Uk5zsJYgd7ZE9WGYd28LGVD3b38S7UMNfJOOdizABkpBog@mail.gmail.com>
References: <CANA9Uk7nUFcLc7L4-=3hGH-7Dcf4dt1+xVSrs7hDzgWdNB+vqw@mail.gmail.com>
 <CAANLjFq3HCJvd6R-17ip+-TqTYeQFk0Z2eSz+hkCr2B4jUyX7w@mail.gmail.com>
 <CANA9Uk53woKRHkOqRTRsthODL8+JOfXX4BEpNhriqdTb0wG4yw@mail.gmail.com>
 <CAF-wwdFvbTRDULTYQAK_3orwqcFLJZYQHcqPXd0d4kyF99orMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6816759466164667405=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdFvbTRDULTYQAK_3orwqcFLJZYQHcqPXd0d4kyF99orMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6816759466164667405==
Content-Type: multipart/alternative; boundary="000000000000b01ee205935b3d72"

--000000000000b01ee205935b3d72
Content-Type: text/plain; charset="UTF-8"

repair took almost 6 hours..but after repair, still sees the scrub errs.

On Wed, Sep 25, 2019 at 5:11 AM Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, Sep 24, 2019 at 10:51 PM M Ranga Swami Reddy
> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Interestingly - "rados list-inconsistent-obj ${PG} --format=json"  not
> showing any objects inconsistent-obj.
> > And also "rados list-missing-obj ${PG} --format=json" also not showing
> any missing or unfound objects.
>
> Complete a scrub of ${PG} just before you run these commands.
>
> >
> > Thanks
> > Swami
> >
> > On Mon, Sep 23, 2019 at 8:18 PM Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> wrote:
> >>
> >> On Thu, Sep 19, 2019 at 4:34 AM M Ranga Swami Reddy
> >> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> >
> >> > Hi-Iam using ceph 12.2.11. here I am getting a few scrub errors. To
> fix these scrub error I ran the "ceph pg repair <pg_id>".
> >> > But scrub error not going and the repair is talking long time like
> 8-12 hours.
> >>
> >> Depending on the size of the PGs and how active the cluster is, it
> >> could take a long time as it takes another deep scrub to happen to
> >> clear the error status after a repair. Since it is not going away,
> >> either the problem is too complicated to automatically repair and
> >> needs to be done by hand, or the problem is repaired and when it
> >> deep-scrubs to check it, the problem has reappeared or another problem
> >> was found and the disk needs to be replaced.
> >>
> >> Try running:
> >> rados list-inconsistent-obj ${PG} --format=json
> >>
> >> and see what the exact problems are.
> >> ----------------
> >> Robert LeBlanc
> >> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> --
> Cheers,
> Brad
>
>

--000000000000b01ee205935b3d72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">repair took almost 6 hours..but after repair, still sees t=
he scrub errs.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Sep 25, 2019 at 5:11 AM Brad Hubbard &lt;<a href=3D=
"mailto:bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Sep 24, 2019 at 10:=
51 PM M Ranga Swami Reddy<br>
&lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">swamireddy@gm=
ail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Interestingly - &quot;rados list-inconsistent-obj ${PG} --format=3Djso=
n&quot;=C2=A0 not showing any objects inconsistent-obj.<br>
&gt; And also &quot;rados list-missing-obj ${PG} --format=3Djson&quot; also=
 not showing any missing or unfound objects.<br>
<br>
Complete a scrub of ${PG} just before you run these commands.<br>
<br>
&gt;<br>
&gt; Thanks<br>
&gt; Swami<br>
&gt;<br>
&gt; On Mon, Sep 23, 2019 at 8:18 PM Robert LeBlanc &lt;<a href=3D"mailto:r=
obert-4JaGZRWAfWbajFs6igw21g@public.gmane.org" target=3D"_blank">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<=
br>
&gt;&gt;<br>
&gt;&gt; On Thu, Sep 19, 2019 at 4:34 AM M Ranga Swami Reddy<br>
&gt;&gt; &lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">swam=
ireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi-Iam using ceph 12.2.11. here I am getting a few scrub erro=
rs. To fix these scrub error I ran the &quot;ceph pg repair &lt;pg_id&gt;&q=
uot;.<br>
&gt;&gt; &gt; But scrub error not going and the repair is talking long time=
 like 8-12 hours.<br>
&gt;&gt;<br>
&gt;&gt; Depending on the size of the PGs and how active the cluster is, it=
<br>
&gt;&gt; could take a long time as it takes another deep scrub to happen to=
<br>
&gt;&gt; clear the error status after a repair. Since it is not going away,=
<br>
&gt;&gt; either the problem is too complicated to automatically repair and<=
br>
&gt;&gt; needs to be done by hand, or the problem is repaired and when it<b=
r>
&gt;&gt; deep-scrubs to check it, the problem has reappeared or another pro=
blem<br>
&gt;&gt; was found and the disk needs to be replaced.<br>
&gt;&gt;<br>
&gt;&gt; Try running:<br>
&gt;&gt; rados list-inconsistent-obj ${PG} --format=3Djson<br>
&gt;&gt;<br>
&gt;&gt; and see what the exact problems are.<br>
&gt;&gt; ----------------<br>
&gt;&gt; Robert LeBlanc<br>
&gt;&gt; PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62=
 B9F1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
<br>
<br>
<br>
-- <br>
Cheers,<br>
Brad<br>
<br>
</blockquote></div>

--000000000000b01ee205935b3d72--

--===============6816759466164667405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6816759466164667405==--
