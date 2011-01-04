From: Roland Rabben <roland@jotta.no>
Subject: CEPH production readyness
Date: Tue, 4 Jan 2011 19:02:20 +0100
Message-ID: <AANLkTi=JGqKApqpJJCf_ejxiA=F1VZ2eNxr7ANxxSRgN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64237 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1ADSCV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 13:02:21 -0500
Received: by qyj19 with SMTP id 19so17276421qyj.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 10:02:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I have been following your project for a long time and it looks like
Ceph is getting closer to release 1.0. Are you planning on calling
version 1.0 "production ready"?

We have been holding off on testing Ceph in depth, but it looks like
we should start now that a stable production ready release is in
sight. For this I have a few questions that I am hoping the community
can answer before we start testing.

Once I have a Ceph distributed file system up and running, what is the
procedure to scale / increase total storage capacity? Any downtime
necessary for this?
Do I need to move any data around or "rebalance" data when I add new
storage nodes? (This  is a huge problem with eg. Glusterfs)
What are the expected and common maintenance tasks that are Ceph specific?

We are really keen on using Ceph in our production environment and
really looking forward to release 1.0.

Great job guys!

Best regards

Roland Rabben
Founder & CEO Jotta AS
Cell: +47 90 85 85 39
Phone: +47 21 04 29 00
Email: roland@jotta.no
