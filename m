From: Abhishek L <abhishek@suse.com>
Subject: Re: Queries on RGW Multitenancy
Date: Fri, 22 Apr 2016 19:36:40 +0200
Message-ID: <86lh45lf4n.fsf@linux-stsn.suse>
References: <87shyggsur.fsf@suse.com> <20160421155916.637a7e77@lembas.zaitcev.lan> <87bn517gfy.fsf@suse.com> <20160422112338.33bde8d2@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41481 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbcDVRg4 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 22 Apr 2016 13:36:56 -0400
In-reply-to: <20160422112338.33bde8d2@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Radoslaw Zarzynski <rzarzynski@mirantis.com>


Pete Zaitcev writes:

> On Fri, 22 Apr 2016 18:32:01 +0200
> Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
>> > One problem remains, as you can guess: cross-tenant access while
>> > authenticated with Keystone. This is simply not implemented. We considered
>> > a couple of approaches, such as
>> >  - a special syntax, such as backslash "tenant\bucket"
>> >  - a new header "X-RGW-Tenant"
>> >  - a user attribute in Keystone (requires cooperation from Keystone)
>> >  - a separate endpoint in the Keystone catalog, possibly using regions
>> >
>> > Thanks for raising this issue. Honestly I gave up on finding an elegant
>> > solution for now, although tinkering with endpoints seems like a winner.
>> > I think Radoslaw liked it too. If you have ideas, by all means please
>> > propose them.  
>> 
>> I might be understanding this wrong, but since endpoints are an admin only
>> thing (to create), are you suggesting something like a different region
>> per tenant or so?
>
> I suggest having two endpoints: one traditional with /swift/v1 and another
> with /swift/v1/%(tenant_id)s. The problem here is, client has to be told
> to use one region or ther other, and the default is the old way.

Ah ok,
>
>> Doesn't keystone returns the tenantid while authenticating (I could be
>> wrong), in which case we somehow enforce that the tenant-id for a user
>> created in rgw[1] if you're using keystone should match the ones used at
>> openstack and check for the value of tenant-id returned by keystone when
>> authenticating?
>
> I'll have to get back to you on this. When I considered using Keystone
> tenant IDs, I was going to put dollars into them. It works, but but you
> have to educate administartors to create users with a specific tenant ID.
> None of the current tools support this.
I was meaning more like when we create users in RGW, we specify the
--tenant with whatever keystone uuid was assigned for the user..but I
forgot about the the whole keystone-tenant -> rgw-uid mapping thing, so
the keystone tenant id is already stored as a RGW user id, we could
potentially check the response against the value of uid, but then again
creating the user for the first time in RGW will still be sort of a
challenge.
> They always let Keystone to select
> the ID, and it uses a random UUID. Having them not matching was very useful
> therefore. An operator just lets Keystone do its thing, then we use the
> "name" instead of their ID, and use it in RGW as ID (clear as mud, right?).

Yeah sure this could also work. 
>
> -- Pete


-- 
Abhishek
