From: Roald van Loon <roaldvanloon@gmail.com>
Subject: subdir-objects
Date: Wed, 21 Aug 2013 21:45:37 +0200
Message-ID: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:62752 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab3HUTph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 15:45:37 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so1732441obb.32
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 12:45:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ceph devs,

I'm working on doing some structuring/designing plugins for RGW. In a
recent discussion with Yehuda, I'm looking into how we can statically
link 'plugins' into the RGW core (so, not really plugins, but more of
a code separation).

However, the ceph automake structure doesn't use AM's subdir-objects
settings, which is causing me headaches. The reason: two 'plugins'
might share similar filenames in different subdirectories;

./src/rgw/plugins/example/plugin.cc
./src/rgw/plugins/hello_world/plugin.cc

Both of which, of course, gets compiled into radosgw-plugin.o because
of the absence of the subdir-objects setting. I can not circumvent
this by making it a library, because partially linking prevents me
from auto-registering the plugins in the RGW core. The only fix for
this is making the RGW core aware of the subdirs/plugins, but I think
that's nasty design. I'd like to have it in my make conf.

So, the question is; is there a reason why we don't use subdir objects?

Roald
