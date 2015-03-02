From: Zack Cerza <zack@redhat.com>
Subject: Re: paddles query
Date: Mon, 2 Mar 2015 14:59:09 -0500 (EST)
Message-ID: <1382449859.14137686.1425326349225.JavaMail.zimbra@redhat.com>
References: <54F1DD70.2000909@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:46506 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbbCBUAO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 15:00:14 -0500
In-Reply-To: <54F1DD70.2000909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hey Loic,

I gave an example in the ticket you filed (http://tracker.ceph.com/issu=
es/10945#note-3) , but here it is again for posterity:
http://paddles.front.sepia.ceph.com/runs/teuthology-2015-03-01_23:18:01=
-multimds-hammer-testing-basic-multi/jobs/?status=3Dfail

Zack

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Zack Cerza" <zack@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Saturday, February 28, 2015 8:23:28 AM
Subject: paddles query

Hi Zack,

Is there a way to ask paddles / pulpito ( http://pulpito.ceph.com/ ) fo=
r the list of failed/dead jobs in a given suite ? Here is a fiction exa=
mple:

$ paddles --failed-or-dead http://pulpito.ceph.com/loic-2015-02-28_11:4=
5:50-fs-firefly-backports---basic-multi/
http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports--=
-basic-multi/783076
http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports--=
-basic-multi/783102
http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports--=
-basic-multi/783093

I would like to then grep 'description:' from the corresponding teuthol=
ogy.log and re-schedule those corresponding to environment failures wit=
h teuthology-suite --filter ( as in http://tracker.ceph.com/issues/1094=
5#note-1 ). If you have a better way to achieve that, please let me kno=
w ;-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
