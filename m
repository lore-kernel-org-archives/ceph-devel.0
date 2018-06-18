From: Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph Mimic on Debian 9 Stretch
Date: Mon, 18 Jun 2018 20:12:08 +0200
Message-ID: <20180618181208.4q7difyk665mglho@work>
References: <CAKme9egBfDKvrS6dgm1JxK3S47xoeFm7vTy07qZ+er6deYhXcg@mail.gmail.com>
 <alpine.DEB.2.11.1806041830480.22723@piezo.novalocal>
 <20180613113616.hbow3e4bcrrsg7ax@nora.maurer-it.com>
 <alpine.DEB.2.11.1806131206580.22590@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1806131206580.22590-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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

On Wed, Jun 13, 2018 at 12:36:50PM +0000, Sage Weil wrote:
> Hi Fabian,

thanks for your quick, and sorry for my delayed response (only having
1.5 usable arms atm).

> =

> On Wed, 13 Jun 2018, Fabian Gr=FCnbichler wrote:
> > On Mon, Jun 04, 2018 at 06:39:08PM +0000, Sage Weil wrote:
> > > [adding ceph-maintainers]
> > =

> > [and ceph-devel]
> > > On Mon, 4 Jun 2018, Charles Alva wrote:
> > > > Hi Guys,
> > > > =

> > > > When will the Ceph Mimic packages for Debian Stretch released? I co=
uld not
> > > > find the packages even after changing the sources.list.
> > > =

> > > The problem is that we're now using c++17, which requires a newer gcc
> > > than stretch or jessie provide, and Debian does not provide backports=
 of
> > > the newer gcc packages.  We currently can't build the latest Ceph for
> > > those releases.
> > =

> > IMHO this is backwards. if you want to support distro X you should take
> > care to not need toolchain features that are not included in distro X.
> =

> Well, I thought we did.  When we were making the C++17 decision we
> verified that we could do builds on Ubuntu and CentOS using a newer
> compiler toolchain.  My assumption was that since both of these distros
> had backports that pretty much everyone did.  Clearly I was wrong.

just to make this explicit: I did not mean to imply any malicious intent
on your part. I am aware this whole issue is more a question of
priorities and capacities than anything else (on all sides, not just
yours). I do appreciate all the work you and the rest of the main Ceph
developers and the community as a whole has done and continues to do,
and we see ourselves very much as part of this community!

> =

> > [...]
> > effectively this means the current Xenial builds are about as safe and
> > production-ready as doing your own gcc backports for Stretch - i.e., not
> > very.
> =

> I missed this nuance as well.

just as another point, install-deps.sh script from ceph.git will
upgrade(!) the following packages on Xenial:

- libatomic1
- libcc1-0
- libcilkrts5
- libgcc1
- libgomp1
- libitm1
- liblsan0
- libquadmath0
- libstdc++6
- libtsan0
- libubsan0

some of them will even be upgraded to versions built from gcc-8. so not
only is this backport not very production-grade from a testing and
support POV, it is also not self-contained (in contrast to the old
Wheezy Mozilla GCC backport, or RedHat's DTS, at least from my
understanding?). IMHO both issues should be mentioned in the appropriate
places (regular docs for the former, dev docs for the latter?).

> > > We'd love to build for stretch, but until there is a newer gcc for th=
at
> > > distro it's not possible.  We could build packages for 'testing', but=
 I'm
> > > not sure if those will be usable on stretch.
> > =

> > saying you'd love to build for a distro, while effectively making sure a
> > build according to that distro's release policies is impossible without
> > major effort by someone else does strike me as a bit of a hollow
> > statement. in the end this is a further nail in the coffin of upstream
> > support for the Debian(-based) distros, with only the latest (1.5 months
> > old!) Ubuntu LTS being properly supported.
> =

> I think we need to be clear about the use of the term "support" here.  I
> was careful to say we'd like to *build* for Debian, but I'm not sure what
> organizations out there are offering formal *support* for any of the
> ceph.com packages (in the sense of providing technical support for bug
> escalations or any guarantees around stability etc).  This incident is
> perhaps an indication that those organizations should become more involved
> in the upstream development and decision-making process.

I am aware that there is no formal support (in the sense of commercial
agreements, etc.pp.) for the packages on download.ceph.com, and the fact
that most of the testing the packages for Debian get are just a
side-effect of you testing Ubuntu Xenial and now Bionic. we are already
rolling our own .deb packages for Proxmox VE (based on the upstream
debian/ directory) because we have been bitten in the past by issues not
caught in the upstream CI infrastructure.

we try to stay involved in the community, e.g. by opening or forwarding
bugs after initial triaging, and contributing fixes when possible. we do
spread the "gospel of Ceph" and promote it quite heaviliy, we do develop
integration and management layers that probably allow end users to setup
and use Ceph that would otherwise not dare to because of the complexity
involved.

but in the end, we (as in Ceph the upstream project, and Proxmox as
downstream distro) both face a similar dilemma - given limited developer
time, we need to make a choice on how to use it. we will continue
discussing internally, and try to ramp up our involvement in one way or
another - especially since we expect Ceph to become an ever more
important component of your virtualization stack.

> > I hope we find some way to support Mimic+ for Stretch without requiring
> > a backport of gcc-7+, although it unfortunately seems unlikely at this
> > point.
> =

> It is not practical to reverse the dependency on C++17.  A lot of C++17
> code has already made it into the tree, and the use of projects that
> require it (notably Seastar) is a *big* part of our plans going forward to
> improve performance on flash devices.

this was my assumption, hence the "seems unlikely" above.

> Again, I would still like to provide these builds.  If the requirement to
> do so is a high level of assurance that the backported compiler used is
> solid and the resulting builds have been tested, then that will take some
> additional effort--at a minimum, adding stretch to the set of OSes that we
> test in the sepia lab.  This is probably not that much work, TBH, but
> does require someone who cares to become engaged in the testing effort.
> There are daily and weekly standups you can join, and of course
> discussions take place on IRC (#sepia) and over email (ceph-devel and
> ceph-maintainers).

I am subscribed to both ceph-devel and ceph-maintainers (the latter
as a result of this thread ;)).

> The immediate practical issue/question, IIRC, is simply for someone to
> verify whether a build using the debian testing version of gcc will
> produce a package that can be installed without additional dependencies on
> stretch.  Or maybe this question was already answered and a backport is
> definitely needed.  Regardless, it seems to me like the compiler version
> in testing would be an appropriate choice for a gcc backport to stretch.

yes and no. even if the current combination of Mimic and gcc-7 in
testing doesnt cause any obvious runtime dependencies (note that there
is at least one linkage against a too new libc6, but that might be an
avoidable false-positive), there is nothing that guarantees that this
status remains when either of the two involved parts change (and they
will, since both are moving targets). it's also a big no-go in the
Debian world to combine stable and testing/unstable in such a fashion
without a rebuild of the packages from the latter (i.e., a backport)[1].
there are very good reasons to never do that anywhere near a production
machine (including on a build host doing a relase build).

gcc packaging in Debian is also very far from trivial, so a clean
self-contained backport is a lot of work (I can tell from personal
experience, because we investigated and promptly abandoned such a task
again earlier this year for the whole Spectre/RETPOLINE mess).

unless such a backport is created and tested fairly well (and we will
spend some more time investigating this internally despite the caveats
above), our plan B will probably involve:
- building Luminous for Buster to ease the upgrade from Stretch+Luminous
   (upgrading both base distro release and Ceph major version in one go
   did not work out in the past)
- keeping our Stretch-based release on Luminous even once Luminous is EoL u=
pstream
- strongly recommending to those of our users that rely on Ceph to
   upgrade to our (future/next) Buster-based release (which will likely
   get Mimic or Nautilus as default Ceph version, depending on whether
   the Ceph release schedule holds or not)
- hope this whole story does not repeat itself too often because of the
   inherent misalignment between Ceph and Debian release cycles

especially the second and third point will irritate some of our users,
but sometimes life only hands you lemons.

> One final note: we didn't move to C++17 for no reason: we did so because
> it is difficult to move the Ceph project forward without taking advantage
> of the new language features.  It took us a *long* time to get to C++11
> because of paranoia around distro support, but we finally realized that we
> could move more quickly if we rely on the compiler backports available in
> most distros (tho clearly not as many as we thought!).  I wish we had
> moved much sooner with C++11, and I still think this was the right
> decision with respect to C++17.  I'm sorry that this has caused problems
> with Debian, but I think with your (or someone's) help we can mitigate the
> damage with testing.

we know the pain (there is a reason we roll our own heavily patched
kernel, Qemu and LXC packages instead of relying on Debian's, for
example). the roles of an upstream project and a downstream distro (or
even derivative) come with different pain thresholds though, or should
in my opinion.

it's of course within your purview as upstream project (lead) to define
certain platforms/architectures/distros as fully supported, and others
as best-effort/community-driven/... . there was no clear public
communication (AFAICT, only the one thread on ceph-maintainers, which is
rather low visibility) that Debian moves from somewhere in the middle[2]
to the latter category with Mimic, and has now (at least for the time
being) effectively joined FreeBSD (which has at least one community
member pouring in enormous amounts of work) and the various community
Linux distros like Arch, Gentoo, ... (where I frankly have no idea about
the status quo). there is also no mention in the docs or the release
notes about the lack of Debian packages (and the state of Xenial
packages) for Mimic. all of which gives off more of an "unintended
consequence" vibe, rather than "conscious decision to drop Debian".

1: https://wiki.debian.org/DontBreakDebian#Don.27t_make_a_FrankenDebian
2: "official" packages, but little to no CI/testing of packages besides
the build itself and whatever level of testing you get for free because
the packaging is shared with Ubuntu
