From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: can we drop support of centos/rhel 7.4?
Date: Fri, 14 Sep 2018 09:25:56 -0400
Message-ID: <CAN-GepL6d3foa62i7NDuwjUS51hAnu_mrntPqyMKTS9bwqPH3Q@mail.gmail.com>
References: <CAJE9aONakRfTc_ghzj_6wie4CcnD6KNMgMHtaZMbK5LbiLyn7A@mail.gmail.com>
 <CALe9h7cNdS2wffQLO2Gsud3xY7fA5KhfUUKWvDDXGMWYPGhpiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6606227302353577398=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7cNdS2wffQLO2Gsud3xY7fA5KhfUUKWvDDXGMWYPGhpiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6606227302353577398==
Content-Type: multipart/alternative; boundary="0000000000002eaafc0575d4c4ea"

--0000000000002eaafc0575d4c4ea
Content-Type: text/plain; charset="UTF-8"

Release dates
RHEL 7.4 - July 2017
Luminous 12.2.0 - August 2017
CentOS 7.4 - September 2017
RHEL 7.5 - April 2018
CentOS 7.5 - May 2018
Mimic 13.2.0 - June 2018

In the world of sysadmins it takes time to let new releases/OS's simmer
before beginning to test them let alone upgrading to them. It is not
possible to tell all companies that use CentOS that we have to move to a
new OS upgrade 5 months after it is released. We are still testing if
CentOS 7.5 works in our infrastructure in general let alone being up and
running on it. The kernel upgrades alone are a big change now to mention
the obvious package version changes. We don't even have the OK to install
it in staging. Once we do, and we have the time to start testing it,
...among our other tasks, we can start regression testing our use case in
staging before thinking about upgrading prod.

That time frame isn't really so bad if everything is working great for
ceph, but what if we're waiting on 12.2.9 and 13.2.2 for a bugfix that's
giving us grief? Now we are not only dealing with the bugs, but now we have
to regression test an OS upgrade, update our package management, and make
sure our new deployments will have this version... And then we can start
regression testing the new release that hopefully fixes the bugs we're
dealing with...

What about backporting the API standards to the CentOS 7.4 version of
gperftools-libs?

I've noticed little package issues like this in the past, but assumed that
was because most development was done on Ubuntu instead of RHEL. We had to
set our repos to a newer version of CentOS than we were running or willing
to upgrade to just for a single package we needed. If y'all are really
thinking of only supporting/testing the latest dot release of the latest
major version of RHEL, then you might have just given me the fuel to be
able to finally convince my company into allowing us to be the first
application in 9,000 servers to not run CentOS. I've been trying to get
them to allow it for a while because of the previous package issues, but I
hadn't put much effort into it because I thought/hoped those problems might
be behind us...

Do y'all not test ceph on 7.3 right now? This email thread really might be
enough to get us off of CentOS for Ceph.

On Fri, Sep 14, 2018, 5:49 AM John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Fri, Sep 14, 2018 at 3:48 AM kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > hi ceph-{maintainers,users,developers},
> >
> > recently, i ran into an issue[0] which popped up when we build Ceph on
> > centos 7.5, but test it on centos 7.4. as we know, the gperftools-libs
> > package provides the tcmalloc allocator shared library, but centos 7.4
> > and centos 7.5 ship different version of gperftools-{devel,libs}. the
> > former ships 2.4, and the latter 2.6.1.
> >
> > the crux is that the tcmalloc in gperftools 2.6.1 implements more
> > standard compliant C++ APIs, which were missing in gperftools 2.4.
> > that's why we have failures like:
> >
> > ceph-osd: symbol lookup error: ceph-osd: undefined symbol: _ZdaPvm
> >
> > when testing Ceph on centos 7.4.
> >
> > my question is: is it okay to drop the support of centos/rhel 7.4? so
> > we will solely build and test the supported Ceph releases (luminous,
> > mimic) on 7.5 ?
>
> My preference would be to target the latest minor release (i.e. 7.5)
> of the major release.  We don't test on CentOS 7.1, 7.2 etc, so I
> don't think we need to give 7.4 any special treatment.
>
> John
>
> >
> > thanks,
> >
> > --
> > [0] http://tracker.ceph.com/issues/35969
> >
> > --
> > Regards
> > Kefu Chai
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000002eaafc0575d4c4ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Release dates<br>RHEL 7.4 - July 2017<br>Luminous 12.2.0 - August 2017<br>C=
entOS 7.4 - September 2017<br>RHEL 7.5 - April 2018<br>CentOS 7.5 - May 201=
8<br>Mimic 13.2.0 - June 2018<br><br>In the world of sysadmins it takes tim=
e to let new releases/OS&#39;s simmer before beginning to test them let alo=
ne upgrading to them. It is not possible to tell all companies that use Cen=
tOS that we have to move to a new OS upgrade 5 months after it is released.=
 We are still testing if CentOS 7.5 works in our infrastructure in general =
let alone being up and running on it. The kernel upgrades alone are a big c=
hange now to mention the obvious package version changes. We don&#39;t even=
 have the OK to install it in staging. Once we do, and we have the time to =
start testing it, ...among our other tasks, we can start regression testing=
 our use case in staging before thinking about upgrading prod.<br><br>That =
time frame isn&#39;t really so bad if everything is working great for ceph,=
 but what if we&#39;re waiting on 12.2.9 and 13.2.2 for a bugfix that&#39;s=
 giving us grief? Now we are not only dealing with the bugs, but now we hav=
e to regression test an OS upgrade, update our package management, and make=
 sure our new deployments will have this version... And then we can start r=
egression testing the new release that hopefully fixes the bugs we&#39;re d=
ealing with...<br><br>What about backporting the API standards to the CentO=
S 7.4 version of gperftools-libs?<br><br>I&#39;ve noticed little package is=
sues like this in the past, but assumed that was because most development w=
as done on Ubuntu instead of RHEL. We had to set our repos to a newer versi=
on of CentOS than we were running or willing to upgrade to just for a singl=
e package we needed. If y&#39;all are really thinking of only supporting/te=
sting the latest dot release of the latest major version of RHEL, then you =
might have just given me the fuel to be able to finally convince my company=
 into allowing us to be the first application in 9,000 servers to not run C=
entOS. I&#39;ve been trying to get them to allow it for a while because of =
the previous package issues, but I hadn&#39;t put much effort into it becau=
se I thought/hoped those problems might be behind us...<br><br>Do y&#39;all=
 not test ceph on 7.3 right now? This email thread really might be enough t=
o get us off of CentOS for Ceph.<br><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Fri, Sep 14, 2018, 5:49 AM John Spray &lt;<a href=3D"mailto:jsp=
ray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Fri, Sep 14, 2018 at 3:48 AM kefu chai &lt;<a href=3D"mail=
to:tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<=
br>
&gt;<br>
&gt; hi ceph-{maintainers,users,developers},<br>
&gt;<br>
&gt; recently, i ran into an issue[0] which popped up when we build Ceph on=
<br>
&gt; centos 7.5, but test it on centos 7.4. as we know, the gperftools-libs=
<br>
&gt; package provides the tcmalloc allocator shared library, but centos 7.4=
<br>
&gt; and centos 7.5 ship different version of gperftools-{devel,libs}. the<=
br>
&gt; former ships 2.4, and the latter 2.6.1.<br>
&gt;<br>
&gt; the crux is that the tcmalloc in gperftools 2.6.1 implements more<br>
&gt; standard compliant C++ APIs, which were missing in gperftools 2.4.<br>
&gt; that&#39;s why we have failures like:<br>
&gt;<br>
&gt; ceph-osd: symbol lookup error: ceph-osd: undefined symbol: _ZdaPvm<br>
&gt;<br>
&gt; when testing Ceph on centos 7.4.<br>
&gt;<br>
&gt; my question is: is it okay to drop the support of centos/rhel 7.4? so<=
br>
&gt; we will solely build and test the supported Ceph releases (luminous,<b=
r>
&gt; mimic) on 7.5 ?<br>
<br>
My preference would be to target the latest minor release (i.e. 7.5)<br>
of the major release.=C2=A0 We don&#39;t test on CentOS 7.1, 7.2 etc, so I<=
br>
don&#39;t think we need to give 7.4 any special treatment.<br>
<br>
John<br>
<br>
&gt;<br>
&gt; thanks,<br>
&gt;<br>
&gt; --<br>
&gt; [0] <a href=3D"http://tracker.ceph.com/issues/35969" rel=3D"noreferrer=
" target=3D"_blank">http://tracker.ceph.com/issues/35969</a><br>
&gt;<br>
&gt; --<br>
&gt; Regards<br>
&gt; Kefu Chai<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--0000000000002eaafc0575d4c4ea--

--===============6606227302353577398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6606227302353577398==--
