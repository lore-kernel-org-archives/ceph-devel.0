From: huang jun <hjwsm1989@gmail.com>
Subject: workload balance
Date: Mon, 27 Jun 2011 17:34:21 +0800
Message-ID: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54458 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab1F0JeX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 05:34:23 -0400
Received: by wyg8 with SMTP id 8so946703wyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2011 02:34:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi=A3=ACall
Here is a problem confused me a lot. Some OSD's workload will be very h=
igh
when the client read a file continuously. So i think the cluster must
have a strategy to balance workload
there are two classes "MovingAverager and  IATAverager ",but i can not
figure out what the class IATAverager mean here?
and futhermore, can we bring tiered storage theory in ceph?

thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
