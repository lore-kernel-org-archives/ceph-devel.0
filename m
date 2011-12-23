From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: API documentation making progress
Date: Thu, 22 Dec 2011 17:24:07 -0800
Message-ID: <CAORUGqD__zuRnFURhDU9P5jyc_9SSfVjSTyV3617YJ-f-ULfQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59454 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab1LWBY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 20:24:29 -0500
Received: by wgbdr13 with SMTP id dr13so16718061wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 17:24:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi. Josh & me have been busy with API documentation. If you want to
play with it before Jan 10th (when I'm back from vacation),
https://github.com/NewDreamNetwork/ceph/tree/wip-librados-doc-tv has
the bits that enable it.

The biggest annoyance right now is missing enum support -- I need to
add that to Sphinx, it's so much more about the Python world that it
actually doesn't currently have a concept of enums. Easy but it's
going to take one more day to fix the few remaining bugs. So I
disabled doxygen for the librados.h enums, for now.

There's a few bugs here and there, but they mostly result in warnings
in the generated document.

Josh, note: it still doesn't do handle dependencies, so you still need
touch doc/api/librados.rst when you edit librados.h, but that's just
me running out of time. I know where to put it.

Enjoy!
