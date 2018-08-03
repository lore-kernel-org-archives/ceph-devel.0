From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Ceph-maintainers] download.ceph.com repository
 changes
Date: Fri, 3 Aug 2018 08:28:03 +0200
Message-ID: <20180803062803.h3ynhilng6aoto5k@nora.maurer-it.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <20180727072842.nm7a4f7yujw46gea@nora.maurer-it.com>
 <CALqRxCw4x9B2xqik28Z+A1tk+N7eg0UAgBgx1exhLeVeQVkggw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALqRxCw4x9B2xqik28Z+A1tk+N7eg0UAgBgx1exhLeVeQVkggw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Jul 30, 2018 at 11:36:55AM -0600, Ken Dreyer wrote:
> On Fri, Jul 27, 2018 at 1:28 AM, Fabian Gr=FCnbichler
> <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org> wrote:
> > On Tue, Jul 24, 2018 at 10:38:43AM -0400, Alfredo Deza wrote:
> >> Hi all,
> >>
> >> After the 12.2.6 release went out, we've been thinking on better ways
> >> to remove a version from our repositories to prevent users from
> >> upgrading/installing a known bad release.
> >>
> >> The way our repos are structured today means every single version of
> >> the release is included in the repository. That is, for Luminous,
> >> every 12.x.x version of the binaries is in the same repo. This is true
> >> for both RPM and DEB repositories.
> >>
> >> However, the DEB repos don't allow pinning to a given version because
> >> our tooling (namely reprepro) doesn't construct the repositories in a
> >> way that this is allowed. For RPM repos this is fine, and version
> >> pinning works.
> >
> > If you mean that reprepo does not support referencing multiple versions
> > of packages in the Packages file, there is a patched fork that does
> > (that seems well-supported):
> >
> > https://github.com/profitbricks/reprepro
> =

> Thanks for this link. That's great to know someone's working on this.
> =

> What's the status of merging that back into the main reprepro code, or
> else shipping that fork as the new reprepro package in Debian /
> Ubuntu? The Ceph project could end up responsible for maintaining that
> reprepro fork if the main Ubuntu community does not pick it up :) The
> fork is several years old, and the latest update on
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D570623 was over a
> year ago.

I don't know anything more than what is publicly available about either
merging back to the original reprepo or shipping in Debian/Ubuntu. We
are using our own custom repo software built around lower level tools, I
was just aware of the fork for unrelated reasons :)
