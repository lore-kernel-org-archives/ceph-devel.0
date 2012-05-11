From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: OSD Journal Failure Behavior
Date: Fri, 11 May 2012 12:31:50 -0600
Message-ID: <CADxhoDTd9Jm6xixSqkCmxx8+bj_OSarJ8J_aYm6ycJzH7gHq4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43008 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161018Ab2EKSbv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 May 2012 14:31:51 -0400
Received: by wibhm4 with SMTP id hm4so1750427wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 May 2012 11:31:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The Ceph Wiki (http://ceph.com/wiki/OSD_journal) does a pretty good
job explaining the purpose of the journal and various modes available.
 What isn't clear is what happens during the failure of a journal.

With the use of btrfs enabling parallel journaling, it sounds like
failure of a journal device would still enable OSD writes to occur
albeit at a slower pace.  In writeahead mode, failure of the journal
seems like it would take all OSDs using that device for journaling
offline.

Is this a correct assessment?  If the journal is a single point of
failure to a system with potentially multiple OSDs ... it might be
worth mentioning in one of the "building a cluster" or hardware pages
about journal redundancy.

Also, it would be nice to know what steps are required to replace a
journal.  (I think this is just an update of the cluster.conf with the
new journal device and a restart of the OSD process, correct?)

Best regards,
Calvin
