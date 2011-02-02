From: Brian Chrisman <brchrisman@gmail.com>
Subject: NFS stale filehandles
Date: Wed, 2 Feb 2011 10:52:02 -0800
Message-ID: <AANLkTi=-oE5r54Km5HNCS5zL9FXSedfb=NDO4RbLsn-y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47675 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab1BBSwD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 13:52:03 -0500
Received: by qyj19 with SMTP id 19so6408512qyj.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 10:52:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

There seems to be a bug in the ceph kernel client NFS implementation.
Triage:  using the same cluster/servers and client
1) export ceph filesystem via NFS, mount on client, copy over files
and build --> stale filehandle/corruption issues
2) export ext filesystem via NFS (same server node as in #1), mount on
client, copy over files and build --> no problem
3) mount ceph locally on build client, copy over files and build --> no problem

From this, it seems most likely that the problem lies in the kernel
client NFS export code.

Kernel 2.6.37rc8
Mounting via NFSv4 (noticed other issues with directories disappearing
when previously testing with NFSv3 that I can retest after figuring
this out)
Other than kernel, systems are a rhel6 beta distro
I wanted to check whether/what testing has been done of the export
code thus far, and see whether this is a known issue.
