From: Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph Mimic on Debian 9 Stretch
Date: Tue, 19 Jun 2018 22:13:17 +0200
Message-ID: <20180619201317.zf4a6hogyum5lzmh@work>
References: <CAKme9egBfDKvrS6dgm1JxK3S47xoeFm7vTy07qZ+er6deYhXcg@mail.gmail.com>
 <alpine.DEB.2.11.1806041830480.22723@piezo.novalocal>
 <20180613113616.hbow3e4bcrrsg7ax@nora.maurer-it.com>
 <alpine.DEB.2.11.1806131206580.22590@piezo.novalocal>
 <20180618181208.4q7difyk665mglho@work>
 <alpine.DEB.2.11.1806181909150.8443@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1806181909150.8443-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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

On Mon, Jun 18, 2018 at 07:15:49PM +0000, Sage Weil wrote:
> On Mon, 18 Jun 2018, Fabian Gr=FCnbichler wrote:
> > it's of course within your purview as upstream project (lead) to define
> > certain platforms/architectures/distros as fully supported, and others
> > as best-effort/community-driven/... . there was no clear public
> > communication (AFAICT, only the one thread on ceph-maintainers, which is
> > rather low visibility) that Debian moves from somewhere in the middle[2]
> > to the latter category with Mimic, and has now (at least for the time
> > being) effectively joined FreeBSD (which has at least one community
> > member pouring in enormous amounts of work) and the various community
> > Linux distros like Arch, Gentoo, ... (where I frankly have no idea about
> > the status quo). there is also no mention in the docs or the release
> > notes about the lack of Debian packages (and the state of Xenial
> > packages) for Mimic. all of which gives off more of an "unintended
> > consequence" vibe, rather than "conscious decision to drop Debian".
> =

> This is a fair assessment, and it's good to hear that there is some path =

> forward.
> =

> It looks like the Buster release date is Feb '19 (give or take), which =

> corresponds to Nautilus, so it should be possible for Debian users to ski=
p =

> mimic and upgrade directly from luminous to nautilus as long as we build =

> some buster packages for luminous as well right around the end of its =

> lifetime (and/or mimic point releases once buster gets closer to stable).
> =

> Is this reasonable?

yes. like I already indicated, this is our "Plan B" in case Mimic on
Stretch is not feasible. we'll likely skip Mimic entirely (except for
some internal testing to catch and fix issue before Nautlius) in that
case, and jump straight to Nautilus with Buster and keep Luminous on
"life support" for Stretch and upgrading.

> 	https://github.com/ceph/ceph/pull/22602

LGTM. still would like to see some note about the Xenial
toolchain stability issues, but that is more for the sake of others (I
am not an Ubuntu user).
