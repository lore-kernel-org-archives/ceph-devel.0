From: Sage Weil <sweil@redhat.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 09:44:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com> <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43963 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781AbbAORpG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Jan 2015 12:45:06 -0500
In-Reply-To: <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

In addition (or instead of) making the API harder to fat-finger, we could 
also add a mon config option like

 mon allow pool deletion = false

that defaults off.  Then, to delete any pool, you need to update ceph.conf 
and restart mons or inject the config option change (ceph daemon 
mon.`hostname` conig set ... on the leader) or the API will give you 
EPERM. 

This offers some protection even for client.admin key users if we prevent 
injectargs for that option (maybe feasible) and they don't have access to 
the actual mon machine.

It also makes it easy to drop these protections for our QA because we can 
just stick that option in the teuthology and vstart.sh ceph.conf files.

sage
