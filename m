From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Queries on RGW Multitenancy
Date: Fri, 22 Apr 2016 11:23:38 -0600
Message-ID: <20160422112338.33bde8d2@lembas.zaitcev.lan>
References: <87shyggsur.fsf@suse.com>
	<20160421155916.637a7e77@lembas.zaitcev.lan>
	<87bn517gfy.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932156AbcDVRXj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 13:23:39 -0400
In-Reply-To: <87bn517gfy.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Radoslaw Zarzynski <rzarzynski@mirantis.com>

On Fri, 22 Apr 2016 18:32:01 +0200
Abhishek Lekshmanan <abhishek@suse.com> wrote:

> > One problem remains, as you can guess: cross-tenant access while
> > authenticated with Keystone. This is simply not implemented. We considered
> > a couple of approaches, such as
> >  - a special syntax, such as backslash "tenant\bucket"
> >  - a new header "X-RGW-Tenant"
> >  - a user attribute in Keystone (requires cooperation from Keystone)
> >  - a separate endpoint in the Keystone catalog, possibly using regions
> >
> > Thanks for raising this issue. Honestly I gave up on finding an elegant
> > solution for now, although tinkering with endpoints seems like a winner.
> > I think Radoslaw liked it too. If you have ideas, by all means please
> > propose them.  
> 
> I might be understanding this wrong, but since endpoints are an admin only
> thing (to create), are you suggesting something like a different region
> per tenant or so?

I suggest having two endpoints: one traditional with /swift/v1 and another
with /swift/v1/%(tenant_id)s. The problem here is, client has to be told
to use one region or ther other, and the default is the old way.

> Doesn't keystone returns the tenantid while authenticating (I could be
> wrong), in which case we somehow enforce that the tenant-id for a user
> created in rgw[1] if you're using keystone should match the ones used at
> openstack and check for the value of tenant-id returned by keystone when
> authenticating?

I'll have to get back to you on this. When I considered using Keystone
tenant IDs, I was going to put dollars into them. It works, but but you
have to educate administartors to create users with a specific tenant ID.
None of the current tools support this. They always let Keystone to select
the ID, and it uses a random UUID. Having them not matching was very useful
therefore. An operator just lets Keystone do its thing, then we use the
"name" instead of their ID, and use it in RGW as ID (clear as mud, right?).

-- Pete
