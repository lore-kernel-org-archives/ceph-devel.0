From: Wido den Hollander <wido@42on.com>
Subject: BlueStore and maximum number of objects per PG
Date: Tue, 21 Feb 2017 21:04:32 +0100 (CET)
Message-ID: <1002796178.10638.1487707472256@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:35616 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753998AbdBUUEh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2017 15:04:37 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 79E503FE4F
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2017 21:04:32 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm about to start a test where I'll be putting a lot of objects into BlueStore and see how it holds.

The reasoning behind is that I have a customer which has 165M objects in it's cluster which results in some PGs having 900k objects.

For FileStore with XFS this is quite heavy. A simple scrub takes ages.

The problem is that we can't simply increase the number of PGs since that will overload the OSDs as well.

On the other hand we could add hardware, but that also takes time.

So just for the sake of testing I'm looking at trying to replicate this situation using BlueStore from master.

Is there anything I should take into account? I'll probably be just creating a lot (millions) of 100 byte objects in the cluster with just a few PGs.

Wido
