From: Sage Weil <sweil@redhat.com>
Subject: boost submodule update
Date: Thu, 29 Sep 2016 16:00:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbcI2QAI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Sep 2016 12:00:08 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCD8BC09219A
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 16:00:07 +0000 (UTC)
Received: from ovpn-112-101.phx2.redhat.com (ovpn-112-101.phx2.redhat.com [10.3.112.101])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8TG05JV015173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 12:00:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

Matt has a working boost submodule branch ready; I've pushed it to 
wip-boost in ceph.git to ensure the gitbuilders are happy and tagged it 
needs-qa.

Just so there are no surprises:

 * This change increases the initial checkout + clone time by about 
**three minutes**.  Boost is structured as several dozen submodules and it 
takes a while to clone them all.  It's painful on the first checkout, but 
fine after that.  This pain only applies to developers.

 * We are using boost 1.61 + a few things.  There are still some 
outstanding warnings.  They appear to be issues in boost 1.61 itself, and 
do not appear to be significant.  (And the warnings are in parts of boost 
we're not using yet: asio and serialization.)

 * There is still the option to use a system boost via a cmake option.  I 
doubt anyone will opt for this in practice given the distros tend to lag, 
but they can if they want.

sage
