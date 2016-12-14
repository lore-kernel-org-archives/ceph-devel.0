From: Sage Weil <sage@newdream.net>
Subject: Re: how to use teuthology-suite in the new world
Date: Wed, 14 Dec 2016 22:27:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612142227300.10615@piezo.novalocal>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40305 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933070AbcLNW1v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 17:27:51 -0500
In-Reply-To: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, "sepia@ceph.com" <sepia@ceph.com>

On Wed, 14 Dec 2016, Sage Weil wrote:
> Please read carefully if you use teuthology:
> 
> ceph-qa-suite.git is no more.  All tests are now in qa/tasks, qa/suite, 
                                                     ^ ceph.git
> and so on.  The directory structure is the same (but now prefixed with 
> qa/) and the git history is intact.
