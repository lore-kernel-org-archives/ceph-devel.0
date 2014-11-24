From: Samuel Just <sam.just@inktank.com>
Subject: fiemap bug on giant
Date: Mon, 24 Nov 2014 13:03:08 -0800
Message-ID: <CA+4uBUbDywTkuFfhY2uCBWcXRCYjcitDQE7SVZRVjm9NwuXOBA@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62186 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaKXVDJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 16:03:09 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so8200045lbi.29
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 13:03:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Bug #10166 (http://tracker.ceph.com/issues/10166) can cause recovery
to result in incorrect object sizes on giant if the setting 'filestore
fiemap' is set to true.  This setting is disabled by default.  This
should be fixed in a future point release, though filestore fiemap
will probably continue to default to false.
-Sam
