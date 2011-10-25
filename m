From: Christian Brunner <chb@muc.de>
Subject: PG stuck in scrubbing
Date: Tue, 25 Oct 2011 14:13:29 +0200
Message-ID: <CAO47_-_N3iP0ShdPi0Q_KcX80P=CU3bJz14uuxjCaWgotKNDdA@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43511 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab1JYMN3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2011 08:13:29 -0400
Received: by vcge1 with SMTP id e1so340778vcg.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Oct 2011 05:13:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here is another problem I've seen. Unfortunatly I do not have any
debug output and it's not reproduceable.

While removing an image with "rbd rm" I noticed that rbd stopped
making progress. When I looked with "ceph -w" I saw a PG, that was in
state "active+clean+scrubbing":

2011-10-25 14:01:34.198961    pg v1215175: 2776 pgs: 2775
active+clean, 1 active+clean+scrubbing; 3000 GB data, 1658 GB used,
56737 GB / 59615 GB avail

This state didn't change for half an hour, so I decided to look which
OSD is involved

pg_stat objects mip     degr    unf     kb      bytes   log
disklog state   v       reported        up      acting  last_scrub
2.163   773     0       0       0       3162113 3238002800      1917
 1917    active+clean+scrubbing  2626'7909       2597'10775
[11,7]       [11,7]  2613'7708       2011-10-24 11:54:39.890963

and I restared OSD 11. After that everything went back to normal - the
"rbd rm" finished and scrubbing continued on other PGs. Doing a manual
scrub on 2.163 is fine, too.

Regards,
Christian
