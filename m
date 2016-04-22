From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: Queries on RGW Multitenancy
Date: Fri, 22 Apr 2016 18:32:01 +0200
Message-ID: <87bn517gfy.fsf@suse.com>
References: <87shyggsur.fsf@suse.com> <20160421155916.637a7e77@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:34623 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcDVQcP (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 22 Apr 2016 12:32:15 -0400
In-reply-to: <20160421155916.637a7e77@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Radoslaw Zarzynski <rzarzynski@mirantis.com>


Pete Zaitcev writes:

> On Wed, 20 Apr 2016 18:14:36 +0200
> Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
>> Are there any changes in the way bucket and object urls are used by
>> clients after creating a user with a tenant? My understanding so far=
 has
>> been that the urls look the same for clients, and based on the
>> credentials passed in, we determine the tenant for requests. Is this
>> correct?
>
> Yes.
>
>> Also on making a bucket/object public the urls follow a format like:
>> `<host>/<tenant>:<bucket>`
>>
>> Is there an equivalent s3 vhost style url for the above? Trying any =
of
>> tenant.bucket.host combos mostly gave  404s
>
> No, sadly there is no such syntax. This is because a bucket name of
> "buc.ket" is valid, so there's no way to tell a cross-tenant referenc=
e
> in your proposal from a valid bucket name within a tenant. One has to
> continue using the old access method, like when using extended names
> of Virgina region buckets.

Thanks for clarifying, yeah I expected it would be difficult since `.`
was allowed to be used in bucket names and you can't construct domain
names with most other seperators, not a deal breaker :)
>
>> And similarly for swift making a bucket public, the only url that se=
emed
>> accessible was the above mentioned `<host>/<tenant>:<bucket>` format=
 and
>> there is no swift url of the format
>> `<host>/swift/v1/<tenant>/<container>` etc? Is this also the expecte=
d
>> behaviour?
>
> Historically, we did not have the ability to do this, because, unlike
> traditional Swift, our URLs did not have a tenant in them. E.g. it wa=
s
> just /swift/v1/<container>. In Jewel, the tenant is included. It was
> made fully backwards compatible by saving the bit to signify the
> tenant-included URL into the token (the "rgwts" token).
> So now the cross-tenant access is done in the exactly the same way as=
 in OpenStack
> Swift.

Ah ok, the information is encoded in the token, so on making a
bucket/container public we'll still access it at
<host>/tenant:container/... location, rather than a /swift/tenant sort
of url
>
> One problem remains, as you can guess: cross-tenant access while
> authenticated with Keystone. This is simply not implemented. We consi=
dered
> a couple of approaches, such as
>  - a special syntax, such as backslash "tenant\bucket"
>  - a new header "X-RGW-Tenant"
>  - a user attribute in Keystone (requires cooperation from Keystone)
>  - a separate endpoint in the Keystone catalog, possibly using region=
s
>
> Thanks for raising this issue. Honestly I gave up on finding an elega=
nt
> solution for now, although tinkering with endpoints seems like a winn=
er.
> I think Radoslaw liked it too. If you have ideas, by all means please
> propose them.

I might be understanding this wrong, but since endpoints are an admin o=
nly
thing (to create), are you suggesting something like a different region
per tenant or so?

Doesn't keystone returns the tenantid while authenticating (I could be
wrong), in which case we somehow enforce that the tenant-id for a user
created in rgw[1] if you're using keystone should match the ones used a=
t
openstack and check for the value of tenant-id returned by keystone whe=
n
authenticating?

[1]: this is still tricky, as we create users at runtime after first
authentication with keystone iirc
>
> -- Pete


--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
