From: huang jun <hjwsm1989@gmail.com>
Subject: questions of pg scrub
Date: Thu, 8 Sep 2011 08:06:55 +0800
Message-ID: <CABAwU-Zfvy_Un1YQirpiDhontLDPi4DRjJDBK=Z4KutA2dpOOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38681 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742Ab1IHAG4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 20:06:56 -0400
Received: by vxj15 with SMTP id 15so193985vxj.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2011 17:06:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
Recently,i read the source code of PG scrub.The ceph periodically
shed_scrub if the system load is not too high. And adminstrator can
manually scrub the specified OSD or PG using cmds.
but many questions come along with me when i got thourgh .
why did ceph need scrub?
what scrub used for?
because the OSD use three threads to handle the scrub transactions,
maybe it has a great effect on the stablity or performance of ceph?

thank you=A3=A1
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
