From: John Axel Eriksson <john@insane.se>
Subject: cephx auth question
Date: Tue, 12 Jun 2012 11:31:59 +0200
Message-ID: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40163 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2FLJcA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 05:32:00 -0400
Received: by yenm10 with SMTP id m10so3215721yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 02:31:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I asked a similar question in a previous email but I didn't get any
satisfying answers. What exactly does cephx auth secure?
From the wiki I just get "this makes your cluster more secure", well
from what? If I run on an internal network accessible only
by a few trusted people - what does cephx auth secure in such a scenario?

In that previous email I got the answer that it secures the cluster
from mistakenly connecting to wrong cluster with rados and
accidentally deleting a pool... well, can rados really "accidentally"
connect to the wrong cluster? Only if I have the wrong config
file right? And if I have the wrong config-file won't it be possible
that I also have the "wrong" key in that case?

Another scenario would be if I take down an OSD that just sits in
storage for say 6 months and then someone starts that machine
again - with key-based auth that OSD wouldn't be able to
connect(somehow? but if it has a working key?) but without auth it
could
possibly connect and wreak havoc in the cluster (since it is so much
behind perhaps in both version of software and what's stored on it).
I thought marking and OSD as down or out would do that?

Are those the main reasons for having cephx auth? Is it to secure the
cluster against people (myself included) making mistakes or  from
hacking, or is there some technical reason that I don't know of or understand?

The reason I'm asking is because having cephx enabled makes cluster
setup much more complicated...


Thanks,

John
