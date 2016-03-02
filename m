From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: why cache tier creates an empty object for a non-existent object?
Date: Wed, 2 Mar 2016 17:05:24 +0800
Message-ID: <CAGkCoN+V=-g20fDZ2P5=eQvgWk5BBVJ0GaUkQPG2cX8nW5jRNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34878 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbcCBJGF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 04:06:05 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so74526960wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 01:06:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Guys,

Recently I am trying cache tier and if I try to stat a non-existent
object in both cache tier pool and base pool, I find cache tier will
not just return -ENOENT, but also create an empty object with setting
its flag as FLAG_WHITEOUT in cache tier pool.

Although it indicates this object is not existed logically, why cache
tier will try to create it rather than only returning -ENOENT?

Thanks.

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com
