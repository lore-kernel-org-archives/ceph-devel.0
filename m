From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Compiling for FreeBSD
Date: Tue, 1 Dec 2015 14:22:58 +0200
Message-ID: <20151201122257.GA8469@gmail.com>
References: <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <565C38D2.4080403@digiware.nl>
 <20151130141320.GB20205@gmail.com>
 <565C5FF8.1090003@digiware.nl>
 <565C73A7.9050201@digiware.nl>
 <CAJ4mKGb0FZ=P5rzCOhDsh2Z2BiPa4hXav_QXTipZB3x0fQa0=A@mail.gmail.com>
 <565D6BA1.1020300@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35833 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928AbbLAMXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 07:23:01 -0500
Received: by lfdl133 with SMTP id l133so5688201lfd.2
        for <ceph-devel@vger.kernel.org>; Tue, 01 Dec 2015 04:23:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <565D6BA1.1020300@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org >> Ceph Development" <ceph-devel@vger.kernel.org>

On Tue, Dec 01, 2015 at 10:42:57AM +0100, Willem Jan Withagen wrote:
> On 30-11-2015 17:20, Gregory Farnum wrote:
> >>Installed the results:
> >>gmake install
> >>
> >>And looked at what it delivered:
> >>         zfs diff <fs-en>
> >>
> >>And I have to be honest that I'm not really enjoying all the ceph-t=
est
> >>stuff in my /usr/local/bin....
> >>Would prefer it to go into something like:
> >>         /usr/local/libexec/ceph/tests
> >>or
> >>         /usr/local/share/ceph/tests
> >>
> >>Not sure if this is possible without disrupting the automated testi=
ng.
> >
> >As far as I know, none of what we do upstream relies on "make instal=
l"
> >and I don't think it's very well-maintained. You could make some
> >changes and submit a PR =E2=80=94 if it does break something it shou=
ld show up
> >in the autobuilder bot.
>=20
> Well got that all compiled and installed.
>=20
> Fixed a startup problem in /usr/local/bin/ceph's python with an unkno=
wn
> error value. So that looks to run.
>=20
> Created a config, and acompanying directories.
>=20
> And now for the real work:
> Run:
> 	ceph-mon -i freetest -d --debug_mon 10 --cluster digiceph -c
> /etc/ceph/ceph.conf
>=20
> Which bombs out with:
> 2015-12-01 10:32:41.877243 804015000  0 ceph version 10.0.0-677-gd704=
c54
> (d704c54b7923ef7265fa27018e9411d8deb463b3), process (unknown), pid 93=
896
> 2015-12-01 10:32:41.879339 804015000 -1 load
> dlopen(/usr/local/lib/ceph/erasure-code/libec_jerasure.so):
> /usr/local/lib/ceph/erasure-code/libec_jerasure.so: Undefined symbol
> "ceph_arch_neon"
>=20
> So of to find where ceph_arch_neon is, and why it seems not defined.
> Perhaps as simple as loading the shared libs??

You have to add -export-dynamic to LDFLAGS, something like in this
patch:

https://github.com/trociny/ceph/commit/dcee0c0635d37f2b36257c55a3cc69d0=
5b5afe5e#diff-ef3c0ccbdde56cca822801c6ef1d289aR79

Also, you don't have to install binaries just to test if they work. As
I wrote previously:

cd src
=2E/vstart.sh

It will start a dev cluster for you using binaries from the build
dir. You can check if it runs with:

=2E/ceph -s

--=20
Mykola Golub
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
