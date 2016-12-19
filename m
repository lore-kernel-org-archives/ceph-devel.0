From: Brad Hubbard <bhubbard@redhat.com>
Subject: Status of static analysis
Date: Mon, 19 Dec 2016 12:45:54 +1000
Message-ID: <20161219024554.GA6396@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34388 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbcLSCqI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2016 21:46:08 -0500
Received: by mail-pg0-f45.google.com with SMTP id y62so2950837pgy.1
        for <ceph-devel@vger.kernel.org>; Sun, 18 Dec 2016 18:46:08 -0800 (PST)
Received: from rskikr.localdomain (CPE-121-215-241-179.static.qld.bigpond.net.au. [121.215.241.179])
        by smtp.gmail.com with ESMTPSA id 16sm26751797pfy.4.2016.12.18.18.46.01
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Dec 2016 18:46:06 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

As you would have noticed in recent weeks we have returned to  running a
Coverity test over the source tree on a weekly basis. In addition, I have been
running Clang Static Analyzer and Cppcheck scans. Until we can find a better
home for these and include at least one of them in our CI processes I will be
hosting them at http://people.redhat.com/bhubbard/

-- 
Cheers,
Brad
