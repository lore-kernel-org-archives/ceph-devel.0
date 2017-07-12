From: Dan Mick <dmick@redhat.com>
Subject: new ceph-mgr Python module notification types
Date: Tue, 11 Jul 2017 21:54:50 -0700
Message-ID: <66c05f35-b618-e490-a365-281aade8a755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbdGLEyv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 00:54:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0CCD285A6
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 04:54:50 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF3105D9C1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 04:54:50 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm considering adding a new notification type ("perf_schema_update"),
to be called from DaemonServer.cc.  The existing notify types are all
defined in Mgr.cc.  Should we try to collect them somewhere more global,
if only for reference's sake?

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
