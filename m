From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: max rbd devices
Date: Mon, 27 Jul 2015 16:38:57 -0400
Message-ID: <CAGbvivKdOFwMqbsLc7wzhYfF=BzMVXXUVR0oBgmq-eC8S-b3JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33857 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbG0Ui6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jul 2015 16:38:58 -0400
Received: by igk11 with SMTP id 11so78987891igk.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2015 13:38:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I found a thread from 2012 talking about the maximum number of RBD
devices that can be mapped, it seems to cap out at around 228.  There
was discussion about possibly fixing this by using a registered/fixed
major block device and bumping the minor device number for each new
mapping.

http://www.spinics.net/lists/ceph-devel/msg09362.html

Did this ever progress any further or was an official bug ever filed?
Im seeing this issue now and was just wondering if there are
workarounds (other than not creating that many mappings).

thanks,
  Wyllys Ingersoll
