From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Subject: RadosGW hanging
Date: Tue, 14 Aug 2012 08:33:26 +0200
Message-ID: <CAMwB3TgG_JZJApvfT2ST9pMr+iHCH7E8vRXi77Sm0Jd+3ES+3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62798 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab2HNGd1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 02:33:27 -0400
Received: by qcro28 with SMTP id o28so18777qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Aug 2012 23:33:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Cluster version  0.47.2-1precise.

Now i can't say what triggers the problem, but cluster is loosing some
OSD, and when it's remmaping, and rebooting this osd's, and finaly
returning to normal (with as lot of delayed operations on delete), But
when cluster is starting to be loosing some OSD, then radogw goes a
wild, and every operation that hit radosgw fcgi, returning only http
code 502 from nginx, for every request.

Process of radosgw is working, and after restart radosgw on each host,
everything back to normal, after cluster back to normal.

Is anybody see such kind of behavior  ??

--=20
-----
Regards

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
