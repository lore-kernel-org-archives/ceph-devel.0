From: Mehdi Abaakouk <sileht@sileht.net>
Subject: Re: Ceph Benchmark HowTo
Date: Thu, 2 Aug 2012 17:48:19 +0200
Message-ID: <20120802154818.GA3315@mail.sileht.net>
References: <20120724144300.GA3317@mail.sileht.net>
 <20120731123106.GA29835@mail.sileht.net>
 <501937F4.4080401@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sileht.net ([178.33.111.110]:45156 "EHLO mail.sileht.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab2HBPsU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Aug 2012 11:48:20 -0400
Content-Disposition: inline
In-Reply-To: <501937F4.4080401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2012 at 09:06:44AM -0500, Mark Nelson wrote:
> I haven't actually used bonnie++ myself, but I've read some rather
> bad reports from various other people in the industry.  Not sure how
> much it's changed since then...
>=20
> https://blogs.oracle.com/roch/entry/decoding_bonnie
> http://www.quora.com/What-are-some-file-system-benchmarks
> http://scalability.org/?p=3D1685
> http://scalability.org/?p=3D1688
>=20
> I'd say to just take extra care to make sure that that it's behaving
> the way you intended it to (probably good advice no matter which
> benchmark you use!)

Thanks, for this good links :), I have started to try fio too for its
flexibility.

> >All results are good, my benchmark is clearly limited by my network
> >connection ~ 110MB/s.
>=20
> Gigabit Ethernet is definitely going to be a limitation with large
> block sequential IO for most modern disks.  I'm concerned with your
> 6 client numbers though.  I assume those numbers are per client?
> Even so, with 10 OSDs that performance is pretty bad!  Are you
> getting a good distribution of writes across all OSDs?  Consistent
> throughput over time on each?

This is a network issue too, the 6 clients tests are not really=20
representatives, all clients share the same 1 gigabit link, I will=20
acquire more hardwares to be more realistic soon (and replace these
results).

Some precisions have been added to the benchmark page.

> >In exception of the rest-api bench, the value seems really low.
> > ...
> >Is my rest-bench result normal ? Have I missed something ?
>=20
> You may want to try increasing the number of concurrent rest-bench
> operations.  Also I'd explicitly specify the number of PGs for the
> pool you create to make sure that you are getting a good
> distribution.

During my test the number of PGs is 640 for 10 OSDs, I have tried with more
concurrent operation 32 and 64, but the result is almost the same with
more latency.=20


Cheers,
--=20
Mehdi Abaakouk for eNovance
mail: sileht@sileht.net
irc: sileht

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQGqFCAAoJEBiStC/OquvIGG4P/3fywB6C4ItWcOpJLIojVCrT
g528w6KFj+3EaWPGVy6zb06JlPAN+46jWchTEfZvBhhmc6BUCh/jultMS7Pwhx0Z
JgkdFYQfIhEfVEJNu+t9GOBxISbd/ViWY3/UhkZlNDJyZthC4i0jdFJAzQNsYBdB
ISMpJKjNuO6frpBpw0e1D0TBiQgfIHG3pJRy76ts9KE3OhPzAANoAPmZSpeo2sm6
54d9tczEzpgC14xHdg2rkfFzROTkaMQUDenlXQsML//G6AsbaVHFk86T05U/tBwd
3l7NeyiCTSl3cQM4HgLExav3EEA0GQHrW2Rrn93BrXR0Fi5r2j5+VnfDXYZ9G0h9
/yNhQiS4h8jEMSOvXTTfNRbeTnY8pvod9m1xbKtid7haq+7YiLgXHCcIOewdOKfe
ucR/sbCWLYYdFlPh/s3/QxAXEJml0kmdt55yuNNSmteqZZwp4Xd+B2vjANvV5Khl
BQ6EA6T2b8uYxHyCe0MH2OjZRTFQVNyEDAmL76xIjYZ1cyOKVPSlUOthFtKxVMzp
3VCmgImalKB4taKW2C0SAUXARThpC9m9wkHdRLQ2ocOYazocJ0z0GSyCcDlJ3GbK
NQfqj2x00s6vVO6W33NRZVLdHuwdyo5+so3B6XKD8hsCLPzc8g4K4OJIaIuC+hlK
2pOIYZTBW8TLJVLL00v3
=chPM
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
