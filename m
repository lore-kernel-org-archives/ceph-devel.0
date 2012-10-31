From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: OSD sizes
Date: Wed, 31 Oct 2012 23:13:46 +0100
Message-ID: <CAJH6TXhoJ9hGokHW3TCo9e1aob=X-=K6d7sdtmgR37xcLNuXXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61263 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab2JaWNs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 18:13:48 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so997632eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 15:13:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'll run a testbed environment made with 3 or 5 DELL R515 servers (12
disks each).
I have no 10gb ethernet but only multiple LACP (2 or 4 gigabit nic)
I'll have two different networks, one for sync, one for client access.

In this case, i think that smaller disks are better, because in case
of failure of a single osd/disk the sync time will be less than a
bigger disk.

For example 12 500GB disks instead 12 3TB disks (the space is not an
issue, actually)
