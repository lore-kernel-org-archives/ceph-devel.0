From: Nathan Cutler <ncutler@suse.cz>
Subject: Are we ready for jewel 10.2.6?
Date: Wed, 1 Feb 2017 16:35:57 +0100
Message-ID: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39153 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751720AbdBAPgB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 10:36:01 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F232ABEA
        for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2017 15:35:59 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Abhishek:

The stable releases and backports team has been working to prepare the 
Jewel 10.2.6 release and so far we have merged a large number of 
bugfixes and even some features that were judged to be worth backporting.

I don't have a full list, yet, because I'm still merging RGW backports 
and there a few more miscellaneous backports still in the queue. The 
integration tests are looking better and better, and I expect these will 
be merged within the next week or two.

Do you think it's time to publish a 10.2.6 point release?

Nathan
