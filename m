From: Samuel Just <sam.just@inktank.com>
Subject: osd systemtap initial steps
Date: Tue, 29 Apr 2014 15:17:41 -0700
Message-ID: <CA+4uBUbt8SikqyznV1q17UyqdAVyNM7fG7n5k5i4uSjSFuL8pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:44603 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965250AbaD2WRm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Apr 2014 18:17:42 -0400
Received: by mail-qg0-f47.google.com with SMTP id e89so972269qgf.6
        for <ceph-devel@vger.kernel.org>; Tue, 29 Apr 2014 15:17:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm starting on adding systemtap trace points to the osd.

https://github.com/athanatos/ceph/tree/wip-osd-stap

has some initial build changes and a single tracepoint in OSD::handle_op.

I'll ping the list when I've got more.
-Sam
