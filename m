From: Christian Brunner <chb@muc.de>
Subject: RBD write-performance
Date: Wed, 17 Aug 2011 13:25:44 +0200
Message-ID: <CAO47_-9r5BgLkcn2SWriS64P5FgkHrT4Oy1jZfN7s0c36O4zMA@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39170 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1HQLZp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 07:25:45 -0400
Received: by vxi9 with SMTP id 9so754580vxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2011 04:25:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We are using ceph exclusively as a storage backend for our KVM-hosting
environment. The number of virtual machines has increased now, but the
machines are idle most of the time. However the OSes of the VMs tend
to do regular small writes on the disks (I suspect journal commits).

As we don't have a lot of disks (only 16 at the moment), this adds up
to a high number of write IOPS on the OSD disks with a negligible
throughput.

What we have in our OSDs are very fast SSD-disks for the ceph journal
and I wonder if it would be possible, to delay writes on the disks,
until a number of IOPS has been collected in the journal. I think this
would improve the situation a lot.

Are there any tuning parameters we could use? What would be your suggestion?

Thanks,
Christian
