From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: ceph caps (Ganesha + Ceph pnfs)
Date: Fri, 4 Jan 2013 19:51:34 -0500 (EST)
Message-ID: <849744156.177.1357347094206.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <681824234.175.1357346630910.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1524 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963Ab3AEA6H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 19:58:07 -0500
In-Reply-To: <681824234.175.1357346630910.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>

Hi Ceph folks,

Summarizing from Ceph IRC discussion by request, I'm one of the developers of a pNFS (parallel nfs) implementation that is built atop the Ceph system.

I'm working on code that wants to use the Ceph caps system to control and sequence i/o operations and file metadata, for example, so that ordinary Ceph clients see a coherent view of the objects being exported via pNFS.

The basic pNFS model (sorry for those who know all this, RFC 5661, etc) is to extend NFSv4 with a distributed/parallel access model.  To do parallel access in pNFS, the NFS client gets a `layout` from an NFS metadata (MDS) server.  A layout is a recallable object, a bit like an oplock/delegation/DCE token, see spec, it basically presents a list of subordinate data servers (DSes) on which to read and/or write regions of a specific file.

Ok, so in our implementation, we would typically expect to have a DS server collocated with each Ceph OSD.  When an NFS client has a layout on a given inode, its i/o requests will be performed "directly" by the appropriate OSD.  When an MDS is asked to issue a layout on a file, it should hold a cap or caps which ensure the layout will not conflict with other Ceph clients and ensure the MDS will be notified when it must recall the layout later if other clients attempt conflicting operations.  In turn, involved DS servers need the correct caps to read and/or write the data, plus, they need to update file metadata periodically.  (This can be upon a final commit of the client's layout, or inline with a write operation, if the client specifies the write be 'sync' stability.)

The current set of behaviors we're modeling are:

a) allow MDS to hold a Ceph caps, tracking issued pNFS layouts, such that it will be able to handle events which should trigger layout recalls at its pNFS clients (e.g., on conflicts)--currently we it holds CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD

b) on a given DS, we currently get CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD caps when asked to perform i/o on behalf of a valid layout--but we need to update metadata (size, mtime) and my question in IRC was cross checking these capabilities as correct to send an update message

In the current pass I'm trying to clean up/refine the model implementation, leaving some room for adjustment.

Thanks!

Matt

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
