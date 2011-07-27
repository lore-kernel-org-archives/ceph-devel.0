From: Christian Brunner <chb@muc.de>
Subject: Filesystems for ceph
Date: Wed, 27 Jul 2011 19:52:45 +0200
Message-ID: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48741 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab1G0Rwq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 13:52:46 -0400
Received: by vxh35 with SMTP id 35so1320676vxh.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 10:52:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We are having quite some problems with the underlying filesystem for
the cosd's and I would like to hear about other experiences. Here is
what we have gone through so far:

btrfs with 2.6.38:

- good performance
- frequently hitting of various BUG_ON conditions

btrfs with 2.6.39:

- big performance problems after a few days uptime
- occasionally hitting BUG_ON conditions

btrfs with 3.0:

- big performance problems after a few days uptime
- occasionally hitting a deadlock in the btrfs filesystem (cosd is in D-state)

ext4 with a RHEL6.0 kernel (don't remember exactly):

- almost immediate blowup of the kernel (OOPS)

From what I read in Fyodors emails ext4 in 2.6.39 isn't much better.

So, what filesystem would you recommend?

Thanks,
Christian
