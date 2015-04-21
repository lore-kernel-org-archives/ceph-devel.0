From: Ning Yao <zay11022@gmail.com>
Subject: Performance test for cache tier
Date: Tue, 21 Apr 2015 11:57:50 +0800
Message-ID: <CALZt5jyiyupUJS2TEXWt5Yo0S9OFu2gDWeacycKCv0meWzOZ-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33247 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbbDUD5v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2015 23:57:51 -0400
Received: by wiax7 with SMTP id x7so97634543wia.0
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2015 20:57:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

Fio will exactly access each block once by default. But it is not the
case we want to use cache tier. The reason we use it is lots of
content will be access repeatedly so that there is lots of cache hits.
I find random_distribution can alter the acess distribution, but hard
to  exactly set the hit : miss rate for the test. Is there any way to
do this?


Regards
Ning Yao
