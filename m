From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: RBD layering needs to work across pools
Date: Fri, 16 Dec 2011 14:48:10 -0800
Message-ID: <CAORUGqBWQ5Sm1npyq4Jh0eoEHCmNz+Rb1jE+mOrT8KGM+A=CwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50492 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab1LPWzP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 17:55:15 -0500
Received: by wibhm6 with SMTP id hm6so299467wib.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 14:55:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@dreamhost.com>

Hi list, hi Josh.

This came up in an OpenStack conversation today:

if we store "template images" and "volumes" both in RBD, it would make
a lot of sense prevent the Nova nodes from accidentally writing to the
golden images. That is, have the templates in a separate pool that is
writeable to Glance, but read-only for the Nova nodes.

To support this, we'd need to make sure the RBD layering we're
building is able to use base images in a separate pool. (And handle
the ugly case where after a misconfiguration the client can't access
the base image anymore...)

Josh, can you say whether that falls in line with what's been planned
for the layering?
