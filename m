From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: [0.48.3] OSD memory leak when scrubbing
Date: Tue, 22 Jan 2013 21:01:30 +0100
Message-ID: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:55785 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab3AVUBb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 15:01:31 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so7328535obb.7
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 12:01:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Since I have ceph in prod, I experienced a memory leak in the OSD
forcing to restart them every 5 or 6 days. Without that the OSD
process just grows infinitely and eventually gets killed by the OOM
killer. (To make sure it wasn't "legitimate", I left one grow up to 4G
or RSS ...).

Here's for example the RSS usage of the 12 OSDs process
http://i.imgur.com/ZJxyldq.png during a few hours.

What I've just noticed is that if I look at the logs of the osd
process right when it grows, I can see it's scrubbing PGs from pool
#3. When scrubbing PGs from other pools, nothing really happens memory
wise.

Pool #3 is the pool where I have all the RBD images for the VMs and so
have a bunch of small read/write/modify. The other pools are used by
RGW for object storage and are mostly write-once,read-many-times of
relatively large objects.

I'm planning to upgrade to 0.56.1 this week end and I was hoping to
see if someone knew if that issue had been fixed with the scrubbing
code ?

I've seen other posts about memory leaks but at the time, it wasn't
confirmed what was the source. Here I clearly see it's the scrubbing
on pools that have RBD image.

Cheers,

      Sylvain
