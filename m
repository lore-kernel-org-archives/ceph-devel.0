From: Jaze Lee <jazeltq@gmail.com>
Subject: Fwd: where can i customize rbd object size?
Date: Thu, 20 Aug 2015 10:24:56 +0800
Message-ID: <CAKZcxgeikFp468rRmZdGHfBGAUhbvO_Lr+Q6oySF==7ueXnW7g@mail.gmail.com>
References: <CAKZcxgea6vyCs_6tPWrU_DpmF1BJ+K1idAV2=NP30YAe2WD7og@mail.gmail.com>
	<CAKZcxgdHRg1fZVaagyXM2uZvD=R9RVXu=fvBn2E-4Aso7Hh4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34598 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbHTCY6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 22:24:58 -0400
Received: by lbbtg9 with SMTP id tg9so14989270lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2015 19:24:56 -0700 (PDT)
In-Reply-To: <CAKZcxgdHRg1fZVaagyXM2uZvD=R9RVXu=fvBn2E-4Aso7Hh4CQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

    qemu-img convert -f qcow2 Trove---mysql-5.6---2015-07-16.qcow2 -O
raw rbd:openstack-00/8205d01a-874c-44c0-b114-1c03821fcc24:conf=3D/etc/c=
eph/ceph.conf

    How can i specify the object size that rbd uses?

   I found that the qemu-image can only use the default object size.
It is defined in block/rbd.c

    #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)

    And i do not find the define for  OBJ_DEFAULT_OBJ_ORDER, if
someone knows , please tell me. Thanks a lot.




--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
