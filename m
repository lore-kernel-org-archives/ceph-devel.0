From: =?UTF-8?B?0K7RgNC40Lkg0KHQvtC60L7Qu9C+0LI=?=
	<funny.falcon@gmail.com>
Subject: librados and multithreading
Date: Sat, 11 Jun 2016 20:01:25 +0300
Message-ID: <CAL-rCA2F5FE1HkCccp_dv=HTEm2KUjWOopfNjmO5rHDEh3oGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38860 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcFKRB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jun 2016 13:01:27 -0400
Received: by mail-wm0-f50.google.com with SMTP id m124so28186001wme.1
        for <ceph-devel@vger.kernel.org>; Sat, 11 Jun 2016 10:01:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Good day, all.

I found this issue: https://github.com/ceph/ceph/pull/5991

Did this issue affected librados ?
Were it safe to use single rados_ioctx_t from multiple threads before this fix?

-- 
With regards,
Sokolov Yura aka funny_falcon
