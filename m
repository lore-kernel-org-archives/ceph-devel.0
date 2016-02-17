From: huang jun <hjwsm1989@gmail.com>
Subject: Use xattr to replace omap operations in rbd
Date: Wed, 17 Feb 2016 23:46:49 +0800
Message-ID: <CABAwU-Ysn9f=U+Aj53n_2k6L_5U_ViaOhXQ_UR9VPdbCisxhTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36230 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424072AbcBQPqv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 10:46:51 -0500
Received: by mail-lf0-f48.google.com with SMTP id 78so13519767lfy.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 07:46:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
now, rbd can only use erasure code pool  with cache tier.
If we want to use rbd + ec, without cache tier,
that means all rbd operations should be rollback,
after trace the rbd code, there are many tmap\omap ops which not
supported by ec.
can i replace the omap operations to xattr, does it works?
and for rbd kernel module,what should be done to support rbd +ec?

By the way, what's main difference between xattr and omap?
bc the omap performance is better when storing larger bytes?

-- 
thanks
huangjun
