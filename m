From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Review request: wip-localized-read-tests
Date: Fri, 30 Nov 2012 14:56:08 -0800
Message-ID: <CAPrxi5-rvMZ1_+RAfYoiifKCcOvUKgiLaKd9N_ZGrGGn3zuuUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54913 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab2K3W4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 17:56:09 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so185395vcd.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 14:56:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

I've pushed up patches for the first phase of testing read from
replica functionality, which looks only at objecter/client level ops:

   wip-localized-read-tests

The major points are:

  1. Run libcephfs tests w/ and w/o localized reads enabled
  2. Add the performance counter in Objecter to record ops sent to replica
  3. Add performance counter accessor in unit tests

Locally I have verified that the performance counters are working with
a 3 OSD setup, although there are not yet any unit tests that try to
specifically assert a positive value on the counters.

Thanks,
Noah
