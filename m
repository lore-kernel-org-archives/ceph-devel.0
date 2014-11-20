From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Can I limit buffering for each object in radosgw?
Date: Thu, 20 Nov 2014 12:03:58 +0300
Message-ID: <CAMWPydROJKB-HvATJmbB28L6QM9kXpYeRf5+myyX8AJ3OiaUSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43867 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757205AbaKTJD7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Nov 2014 04:03:59 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so3076462wgh.17
        for <ceph-devel@vger.kernel.org>; Thu, 20 Nov 2014 01:03:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am using radosgw, I have a large number of connections with huge
files, the memory usage keeps getting higher until killed by the
kernel, I *think* because of buffering for each request.
Is the a way to limit the buffer size for each object (or for each
connection)? and What do you suggest?
