From: Gary Lowell <gary.lowell@inktank.com>
Subject: Review request  branch wip-3768  remove perl dependency
Date: Mon, 4 Feb 2013 17:35:50 -0800
Message-ID: <F40EEEA9-2D0B-41E3-8C5A-D84AADFFED88@inktank.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:62116 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3BEBfz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 20:35:55 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2888952dak.16
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 17:35:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi -

This is a relatively small change but involves changing a perl regex to sed:

diff --git a/src/logrotate.conf b/src/logrotate.conf
index 9af3104..0a4a5a2 100644
--- a/src/logrotate.conf
+++ b/src/logrotate.conf
@@ -15,7 +15,7 @@
             #   https://bugs.launchpad.net/upstart/+bug/1012938
             for type in mon osd mds; do
                initctl list \
-                   | perl -ne 'print "$+{service} cluster=$+{cluster} id=$+{id}\n" if m{^(?<service>ceph-(mon|osd|mds)+)\s+\((?<cluster>[^/)]+)/(?<id>[^)]+)\) start/}' \
+                   | sed -n 's/^\(ceph-\(mon\|osd\|mds\)\+\)[ \t]\+(\([^ \/]\+\)\/\([^ \/]\+\))[ \t]\+start\/.*$/\1 cluster=\3 id=\4/p' \
                    | while read l; do
                    initctl reload -- $l 2>/dev/null || :


I'd really appreciate any feedback on the new sed regex.  Also, I suspect that the for loop is not needed any longer since type is unused.

Thanks
Gary

