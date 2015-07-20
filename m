From: Travis Rhoden <trhoden@redhat.com>
Subject: [ANN] ceps-deploy 1.5.26 released
Date: Mon, 20 Jul 2015 14:52:09 -0700
Message-ID: <32269290-BBEA-419E-92B9-13B545364F41@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbGTVwK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 17:52:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-announce@lists.ceph.com

Hi everyone,

This is announcing a new release of ceph-deploy that focuses on usabili=
ty improvements.

 - Most of the help menus for ceph-deploy subcommands (e.ge. =E2=80=9Cc=
eph-deploy mon=E2=80=9D and =E2=80=9Cceph-deploy osd=E2=80=9D) have bee=
n improved to be more context aware, such that help for =E2=80=9Cceph-d=
eploy osd create --help =E2=80=9C and =E2=80=9Cceph-deploy osd zap --he=
lp=E2=80=9D return different output specific to the command.  Previousl=
y it would show generic help for =E2=80=9Cceph-deploy osd=E2=80=9D.  Ad=
ditionally, the list of optional arguments shown for the command are al=
ways correct for the subcommand in question.  Previously the options sh=
own were the aggregate of all options.

 - ceph-deploy now points to git.ceph.com for downloading GPG keys

 - ceph-deploy will now work on the Mint Linux distribution (by pointin=
g to Ubuntu packages)

 - SUSE distro users will now be pointed to SUSE packages by default, a=
s there have not been updated SUSE packages on ceph.com in quite some t=
ime.

=46ull changelog is available at: http://ceph.com/ceph-deploy/docs/chan=
gelog.html#id1

New packages are available in the usual places of ceph.com hosted repos=
 and PyPI.

Cheers,

 - Travis--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
