From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: [ceph-users] Inherent insecurity of OSD daemons when using only
 a "public network"
Date: Fri, 13 Jan 2017 09:32:29 +0100
Message-ID: <591750c9-2ac5-d995-7f95-a045e0ad7b9f@digiware.nl>
References: <20170113170713.12837f19@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:30961 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbdAMIdE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 13 Jan 2017 03:33:04 -0500
In-Reply-To: <20170113170713.12837f19@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, chibi@gol.com

Hi,

This is an observation on the user-list.
And I do agree with it whole hartedly.

And it stems from the first binding where 0.0.0.0 is used to bind.
From the top of my head somewhere in msg/async. It starts out with
0.0.0.0 but on rebinds it binds to an actual ipnr.

If the idea here is that we need to bind to either private/public IP, I
can look into that.

--WjW


-------- Forwarded Message --------
Subject: [ceph-users] Inherent insecurity of OSD daemons when using only
a "public network"
Date: Fri, 13 Jan 2017 17:07:13 +0900
From: Christian Balzer <chibi@gol.com>
Organization: FusionGOL
To: ceph-users <ceph-users@lists.ceph.com>


Hello,

Something I came across a while agao, but the recent discussion here
jolted my memory.

If you have a cluster configured with just a "public network" and that
network being in RFC space like 10.0.0.0/8, you'd think you'd be "safe",
wouldn't you?

Alas you're not:
---
root@ceph-01:~# netstat -atn |grep LIST |grep 68
tcp        0      0 0.0.0.0:6813            0.0.0.0:*
LISTEN     tcp        0      0 0.0.0.0:6814            0.0.0.0:*
      LISTEN     tcp        0      0 10.0.0.11:6815          0.0.0.0:*
            LISTEN     tcp        0      0 10.0.0.11:6800
0.0.0.0:*               LISTEN     tcp        0      0 0.0.0.0:6801
      0.0.0.0:*               LISTEN     tcp        0      0
0.0.0.0:6802            0.0.0.0:*               LISTEN     etc..
---

Something that people most certainly would NOT expect to be the default
behavior.

Solution, define a complete redundant "cluster network" that's identical
to the public one and voila:
---
root@ceph-02:~# netstat -atn |grep LIST |grep 68
tcp        0      0 10.0.0.12:6816          0.0.0.0:*
LISTEN     tcp        0      0 10.0.0.12:6817          0.0.0.0:*
      LISTEN     tcp        0      0 10.0.0.12:6818          0.0.0.0:*
            LISTEN     etc.
---

I'd call that a security bug, simply because any other daemon on the
planet will bloody bind to the IP it's been told to in its respective
configuration.

The above is with Hammer, any version.

Christian
-- 
Christian Balzer        Network/Systems Engineer
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
