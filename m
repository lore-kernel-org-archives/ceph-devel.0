From: Cheng Wei-Chung <freeze.vicente.cheng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.80.4 Firefly released
Date: Thu, 17 Jul 2014 10:35:06 +0800
Message-ID: <CABF_e-GQ-a0Z5UWsz6qS62bvaccYVQ500b-jDe30hU-3-K9r+A@mail.gmail.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
	<e7039ceecb224324acb2466f87efff8b@SIXPR04MB304.apcprd04.prod.outlook.com>
	<CAPYLRzgARD7K0WtB6O=pj-vbePCet2atcq447cugvdbFppZfjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1283705923=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzgARD7K0WtB6O=pj-vbePCet2atcq447cugvdbFppZfjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1283705923==
Content-Type: multipart/alternative; boundary=047d7b414e14232b4504fe5a7d0e

--047d7b414e14232b4504fe5a7d0e
Content-Type: text/plain; charset=UTF-8

hi all:

This issue will meet deep-scrub error 100% with RBD user?

I mean it is possible just occur sometimes.

I use firefly v0.80.1 with kernel 3.8.0-37 and did not see any deep-scrub
error.

Then I still need to upgrade to 0.80.4 or I didn't get this issue?

Thanks!!


2014-07-17 1:19 GMT+08:00 Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:

> On Wed, Jul 16, 2014 at 1:50 AM, James Harper <james-u7/cK5yN3tp/jDykUgYHh4dd74u8MsAO@public.gmane.org>
> wrote:
> > Can you offer some comments on what the impact is likely to be to the
> data in an affected cluster? Should all data now be treated with suspicion
> and restored back to before the firefly upgrade?
>
> I am under the impression that it's not actually a data corruption
> bug, so much as a "reveal garbage data in sparse files" bug. So far
> everybody who's run into this has run a repair and not seen any
> issues, at least. Backups *should* be unnecessary, but we're still
> nailing down *exactly* what the bug is, so it's possible our
> suspicions are wrong or my information is out of date.
>
> On Wed, Jul 16, 2014 at 2:49 AM, Sylvain Munaut
> <s.munaut-IEbV4ISQ1OTUSxYbhEqsfVaTQe2KTcn/@public.gmane.org> wrote:
> > On Wed, Jul 16, 2014 at 10:50 AM, James Harper <james-u7/cK5yN3tp/jDykUgYHh4dd74u8MsAO@public.gmane.org>
> wrote:
> >> Can you offer some comments on what the impact is likely to be to the
> data in an affected cluster? Should all data now be treated with suspicion
> and restored back to before the firefly upgrade?
> >
> > Yes, I'd definitely like to know that too ... I upgraded a couple
> > weeks ago to firefly and I run precise with a 3.2 kernel on XFS. I
> > didn't see any deep scrubs error however.
> >
> > Also does this affect RBD only or can also affect radosgw ?
>
> RBD-only, and if you haven't seen/don't get deep-scrub errors you
> won't have any issues.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7b414e14232b4504fe5a7d0e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi all:<div><br></div><div>This issue will meet deep-scrub=
 error 100% with RBD user?</div><div><br></div><div>I mean it is possible j=
ust occur sometimes.</div><div><br></div><div>I use firefly v0.80.1 with ke=
rnel 3.8.0-37 and did not see any deep-scrub error.</div>
<div><br></div><div>Then I still need to upgrade to 0.80.4 or I didn&#39;t =
get this issue?</div><div><br></div><div>Thanks!!</div><div><div class=3D"g=
mail_extra"><br><br><div class=3D"gmail_quote">2014-07-17 1:19 GMT+08:00 Gr=
egory Farnum <span dir=3D"ltr">&lt;<a href=3D"mailto:greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" targ=
et=3D"_blank">greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Wed, Jul 16, 2014 at 1:50=
 AM, James Harper &lt;<a href=3D"mailto:james-u7/cK5yN3tp/jDykUgYHh4dd74u8MsAO@public.gmane.org">james@ejbd=
igital.com.au</a>&gt; wrote:<br>

&gt; Can you offer some comments on what the impact is likely to be to the =
data in an affected cluster? Should all data now be treated with suspicion =
and restored back to before the firefly upgrade?<br>
<br>
</div>I am under the impression that it&#39;s not actually a data corruptio=
n<br>
bug, so much as a &quot;reveal garbage data in sparse files&quot; bug. So f=
ar<br>
everybody who&#39;s run into this has run a repair and not seen any<br>
issues, at least. Backups *should* be unnecessary, but we&#39;re still<br>
nailing down *exactly* what the bug is, so it&#39;s possible our<br>
suspicions are wrong or my information is out of date.<br>
<div class=3D""><br>
On Wed, Jul 16, 2014 at 2:49 AM, Sylvain Munaut<br>
&lt;<a href=3D"mailto:s.munaut-IEbV4ISQ1OTUSxYbhEqsfVaTQe2KTcn/@public.gmane.org">s.munaut@whatever-comp=
any.com</a>&gt; wrote:<br>
&gt; On Wed, Jul 16, 2014 at 10:50 AM, James Harper &lt;<a href=3D"mailto:j=
ames-u7/cK5yN3tp/jDykUgYHh4dd74u8MsAO@public.gmane.org">james-u7/cK5yN3tp/jDykUgYHh4dd74u8MsAO@public.gmane.org</a>&gt; wrote:<br>
</div><div class=3D"">&gt;&gt; Can you offer some comments on what the impa=
ct is likely to be to the data in an affected cluster? Should all data now =
be treated with suspicion and restored back to before the firefly upgrade?<=
br>

&gt;<br>
</div><div class=3D"">&gt; Yes, I&#39;d definitely like to know that too ..=
. I upgraded a couple<br>
&gt; weeks ago to firefly and I run precise with a 3.2 kernel on XFS. I<br>
&gt; didn&#39;t see any deep scrubs error however.<br>
&gt;<br>
&gt; Also does this affect RBD only or can also affect radosgw ?<br>
<br>
</div>RBD-only, and if you haven&#39;t seen/don&#39;t get deep-scrub errors=
 you<br>
won&#39;t have any issues.<br>
-Greg<br>
Software Engineer #42 @ <a href=3D"http://inktank.com" target=3D"_blank">ht=
tp://inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">http:/=
/ceph.com</a><br>
<div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</div></div></blockquote></div><br></div></div></div>

--047d7b414e14232b4504fe5a7d0e--

--===============1283705923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1283705923==--
