From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Luminous 12.1.3 upgrade mgr nits
Date: Sat, 12 Aug 2017 12:22:11 +1200
Message-ID: <c7dc985e-0df7-cf4c-577e-255e94315ba0@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:42468
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751233AbdHLAWP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Aug 2017 20:22:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTP id E043980891
        for <ceph-devel@vger.kernel.org>; Sat, 12 Aug 2017 12:22:13 +1200 (NZST)
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([127.0.0.1])
        by localhost (cat-porwal-prod-mail1.servers.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TCFUJzy1gQpq for <ceph-devel@vger.kernel.org>;
        Sat, 12 Aug 2017 12:22:11 +1200 (NZST)
Received: from [IPv6:2406:e001:930:1:7924:2441:2286:f83f] (unknown [IPv6:2406:e001:930:1:7924:2441:2286:f83f])
        (Authenticated sender: mark.kirkwood@catalyst.net.nz)
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id B7276807D6
        for <ceph-devel@vger.kernel.org>; Sat, 12 Aug 2017 12:22:11 +1200 (NZST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Just had a go at this - 12.1.3 from a freshly deployed Jewel (10.2.9) on 
Ubuntu 16.04, following the notes in 
http://ceph.com/releases/v12-1-3-luminous-rc-released/

It all worked nicely *except* for the the mgr deploy (arrrg - again)! 
This time it is a new wrinkle, it appears that the bootstrap-mgr auth 
key does not match the on disk keyring:

markir@ceph0:~$ sudo cat /var/lib/ceph/bootstrap-mgr/ceph.keyring
[client.bootstrap-mgr]
         key = AQBWP45ZZVsOKRAAQoLg48bT6niU/dI8BmGqJQ==


markir@ceph0:~$ sudo ceph auth get client.bootstrap-mgr
exported keyring for client.bootstrap-mgr
[client.bootstrap-mgr]
         key = AQC7RY5ZsEHRKRAAOhUNB2rc8r/Xdg7xXIAteA==
         caps mon = "allow profile bootstrap-mgr"

Editing the on disk key to make it match the one 'ceph auth get' shows 
solves the problem, so pretty simple to work around - if you think to 
check that file and auth get for differences!

regards

Mark

