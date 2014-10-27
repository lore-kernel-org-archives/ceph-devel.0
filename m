From: Plato Zhang <sangongs@gmail.com>
Subject: Any way to list the keys&values of omap in certain range?
Date: Mon, 27 Oct 2014 16:52:11 +0800
Message-ID: <CAJu7gM1M=He7Qzxc9q8-wLEGqSVoJH-MCr_2UsE_G5GRJuLjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40671 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaJ0IwM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 04:52:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so3880804ieb.18
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 01:52:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all!

We are trying to utilize omap to store kv map.

However, we couldn't find a proper way to scan a certain key range of omap.

We do can use arg `max_return' to finish this job by iterating .
But if `max_return' is set too large, then there will be io waste
while the number of keys is few.
On the contrary, if it is set too small, then there will also be waste
while the number of keys is too many.

Is there any solution?
