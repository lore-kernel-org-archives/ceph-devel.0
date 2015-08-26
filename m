From: huang jun <hjwsm1989@gmail.com>
Subject: format 2TB rbd device is too slow
Date: Wed, 26 Aug 2015 23:16:24 +0800
Message-ID: <CABAwU-ahZz48B2VHfeyqssBv778fKoVeD5Z3x2=Xgcf42VxTbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35001 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbHZPQ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Aug 2015 11:16:26 -0400
Received: by lbcbn3 with SMTP id bn3so121596012lbc.2
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2015 08:16:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
we create a 2TB rbd image, after map it to local,
then we format it to xfs with 'mkfs.xfs /dev/rbd0', it spent 318
seconds to finish, but  local physical disk with the same size just
need 6 seconds.

After debug, we found there are two steps in rbd module during formating:
a) send  233093 DELETE requests to osds(number_of_requests = 2TB / 4MB),
   this step spent almost 92 seconds.
b) send 4238 messages like this: [set-alloc-hint object_size 4194304
write_size 4194304,write 0~512] to osds, that spent 227 seconds.

is there any optimations can we do?
-- 
thanks
huangjun
