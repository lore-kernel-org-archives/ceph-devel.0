From: chen kael <chenji.bupt@gmail.com>
Subject: How to make a osd status become down+peering?
Date: Mon, 28 Sep 2015 19:05:32 +0800
Message-ID: <CAA-rZjabHkRNy6JfsXJ+5ctVy5EM7Jv99=YktnPrhsqUGqP8VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35426 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932533AbbI1LFo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 07:05:44 -0400
Received: by wicge5 with SMTP id ge5so99585564wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 04:05:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

HI,
Now I am running a cluster on giant0.87 ,After a serials of disks
failures, we have to  add new osd and set out bad ones, so the
rebalance process began
unfortunately=EF=BC=8Cone osd was stuck in down+peering ,and cat not re=
cover by itself.
=46rom log , we found that one pg was stuck,because two files on this p=
g
was broken, so the peering process abort.
So, I tried ceph osd lost osd.n, but It doesn`t work.At last I deleted
this two bad files,and the osd success recoverd.

Now I am trying fix this bug, maybe some has already fixed it.So Does
anyone know how to solve this problem or encounter it before would be
help!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
