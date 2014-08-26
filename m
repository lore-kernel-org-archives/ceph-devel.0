From: =?UTF-8?B?TWljaGHFgiBTenltYcWEc2tp?= <michalszymanski91@gmail.com>
Subject: OSD's load_pgs takes a lot of time
Date: Tue, 26 Aug 2014 09:43:15 +0200
Message-ID: <CADg7yx3mM+zagdcwQ6AO-omzxBM33=Gft3hvMEKDPEVysqKxBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54522 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198AbaHZHnh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Aug 2014 03:43:37 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so14319091lan.5
        for <ceph-devel@vger.kernel.org>; Tue, 26 Aug 2014 00:43:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have noticed that sometimes it takes a lot of time for an OSD to go
back up and in. From what i can see in the logs it is stuck on
load_pgs for a while:
2014-08-21 15:32:04.711048 7fba11569780  0 osd.1 139 load_pgs
2014-08-21 15:32:04.712512 7fba11569780 10 osd.1 139 load_pgs
3.165_TEMP clearing temp
2014-08-21 15:32:19.648610 7fba11569780 10 osd.1 139 load_pgs
3.13b_TEMP clearing temp
2014-08-21 15:32:34.674773 7fba11569780 10 osd.1 139 load_pgs
3.36b_TEMP clearing temp

It happens when you restart an OSD while there was an ongoing recovery
in the cluster. The process isn't neither IO nor CPU heavy at that
time, and judging by strace output it mostly does futex calls and a
little IO on PGs. I am using Ceph 0.80.5.

Have anybody noticed this behavior? Isn't it possible to clear temp fas=
ter?

--=20
Pozdrawiam
Micha=C5=82 Szyma=C5=84ski
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
