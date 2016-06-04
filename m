From: Ning Yao <zay11022@gmail.com>
Subject: Does mon skew really matters?
Date: Sat, 4 Jun 2016 12:06:06 +0800
Message-ID: <CALZt5jypeXGhVhhjur8dpC5KPDqFN-HRC+HbUzOEmVtzO6N1vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35462 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcFDEGJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Jun 2016 00:06:09 -0400
Received: by mail-wm0-f44.google.com with SMTP id a136so20621601wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2016 21:06:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

I find that even if I have mon clock skew warning, under most cases,
my cluster still can work properly as expected.

I go through the code in mon but do not find any related issue without
time_check() to update whether clock skew periodically.

can any one tell what is the design purpose of the clock skew between
mon and when it will really matter the cluster?

Thanks a lots!

Regards
Ning Yao
