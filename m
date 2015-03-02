From: Samuel Just <sjust@redhat.com>
Subject: Re: rados and the next firefly release
Date: Mon, 2 Mar 2015 10:54:41 -0500 (EST)
Message-ID: <909602191.30675260.1425311681299.JavaMail.zimbra@redhat.com>
References: <54F1E1FD.7060206@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:33069 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbbCBPzo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 10:55:44 -0500
In-Reply-To: <54F1E1FD.7060206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Yeah, we don't need to worry about that one, good for QE to start.
-Sam

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Samuel Just" <sjust@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Saturday, February 28, 2015 7:42:53 AM
Subject: rados and the next firefly release

Hi Sam,

The rados teuthology suite for the next firefly release as found in htt=
ps://github.com/ceph/ceph/commits/firefly-backports came back with one =
failure (unreadable crash from ceph-osd http://tracker.ceph.com/issues/=
10485). The details of the run is at http://tracker.ceph.com/issues/106=
41#rados (note that one run was solely to repeat the jobs that failed b=
ecause of environmental problems). Do you think it is ready for QE to s=
tart their own round of testing ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre







--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
