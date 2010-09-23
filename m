From: Sage Weil <sage@newdream.net>
Subject: Re: corrupt pg logs
Date: Thu, 23 Sep 2010 09:03:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009230858530.16100@cobra.newdream.net>
References: <Pine.LNX.4.64.1009230757330.16100@cobra.newdream.net>
 <AANLkTimU5s3Ti32BZGjMo4japLVJ0=aDLy7DV6BnN=sX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-94527736-1285257801=:16100"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50123 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab0IWQB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 12:01:29 -0400
In-Reply-To: <AANLkTimU5s3Ti32BZGjMo4japLVJ0=aDLy7DV6BnN=sX@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org, henry_c_chang@tcloudcomputing.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-94527736-1285257801=:16100
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Sep 2010, Leander Yu wrote:

> Hi Sage,
> I have some high level idea about this but I haven't fully trace the
> code so please forgive me if it's too naive
>=20
> On Thu, Sep 23, 2010 at 11:05 PM, Sage Weil <sage@newdream.net> wrote:
> > One problem that keeps popping up is corruption in the PG logs. =A0This
> > usually manifests itself as a crash when the OSD restarts and is unable=
 to
> > parse the log. =A0There are a couple of things to do here.
> >
> > First, we need to figure out where the corruption is coming from. =A0Du=
mps
> > of the corrupt pglog files will help. =A0Are they zeroed out? =A0Entire=
ly? =A0Is
> > there valid data at the end of the file? =A0etc.
> >
>=20
> I am thinking to have a checksum for each log entry, when osd restart
> and parse the log it will be able to detect if the data is corrupt.

Ah, yeah, that would be better.  The encoding format will have to change a=
=20
bit so that there is an entry length preceeding the entry, probably. =20
Something like

 <length><entry payload><crc32c>

so that we can validate before trying to decode the entry itself.

> > Second, we need to come up with a reasonable way to start up even when
> > some PGs are corrupt. =A0Deleting them is one option, but we want to av=
oid
> > doing so unless we're sure we have a good copy elsewhere.
> >
>=20
> By implement the checksum for each log entry, we will be able to
> ignore the corrupted log and hopefully it can be rebuilt.
> This is the place I am not certain, we have deleted the single PGinfo
> that cause the error manually and see that osd start successfully, but
> due to the limited knowledge about current implementation we are not
> sure if everything is rebuilt properly.

You can scrub the specific PG to check for consistency between replicas=20
with

$ ceph pg scrub <pgid>     # e.g. 'ceph pg scrub 0.1f3'

The results will show up in the system log (ceph -w to watch).

sage
--557981400-94527736-1285257801=:16100--
