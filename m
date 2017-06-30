From: Nathan Cutler <ncutler@suse.cz>
Subject: "Unix Domain socket path too long" failures in Jenkins make check
Date: Fri, 30 Jun 2017 23:08:02 +0200
Message-ID: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752995AbdF3VIE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Jun 2017 17:08:04 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F4ABAAB6
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 21:08:03 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ceph!

Now that 10.2.8 is finally in QE, I had planned to turn my attention to 
kraken 11.2.1. The first task is to get the backport PRs through "make 
check". This is proving more difficult than usual because most of the 
time the make check test fails due to the "Unix Domain socket path too 
long" error. This happens in jewel PRs, too, but the incidence in kraken 
PRs seems much higher.

Does the CI team have statistics on how many make check jobs are failing 
due to this bug?

Also, is my understanding correct that there is no way to get Jenkins to 
shorten the path?

Thanks,
Nathan
