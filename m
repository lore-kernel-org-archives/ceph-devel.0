From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW multi-tenancy APIs overview
Date: Mon, 9 Nov 2015 21:36:47 -0800
Message-ID: <CADRKj5TmduPhctTc2LdbSXrMyycrR_9=+jkiXNOCpUy63ozuPg@mail.gmail.com>
References: <20151109221015.2fa7745c@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36369 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbKJFgs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 00:36:48 -0500
Received: by vkas68 with SMTP id s68so6663332vka.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 21:36:47 -0800 (PST)
In-Reply-To: <20151109221015.2fa7745c@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 9, 2015 at 9:10 PM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> With ticket 5073 getting close to complete, we're getting the APIs mostly

Great! thanks for all the work you've done to get this closer to completion.

> nailed down. Most of them come down to selection a syntax separator
> character. Unfortunately, there are several such characters. Plus,
> it is not always feasible to get by with a character (in S3 at least).
>
> So far we have the following changes:
>
> #1 Back-end and radosgw-admin use '/' or "tenant/bucket". This is what is
> literally stored in RADOS, because it's used to name bucket objects in
> the .rgw pool.
>
> #2 Buckets in Swift URLs use '\' (backslash), because there does not seem
> to be a way to use '/'. Example:
>  http://host.corp.com:8080/swift/v1/testen\testcont
>
> At first, I tried URL encoding (%2f), but that didn't work: we permit '%'
> in Swift container names, so there's a show-stopper compatibility problem.
> So, backslash. The backslash poses a similar problem, too, but hopefuly
> nobody created a container with backslash in name.
>
> Note that strictly speaking, we don't really need this, since Swift URLs
> could easily include tenant names where reference Swift places account names.
> It's just easier to implement without disturbing authenthication code.

I think that leveraging the native swift URL tenant encoding is
probably a cleaner solution than having it encoded as a backslash.

>
> #3 S3 host addressing of buckets
>
> This is similar to Swift and is slated to use backslash. Note that S3
> prohibits it, so we're reasonably safe with this choice.
>
> #4 S3 URL addressing of buckets
>
> Here we must use a period. Example:
>  bucket.tenant.host.corp.com
>

Can probably identify this automatically, if the host is at a
subdomain of a supported domain, and it's a second level subdomain
from the main domain then we can regard it as <bucket>.<tenant>

> #5 Listings and redirects.
>
> Listings present a difficulty in S3: we don't know if the name will be
> used in host-based or URL-based addressing of a bucket. So, we put the
> tenant of a bucket into a separate XML attribute.

You mean a separate http header? http param?

In the supported domains configuration, we can specify for each domain
whether a subdomain for it would be a bucket (as it is now), or
whether it would be a tenant (which implies the possibility of
bucket.tenant). This only affects the global (a.k.a the "empty")
tenant.

E.g., we can have two domains:

legacy-foo.com
new-foo.com

We'd specify that legacy-foo.com is a global tenant endpoint. In which
case, when accessing buck.legacy-foo.com, it will access the global
tenant, and bucket=buck.
Whereas, new-foo.com isn't a global tenant endpoint, in which case, if
we'd access buck.new-foo.com, it will mean that we accessed the 'buck'
tenant.


>
> Since Swift listings are always in a specific account, and thus tenant,
> they are unchanged.
>
> In addition to listings, bucket names leak into certain HTTP headers, where
> we add "Tenant:" headers as appropriate.
>
> Finally, multi-tenancy also puts user_uid namespaces under tenants as well
> as bucket namespaces. That one is easy though. A '$' separator is used
> consistently for it (tenant$user).
>

Does that work the same for object copy, and acls?

Thanks,
Yehuda

> -- Pete
