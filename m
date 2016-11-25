From: Nathan Cutler <ncutler@suse.cz>
Subject: What is XFS/filesystem corruption and whose fault is it?
Date: Fri, 25 Nov 2016 17:26:07 +0100
Message-ID: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33493 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755609AbcKYQk5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 25 Nov 2016 11:40:57 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E608DAAD0
        for <ceph-devel@vger.kernel.org>; Fri, 25 Nov 2016 16:26:07 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've been doing some research on OSDs not starting after power outages, 
when supposedly "uncorruptible" XFS filesystems are corrupted and need 
repair. This led me to write the following brief blog post:

http://smithfarm-thebrain.blogspot.cz/2016/11/what-is-xfsfilesystem-corruption-and.html

Any comments and/or suggestions for improvement would be most welcome.

Thanks for reading!

Nathan
