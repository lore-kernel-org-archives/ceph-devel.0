From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 10:57:53 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602291056350.1904@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
	<CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
	<CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
	<EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
	<CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
	<FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
	<1456736629334.47610@croc.ru>
	<191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
	<1456745435596.21796@croc.ru>
	<CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
	<56D45CCC.8010608@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1315070058-1456761476=:1904"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <56D45CCC.8010608-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: "Franklin M. Siler" <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1315070058-1456761476=:1904
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The intention was to continue building stable releases (0.94.x) on the ol=
d=20
list of supported platforms (which inclues 12.04 and el6).  I think it wa=
s=20
just an oversight that they weren't built this time around.  I the=20
overhead to doing so is just keeping a 12.04 and el6 jenkins build slave=20
around.

Doing this builds in the existing environment sounds much better than=20
trying to pull in externally built binaries...

sage


On Mon, 29 Feb 2016, Loic Dachary wrote:

> Hi Dan & al,
>=20
> I think it would be relatively simple to have these binaries published =
as part of the current "Stable release" team effort[1]. Essentially doing=
 what you did and electing a central place to store these binaries. The t=
rick is to find a sustainable way to do this which means having a process=
 that is simple to maintain and understand as well as enough of us to mai=
ntain that in the long run.
>=20
> The basic idea is to copy the packages that are build by gitbuilders or=
 by the buildpackage teuthology task in a central place. Because these pa=
ckages are built, for development versions as well as stable versions[2].=
 And they are tested via teuthology. The packages that are published on h=
ttp://ceph.com/ are rebuilt from scratch, using the process that Alfredo =
described. This is fine for the supported platforms and for the stable re=
leases. But for the development releases and the platforms that are no lo=
nger supported but still built by gibuilders, we could just copy the pack=
ages over.
>=20
> Does that sound sensible ?
>=20
> [1] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO
> [2] http://gitbuilder.ceph.com/
>=20
>=20
> On 29/02/2016 20:28, Dan van der Ster wrote:
> > On Mon, Feb 29, 2016 at 12:30 PM, Odintsov Vladislav <VlOdintsov@croc=
.ru> wrote:
> >> Can you please provide right way for building rpm packages?
> >=20
> > It's documented here:
> > http://docs.ceph.com/docs/master/install/build-ceph/#rpm-package-mana=
ger
> >=20
> > For 0.94.6 you need to change the .spec file to use .tar.gz (because
> > there was no .bz2 published for some reason). And then also grab
> > init-ceph.in-fedora.patch from here:
> > https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-ceph.in-f=
edora.patch
> >=20
> > BTW, I've put our build here:
> > http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/
> > These are unsigned, untested and come with no warranty, no guarantees
> > of any sort. And IMHO, no third party build would ever to give that
> > warm fuzzy trust-it-with-my-data feeling like a ceph.com build would
> > ;)
> >=20
> > Moving forward, it would be great if the required community effort
> > could be put to work to get ceph.com el6 (and other) builds. For el6
> > in particular there is also the option to help out the Centos Storage
> > SIG to produce builds. I don't have a good feeling which direction is
> > better ... maybe both.
> >=20
> > -- Dan
> > CERN IT Storage Group
> >=20
> >=20
> >> ________________________________
> >> Regards,
> >>
> >> Vladislav Odintsov
> >>
> >> ________________________________________
> >> From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> Sent: Monday, February 29, 2016 14:11
> >> To: Odintsov Vladislav
> >> Cc: Franklin M. Siler; Xiaoxi Chen; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph=
-users; Sage Weil
> >> Subject: Re: [ceph-users] v0.94.6 Hammer released
> >>
> >> Can we make any kind of general procedure to make packages so that a=
lmost everyone in community build packages by themselves and reduce devel=
opers work load caused by too much requirement -;
> >>
> >> Cheers,
> >> Shinobu
> >>
> >> ----- Original Message -----
> >> From: "Odintsov Vladislav" <VlOdintsov-b5CV0i+qpxk@public.gmane.org>
> >> To: "Franklin M. Siler" <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>, "Xiaoxi Chen" <superdeb=
uger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, =
"Sage Weil" <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> Sent: Monday, February 29, 2016 6:04:02 PM
> >> Subject: Re: [ceph-users] v0.94.6 Hammer released
> >>
> >> Hi all,
> >>
> >> should we build el6 packages ourself or, it's hoped that these packa=
ges would be built officially by community?
> >>
> >> ________________________________
> >> Regards,
> >>
> >> Vladislav Odintsov
> >>
> >> ________________________________________
> >> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <ceph-devel-owner-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org> on behalf of Franklin M. Siler <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>
> >> Sent: Friday, February 26, 2016 05:03
> >> To: Xiaoxi Chen
> >> Cc: Alfredo Deza; Dan van der Ster; Sage Weil; ceph-devel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org; ceph-users
> >> Subject: Re: [ceph-users] v0.94.6 Hammer released
> >>
> >> On Feb 25, 2016, at 1839, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> >>
> >>> Will we build package for ubuntu 12.04 (Precise)?
> >>> Seems it also doesnt show in the repo
> >>
> >> The Ceph packages provided by Ubuntu are old.  However, the Ceph pro=
ject publishes its own packages.
> >>
> >> http://download.ceph.com/debian-hammer/dists/precise/
> >>
> >> so repo lines for sources.list would be, I think:
> >>
> >> deb http://download.ceph.com/debian-hammer/ precise main
> >> deb-src http://download.ceph.com/debian-hammer/ precise main
> >>
> >>
> >> Cheers,
> >>
> >> Frank Siler
> >> Siler Industrial Analytics
> >> 314.799.9405--
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
--8323329-1315070058-1456761476=:1904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1315070058-1456761476=:1904--
