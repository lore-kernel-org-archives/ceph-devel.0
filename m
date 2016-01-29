From: Loic Dachary <loic@dachary.org>
Subject: AIO error
Date: Fri, 29 Jan 2016 16:07:23 +0700
Message-ID: <56AB2BCB.80501@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35079 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbcA2JHd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 04:07:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya,

This time is not a udev related question. I think (hope ?) there won't =
be any other udev trick questions.

A year ago I spent some time investigating the possible cause of http:/=
/tracker.ceph.com/issues/9570#note-8 I exhausted all options (the log o=
f my research is at http://tracker.ceph.com/issues/9570#note-17 and fol=
lowing). The problem resurfaces, rarely but often enough to re-open the=
 case and examine new logs.

I would be grateful if you could share bits of wisdom regarding AIO, if=
 you have some :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
