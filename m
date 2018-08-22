From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Wed, 22 Aug 2018 14:57:39 -0400
Message-ID: <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA@mail.gmail.com>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8939307422886767502=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============8939307422886767502==
Content-Type: multipart/alternative; boundary="0000000000000e23f505740ab8b4"

--0000000000000e23f505740ab8b4
Content-Type: text/plain; charset="UTF-8"

My initial reaction to this PR/backport was questioning why such a major
update would happen on a dot release of Luminous.  Your reaction to keeping
both dashboards viable goes to support that.  Should we really be
backporting features into a dot release that force people to change how
they use the software?  That seems more of the purpose of having new
releases.

I haven't really used either dashboard though.  Other than adding admin
functionality, does it remove any functionality of the previous dashboard?

On Wed, Aug 22, 2018 at 1:43 PM Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Thanks for your feedback, Willem!
>
> > The old dashboard does not need any package fetch while
> > building/installing. Something that is not very handy when building
> > FreeBSD packages. And I haven't gotten around to determining how to >
> get around that.
>
> I thought that https://github.com/ceph/ceph/pull/22562 fixed make-dist
> issues on FreeBSD. Is that not working yet? Let us know if that's the
> case!
>
> > Suggest renaming it to simpledash or dashboard_v1 and keep it in the
> > tree.
>
> Unfortunately, keeping v1 is not as simple as moving the dashboard to
> a separate directory (unless we leave it hanging as dead code).
> Dashboard_v2 completely replaces dashboard_v1, and that also means
> unit test, QA suites, and references in common files (install-deps.sh,
> CMakeLists.txt, ceph.spec.in, debian/*, do_freebsd.sh, vstart.sh,
> etc.).
>
> My concern is that properly keeping both ones would go beyond a
> long-but-mostly-clean cherry-picking. It'd involve Luminous actively
> diverging from master, which might burden other backports with
> manual/creative conflict-solving.
>
> KR,
>
> Ernesto
>
> On Wed, Aug 22, 2018 at 12:43 PM Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
> wrote:
> >
> > On 22/08/2018 12:16, Ernesto Puerta wrote:
> > > [sent both to ceph-devel and ceph-users lists, as it might be of
> > > interest for both audiences]
> > >
> > > Hi all,
> > >
> > > This e-mail is just to announce the WIP on backporting dashboard_v2
> > > (http://docs.ceph.com/docs/master/mgr/dashboard/) from master to
> > > Luminous release.
> > >
> > > The ultimate goal for this backport is to replace dashboard_v1 in
> > > Luminous and provide, **as much as possible**, (see note below) a
> > > level of functionality on a par with master's (i. e.: RBD and RGW
> > > management, HTTPS support, User Management, Role Based Access Control,
> > > Grafana integration, SSO, etc.).
> >
> > If done so, I would prefer to also keep the old "simple" Dashboard.
> > Reason for that is the ease of portability.
> >
> > The old dashboard does not need any package fetch while
> > building/installing. Something that is not very handy when building
> > FreeBSD packages. And I haven't gotten around to determining how to get
> > around that.
> >
> > Next to that: that dashboard is "simple". Something I really like, but
> > that is perhaps personal.
> >
> > Suggest renaming it to simpledash or dashboard_v1 and keep it in the
> tree.
> >
> > Thanx,
> > --WjW
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000000e23f505740ab8b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">My initial reaction to this PR/backport was questioning wh=
y such a major update would happen on a dot release of Luminous.=C2=A0 Your=
 reaction to keeping both dashboards viable goes to support that.=C2=A0 Sho=
uld we really be backporting features into a dot release that force people =
to change how they use the software?=C2=A0 That seems more of the purpose o=
f having new releases.<div><br></div><div>I haven&#39;t really used either =
dashboard though.=C2=A0 Other than adding admin functionality, does it remo=
ve any functionality of the previous dashboard?</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">On Wed, Aug 22, 2018 at 1:43 PM Ernesto P=
uerta &lt;<a href=3D"mailto:epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Thanks for your feedback, =
Willem!<br>
<br>
&gt; The old dashboard does not need any package fetch while<br>
&gt; building/installing. Something that is not very handy when building<br=
>
&gt; FreeBSD packages. And I haven&#39;t gotten around to determining how t=
o &gt; get around that.<br>
<br>
I thought that <a href=3D"https://github.com/ceph/ceph/pull/22562" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/ceph/ceph/pull/22562</a> fi=
xed make-dist<br>
issues on FreeBSD. Is that not working yet? Let us know if that&#39;s the<b=
r>
case!<br>
<br>
&gt; Suggest renaming it to simpledash or dashboard_v1 and keep it in the<b=
r>
&gt; tree.<br>
<br>
Unfortunately, keeping v1 is not as simple as moving the dashboard to<br>
a separate directory (unless we leave it hanging as dead code).<br>
Dashboard_v2 completely replaces dashboard_v1, and that also means<br>
unit test, QA suites, and references in common files (install-deps.sh,<br>
CMakeLists.txt, <a href=3D"http://ceph.spec.in" rel=3D"noreferrer" target=
=3D"_blank">ceph.spec.in</a>, debian/*, do_freebsd.sh, vstart.sh,<br>
etc.).<br>
<br>
My concern is that properly keeping both ones would go beyond a<br>
long-but-mostly-clean cherry-picking. It&#39;d involve Luminous actively<br=
>
diverging from master, which might burden other backports with<br>
manual/creative conflict-solving.<br>
<br>
KR,<br>
<br>
Ernesto<br>
<br>
On Wed, Aug 22, 2018 at 12:43 PM Willem Jan Withagen &lt;<a href=3D"mailto:=
wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org" target=3D"_blank">wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 22/08/2018 12:16, Ernesto Puerta wrote:<br>
&gt; &gt; [sent both to ceph-devel and ceph-users lists, as it might be of<=
br>
&gt; &gt; interest for both audiences]<br>
&gt; &gt;<br>
&gt; &gt; Hi all,<br>
&gt; &gt;<br>
&gt; &gt; This e-mail is just to announce the WIP on backporting dashboard_=
v2<br>
&gt; &gt; (<a href=3D"http://docs.ceph.com/docs/master/mgr/dashboard/" rel=
=3D"noreferrer" target=3D"_blank">http://docs.ceph.com/docs/master/mgr/dash=
board/</a>) from master to<br>
&gt; &gt; Luminous release.<br>
&gt; &gt;<br>
&gt; &gt; The ultimate goal for this backport is to replace dashboard_v1 in=
<br>
&gt; &gt; Luminous and provide, **as much as possible**, (see note below) a=
<br>
&gt; &gt; level of functionality on a par with master&#39;s (i. e.: RBD and=
 RGW<br>
&gt; &gt; management, HTTPS support, User Management, Role Based Access Con=
trol,<br>
&gt; &gt; Grafana integration, SSO, etc.).<br>
&gt;<br>
&gt; If done so, I would prefer to also keep the old &quot;simple&quot; Das=
hboard.<br>
&gt; Reason for that is the ease of portability.<br>
&gt;<br>
&gt; The old dashboard does not need any package fetch while<br>
&gt; building/installing. Something that is not very handy when building<br=
>
&gt; FreeBSD packages. And I haven&#39;t gotten around to determining how t=
o get<br>
&gt; around that.<br>
&gt;<br>
&gt; Next to that: that dashboard is &quot;simple&quot;. Something I really=
 like, but<br>
&gt; that is perhaps personal.<br>
&gt;<br>
&gt; Suggest renaming it to simpledash or dashboard_v1 and keep it in the t=
ree.<br>
&gt;<br>
&gt; Thanx,<br>
&gt; --WjW<br>
&gt;<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--0000000000000e23f505740ab8b4--

--===============8939307422886767502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8939307422886767502==--
