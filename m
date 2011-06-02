From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: ceph_tool_common_init failed
Date: Thu, 2 Jun 2011 08:45:16 -0700
Message-ID: <BANLkTimK72kHioovQ=9Jaz0neiBzq+5LNQ@mail.gmail.com>
References: <BANLkTinhA3T3F3+ocVrr9vzckJoWZRtXZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41834 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab1FBPpT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 11:45:19 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 685CAC81C
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jun 2011 08:45:18 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 18EDEC0D3
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jun 2011 08:45:17 -0700 (PDT)
Received: by eyx24 with SMTP id 24so321071eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2011 08:45:16 -0700 (PDT)
In-Reply-To: <BANLkTinhA3T3F3+ocVrr9vzckJoWZRtXZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/6/2 biyan chen <riby.chen@gmail.com>:
> 2011-06-02 16:27:35.010776 7f3f53940720 unable to authenticate as client.admin

That's your problem. You don't have your keys set up properly to
authenticate as the admin on those nodes. :)

I suspect permissions problems are the cause of your other issues with
file writing as well. How did you set up this cluster? Try recreating
your cluster by carefully following the instructions at
http://ceph.newdream.net/wiki/Creating_a_new_file_system
-Greg
