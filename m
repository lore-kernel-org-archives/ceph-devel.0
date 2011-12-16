From: Sage Weil <sage@newdream.net>
Subject: Re: Return stale file handle (-ESTALE) like NFS instead of hanging
 forever?
Date: Fri, 16 Dec 2011 09:00:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112160855080.25421@cobra.newdream.net>
References: <201112081455.56365.a.ott@m-privacy.de>
 <CAF3hT9CHwgkuXynhdM9bmG2g6n2pFYdxxwRH3mCw7Jxcp6QfzQ@mail.gmail.com>
 <201112160936.35587.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-364011074-1324054803=:25421"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44643 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab1LPRAE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 12:00:04 -0500
In-Reply-To: <201112160936.35587.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-364011074-1324054803=:25421
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Amon,

There is a long-standing item in the issue tracker to add a 'soft' mode to=
=20
the kernel client that would be analogous to the NFS mount option.  I=20
think this is basically what you're asking for.  The general problem is=20
that timeouts in general lead to timing-dependent behavior and=20
non-deterministic results.  Usually people would prefer 'correct'=20
application behvior that waits for a long time over a shorter delay=20
followed by spurios erros that the application may or may not handle=20
properly.  So ESTALE will never be the default.. but it is something we=20
can make optional.

If it is purely a matter of raising an appropriate alarm without=20
accumulating blocked nagios checks, that's something we can more easily=20
solve (e.g. by checking client health in debugfs).

FWIW, here is what the nfs(5) man page says about it:

                      NB:  A  so-called  "soft"  timeout can cause silent d=
ata
                      corruption in certain  cases.  As  such,  use  the  s=
oft
                      option only when client responsiveness is more import=
ant
                      than data integrity.  Using NFS over TCP  or  increas=
ing
                      the value of the retrans option may mitigate some of =
the
                      risks of using the soft option.

sage



On Fri, 16 Dec 2011, Amon Ott wrote:

> On Thursday 15 December 2011 wrote Gregory Farnum:
> > On Thu, Dec 8, 2011 at 5:55 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > > Hi folks,
> > >
> > > if file access through Ceph kernel client cannot continue, e.g. becau=
se
> > > there is no mds available, it hangs forever.
> > >
> > > I would prefer if after a timeout the application would get an error
> > > code, e.g. the -ESTALE that NFS and Gluster return if something goes
> > > wrong. This would allow for the application to handle the error inste=
ad
> > > of blocking forever without a chance to recover.
> >
> > This is interesting to me ? Ceph works very hard to provide POSIX
> > semantics and so philosophically the introduction of ESTALE returns is
> > not a natural thing for us.
> > That doesn't necessarily make it the wrong choice, but since Ceph's
> > systems are designed to be self-repairing the expectation is that any
> > outage is a temporary situation that will resolve itself pretty
> > quickly. And unlike NFS, which often returns ESTALE when other file
> > accesses might succeed, if Ceph fails on an MDS request that's pretty
> > much the ballgame. So returning ESTALE seems like it's a cop-out,
> > losing data and behaving unexpectedly without actually doing anything
> > to resolve the issues or giving other data a chance to get saved ? ie,
> > it's not something we want to do automatically. I believe we already
> > honor interrupts so that you can do things like Ctrl-C an application
> > waiting for IO and cancel the operations.
>=20
> The assumption that any outage resolves itself quickly is unfortunately w=
rong.=20
> During my tests over some months by now, I had several cases where Ceph=
=20
> services on all nodes crashed one after another when trying to recover fr=
om=20
> some error. This always resulted in infinite hangs for every single proce=
ss=20
> that tried to access something on Ceph FS, until I sent a kill manually. =
For=20
> a big cluster this is not acceptable.
>=20
> Ceph design is supposed to handle crashes of singles service instances, b=
ut a=20
> bug in a service daemon that makes the same kind of service crash on all=
=20
> nodes is always possible, because they have the same data. There needs to=
 be=20
> some reliable way to find out at the client side that access is not likel=
y to=20
> recover any time soon.
>=20
> > Can you describe why this behavior interests you (and manual
> > interruption is insufficient)? I discussed with a few people the
> > possibility of making it an off-by-default mount option (though I'm
> > unclear on the technical difficulty involved; I'm not big on our
> > kernel stuff); presumably that would be enough for your purposes?
>=20
> Our server clusters have quite a few cron jobs as well as Nagios health c=
hecks=20
> that also access the common data area on Ceph FS for configuration and st=
atus=20
> storage. If these jobs hang forever because of a blocked access, they can=
not=20
> finish their other tasks - even if that access is not vital for these oth=
er=20
> tasks. Specially, they can never return a result. You cannot even shutdow=
n=20
> the system cleanly, if umount blocks forever.
>=20
> The systems cannot help themselves, unless we add our own timeouts to any=
 such=20
> access and kill the processes after timeout. A meaningful error code inst=
ead=20
> of unconditional kill would be very helpful, whatever code that is - we c=
ould=20
> simply handle it in the scripts.
>=20
> Please note that I am not talking about rather short term blocks like 10s=
 or=20
> even a minute, while the system recovers from some service crash. After 1=
5=20
> minutes or so I would rather get a meaningful alarm from some error inste=
ad=20
> of a hanging check that tells me nothing. Additionally, this removes the =
need=20
> to check for hanging previous checks before they use up too many system=
=20
> resources.
>=20
> Amon Ott
> --=20
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Am K=F6llnischen Park 1    Fax: +49 30 24342336
> 10179 Berlin             http://www.m-privacy.de
>=20
> Amtsgericht Charlottenburg, HRB 84946
>=20
> Gesch=E4ftsf=FChrer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
>=20
> GnuPG-Key-ID: 0x2DD3A649
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-364011074-1324054803=:25421--
