From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Several patches for CEPH
Date: Wed, 22 Sep 2010 23:29:49 +0800
Message-ID: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64288 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab0IVP3v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 11:29:51 -0400
Received: by qyk33 with SMTP id 33so912269qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 08:29:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Would you help to review several patches on our github for ceph-unstable?

1. http://github.com/tcloud/ceph/commit/3c91d0c0e20425f94eaa374f39b2a1f398270255

This fixed a monitor bug we hit several times. When some osds report
that other osds are down,
there is a chance that the leading monitor would enter an infinite loop (you can
see the CPU usage of cmon is 100% from "top").

ps. I found that the master branch does not contain this piece of
code. Is there any concern?


2. http://github.com/tcloud/ceph/commit/e3147e8929220997017de8fffa34b9d9c2abf9cf

We hit this assert fail once. Can you check if this patch is reasonable?


3. http://github.com/tcloud/ceph/commit/01e3bd78fe7ae26b394f5acda5c0ea875726a387

We found that every execution of 'ceph -s' causes a thread leaking on
the monitor.
This patch sort of fixed the problem: the thread will be terminated
when the subscription
expires. However, I wonder if we should provide an "unsubscribe" mechanism to
allow the client to explicitly unsubscribe it.

Thanks,
Henry
