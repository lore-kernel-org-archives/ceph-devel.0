From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Queries on RGW Multitenancy
Date: Thu, 21 Apr 2016 15:59:16 -0600
Message-ID: <20160421155916.637a7e77@lembas.zaitcev.lan>
References: <87shyggsur.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49879 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbcDUV7S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Apr 2016 17:59:18 -0400
In-Reply-To: <87shyggsur.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Radoslaw Zarzynski <rzarzynski@mirantis.com>

On Wed, 20 Apr 2016 18:14:36 +0200
Abhishek Lekshmanan <abhishek@suse.com> wrote:

> Are there any changes in the way bucket and object urls are used by
> clients after creating a user with a tenant? My understanding so far has
> been that the urls look the same for clients, and based on the
> credentials passed in, we determine the tenant for requests. Is this
> correct?

Yes.

> Also on making a bucket/object public the urls follow a format like:
> `<host>/<tenant>:<bucket>`
> 
> Is there an equivalent s3 vhost style url for the above? Trying any of
> tenant.bucket.host combos mostly gave  404s

No, sadly there is no such syntax. This is because a bucket name of
"buc.ket" is valid, so there's no way to tell a cross-tenant reference
in your proposal from a valid bucket name within a tenant. One has to
continue using the old access method, like when using extended names
of Virgina region buckets.

> And similarly for swift making a bucket public, the only url that seemed
> accessible was the above mentioned `<host>/<tenant>:<bucket>` format and
> there is no swift url of the format
> `<host>/swift/v1/<tenant>/<container>` etc? Is this also the expected
> behaviour?

Historically, we did not have the ability to do this, because, unlike
traditional Swift, our URLs did not have a tenant in them. E.g. it was
just /swift/v1/<container>. In Jewel, the tenant is included. It was
made fully backwards compatible by saving the bit to signify the
tenant-included URL into the token (the "rgwts" token). So now the
cross-tenant access is done in the exactly the same way as in OpenStack
Swift.

One problem remains, as you can guess: cross-tenant access while
authenticated with Keystone. This is simply not implemented. We considered
a couple of approaches, such as
 - a special syntax, such as backslash "tenant\bucket"
 - a new header "X-RGW-Tenant"
 - a user attribute in Keystone (requires cooperation from Keystone)
 - a separate endpoint in the Keystone catalog, possibly using regions

Thanks for raising this issue. Honestly I gave up on finding an elegant
solution for now, although tinkering with endpoints seems like a winner.
I think Radoslaw liked it too. If you have ideas, by all means please
propose them.

-- Pete
