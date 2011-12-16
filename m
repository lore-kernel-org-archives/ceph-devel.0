From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Return stale file handle (-ESTALE) like NFS instead of hanging forever?
Date: Fri, 16 Dec 2011 09:36:34 +0100
Message-ID: <201112160936.35587.a.ott@m-privacy.de>
References: <201112081455.56365.a.ott@m-privacy.de> <CAF3hT9CHwgkuXynhdM9bmG2g6n2pFYdxxwRH3mCw7Jxcp6QfzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:51732 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760173Ab1LPIgp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 03:36:45 -0500
In-Reply-To: <CAF3hT9CHwgkuXynhdM9bmG2g6n2pFYdxxwRH3mCw7Jxcp6QfzQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thursday 15 December 2011 wrote Gregory Farnum:
> On Thu, Dec 8, 2011 at 5:55 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > Hi folks,
> >
> > if file access through Ceph kernel client cannot continue, e.g. bec=
ause
> > there is no mds available, it hangs forever.
> >
> > I would prefer if after a timeout the application would get an erro=
r
> > code, e.g. the -ESTALE that NFS and Gluster return if something goe=
s
> > wrong. This would allow for the application to handle the error ins=
tead
> > of blocking forever without a chance to recover.
>
> This is interesting to me =97 Ceph works very hard to provide POSIX
> semantics and so philosophically the introduction of ESTALE returns i=
s
> not a natural thing for us.
> That doesn't necessarily make it the wrong choice, but since Ceph's
> systems are designed to be self-repairing the expectation is that any
> outage is a temporary situation that will resolve itself pretty
> quickly. And unlike NFS, which often returns ESTALE when other file
> accesses might succeed, if Ceph fails on an MDS request that's pretty
> much the ballgame. So returning ESTALE seems like it's a cop-out,
> losing data and behaving unexpectedly without actually doing anything
> to resolve the issues or giving other data a chance to get saved =97 =
ie,
> it's not something we want to do automatically. I believe we already
> honor interrupts so that you can do things like Ctrl-C an application
> waiting for IO and cancel the operations.

The assumption that any outage resolves itself quickly is unfortunately=
 wrong.=20
During my tests over some months by now, I had several cases where Ceph=
=20
services on all nodes crashed one after another when trying to recover =
from=20
some error. This always resulted in infinite hangs for every single pro=
cess=20
that tried to access something on Ceph FS, until I sent a kill manually=
=2E For=20
a big cluster this is not acceptable.

Ceph design is supposed to handle crashes of singles service instances,=
 but a=20
bug in a service daemon that makes the same kind of service crash on al=
l=20
nodes is always possible, because they have the same data. There needs =
to be=20
some reliable way to find out at the client side that access is not lik=
ely to=20
recover any time soon.

> Can you describe why this behavior interests you (and manual
> interruption is insufficient)? I discussed with a few people the
> possibility of making it an off-by-default mount option (though I'm
> unclear on the technical difficulty involved; I'm not big on our
> kernel stuff); presumably that would be enough for your purposes?

Our server clusters have quite a few cron jobs as well as Nagios health=
 checks=20
that also access the common data area on Ceph FS for configuration and =
status=20
storage. If these jobs hang forever because of a blocked access, they c=
annot=20
finish their other tasks - even if that access is not vital for these o=
ther=20
tasks. Specially, they can never return a result. You cannot even shutd=
own=20
the system cleanly, if umount blocks forever.

The systems cannot help themselves, unless we add our own timeouts to a=
ny such=20
access and kill the processes after timeout. A meaningful error code in=
stead=20
of unconditional kill would be very helpful, whatever code that is - we=
 could=20
simply handle it in the scripts.

Please note that I am not talking about rather short term blocks like 1=
0s or=20
even a minute, while the system recovers from some service crash. After=
 15=20
minutes or so I would rather get a meaningful alarm from some error ins=
tead=20
of a hanging check that tells me nothing. Additionally, this removes th=
e need=20
to check for hanging previous checks before they use up too many system=
=20
resources.

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
