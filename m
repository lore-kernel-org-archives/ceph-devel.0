From: Sage Weil <sweil@redhat.com>
Subject: mgr interface for OSDMap
Date: Tue, 11 Jul 2017 03:27:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707110238540.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755073AbdGKD1P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Jul 2017 23:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3050B80C03
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 03:27:15 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jspray@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey John, can you take a quick look at

	https://github.com/ceph/ceph/pull/16250

and let me know if I'm on the right track?  This successfully gets the 
epoch, so it seems to be basically working.  I didn't the dtor called, 
which makes me a bit suspicious, but otherwise it seems to work fine.  
(Lazy gc?)

It seems a bit weird that all methods are static and we don't use the 
PyObject *self... and instead pass around the _handle value explicitly as 
an argument.  Is that just how it is?  The examples I see seem to all be 
static as well.

The plan is to wrap enough of OSDMap and CrushWrapper that a mgr module 
can exercise the upmap optimizer code and/or make CRUSH changes to run 
Loic's gradient optimization...

Thanks!
sage
