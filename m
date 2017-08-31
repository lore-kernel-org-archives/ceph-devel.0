From: Mark Meyers <MarkMeyers.MMY@gmail.com>
Subject: a metadata lost problem when mds breaks down
Date: Thu, 31 Aug 2017 15:02:03 +0000 (UTC)
Message-ID: <1228685801.457671.1504191723500@mail.yahoo.com>
References: <1228685801.457671.1504191723500.ref@mail.yahoo.com>
Reply-To: Mark Meyers <MarkMeyers.MMY@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sonic313-37.consmr.mail.ne1.yahoo.com ([66.163.185.60]:33766
        "EHLO sonic313-37.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751011AbdHaPJq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 31 Aug 2017 11:09:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@ceph.com" <ceph-users@ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi:

        I encountered a metadata lost problem of files when testing the outcome of ceph mds's unpredictable breakdown. 
        The test shell script is like(not real code):

        while i < 100000
        do 
            touch $i
            i++
        done
        echo c > /proc/sysrq-trigger

        The script is run in the same machine which mds is running on, and the directory is mount point of cephfs. 
        I created 10,000 files using touch command and forced the system to break down.
        When the machine rebooted again, the number of new files created is smaller than 10000. So the metadata of those files are lost.
        My question: Are those losts of metadata allowed by ceph? Or is this a bug of ceph mds which could be solved in the future? My ceph version is 12.1.0, ubuntu kernel version 4.4.0.
        
        Thanks for your reading, I really appreciate your rely. Thanks!
