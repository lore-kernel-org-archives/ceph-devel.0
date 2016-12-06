From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] Ceph RADOS cluster mutex helper for Samba CTDB
Date: Tue, 6 Dec 2016 13:14:04 +0100
Message-ID: <20161206131404.38f737d0@suse.de>
References: <20161201151715.019228c1@suse.de>
        <CAJ+X7mTkBLQDYb+r9LELQe-sqfG_4YkQ9HbkDFAp70cPp7V8zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37019 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbcLFMO6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Dec 2016 07:14:58 -0500
In-Reply-To: <CAJ+X7mTkBLQDYb+r9LELQe-sqfG_4YkQ9HbkDFAp70cPp7V8zA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amitay Isaacs <amitay@gmail.com>
Cc: Samba Technical <samba-technical@lists.samba.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 6 Dec 2016 18:58:41 +1100, Amitay Isaacs wrote:

> On Fri, Dec 2, 2016 at 1:17 AM, David Disseldorp <ddiss@suse.de> wrote:
> 
> > Hi,
> >
> > The attached patch-set implements a cluster mutex helper for Samba CTDB
> > using Ceph librados.
> >
> > ctdb_mutex_ceph_rados_helper_lock can be used as a recovery lock provider
> > for CTDB.  When configured, split brain avoidance during CTDB recovery
> > will be handled using locks against an object located in a Ceph RADOS
> > pool.
> >
> > I've also attached a standalone test script - @Martin: does this belong
> > in the ctdb test suite, or can I just commit it as a standalone test?
> > It has a few non-standard dependencies: a running Ceph cluster, the
> > rados and jq binaries.
> >
> > Feedback appreciated.
> >
> >  
> This code does not belong in ctdb/tools.  You can move it to an appropriate
> directory in ctdb/utils.
> 
> Please include the test code also as part of the commit.  Someone with
> ceph-rados setup should be able to run this test.
> I would appreciate if you can add few comments in the test script
> describing the requirements and how to run the test.

Thanks for the feedback, Amitay. Please find a v2 patchset attached,
with the following changes:
- move ctdb_mutex_ceph_rados_helper under ctdb/utils/ceph
- add test_ceph_rados_reclock.sh and document usage

Cheers, David

--

 ctdb/doc/Makefile                             |   3 +-
 ctdb/doc/ctdb_mutex_ceph_rados_helper.7.xml   |  90 +++++
 .../utils/ceph/ctdb_mutex_ceph_rados_helper.c | 334 ++++++++++++++++++
 ctdb/utils/ceph/test_ceph_rados_reclock.sh    | 151 ++++++++
 ctdb/wscript                                  |  19 +
 5 files changed, 596 insertions(+), 1 deletion(-)
