From: NeilBrown <neilb@suse.de>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Wed, 30 Jul 2014 12:19:35 +1000
Message-ID: <20140730121935.124bc7c9@notabene.brown>
References: <CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
	<CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
	<29057.1406650354@warthog.procyon.org.uk>
	<20140730071735.21ab7ca6@notabene.brown>
	<CANP1eJHo7xrFoXWWgKQNrTi94vaxN9x-ViXNBE4VcXAa_jjQ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/asB.5b=FcD4nt5q5xfqNt.0"; protocol="application/pgp-signature"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CANP1eJHo7xrFoXWWgKQNrTi94vaxN9x-ViXNBE4VcXAa_jjQ3Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Milosz Tanski <milosz@adfin.com>
Cc: David Howells <dhowells@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

--Sig_/asB.5b=FcD4nt5q5xfqNt.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2014 21:48:34 -0400 Milosz Tanski <milosz@adfin.com> wrote:

> I would vote on the lower end of the spectrum by default (closer to
> 100ms) since I imagine anybody deploying this in production
> environment would likely be using SSD drives for the caching. And in
> my tests on spinning disks there was little to no benefit outside of
> reducing network traffic.

Maybe I'm confused......

I thought the whole point of this patch was to avoid deadlocks.
Now you seem to be talking about a performance benefit.
What did I miss?

NeilBrown


>=20
> - Milosz
>=20
> On Tue, Jul 29, 2014 at 5:17 PM, NeilBrown <neilb@suse.de> wrote:
> > On Tue, 29 Jul 2014 17:12:34 +0100 David Howells <dhowells@redhat.com> =
wrote:
> >
> >> Milosz Tanski <milosz@adfin.com> wrote:
> >>
> >> > That's the same thing exact fix I started testing on Saturday. I fou=
nd that
> >> > there already is a wait_event_timeout (even without your recent chan=
ges). The
> >> > thing I'm not quite sure is what timeout it should use?
> >>
> >> That's probably something to make an external tuning knob for.
> >>
> >> David
> >
> > Ugg.  External tuning knobs should be avoided wherever possible, and al=
ways
> > come with detailed instructions on how to tune them  </rant>
> >
> > In this case I think it very nearly doesn't matter *at all* what value =
is
> > used.
> >
> > If you set it a bit too high, then on the very very rare occasion that =
it
> > would currently deadlock, you get a longer-than-necessary wait.  So jus=
t make
> > sure that is short enough that by the time the sysadmin notices and sta=
rts
> > looking for the problem, it will be gone.
> >
> > And if you set it a bit too low, then it will loop around to find anoth=
er
> > page to deal with before that one is finished being written out, and so=
 maybe
> > do a little bit more work than is needed (though it'll be needed eventu=
ally).
> >
> > So the perfect number is somewhere between the typical response time for
> > storage, and the typical response time for the sys-admin.  Anywhere bet=
ween
> > 100ms and 10sec would do.  1 second is the geo-mean.
> >
> > (sorry I didn't reply earlier - I missed you email somehow).
> >
> > NeilBrown
>=20
>=20
>=20


--Sig_/asB.5b=FcD4nt5q5xfqNt.0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU9hWNznsnt1WYoG5AQLUlw//Zm+SXXyzheobKhZ7nuGNXWpo/+CmRLHz
IUKHjFnxeptkXqOXt5uhjQhPFIFV4iOOCh1wlXp3AY5ZCUJ2NfgGLwXX6vu24uHl
Owja0OagN3tDEgyGDzb8FDzZhfulV9Kgcet95skSGNk3apDt1y+Aak0OZYq5Q7WB
CAA/uFjEYVXMTqIq/TqwlZtfStKuw7sOjnExWwUSzJj2WGqe5RdwGFYNrenFNdET
D7Kz0yTF26jzT+73asgYOVjH1LWp58kxbdlNVs43nhv7p7327poE3MW/iN/2olOZ
8reUtYXpYBPXOsvnGdiq+z5AGWc6UT3HUvhE2nhwDm6fLAwiH4jdWa5h7qteIkFU
ZZD0Sc/z7QNXYslz5mYkoDma9qPYzuDK4UDasspyxAmbOEEf/5bA7b2++vhA9Uxl
IzU0w6OiYmlNwksWEgfW1TAqlxwPYUprcvuftIt+d6pzyAXcRZxPcogPDn+/02V0
S7tiPbIZNzR9Kt5uP59OSApdyzAiFGrIgEaia1sfGJd1059/XFDAg20ZUmS6l7Iv
RxT2hm+2Ef5+S+SrlyFKSX2E7YG0TbhGH031YN3y1EhOLSejqV2O49nzt7m4gebW
GhuvsCLBIqQXYF5SCOALzjKbNjB94lDJESLKPB7TEBERX21FAfwECKXD000W2Htl
YJdw8N0n7T8=
=3qjX
-----END PGP SIGNATURE-----

--Sig_/asB.5b=FcD4nt5q5xfqNt.0--
