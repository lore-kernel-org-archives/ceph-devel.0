From: Sage Weil <sweil@redhat.com>
Subject: killing ceph-rest-api
Date: Fri, 2 Feb 2018 21:19:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802022117010.22482@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeBBVTh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:19:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00B144A6EA
        for <ceph-devel@vger.kernel.org>; Fri,  2 Feb 2018 21:19:37 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dmick@redhat.com, jspray@redhat.com

This has come up several times but it's not dead yet.

I see two options:

1- Add a mon command passthrough to restful.  John has expressed 
reservations about this in the past as it is too tempting to use.  On the 
other hand, I suspect there will always be a need for things to do 
"low-level" mon commands for unusual cases, and having a way to 
do that without shelling out or creating a librados session seems useful.

2- Transpant ceph-rest-api into a mgr module.  This probably requires a 
bit more work but would keep it as a separate thing from the curated 
restful.

Thoughts?
sage


