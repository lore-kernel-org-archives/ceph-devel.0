From: Damien Churchill <damoxc@gmail.com>
Subject: rbd copy progress
Date: Fri, 12 Aug 2011 15:59:05 +0100
Message-ID: <CAFtEh-dpiebifi31NXNoGYpzawvWNR0T5qc8DO-XLivXbw8HCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58806 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab1HLO7H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2011 10:59:07 -0400
Received: by gwaa12 with SMTP id a12so2000157gwa.19
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2011 07:59:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was wondering if it's possible to get copy progress statistics some
how when doing a rbd copy <image> <dest>? I could check the disk usage
for Ceph but that seems rather unclean and also prone to errors,
especially if there are multiple copies going on at once.

Thanks,
Damien
