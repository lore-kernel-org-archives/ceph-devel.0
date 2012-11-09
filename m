From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: OSD hardware suggestion
Date: Fri, 9 Nov 2012 14:11:17 +0100
Message-ID: <CAJH6TXha_jTHocYATAHY_EYqo5zCT1rwtg9jxv6XkAg6mwPH-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39926 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab2KINLT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 08:11:19 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so1464227eaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 05:11:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Based on your experience, will the following configuration be ok for a
production cluster?
 - R515 12 disks + 2 internal disks

I'll start with 2x or 4x 2TB SATA disks in each R515. One OSD for each
disk, 3 servers.
Each R515 will have one internal SSD to be used as journal (single,
huge, filesystem) shared by all OSDs and one SATA 10k RPM (probably WD
Raptor) to be used as operating system and mons storage.

On each R515 i'll put OSDs and one mon node.

Actually, i'll use only RBD and RGW, so no need for MDS. When CephFS
will be stable, i'll put MDS on each node.

Any suggestion/advice ?
