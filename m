From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph; pg scrub errors
Date: Tue, 24 Sep 2019 18:21:13 +0530
Message-ID: <CANA9Uk53woKRHkOqRTRsthODL8+JOfXX4BEpNhriqdTb0wG4yw@mail.gmail.com>
References: <CANA9Uk7nUFcLc7L4-=3hGH-7Dcf4dt1+xVSrs7hDzgWdNB+vqw@mail.gmail.com>
 <CAANLjFq3HCJvd6R-17ip+-TqTYeQFk0Z2eSz+hkCr2B4jUyX7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3256492640689197126=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFq3HCJvd6R-17ip+-TqTYeQFk0Z2eSz+hkCr2B4jUyX7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3256492640689197126==
Content-Type: multipart/alternative; boundary="0000000000008049d105934bfe13"

--0000000000008049d105934bfe13
Content-Type: text/plain; charset="UTF-8"

Interestingly - "rados list-inconsistent-obj ${PG} --format=json"  not
showing any objects inconsistent-obj.
And also "rados list-missing-obj ${PG} --format=json" also not showing any
missing or unfound objects.

Thanks
Swami

On Mon, Sep 23, 2019 at 8:18 PM Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:

> On Thu, Sep 19, 2019 at 4:34 AM M Ranga Swami Reddy
> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hi-Iam using ceph 12.2.11. here I am getting a few scrub errors. To fix
> these scrub error I ran the "ceph pg repair <pg_id>".
> > But scrub error not going and the repair is talking long time like 8-12
> hours.
>
> Depending on the size of the PGs and how active the cluster is, it
> could take a long time as it takes another deep scrub to happen to
> clear the error status after a repair. Since it is not going away,
> either the problem is too complicated to automatically repair and
> needs to be done by hand, or the problem is repaired and when it
> deep-scrubs to check it, the problem has reappeared or another problem
> was found and the disk needs to be replaced.
>
> Try running:
> rados list-inconsistent-obj ${PG} --format=json
>
> and see what the exact problems are.
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>

--0000000000008049d105934bfe13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Interestingly - &quot;rados list-inconsistent-obj ${PG} --=
format=3Djson&quot;=C2=A0 not showing any objects inconsistent-obj.<div>And=
 also &quot;rados list-missing-obj ${PG} --format=3Djson&quot; also not sho=
wing any missing or unfound objects.</div><div><br></div><div>Thanks</div><=
div>Swami</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Sep 23, 2019 at 8:18 PM Robert LeBlanc &lt;<a href=
=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Sep 19, 2019 a=
t 4:34 AM M Ranga Swami Reddy<br>
&lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">swamireddy@gm=
ail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi-Iam using ceph 12.2.11. here I am getting a few scrub errors. To fi=
x these scrub error I ran the &quot;ceph pg repair &lt;pg_id&gt;&quot;.<br>
&gt; But scrub error not going and the repair is talking long time like 8-1=
2 hours.<br>
<br>
Depending on the size of the PGs and how active the cluster is, it<br>
could take a long time as it takes another deep scrub to happen to<br>
clear the error status after a repair. Since it is not going away,<br>
either the problem is too complicated to automatically repair and<br>
needs to be done by hand, or the problem is repaired and when it<br>
deep-scrubs to check it, the problem has reappeared or another problem<br>
was found and the disk needs to be replaced.<br>
<br>
Try running:<br>
rados list-inconsistent-obj ${PG} --format=3Djson<br>
<br>
and see what the exact problems are.<br>
----------------<br>
Robert LeBlanc<br>
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904=C2=A0 C70E E654 3BB2 FA62 B9F1<br>
</blockquote></div>

--0000000000008049d105934bfe13--

--===============3256492640689197126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3256492640689197126==--
