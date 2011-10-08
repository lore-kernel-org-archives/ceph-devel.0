From: Christian Brunner <chb@muc.de>
Subject: OSD::disk_tp timeout
Date: Sat, 8 Oct 2011 22:37:49 +0200
Message-ID: <CAO47_-_x3QqP4qmTUAFB5SrObaBuzaJUa4dh+p+mdTHzKGeojg@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41092 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab1JHUhu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Oct 2011 16:37:50 -0400
Received: by vws1 with SMTP id 1so3861627vws.19
        for <ceph-devel@vger.kernel.org>; Sat, 08 Oct 2011 13:37:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've upgraded ceph from 0.32 to 0.36 yesterday. Now I have a totaly
screwed ceph cluster. :(

What bugs me most is the fact, that OSDs become unresponsive
frequently. The process is eating a lot of cpu and I can see the
following messages in the log:

Oct =A08 22:30:05 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
Oct =A08 22:30:10 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
Oct =A08 22:30:15 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
Oct =A08 22:30:20 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
Oct =A08 22:30:25 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60
Oct =A08 22:30:30 os00 osd.000[31688]: 7fe0f3b9c700 heartbeat_map
is_healthy 'OSD::disk_tp thread 0x7fe0e527e700' had timed out after 60

Do you have any idea, what to do about that?

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
