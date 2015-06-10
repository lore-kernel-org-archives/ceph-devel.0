From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Build RPMs from git
Date: Wed, 10 Jun 2015 13:38:36 -0600
Message-ID: <CAANLjFoX6bNRgj4g4P9meD3M3OnMK71mXfwPHbk2b-6yDQStTw@mail.gmail.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
	<581259457.12927282.1433946627668.JavaMail.zimbra@redhat.com>
	<CAANLjFprkpfMdCk5HKMtCt1r2y8Og+8p2b3BjgxsoYWynCV8oA@mail.gmail.com>
	<55787270.10101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33970 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbFJTih (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 15:38:37 -0400
Received: by wibut5 with SMTP id ut5so58054531wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 12:38:36 -0700 (PDT)
In-Reply-To: <55787270.10101@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

They are using the rules file in /debian. Debian doesn't have the
requirement to be built in a specific location (i.e.
rpmbuild/{BUILD|BUILDROOT|etc) so you can build a Debian package right
out of any directory. In fact most of the time, I untar (or install
the source package) into a directory, make my changes/patch and then
build from the directory. I think you can tell Debian to build from a
tarball, but I've not done it that way. The two have very different
approaches. I do like the Debian method because I can run make
manually, get all the binaries just right and then tell Debian to
build the package with dpkg-buildpackage and it is only a matter of
packaging up what was already compiled, no need to recompile again.
Any small changes to code only required the dependent files to be
re-compiled with make if I'm tweaking things.

I like aspects of both, but it seems so much more time consuming on
rpms when debugging packaging.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVeJIvCRDmVDuy+mK58QAAA28P/iY+eOgg2ZEcoFIaUV3M
e7h1h7ELnGXNuihEO3rqKsCBmCyFRqQrFyX95ZWKUzSsCDVN/DKjr1+JzqTp
5jIn6PS3nr6NMhG/c0su/Y+LUlKt1nQsz3aL6/VbshmbaNIGJ+M8PBlEZs9r
QM7ist1lUu8LekriciZMHnO3W7GK5FN0lz1iZZ5XWj6M+xvbjBVg6r6PBnmk
l28bRF1ejSUJ71LmITccPtID8/HynBNem411ZPQOtw8wHAufW7Qgx7gv8ZNh
HaK2YrmGM2OSh3nPcTZkqoK5PJijakL5EoUA6x1JeGWpa44udXwz2DAbPizO
i003vnAlg1k8DSIg13qOxwl67aPV8ku0HFL0j6oi18jRt1viEqQikEWr8Ng2
3Wvr7dGGl17MzPxMSl/O6WEdVpnGrJoRjaMKFaugClVHgvhGC57wOWmU55XB
W5Xa5OFCcbRPuZ0yUalPIXouEeZclY0DJCbhMIYodpLKBCOxAF6Au+XXYNx7
naj7ii/CYOg3xB9w6pS2eHX//QtCRxmXtu3o9qQYwGaPhKrAOPDZIsDBSqrT
kUhXWMaBpETpqpgB5ZAzl2KygPlgIwoz+vLkMmcOqghSF5z/PytLGv8jCXxv
Rx6DfsdHfSN5ji4poAlpExwvRmwbdBSr16kVhPU07DdODdmlK8nF64g8U4yY
WItD
=sGNI
-----END PGP SIGNATURE-----

----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Jun 10, 2015 at 11:22 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On 06/10/2015 09:44 AM, Robert LeBlanc wrote:
>> This is really helpful, I was able to figure out what was needed in a
>> tarball manually, but this is what I was really looking for to create
>> the tarball.
>>
>> Is there anyway to skip this step like in the deb build for really
>> fast builds? I guess if I don't have retar a dozen times to tweak
>> something every time because I forgot to add something to the tarball,
>> it won't be so bad...
>
> There is a "make_dist.sh" script on master that is going to eventually
> replace this "make dist-bzip2" step. It still requires you to repack a
> whole new tarball, though.
>
> Sorry I'm not very familiar with the way that the Debian builds straight
> out of Git work. Reading through ceph-build.git and autobuild-ceph.git,
> it's not using git-buildpackage. How are you doing it?
>
> - Ken
