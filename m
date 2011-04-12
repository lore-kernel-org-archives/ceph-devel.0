From: Sylar Shen <kimulaaa@gmail.com>
Subject: The cache problem of re-export NFS test
Date: Tue, 12 Apr 2011 22:57:22 +0800
Message-ID: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53470 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab1DLO5X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 10:57:23 -0400
Received: by bwz15 with SMTP id 15so5432899bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 07:57:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi developers,
I know that the following question may not be relative to Ceph but
this confuses me a lot.
I am testing the function of re-exporting nfs by command "dd" without
using buffer.
That means I would like my data to be written to Ceph DFS directly
without passing by the buffer of client or nfs-client.
Here is my test architecture. Hope you could understand what I am
trying to express.....:p
------------------------------------------------------------------------------
                   nfs                             ceph protocol
Client <------------>Ceph-Client <-------------------> Ceph DFS
------------------------------------------------------------------------------
I used the command "dd if=/dev/zero of=/mnt/ceph/test bs=64k
count=10000 oflag=dsync"
My purpose was to write the data from the client to Ceph DFS through
Ceph-client.
Ceph DFS was mounted by Ceph-client using Ceph protocol and
Ceph-client was mounted by client using nfs protocol.
I know that my dd command with argument oflag=dsync would write the
data to Ceph-client without using buffer on the client.
But I want my Ceph-client could also just pass the data to Ceph DFS
without using its buffer.
So.....is there any way I can run my scenario?
Or in other words, is there any method I can assure that Ceph-client
won't do the buffer task itself?
Thank you~~
-- 
Best Regards,
Sylar Shen
