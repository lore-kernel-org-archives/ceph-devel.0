From: huang jun <hjwsm1989@gmail.com>
Subject: rbd write rate
Date: Thu, 26 May 2011 09:06:34 +0800
Message-ID: <BANLkTimsL17LUHPg4F_TO5y3qnMcPeQOYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40971 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab1EZBGf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 21:06:35 -0400
Received: by wwa36 with SMTP id 36so212783wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2011 18:06:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
i have another rbd question,when i use rbd to wite a file to OSD
my configuration is : 4 OSDs 1MON 1MDS,linux kernel version is 2.6.37.6
and the average write rate is about 5MB/s.
when i look into the log in /var/log/kernel.log, and find that the
client get items from request_queue
with the write size between 1 page and 31 pages.
i think it results in the low write rate.am i right?
if not, please give me some advice?

thanks!
