From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: RGW multi-tenancy APIs overview
Date: Tue, 17 Nov 2015 16:47:23 -0700
Message-ID: <20151117164723.0d89f579@lembas.zaitcev.lan>
References: <20151109221015.2fa7745c@lembas.zaitcev.lan>
 <CADRKj5TmduPhctTc2LdbSXrMyycrR_9=+jkiXNOCpUy63ozuPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140AbbKQXrY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Nov 2015 18:47:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 589111136E2
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2015 23:47:24 +0000 (UTC)
In-Reply-To: <CADRKj5TmduPhctTc2LdbSXrMyycrR_9=+jkiXNOCpUy63ozuPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, zaitcev@redhat.com

On Mon, 9 Nov 2015 21:36:47 -0800
Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:

We discussed this a bit on RGW team meeting in BJ, and there were some
developments, so for the sake of update here goes.

> > #1 Back-end and radosgw-admin use '/' or "tenant/bucket". This is what is
> > literally stored in RADOS, because it's used to name bucket objects in
> > the .rgw pool.

This works.

> > #2 Buckets in Swift URLs use '\' (backslash), because there does not seem
> > to be a way to use '/'. Example:
> >  http://host.corp.com:8080/swift/v1/testen\testcont

> > Note that strictly speaking, we don't really need this, since Swift URLs
> > could easily include tenant names where reference Swift places account names.
> > It's just easier to implement without disturbing authenthication code.
> 
> I think that leveraging the native swift URL tenant encoding is
> probably a cleaner solution than having it encoded as a backslash.

Indeed, I clearly took a lazy way out. Backslashes are removed from the
current pull request #6358, to be replaced with the right solution through
the auth.

> > #3 S3 host addressing of buckets
> >
> > This is similar to Swift and is slated to use backslash. Note that S3
> > prohibits it, so we're reasonably safe with this choice.

We circled back to this in the meeting and replaced backslashes with colons,
for a cleaner look.

Note that in a potentially major development, the tenant name and the colon
are included into the string that is used to calculate HMAC. So, theoretically
stock clients could work, by packing tenant into buckets - except if they
use some kind of configuration syntax with colons. One motivation for
backslash was that it could be easier to make clients to eat. This is
something we ought to test and possibly tweak.

> > #4 S3 URL addressing of buckets
> >
> > Here we must use a period. Example:
> >  bucket.tenant.host.corp.com
> 
> Can probably identify this automatically, if the host is at a
> subdomain of a supported domain, and it's a second level subdomain
> from the main domain then we can regard it as <bucket>.<tenant>

This part suffered a major setback. And oddly enough nobody raised any
objections until now. But periods are permitted in bucket names in S3.
Therefore the "bucket.tenant.host.domain" thing cannot work.

I'm inclined to document this and simply tell people who want to access
buckets across tenants to use URL paths per above. However...

> In the supported domains configuration, we can specify for each domain
> whether a subdomain for it would be a bucket (as it is now), or
> whether it would be a tenant (which implies the possibility of
> bucket.tenant). This only affects the global (a.k.a the "empty")
> tenant.
> 
> E.g., we can have two domains:
> 
> legacy-foo.com
> new-foo.com
> 
> We'd specify that legacy-foo.com is a global tenant endpoint. In which
> case, when accessing buck.legacy-foo.com, it will access the global
> tenant, and bucket=buck.
> Whereas, new-foo.com isn't a global tenant endpoint, in which case, if
> we'd access buck.new-foo.com, it will mean that we accessed the 'buck'
> tenant.

Okay, that is plausible (meaning: I can make it work). This scheme has
a little downside in it: these DNS domains cannot nest. In other words,
corp.com cannot be migrated to tenantized-rados.corp.com. But otherwise,
I don't see it can't work.

> > #5 Listings and redirects.
> >
> > Listings present a difficulty in S3: we don't know if the name will be
> > used in host-based or URL-based addressing of a bucket. So, we put the
> > tenant of a bucket into a separate XML attribute.
> 
> You mean a separate http header? http param?

Not sure what that question assumed. A separate XML attribute looks like:

<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01">
 <Name>foobucket</Name>
 <Tenant>footenant</Tenant>  <=============== this one
 <IsTruncated>false</IsTruncated>

There's a certain problem with this, in case the client is constructing
the URLs for further access. In case it's trying to access across tenants,
it has to fetch the tenant name from the attribute. I thought about returning
the bucket name as <Name>footenant:foobucket</Name> for all buckets that
belong to non-empty tenant, but that seems asking for compatibility issues
even for access within the tenant.

> > Since Swift listings are always in a specific account, and thus tenant,
> > they are unchanged.
> >
> > In addition to listings, bucket names leak into certain HTTP headers, where
> > we add "Tenant:" headers as appropriate.
> >
> > Finally, multi-tenancy also puts user_uid namespaces under tenants as well
> > as bucket namespaces. That one is easy though. A '$' separator is used
> > consistently for it (tenant$user).

> Does that work the same for object copy, and acls?

ACLs do not list buckets, only users, which may be qualified (tenant$user).
COPY verbs use colons in S3. Fortunately there's no additional complication
with HMAC. In Swift, currently, all that support is removed together with
the backslash and is waiting for "new" URLs.

-- Pete
