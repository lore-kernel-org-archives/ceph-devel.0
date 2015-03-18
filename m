From: kefu chai <tchaikov@gmail.com>
Subject: Re: regenerating man pages
Date: Wed, 18 Mar 2015 14:25:26 +0800
Message-ID: <CAJE9aONKh0dzsUByVGaPaapdUj+DXp+RJrW7y=Q+OMGcQcFUHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33425 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbCRGZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2015 02:25:27 -0400
Received: by ignm3 with SMTP id m3so67364612ign.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 23:25:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

sorry for resending this mail. i sent it using multipart encoding and
got rejected by the mail server.

On Wed, 18 Mar 2015 at 03:47 Sage Weil <sweil@redhat.com> wrote:
>
> On Tue, 17 Mar 2015, Josh Durgin wrote:
> > On 03/17/2015 12:32 PM, Gregory Farnum wrote:
> > > Yeah. If this has gotten easier it's fine, but asphyxiate require=
d a
> > > *lot* of tooling that I'd rather we not require as developer buil=
d
> > > deps. I'd imagine we can just produce them as part of the Jenkins
> > > build procedure or something?
> >
> > None of that is needed for man pages or developer builds. asphyxiat=
e is
> > just for getting doxygen into the docs. The man pages are generated=
 with
> > plain sphinx, and do not need to be part of developer builds. Only
> > package builds need to generate them.
>
> Note that in practice devs will run install-deps.sh, which greps the
> Build-depends out of the spec or debian/control file, so they'll prob=
ably
> end up installing sphinx.  If it's just that I don't think it'll caus=
e
> problems though!


i failed to find sphinx in ceph.spec.in or debian/control. so we might
want to add it? if we expect the packager to generate the man pages,
maybe we should put it into the Build-Depends. and blacklist it in the
install-deps.sh?

>
>
> sage
>
> >
> > Josh
> >
> > > On Tue, Mar 17, 2015 at 12:27 PM, David Zafman <dzafman@redhat.co=
m> wrote:
> > > >
> > > > I found that I could not build the docs on Ubuntu 14.10 with th=
e proper
> > > > packages installed.  Kefu is looking into Asphyxiate which is v=
ery
> > > > tempermental.  I installed an Ubuntu 11.10 in order to generate=
 docs.
> > > >
> > > > David
> > > >
> > > >
> > > > On 3/17/15 10:11 AM, Sage Weil wrote:
> > > > >
> > > > > On Tue, 17 Mar 2015, Josh Durgin wrote:
> > > > > >
> > > > > > On 03/17/2015 09:40 AM, Ken Dreyer wrote:
> > > > > > >
> > > > > > > I had a question about the way that we're handling man pa=
ges.
> > > > > > >
> > > > > > > In 356a749f63181d401d16371446bb8dc4f196c2a6 , "rbd: regen=
erate
> > > > > > > rbd(8)
> > > > > > > man page", it looks like man/rbd.8 was regenerated from
> > > > > > > doc/man/8/rbd.rst
> > > > > > >
> > > > > > > It seems like it would be more efficient to avoid storing=
 man pages
> > > > > > > in
> > > > > > > Git and generate them dynamically at build time instead?
> > > > > >
> > > > > > Yes, that'd be great!
> > > > > >
> > > > > > > https://github.com/ceph/ceph/blob/master/admin/manpage-ho=
wto.txt
> > > > > > >
> > > > > > > "admin/build-doc" does a lot of things (including man pag=
e
> > > > > > > generation).
> > > > > > > Could we simply run the "sphinx-build -b man" part at bui=
ld time as
> > > > > > > a
> > > > > > > part of "make"?
> > > > > >
> > > > > > I don't see a reason not to. It's just a matter of making i=
t work on
> > > > > > all
> > > > > > the platforms we're building packages for. That might be an=
noying for
> > > > > > the entirety of build-doc, but for just building man pages =
it should
> > > > > > be simple.
> > > > >
> > > > > I think the original reason we didn't was just because there =
are a lot
> > > > > of
> > > > > dependencies for building the docs, so this inflates Build-De=
pends.
> > > > > That
> > > > > doesn't particularly bother me, though, if the deps do in fac=
t exist.


yeah. to move the generated artifacts out of the git repo, and to
maintain man pages, probably we can

1. extract the man page rendering out of build-doc,
2. and make it a configurable option in configure.ac. so developer
builds are not impacted.
3. enable it in the ceph.spec.in and debian/rules, so the packager
won't miss the man pages.

if we are good with this proposal, i will send a PR later on.

for embedding doxygen docs in sphinx, and avoiding extra maintenance
overhead to dodge the unsupported sections issues (e.g.
https://github.com/ceph/asphyxiate/issues)  :

1. let's switch to breathe (see the discussion in
https://github.com/ceph/asphyxiate/pull/2). i checked the generated
doc at rados/api/librados/index.html, it looks good.
2. et voil=C3=A0 !

i am sending a pull request for the breathe changes:
https://github.com/ceph/ceph/pull/4058 .

>
> > > > >
> > > > > sage
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
> > > >
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--=20
Regards
Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
