From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Queries on RGW Multitenancy
Date: Thu, 21 Apr 2016 17:30:36 -0600
Message-ID: <20160421173036.3d2b84d8@lembas.zaitcev.lan>
References: <87shyggsur.fsf@suse.com>
	<20160421155916.637a7e77@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcDUXai (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Apr 2016 19:30:38 -0400
In-Reply-To: <20160421155916.637a7e77@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Radoslaw Zarzynski <rzarzynski@mirantis.com>

> On Wed, 20 Apr 2016 18:14:36 +0200
> Abhishek Lekshmanan <abhishek@suse.com> wrote:
> 
> > Are there any changes in the way bucket and object urls are used by
> > clients after creating a user with a tenant? My understanding so far has
> > been that the urls look the same for clients, and based on the
> > credentials passed in, we determine the tenant for requests. Is this
> > correct?  
> 
> Yes.

Sorry to reply to myself, but I need to elaborate. It's yes for the
case of normal access within the tenant: everything stays as before.
But, if you want to break out of the tenant, we have additional
ways to do that which involve trick URLs or other breakouts,
as discussed in the reply.

-- Pete
