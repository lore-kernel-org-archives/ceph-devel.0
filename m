From: Florian Haas <florian@hastexo.com>
Subject: Setting a big maxosd kills all mons
Date: Thu, 5 Jul 2012 19:39:18 +0200
Message-ID: <CAPUexz9EHLsEvSCrw40U6L9zP=yWA6S81GCoeoBwXutPzxm9Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57996 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab2GERjU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 13:39:20 -0400
Received: by qcro28 with SMTP id o28so5012775qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 10:39:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi guys,

Someone I worked with today pointed me to a quick and easy way to
bring down an entire cluster, by making all mons kill themselves in
mass suicide:

ceph osd setmaxosd 2147483647
2012-07-05 16:29:41.893862 b5962b70  0 monclient: hunting for new mon

I don't know what the actual threshold is, but setting your maxosd to
any sufficiently big number should do it. I had hoped 2^31-1 would be
fine, but evidently it's not.

This is what's in the mon log -- the first line is obviously only on
the leader at the time of the command, the others are on all mons.

    -1> 2012-07-05 16:29:41.829470 b41a1b70  0 mon.daisy@0(leader) e1
handle_command mon_command(osd setmaxosd 2147483647 v 0) v1
     0> 2012-07-05 16:29:41.887590 b41a1b70 -1 *** Caught signal (Aborted) **
 in thread b41a1b70

 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
 1: /usr/bin/ceph-mon() [0x816f461]
 2: [0xb7738400]
 3: [0xb7738424]
 4: (gsignal()+0x51) [0xb731a781]
 5: (abort()+0x182) [0xb731dbb2]
 6: (__gnu_cxx::__verbose_terminate_handler()+0x14f) [0xb753b53f]
 7: (()+0xbd405) [0xb7539405]
 8: (()+0xbd442) [0xb7539442]
 9: (()+0xbd581) [0xb7539581]
 10: (()+0x11dea) [0xb7582dea]
 11: (tc_new()+0x26) [0xb75a1636]
 12: (std::vector<unsigned char, std::allocator<unsigned char>
>::_M_fill_insert(__gnu_cxx::__normal_iterator<unsigned char*,
std::vector<unsigned char, std::allocator<unsigned char> > >, unsigned
int, unsigned char const&)+0x79) [0x8185629]
 13: (OSDMap::set_max_osd(int)+0x497) [0x817c6b7]

From src/mon/OSDMonitor.cc:

      int newmax = atoi(m->cmd[2].c_str());
      if (newmax < osdmap.crush->get_max_devices()) {
        err = -ERANGE;
        ss << "cannot set max_osd to " << newmax << " which is < crush
max_devices "
           << osdmap.crush->get_max_devices();
        goto out;
      }

I think that counts as unchecked user input, or has cmd[2] been
sanitized at any time before it gets here?

Also, is there a way to recover from this, short of reinitializing all mons?

Cheers,
Florian
