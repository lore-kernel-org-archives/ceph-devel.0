From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: teuthology job priorities
Date: Thu, 28 May 2015 12:21:49 -0400 (EDT)
Message-ID: <613662148.8423810.1432830109340.JavaMail.zimbra@redhat.com>
References: <5566E0AD.80401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:46905 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbbE1QWw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 12:22:52 -0400
In-Reply-To: <5566E0AD.80401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I usually use:=20
priority [90,100]

for point releases validations.

This is a good thread to bring up for open approval/disapproval.

Does that sound reasonable ??

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Thursday, May 28, 2015 2:32:29 AM
Subject: teuthology job priorities

Hi,

This morning I'll schedule a job with priority 50, assuming nobody will=
 get mad at me for using such a low priority because the associated bug=
 fix blocks the release of v0.94.2 (http://tracker.ceph.com/issues/1154=
6) and also assuming noone uses a priority lower than 100 just to get i=
n front of the nightlies[1]. In my imagination

   priority [0,100] is for emergencies
   priority [100,1000] is to schedule a job with higher priority than t=
he nightlies
   priority 1000 (the default) is for all automated tests and no human =
being wait on them (the nightlies for instance).

Does someone have a different mapping in mind ?

Cheers

[1] the nightlies http://tracker.ceph.com/projects/ceph-releases/wiki/H=
OWTO_monitor_the_automated_tests_AKA_nightlies
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
