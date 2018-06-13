From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph Mimic on Debian 9 Stretch
Date: Wed, 13 Jun 2018 13:36:16 +0200
Message-ID: <20180613113616.hbow3e4bcrrsg7ax@nora.maurer-it.com>
References: <CAKme9egBfDKvrS6dgm1JxK3S47xoeFm7vTy07qZ+er6deYhXcg@mail.gmail.com>
 <alpine.DEB.2.11.1806041830480.22723@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1806041830480.22723-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, Charles Alva <charlesalva-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Jun 04, 2018 at 06:39:08PM +0000, Sage Weil wrote:
> [adding ceph-maintainers]

[and ceph-devel]

> 
> On Mon, 4 Jun 2018, Charles Alva wrote:
> > Hi Guys,
> > 
> > When will the Ceph Mimic packages for Debian Stretch released? I could not
> > find the packages even after changing the sources.list.
> 
> The problem is that we're now using c++17, which requires a newer gcc 
> than stretch or jessie provide, and Debian does not provide backports of 
> the newer gcc packages.  We currently can't build the latest Ceph for 
> those releases.

IMHO this is backwards. if you want to support distro X you should take
care to not need toolchain features that are not included in distro X.

Debian only provides one toolchain backport, and that is for Firefox,
which has a stable update exception because it is such an important
component for desktop systems and cannot be supported otherwise[1]. This
package is also not intended as general purpose toolchain, but built
solely for enabling a Firefox backport.

> We raised this with the Debian package maintainers about a month ago[1][2] 
> when the first release candidate was built and didn't get any response 
> (beyond a "yes, we there are not gcc package backports").

this is not how Debian works, as you most likely know ;)

> Both ubuntu and 
> fedora/rhel/centos (and I presume sles/opensuse) provide compiler 
> backports we did not anticipate this being a problem.

this is also not very accurate. it is true that Canonical provides a
toolchain PPA[2] which the Ceph build for Xenial seems to use, but there
is (AFAICT) no official guarantee for the level of support, security or
otherwise[3]. in fact, the PPA description states that it contains
"Toolchain test builds", which seem to mean pretty automatic backports
of whatever is in the current Ubuntu dev release, with a very short
delay between upload to Cosmic and the PPA for Xenial. e.g., for the
currently contained gcc-7 packages, there was less than a week between
hitting Cosmic and Xenial. Cosmic at the current point in the release
cycle is already not really exposed to public testing scrutiny in
general, and for sure not to the level something like the core toolchain
would require.

effectively this means the current Xenial builds are about as safe and
production-ready as doing your own gcc backports for Stretch - i.e., not
very.

> We'd love to build for stretch, but until there is a newer gcc for that 
> distro it's not possible.  We could build packages for 'testing', but I'm 
> not sure if those will be usable on stretch.

saying you'd love to build for a distro, while effectively making sure a
build according to that distro's release policies is impossible without
major effort by someone else does strike me as a bit of a hollow
statement. in the end this is a further nail in the coffin of upstream
support for the Debian(-based) distros, with only the latest (1.5 months
old!) Ubuntu LTS being properly supported.

I hope we find some way to support Mimic+ for Stretch without requiring
a backport of gcc-7+, although it unfortunately seems unlikely at this
point.

1: https://tracker.debian.org/pkg/gcc-mozilla
2: https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test
3: https://wiki.ubuntu.com/ToolChain#Toolchain_Updates
