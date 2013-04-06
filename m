From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: What will PGs do when the network splits?
Date: Sat, 6 Apr 2013 13:22:45 +0800
Message-ID: <CAMm-wcK9TBrR=qgO6__1efeimdN1uHGZsYk_Rfs2VO47U7JqvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:38898 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3DFFWp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Apr 2013 01:22:45 -0400
Received: by mail-vb0-f44.google.com with SMTP id e12so2634928vbg.17
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 22:22:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys.

I have a problem when reading the codes of the ceph.

In the osd.cc, the tick method will check if the mon is timeout by
compare "now - g_conf->osd_mon_ack_timeout" with last_pg_stats_ack, if
it's timeout, then monc->reopen_session() will be called to try to
re-connect to the mon.

The question is that, if the network has splited so that the osd will
never be able to connect to any mon, how do the PGs on the osd know
that? I think the PGs may still believe they are heathly with the
current OSDMap even the mons have already mark their osd down & out
(but couldn't tell them for the network problem), Then they continue
to sevice clients who have the same OSDMap with them. So two primary
PG may exist in the cluster at the same time which is terrible.

I want to knwon any code work with this issue or is there some wrong
with my opinion?

Thanks for any help!


--
=E8=A2=81=E5=86=AC
Email:yuandong1222@gmail.com
QQ:10200230
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
