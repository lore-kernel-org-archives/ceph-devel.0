From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 8 May 2015 08:36:23 -0400 (EDT)
Message-ID: <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com>
References: <554C7CE5.4070600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:45032 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbbEHMh2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 08:37:28 -0400
In-Reply-To: <554C7CE5.4070600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Nice catch.  It is deadlocked in a code path between handling a watch/n=
otify error from librados and flushing the internal cache.  The issue a=
lready appears to exist in the hammer branch.

--=20

Jason Dillaman=20
Red Hat=20
dillaman@redhat.com=20
http://www.redhat.com=20


----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Jason Dillaman" <dillaman@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Friday, May 8, 2015 5:07:49 AM
Subject: long running workloads/rbd_fsx_cache_writeback.yaml on hammer

Hi Janson,

There is a long running (12h +) job at

http://pulpito.ceph.com/loic-2015-05-07_09:46:27-rbd-hammer-backports--=
-basic-multi/878799/

which is about

 rbd/thrash/{base/install.yaml clusters/fixed-2.yaml fs/xfs.yaml msgr-f=
ailures/few.yaml thrashers/default.yaml workloads/rbd_fsx_cache_writeba=
ck.yaml}=20

and runs on the current hammer-backports branch which contains a few li=
brbd backports

http://tracker.ceph.com/issues/11492#Teuthology-run-commit-commita79146=
fc3cae28bf4c07478fb4566b06942da60d-hammer-backports-branch-May-2015

I don't see an obvious cause for error in the logs. Does it ring a bell=
 ? Is it supposed to take that long ? Note that all other jobs complete=
d successfully (see http://pulpito.ceph.com/loic-2015-05-07_09:46:27-rb=
d-hammer-backports---basic-multi/ for details).

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
