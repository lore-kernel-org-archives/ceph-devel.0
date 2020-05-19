From: <Michal.Plsek@seznam.cz>
Subject: ceph kernel client orientation
Date: Tue, 19 May 2020 15:43:40 +0200 (CEST)
Message-ID: <6n.cjI5.4P7G519BQ1k.1Um{AC@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.57)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESNno (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2020 09:43:44 -0400
Received: from mxb1.seznam.cz (mxb1.seznam.cz [IPv6:2a02:598:a::78:89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0DC08C5C0
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 06:43:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am trying to get to functions responsible for reading/writing to/opening=
 RBD blocks in ceph client kernel module (alternatives to librbd=E2=80=99s=
 rbd_read(), rbd_write() etc.). I presume it should be located somewhere a=
round drivers/block/, but until now I=E2=80=99ve been without luck. My ide=
a is to edit these functions, rebuild the ceph kernel =E2=80=98rbd=
=E2=80=99 module and replace it. Since comments are pretty much missing ev=
erywhere, it would be nice to narrow my searching area.

If you know anything about it, please let me know. Thanks, M. 
