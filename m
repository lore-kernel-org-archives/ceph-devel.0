From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Tue, 26 Feb 2013 20:58:37 +0100
Message-ID: <20130226195837.GH16091@kdecherf.com>
References: <20130213114750.GC7399@kdecherf.com>
 <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
 <20130216010217.GA26823@kdecherf.com>
 <CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
 <20130216182403.GB5313@kdecherf.com>
 <CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
 <20130220010052.GO7121@kdecherf.com>
 <CAPYLRzgkR61eFuGU_NdL88bJvOD2em+TMO7g1g+X3RTFAZvY5Q@mail.gmail.com>
 <20130226175742.GE16091@kdecherf.com>
 <CAPYLRziS4rTVWU8C1fDJ6W6jgk7s9SOVnRGOcdiH9YshqGNaww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35939 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759743Ab3BZT67 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 14:58:59 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so3645839wgb.11
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 11:58:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPYLRziS4rTVWU8C1fDJ6W6jgk7s9SOVnRGOcdiH9YshqGNaww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Tue, Feb 26, 2013 at 10:10:06AM -0800, Gregory Farnum wrote:
> On Tue, Feb 26, 2013 at 9:57 AM, Kevin Decherf <kevin@kdecherf.com> w=
rote:
> > On Tue, Feb 19, 2013 at 05:09:30PM -0800, Gregory Farnum wrote:
> >> On Tue, Feb 19, 2013 at 5:00 PM, Kevin Decherf <kevin@kdecherf.com=
> wrote:
> >> > On Tue, Feb 19, 2013 at 10:15:48AM -0800, Gregory Farnum wrote:
> >> >> Looks like you've got ~424k dentries pinned, and it's trying to=
 keep
> >> >> 400k inodes in cache. So you're still a bit oversubscribed, yes=
=2E This
> >> >> might just be the issue where your clients are keeping a bunch =
of
> >> >> inodes cached for the VFS (http://tracker.ceph.com/issues/3289)=
=2E
> >> >
> >> > Thanks for the analyze. We use only one ceph-fuse client at this=
 time
> >> > which makes all "high-load" commands like rsync, tar and cp on a=
 huge
> >> > amount of files. Well, I will replace it by the kernel client.
> >>
> >> Oh, that bug is just an explanation of what's happening; I believe=
 it
> >> exists in the kernel client as well.
> >
> > After setting the mds cache size to 900k, storms are gone.
> > However we continue to observe high latency on some clients (always=
 the
> > same clients): each IO takes between 40 and 90ms (for example with
> > Wordpress, it takes ~20 seconds to load all needed files...).
> > With a non-laggy client, IO requests take less than 1ms.
>=20
> I can't be sure from that description, but it sounds like you've got
> one client which is generally holding the RW "caps" on the files, and
> then another client which comes in occasionally to read those same
> files. That requires the first client to drop its caps, and involves =
a
> couple round-trip messages and is going to take some time =E2=80=94 t=
his is an
> unavoidable consequence if you have clients sharing files, although
> there's probably still room for us to optimize.
>=20
> Can you describe your client workload in a bit more detail?

We have one folder per application (php, java, ruby). Every application=
 has
small (<1M) files. The folder is mounted by only one client by default.

In case of overload, another clients spawn to mount the same folder and
access the same files.

In the following test, only one client was used to serve the
application (a website using wordpress).

I made the test with strace to see the time of each IO request (strace =
-T
-e trace=3Dfile) and I noticed the same pattern:

=2E..
[pid  4378] stat("/data/wp-includes/user.php", {st_mode=3DS_IFREG|0750,=
 st_size=3D28622, ...}) =3D 0 <0.033409>
[pid  4378] lstat("/data/wp-includes/user.php", {st_mode=3DS_IFREG|0750=
, st_size=3D28622, ...}) =3D 0 <0.081642>
[pid  4378] open("/data/wp-includes/user.php", O_RDONLY) =3D 5 <0.04113=
8>
[pid  4378] stat("/data/wp-includes/meta.php", {st_mode=3DS_IFREG|0750,=
 st_size=3D10896, ...}) =3D 0 <0.082303>
[pid  4378] lstat("/data/wp-includes/meta.php", {st_mode=3DS_IFREG|0750=
, st_size=3D10896, ...}) =3D 0 <0.004090>
[pid  4378] open("/data/wp-includes/meta.php", O_RDONLY) =3D 5 <0.08192=
9>
=2E..

~250 files were accessed for only one request (thanks Wordpress.).

The fs is mounted with these options: rw,noatime,name=3D<hidden>,secret=
=3D<hidden>,nodcache.

I have a debug (debug_mds=3D20) log of the active mds during this test =
if you want.
--=20
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
