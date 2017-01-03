From: Casey Bodley <cbodley@redhat.com>
Subject: ceph-ci.git and pull requests
Date: Tue, 3 Jan 2017 12:23:58 -0500
Message-ID: <7ca73dab-23d4-6725-79d4-c3bac274dc3b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34141 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965312AbdACRar (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 12:30:47 -0500
Received: by mail-qt0-f171.google.com with SMTP id d45so246608607qta.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 09:30:47 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id z7sm44053356qkz.7.2017.01.03.09.23.59
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2017 09:23:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

I had pushed a branch to ceph/ceph-ci.git for testing, but was unable to 
open a pull request for it against ceph/ceph.git. The github ui wouldn't 
let me target branches in ceph-ci.git, presumably because it doesn't 
recognize it as a fork if ceph.git.

Has anyone else been able to figure this out?

Thanks,
Casey

