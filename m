From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: puzzling ceph with systemd boot sequence error
Date: Wed, 30 Nov 2016 22:52:06 +0100
Message-ID: <0ccaee79-81df-c656-c045-9eb2b87d203f@suse.cz>
References: <348e1d53-2195-2e43-bc89-ce1788cc3700@dachary.org>
 <b853373c-5490-ff27-2283-e3c0d36b1060@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52573 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755593AbcK3VwJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 16:52:09 -0500
In-Reply-To: <b853373c-5490-ff27-2283-e3c0d36b1060@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

> * ERROR: unable to open OSD superblock on /var/lib/ceph/osd/XXXX-0: (2) No such file or directory
>
> does not mean /var/lib/ceph/osd/XXXX-0 does not exist. It means files within /var/lib/ceph/osd/XXXX-0 do not exist. It would be clearer if the path of the missing file name was displayed instead of the directory [1].

Right. It means the OSD data device (partition) has not been mounted. 
/var/lib/ceph/osd/XXXX-0 is just the mount point for that device.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
