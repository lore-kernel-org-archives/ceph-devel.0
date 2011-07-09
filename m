From: Vineet Jain <vinjvinj@gmail.com>
Subject: Struggling with mds. It seems very fragile.
Date: Fri, 8 Jul 2011 23:39:15 -0400
Message-ID: <CAG_bnfw72QOihdK9UWg5wbVht2dmO7-dJQCsFUAuESo=YNbrTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43074 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab1GIDjR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 23:39:17 -0400
Received: by bwd5 with SMTP id 5so2150475bwd.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2011 20:39:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Using ceph version 0.3 and the ceph kernel that comes with ubuntu 11.04.

I've setup 5 osds and one one mon and mds on one machine. When I first
started, without writing any data to the ceph fs my mds would keep
crashing. I fixed that problem by deleting the mod data directory and
the ceph data directories and restarting ceph. I then started copying
test data from a 2tb external drive to my ceph fs. I left my computer
and came back and could not login to my machine. I saw that the
external drive light was blinking so something was going on. I did a
hard power off thinking I would just delete the last file that was
copied over and start over.

As expected, I could not start up ceph again. I had to delete all the
data directories again to get ceph up again. Is there any way to flush
whatever to get ceph back to some sort of stage where you can enter
back into the fs without having to purge everything a start over?
