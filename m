From: Sage Weil <sweil@redhat.com>
Subject: new release manager
Date: Thu, 8 Sep 2016 13:47:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609081328030.32742@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbcIHNr1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 09:47:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@ceph.com

Hi everyone,

A key role that we've had a hard time staying on top of is that of release 
manager.  Getting releases tagged, built, and published has been done on a 
pretty ad hoc basis without much in the way of central coordination or a 
schedule or much else.  The dev checkpoint releases we used to do on a 
regular basis have mostly stopped entirely because we get busy with other 
things and either forget or don't have the time.

The situation improved dramatically when Loic organized a group of 
contributors to work on handling backports of bug fixes to stable releases 
and created and documented a repeatable and scalable process.  Even so, 
releases themselves have remained a pain point.

Abhishek Lekshman (of SUSE) has offered to take on a release manager role 
to coordinate our efforts.  Yay!  This will include

 - deciding when to do a stable release (a combination of regular cadence 
and expedited releases due to critical bugs)
 - working with the backports team to ensure backports land and are 
tested in time for a stable release
 - working with dev leads for their sign-off on releases
 - periodic dev checkpoint releases off of master
 - driving the mechanics of the release itself (the new build/release 
infrastructure that Alfredo and team have been working on)
 - release announcements (email + blog)

although I'm sure the role will evolve as we go.  :)

We've just ripped the last vestiges of autotools out of the master branch, 
so one of the first projects will be to kick the tires on the new build 
infrastructure with a dev release off of master that is 100% cmake.

Thanks, Abhishek!
sage

