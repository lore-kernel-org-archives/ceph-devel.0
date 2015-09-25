From: Jaze Lee <jazeltq@gmail.com>
Subject: how to sepcify the point a rbd mapped?
Date: Fri, 25 Sep 2015 11:25:09 +0800
Message-ID: <CAKZcxgeKCGr3_=z1=A4yhDyqK01ZzXeAFMhMow_aCT1gXeuAoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33833 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbbIYDZL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 23:25:11 -0400
Received: by lacdq2 with SMTP id dq2so29384019lac.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 20:25:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
    I know we can map a rbd image to a block device into kernel by
=E2=80=98rbd map=E2=80=99 command=E3=80=82
    But we can not specify which block device. For example, if i have
a rbd named rbd_0,
    i want it mapped into /dev/rbd_0 when it mapped.

    Is there some way to do that?

--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
