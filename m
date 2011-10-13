From: huang jun <hjwsm1989@gmail.com>
Subject: [patch] build ceph without using btrfs
Date: Thu, 13 Oct 2011 20:52:35 +0800
Message-ID: <CABAwU-afkv_2HXNpoUKii9yCSZ9eqAYWVzpddPKwJfKHuSi6HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39902 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab1JMMwg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2011 08:52:36 -0400
Received: by vws1 with SMTP id 1so1224248vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2011 05:52:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

If we build the ceph cluster without using btrfs, it returns error if
the osd_data and mon_data directory doesn't exist.
diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 0d86c75..5bb94ae 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -246,6 +246,8 @@ if [ -n "$initdaemon" ]; then
     name="$type.$id"

     if [ $type = "osd" ]; then
+       get_conf osd_data "" "osd data"
+       test -d $osd_data || mkdir -p $osd_data
        $BINDIR/cosd -c $conf --monmap $dir/monmap -i $id --mkfs
        create_private_key
     fi
@@ -255,6 +257,8 @@ if [ -n "$initdaemon" ]; then
     fi

     if [ $type = "mon" ]; then
+       get_conf mon_data "" "mon data"
+       test -d $mon_data || mkdir -p $mon_data
        $BINDIR/cmon -c $conf --mkfs -i $id --monmap $dir/monmap
--osdmap $dir/osdmap -k $dir/keyring.mon
     fi
