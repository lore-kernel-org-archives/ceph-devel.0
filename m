From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: giant integration branch for v0.87.1 ready for QE
Date: Mon, 16 Feb 2015 13:49:31 -0500 (EST)
Message-ID: <2056497072.19411084.1424112571273.JavaMail.zimbra@redhat.com>
References: <54DA3DD6.7070108@dachary.org> <54DB757E.2000009@dachary.org> <1387059957.19365485.1424108024488.JavaMail.zimbra@redhat.com> <CAC6JEv8LEV5bNaoW3__2hjfYNZRmXDScp-a_1V+AKiX_SwWQCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:39331 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbBPSuf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Feb 2015 13:50:35 -0500
In-Reply-To: <CAC6JEv8LEV5bNaoW3__2hjfYNZRmXDScp-a_1V+AKiX_SwWQCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Greg, thx, so noted.

Thx
YuriW

----- Original Message -----
=46rom: "Gregory Farnum" <greg@gregs42.com>
To: "Yuri Weinstein" <yweinste@redhat.com>, "Loic Dachary" <loic@dachar=
y.org>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Monday, February 16, 2015 10:44:35 AM
Subject: Re: giant integration branch for v0.87.1 ready for QE

The multimds suite has never passed and is strictly informational at th=
is
point. You shouldn't worry about it. (We use it only to make sure we do=
n't
completely break multimds systems, but we don't expect it to pass. It's
just nice to have a rough idea how far off we are.)
-Greg
On Mon, Feb 16, 2015 at 9:34 AM Yuri Weinstein <yweinste@redhat.com> wr=
ote:

> I have completed suites execution on giant branch (v0.87.1 RC)
>
> All results are summarized in http://tracker.ceph.com/issues/10501 un=
der
> "QE VALIDATION" section.
> Some suites had to be run more then ones due to environment noise.
>
> Two suites are being re-run now - upgrade:firefly-x and powecycle.
>
> Next steps:
> -  the team leads to review/confirm results
> -  Loic - can you review and triage issues as needed.
> -  two suites require results analysis:
>    multimds
>    rados (two known tickets, but need more checking) ## 10209, 9891
>    krbd (two new tickets, but need more checking) ## 10889, 10890
>
>
> Thx
> YuriW
>
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, February 11, 2015 7:30:06 AM
> Subject: Re: giant integration branch for v0.87.1 ready for QE
>
> Hi Yuri,
>
> The giant-backports pull requests were merged into
> https://github.com/ceph/ceph/tree/giant which is not ready for testin=
g.
>
> For the record, the head is https://github.com/ceph/ceph/commit/
> 78c71b9200da5e7d832ec58765478404d31ae6b5
>
> Cheers
>
> On 10/02/2015 18:20, Loic Dachary wrote:
> > Hi Yuri,
> >
> > The giant integration branch for v0.87.1 as found at
> https://github.com/ceph/ceph/commits/giant-backports has been approve=
d by
> Yehuda, Josh and Sam and is ready for QE.
> >
> > For the record, the head is https://github.com/ceph/ceph/commit/
> 6b08a729540c61f3c8b15c5a3ce9382634bf800c
> >
> > Cheers
> >
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
