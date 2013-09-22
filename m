From: Andrey Korolyov <andrey@xdel.ru>
Subject: Hiding auth key string for the qemu process
Date: Sun, 22 Sep 2013 23:54:16 +0400
Message-ID: <CABYiri_WXi-CCtJBJZSsy7t8MsX6kVdq=OHKiRmS+kDhekhyiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:40114 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3IVTyh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 15:54:37 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so10605oag.6
        for <ceph-devel@vger.kernel.org>; Sun, 22 Sep 2013 12:54:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

Since it was a long time from enabling cephx by default and we may
think that everyone using it, is seems worthy to introduce bits of
code hiding the key from cmdline. First applicable place for such
improvement is most-likely OpenStack envs with their sparse security
and usage of admin key as default one.
