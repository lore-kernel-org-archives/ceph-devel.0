From: Axel Dunkel <ad@dunkel.de>
Subject: AW: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 19:35:27 +0100 (CET)
Message-ID: <1dc4d01d051f2$febae0e0$fc30a2a0$@dunkel.de>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay.rod.mail.dunkel.de ([88.215.200.254]:40909 "EHLO
	relay.rod.mail.dunkel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbBZSfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 13:35:31 -0500
In-Reply-To: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Content-Language: de
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-users@ceph.com, ceph-devel@vger.kernel.org

Sage,

we use apache as a filter for security and additional functionality
reasons. I do like the idea, but we'd need some kind of interface to
filter/modify/process requests.

Best regards
Axel Dunkel

-----Urspr=FCngliche Nachricht-----
Von: ceph-devel-owner@vger.kernel.org
[mailto:ceph-devel-owner@vger.kernel.org] Im Auftrag von Sage Weil
Gesendet: Mittwoch, 25. Februar 2015 20:32
An: ceph-users@ceph.com; ceph-devel@vger.kernel.org
Betreff: who is using radosgw with civetweb?

Hey,

We are considering switching to civetweb (the embedded/standalone rgw w=
eb
server) as the primary supported RGW frontend instead of the current
apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here mean=
s
both the primary platform the upstream development focuses on and what =
the
downstream Red Hat product will officially support.

How many people are using RGW standalone using the embedded civetweb
server instead of apache?  In production?  At what scale?  What
version(s) (civetweb first appeared in firefly and we've backported mos=
t
fixes).

Have you seen any problems?  Any other feedback?  The hope is to (vastl=
y)
simplify deployment.

Thanks!
sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org More majordomo info =
at
http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
