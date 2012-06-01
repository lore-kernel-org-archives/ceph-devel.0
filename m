From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Fri, 1 Jun 2012 11:35:37 +0200
Message-ID: <201206011135.38119.a.ott@m-privacy.de>
References: <201205290944.33983.a.ott@m-privacy.de> <Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net> <201205300908.56991.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:51026 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759312Ab2FAJfs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 05:35:48 -0400
In-Reply-To: <201205300908.56991.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday 30 May 2012 wrote Amon Ott:
> On Tuesday 29 May 2012 you wrote:
> > On Tue, 29 May 2012, Amon Ott wrote:
> > > Please consider putting out a fat warning at least at build time,=
 if
> > > syncfs() is not available, e.g. "No syncfs() syscall, please expe=
ct a
> > > deadlock when running osd on non-btrfs together with a local ceph=
fs
> > > mount." Even better would be a quick runtime test for missing syn=
cfs()
> > > and storage on non-btrfs that spits out a warning, if deadlock is
> > > possible.
> >
> > I think a runtime warning makes more sense; nobody will see the bui=
ld
> > time warning (e.g., those installed debs).
>
> Yes, fully agreed.

Thanks for the new log lines in master git. The warning without syncfs(=
)=20
support could be a bit more clear though - the system is not only slowe=
r, it=20
hangs needing a reset and reboot. This is much worse, specially if ceph=
fs is=20
permanently broken by bug 1047 afterwards. And I am pretty sure that ou=
r=20
systems were not running out of memory, because during our load tests w=
e=20
always have several GB of unused memory.

After backporting syncfs() support into Debian stable libc6 2.11 and=20
recompiling Ceph with it, our test cluster is now running with syncfs()=
=2E

A first two hour load test this morning did not produce any problems, s=
o I can=20
say that syncfs() makes it significantly more stable than sync(). We wi=
ll=20
make a several day load test soon.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
