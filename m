From: Jaze Lee <jazeltq@gmail.com>
Subject: why there is not a status bit for CEPH_OSD_DOWN?
Date: Thu, 21 Apr 2016 12:11:56 +0800
Message-ID: <CAKZcxgcdkwJbo8wgKan4o8YZZRz+hwD4CLcKhj2fx-RLHX4Xig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36194 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbcDUEL5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2016 00:11:57 -0400
Received: by mail-io0-f195.google.com with SMTP id s2so9338320iod.3
        for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2016 21:11:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all
  I found when osds report a target osd failure, the monitor encode
CEPH_OSD_UP in
  the pend_inc. Why not put CEPH_OSD_DOWN there?
   The code is here
   https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L1777

  May be i miss something? Or my understanding is wrong? Can someone
who know that
  explain a little more?

Thanks a lot....





--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
