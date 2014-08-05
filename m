From: NeilBrown <neilb@suse.de>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Tue, 5 Aug 2014 14:49:23 +1000
Message-ID: <20140805144923.7b315366@notabene.brown>
References: <CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
	<CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
	<29057.1406650354@warthog.procyon.org.uk>
	<20140730071735.21ab7ca6@notabene.brown>
	<CANP1eJHo7xrFoXWWgKQNrTi94vaxN9x-ViXNBE4VcXAa_jjQ3Q@mail.gmail.com>
	<20140730121935.124bc7c9@notabene.brown>
	<CANP1eJEBO0VbG2MoBzRB1h3c0QzOhAjvqUtHSX0+Y_uDT5oZug@mail.gmail.com>
	<CANP1eJGoT2RmKB6asjbFgP=emLuxQqgqE4Xf9Gx7fYzPfS1img@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/YxZExu9z6.8n/TF.eim.IMU"; protocol="application/pgp-signature"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CANP1eJGoT2RmKB6asjbFgP=emLuxQqgqE4Xf9Gx7fYzPfS1img@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Milosz Tanski <milosz@adfin.com>
Cc: David Howells <dhowells@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

--Sig_/YxZExu9z6.8n/TF.eim.IMU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Aug 2014 00:12:25 -0400 Milosz Tanski <milosz@adfin.com> wrote:

> I was away for a few days but I did think about this some more and how
> to avoid a tunable and having a sensible default option.
>=20
> FSCache already tracks statistics about how long writes and reads take
> (at least if you enable that option). With those stats in hand we
> should be able generate a default timeout value that works well and
> avoid a tunable.
>=20
> My self I thinking something like the 90th percentile time for page
> write... whatever the value may be this should be a decent way of
> auto-optimizing this timeout.

Sounds like it could be a good approach, though if stats aren't enabled we
need a sensible fall back.

What is the actual cost of having the timeout too small?  I guess it might =
be
unnecessary writeouts, but I haven't done any analysis.
If the cost is expected to be quite small, a smaller timeout might be very
appropriate.

One statistic that might be interesting is how long that wait typically tak=
es
at present, and how often it deadlocks.

Mind you, we might be trying too hard.  Maybe just go for 100ms.

When you suggested that, I wasn't really objecting to your choice of a
number.  I was surprised because you seemed to justify it as a performance
concern, and I didn't think deadlocks would happen often enough for that to
be a valid concern.  When deadlock do happen, I presume the system is
temporarily under high memory pressure so lots of things are probably going
slowly, so a delay of a second might not be noticed.
But there are way too many "probably"s and "might"s.  If you can present
anything that looks like real data, it'll certainly trump all my hypotheses.

Thanks,
NeilBrown

>=20
> - M
>=20
> On Wed, Jul 30, 2014 at 12:06 PM, Milosz Tanski <milosz@adfin.com> wrote:
> > I don't think that fixing a dead lock should impose a somewhat
> > un-explainable high latency for the for the end user (or system
> > admin). With old drives such latencies (second plus) were not
> > unexpected.
> >
> > - Milosz
> >
> > On Tue, Jul 29, 2014 at 10:19 PM, NeilBrown <neilb@suse.de> wrote:
> >> On Tue, 29 Jul 2014 21:48:34 -0400 Milosz Tanski <milosz@adfin.com> wr=
ote:
> >>
> >>> I would vote on the lower end of the spectrum by default (closer to
> >>> 100ms) since I imagine anybody deploying this in production
> >>> environment would likely be using SSD drives for the caching. And in
> >>> my tests on spinning disks there was little to no benefit outside of
> >>> reducing network traffic.
> >>
> >> Maybe I'm confused......
> >>
> >> I thought the whole point of this patch was to avoid deadlocks.
> >> Now you seem to be talking about a performance benefit.
> >> What did I miss?
> >>
> >> NeilBrown
> >>
> >>
> >>>
> >>> - Milosz
> >>>
> >>> On Tue, Jul 29, 2014 at 5:17 PM, NeilBrown <neilb@suse.de> wrote:
> >>> > On Tue, 29 Jul 2014 17:12:34 +0100 David Howells <dhowells@redhat.c=
om> wrote:
> >>> >
> >>> >> Milosz Tanski <milosz@adfin.com> wrote:
> >>> >>
> >>> >> > That's the same thing exact fix I started testing on Saturday. I=
 found that
> >>> >> > there already is a wait_event_timeout (even without your recent =
changes). The
> >>> >> > thing I'm not quite sure is what timeout it should use?
> >>> >>
> >>> >> That's probably something to make an external tuning knob for.
> >>> >>
> >>> >> David
> >>> >
> >>> > Ugg.  External tuning knobs should be avoided wherever possible, an=
d always
> >>> > come with detailed instructions on how to tune them  </rant>
> >>> >
> >>> > In this case I think it very nearly doesn't matter *at all* what va=
lue is
> >>> > used.
> >>> >
> >>> > If you set it a bit too high, then on the very very rare occasion t=
hat it
> >>> > would currently deadlock, you get a longer-than-necessary wait.  So=
 just make
> >>> > sure that is short enough that by the time the sysadmin notices and=
 starts
> >>> > looking for the problem, it will be gone.
> >>> >
> >>> > And if you set it a bit too low, then it will loop around to find a=
nother
> >>> > page to deal with before that one is finished being written out, an=
d so maybe
> >>> > do a little bit more work than is needed (though it'll be needed ev=
entually).
> >>> >
> >>> > So the perfect number is somewhere between the typical response tim=
e for
> >>> > storage, and the typical response time for the sys-admin.  Anywhere=
 between
> >>> > 100ms and 10sec would do.  1 second is the geo-mean.
> >>> >
> >>> > (sorry I didn't reply earlier - I missed you email somehow).
> >>> >
> >>> > NeilBrown
> >>>
> >>>
> >>>
> >>
> >
> >
> >
> > --
> > Milosz Tanski
> > CTO
> > 16 East 34th Street, 15th floor
> > New York, NY 10016
> >
> > p: 646-253-9055
> > e: milosz@adfin.com
>=20
>=20
>=20


--Sig_/YxZExu9z6.8n/TF.eim.IMU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU+BiVDnsnt1WYoG5AQJtuQ/+My1BouWeaSkgMi3aYkqej14oZF7IR4gk
lFUELsJNSYMjGpcIF1DnHZgbNd2vOYkq4OHc0hkAIoVaOP8bccyk58/5J2a5NT40
1WNt5tStrHUH8xxCD9L0vGjBSHT6BYhmxGXmsmyNEG0Ol3Q0sLBReO50+auDFcyr
UcefuUgK3dpHvrX0TQPJaQrhSAjQo8BoVTMVOwy6WZ6ppXATRQmonulVmiYKYj5C
0L6nt1INwQChPx4rPwVEm9nYbehd60DdTH9j+t5HBN9W4oVMxsMcYSDFk6DGfZF/
uNrVBc1alLCo97hk6gSla/Awrs0/f5HPFx7ukmPu4PL5ZrE4FIAmcKVqaOej4pJJ
YpYCO8vAyGprjJEoy9zgorrvDGbXtaujIzjEWGZvaVEdZEezBtPJ4Q0TfM8dU2so
DbHsNTmh0myEkA7va6nxCBszPYNv4Of05LbLq02Cn8VTeIHYYRlfVfan9ENT2qDR
LbaySbR+ocKHET3ig37cZh9Up6ao22dzlAo7fPGVlNt3we3NF8JRq5GxCR61yp+D
ps+wpedcAbK8KKC0JRJ/zAd0q7qHB5h9aXbgVzR6IfM8qDHfNrkT+eMcW15sm6UJ
O2Csw4Ol9w+tVAmOCOCoWf4it+rBRKzW9hb8Eu5YrqYGLYZO78/Bx5QtvAbT0fyt
kCPQWneeRP0=
=0UtF
-----END PGP SIGNATURE-----

--Sig_/YxZExu9z6.8n/TF.eim.IMU--
