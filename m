From: huang jun <hjwsm1989@gmail.com>
Subject: osd_journal error in mkbsdocfs.in
Date: Tue, 5 Jul 2011 08:54:57 +0800
Message-ID: <CABAwU-ZK8Z4eJT9G4jWz1DCxFTfQOKfEvqGkeeg18VfOGp_VRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51258 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1GEAy7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 20:54:59 -0400
Received: by wyg8 with SMTP id 8so3679354wyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 17:54:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
I test ceph v0.30 without osd_journal, but i cannot set up  the
cluster successful,
it shows :
2011-07-05 08:10:54.874622   mds e14: 1/1/1 up {0=0=up:replay}, 1 up:standby
2011-07-05 08:10:54.874655   osd e22: 3 osds: 0 up, 0 in
the output is :
=== osd.0 ===
dirname: missing operand
Try `dirname --help' for more information.
mkdir: missing operand
Try `mkdir --help' for more information.
failed: '/usr/sbin/mkcephfs -d /tmp/mkcephfs.NUxYzZlZQT --prepare-osdfs osd.0'

use bashdb to debug, i find something wrong with this in mkcephfs.in :
[ -n "$osd_journal" ] && test -d $osd_journal || mkdir -p `dirname $osd_journal`

i instead it by :
  if [ -n "$osd_journal" ] ; then
    	test -d $osd_journal || mkdir -p `dirname $osd_journal`
    fi
everything works fine

you know, not all people use osd_journal

thanks
