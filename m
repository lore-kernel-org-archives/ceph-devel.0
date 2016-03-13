From: Peng Tao <bergwolf@gmail.com>
Subject: Question about rbd layering kernel warning
Date: Sun, 13 Mar 2016 19:45:45 +0800
Message-ID: <CA+a=Yy48ZQan3AKU_GrtOefaENaju5dKgrCaxxL-RBjq5VZg7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35678 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbcCMLqG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Mar 2016 07:46:06 -0400
Received: by mail-io0-f169.google.com with SMTP id g203so193724934iof.2
        for <ceph-devel@vger.kernel.org>; Sun, 13 Mar 2016 04:46:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

Hi,

The warning about rbd layering in kernel client code has been there
for more than three years, since it was first activated by commit
770eba6e2 (rbd: activate support for layered images) in Oct 2012.

Now users still get "WARNING: kernel layering is EXPERIMENTAL!" when
mapping an image with parent. Is it time to just drop the warning? Or
is there still stability concern in some cases?

Thanks,
Tao
