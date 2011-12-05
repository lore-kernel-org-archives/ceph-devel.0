From: Christian Brunner <chb@muc.de>
Subject: 'ceph -w' in 0.39
Date: Mon, 5 Dec 2011 14:59:42 +0100
Message-ID: <CAO47_--yZib5-zpwDutQSdiw7f8CWu=2CE0jNVAVP2fD4nrcZA@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61184 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab1LEN7n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 08:59:43 -0500
Received: by vbbfc26 with SMTP id fc26so3881068vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2011 05:59:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've just updated to 0.39. Everything seems to be fine, except one
minor thing I noticed:

'ceph -w' output stops after a few minutes. With "debug ms = 1" it
ends with these lines:

2011-12-05 14:45:52.939300 7fc700637700 -- 10.255.0.21:0/14145 <==
mon.2 10.255.0.22:6789/0 315 ==== mon_observe_notify(v4525550 1303
bytes v4525550) v1 ==== 1354+0+0 (339634604 0 0) 0x7fc6f4000920 con
0x874070
2011-12-05 14:45:52.939319    pg v4525550: 2776 pgs: 2776
active+clean; 3362 GB data, 1646 GB used, 57135 GB / 59615 GB avail

After that, silence...

When I press Ctrl-C and restart it, it is again running for a few minutes.

Any hints what I'm doing wrong?

Thanks,
Christian
