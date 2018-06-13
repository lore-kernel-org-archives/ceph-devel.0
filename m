From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Ceph Mimic on Debian 9 Stretch
Date: Wed, 13 Jun 2018 12:36:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1806131206580.22590@piezo.novalocal>
References: <CAKme9egBfDKvrS6dgm1JxK3S47xoeFm7vTy07qZ+er6deYhXcg@mail.gmail.com>
 <alpine.DEB.2.11.1806041830480.22723@piezo.novalocal>
 <20180613113616.hbow3e4bcrrsg7ax@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-971470460-1528893412=:22590"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20180613113616.hbow3e4bcrrsg7ax-aVfaTQcAavps8ZkLLAvlZtBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?ISO-8859-15?Q?Fabian_Gr=FCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, Charles Alva <charlesalva-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-971470460-1528893412=:22590
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi Fabian,

On Wed, 13 Jun 2018, Fabian Grünbichler wrote:
> On Mon, Jun 04, 2018 at 06:39:08PM +0000, Sage Weil wrote:
> > [adding ceph-maintainers]
> 
> [and ceph-devel]
> 
> > 
> > On Mon, 4 Jun 2018, Charles Alva wrote:
> > > Hi Guys,
> > > 
> > > When will the Ceph Mimic packages for Debian Stretch released? I could not
> > > find the packages even after changing the sources.list.
> > 
> > The problem is that we're now using c++17, which requires a newer gcc 
> > than stretch or jessie provide, and Debian does not provide backports of 
> > the newer gcc packages.  We currently can't build the latest Ceph for 
> > those releases.
> 
> IMHO this is backwards. if you want to support distro X you should take
> care to not need toolchain features that are not included in distro X.

Well, I thought we did.  When we were making the C++17 decision we 
verified that we could do builds on Ubuntu and CentOS using a newer 
compiler toolchain.  My assumption was that since both of these distros 
had backports that pretty much everyone did.  Clearly I was wrong.

> [...]
> effectively this means the current Xenial builds are about as safe and
> production-ready as doing your own gcc backports for Stretch - i.e., not
> very.

I missed this nuance as well.

> > We'd love to build for stretch, but until there is a newer gcc for that 
> > distro it's not possible.  We could build packages for 'testing', but I'm 
> > not sure if those will be usable on stretch.
> 
> saying you'd love to build for a distro, while effectively making sure a
> build according to that distro's release policies is impossible without
> major effort by someone else does strike me as a bit of a hollow
> statement. in the end this is a further nail in the coffin of upstream
> support for the Debian(-based) distros, with only the latest (1.5 months
> old!) Ubuntu LTS being properly supported.

I think we need to be clear about the use of the term "support" here.  I 
was careful to say we'd like to *build* for Debian, but I'm not sure what 
organizations out there are offering formal *support* for any of the 
ceph.com packages (in the sense of providing technical support for bug 
escalations or any guarantees around stability etc).  This incident is 
perhaps an indication that those organizations should become more involved 
in the upstream development and decision-making process.

> I hope we find some way to support Mimic+ for Stretch without requiring
> a backport of gcc-7+, although it unfortunately seems unlikely at this
> point.

It is not practical to reverse the dependency on C++17.  A lot of C++17 
code has already made it into the tree, and the use of projects that 
require it (notably Seastar) is a *big* part of our plans going forward to 
improve performance on flash devices.

Again, I would still like to provide these builds.  If the requirement to 
do so is a high level of assurance that the backported compiler used is 
solid and the resulting builds have been tested, then that will take some 
additional effort--at a minimum, adding stretch to the set of OSes that we 
test in the sepia lab.  This is probably not that much work, TBH, but 
does require someone who cares to become engaged in the testing effort.  
There are daily and weekly standups you can join, and of course 
discussions take place on IRC (#sepia) and over email (ceph-devel and 
ceph-maintainers).

The immediate practical issue/question, IIRC, is simply for someone to 
verify whether a build using the debian testing version of gcc will 
produce a package that can be installed without additional dependencies on 
stretch.  Or maybe this question was already answered and a backport is 
definitely needed.  Regardless, it seems to me like the compiler version 
in testing would be an appropriate choice for a gcc backport to stretch.

One final note: we didn't move to C++17 for no reason: we did so because 
it is difficult to move the Ceph project forward without taking advantage 
of the new language features.  It took us a *long* time to get to C++11 
because of paranoia around distro support, but we finally realized that we 
could move more quickly if we rely on the compiler backports available in 
most distros (tho clearly not as many as we thought!).  I wish we had 
moved much sooner with C++11, and I still think this was the right 
decision with respect to C++17.  I'm sorry that this has caused problems 
with Debian, but I think with your (or someone's) help we can mitigate the 
damage with testing.

Thanks!
sage
--8323329-971470460-1528893412=:22590
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-971470460-1528893412=:22590--
