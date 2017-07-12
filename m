From: Sage Weil <sweil@redhat.com>
Subject: updating the documentation
Date: Wed, 12 Jul 2017 18:29:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707121823111.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbdGLSaB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 14:30:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@ceph.com

We have a fair-sized list of documentation items to update for the 
luminous release.  The other day when I starting looking through what is 
there now, though, I was also immediately struck by how out of date much 
of the content is.  In addition to addressing the immediate updates for 
luminous, I think we also need a systematic review of the current docs 
(including the information structure) and a coordinated effort to make 
updates and revisions.

First question is, of course: is anyone is interested in helping 
coordinate this effort?

In the meantime, we can also avoid making the problem worse by requiring 
that all pull requests include any relevant documentation updates.  This 
means (1) helping educate contributors that doc updates are needed, (2) 
helping maintainers and reviewers remember that doc updates are part of 
the merge criteria (it will likely take a bit of time before this is 
second nature), and (3) generally inducing developers to become aware of 
the documentation that exists so that they know what needs to be updated 
when they make a change.

Comments or concerns?

Thanks!
sage

