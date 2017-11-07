From: Jan Fajerski <jfajerski@suse.com>
Subject: decompiled crushmap device list after removing osd
Date: Tue, 7 Nov 2017 15:46:58 +0100
Message-ID: <20171107144658.crbrv6sxidvyuay2@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:52177 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdKGOrW (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 7 Nov 2017 09:47:22 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I noticed some weird behaviour of crushtool when decompiling a map after an osd 
has been removed. Say I have a cluster with 4 osds. When I remove osd.2, get and 
decompile the crushmap, I get this device list in the crushmap:

# devices
device 0 osd.0 class hdd
device 1 osd.1 class hdd
device 2 device2
device 3 osd.3 class hdd

I'd appreciate some info on whether this is intended behaviour and what the 
reasoning is. I'd expect the map not to list id 2 at all and afaict the crushmap 
doesn't contain the id anymore. If there is no reason for listing that I'd be 
happy to make a PR.

Best,
Jan

