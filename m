From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: timeout 120 teuthology-killl is highly recommended
Date: Tue, 21 Jul 2015 12:38:50 -0400 (EDT)
Message-ID: <934585543.1874305.1437496730064.JavaMail.zimbra@redhat.com>
References: <55AE6F90.3070503@dachary.org> <1312196360.1870726.1437496406379.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:53419 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932815AbbGUQjw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:39:52 -0400
In-Reply-To: <1312196360.1870726.1437496406379.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I was thinking of teuthology-nuke thou !


Thx
YuriW

----- Original Message -----
=46rom: "Yuri Weinstein" <yweinste@redhat.com>
To: "Loic Dachary" <loic@dachary.org>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Tuesday, July 21, 2015 9:33:26 AM
Subject: Re: timeout 120 teuthology-killl is highly recommended

Loic

I don't use teuthology-kill simultaneously only sequentially.
As far as run time, just as a note, when we use 'stale' arg and it invo=
kes ipmitool interface it does take awhile to finish.=20


Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Tuesday, July 21, 2015 9:13:04 AM
Subject: timeout 120 teuthology-killl is highly recommended

Hi Ceph,

Today I did something wrong and that blocked the lab for a good half ho=
ur.=20

a) I ran two teuthology-kill simultaneously and that makes them deadloc=
k each other
b) I let them run unattended only to come back to the terminal 30 minut=
es later and see them stuck.

Sure, two teuthology-kill simultaneously should not deadlock and that n=
eeds to be fixed. But the easy workaround to avoid that trouble is to j=
ust not let it run forever. Even for ~200 jobs it takes at most a minut=
e or two. And if it takes longer it probably means another teuthology-k=
ill competes and it should be interrupted and restarted later. From now=
 on I'll do

timeout 120 teuthology-kill .... || echo FAIL!

as a generic safeguard.

Apologies for the troubles.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
