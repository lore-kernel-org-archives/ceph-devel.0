From: huang jun <hjwsm1989@gmail.com>
Subject: dnl status in mds rejoin operation
Date: Tue, 24 May 2011 16:32:09 +0800
Message-ID: <BANLkTikG1C1WDEvSmpA+QEaxvY-o5ruf1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59913 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab1EXIcL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 04:32:11 -0400
Received: by wwa36 with SMTP id 36so7056348wwa.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 01:32:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
   There is an assert(dnl->is_primary()) in function "rejoin_walk()".
why should the dnl must be primary if we want to  continue rejoin
operation? or the assert() crashed.
   I want to know whether the status of the replica subtree root
directory's dentry should be primary?
   And  we assume one dentry in directory is a remote link ,then place
this dentry in a fragment, can we create the replicas of this fragment
in other MDSs?




thanks!
