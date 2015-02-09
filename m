From: Sage Weil <sage@newdream.net>
Subject: Re: Bucket lifecycle (object expiration)
Date: Mon, 9 Feb 2015 03:42:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502090335140.5710@cobra.newdream.net>
References: <1033454365.478048.1423259167886.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47022 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759227AbbBILml (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 06:42:41 -0500
In-Reply-To: <1033454365.478048.1423259167886.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 6 Feb 2015, Yehuda Sadeh-Weinraub wrote:
> I have been recently looking at implementing object expiration in rgw. First, a brief description of the feature:
> 
> S3 provides mechanisms to expire objects, and/or to transition them into different storage class. The feature works at the bucket level. Rules can be set as to which objects will expire and/or transitioned , and when. Objects are specified by using prefixes, the configuration is not per-object. Time is set in days (since object creation), and events are always rounded to the start of the next day.
> The rules can also work in conjuction with object versioning. When a versioned object (a current object) expires, a delete marker is created. Non-current versioned objects can be set to be removed after a specific amount of time since the point where they became non-current.
> As mentioned before, objects can be configured to transition to a different storage class (e.g., Amazon Glacier). It is possible to configure an object to be transitioned after a specific period, and after another period to be completely removed.
> When reading object information, it will specify when it is scheduled for removal. It is not yet clear to me whether an object can be accessed after that time, or whether it appears as gone immediately (either when trying to access it, or when listing the bucket).
> Rules cannot intersect. Each object cannot be affected by more than one rule.
> 
> Swift provides a completely different object expiration system. In swift the expiration is set per object, and with an explicit time for it to be removed.
> 
> In accordance with previous work, I'll currently focus on an S3 implementation. We do not yet support object transition to a different storage class, so either we implement that first, or out first lifecycle implementation will not include that.

While the tier transition seems like the most interesting part to me, it 
shares some overlap with the current cache tiering ("move older objects to 
an EC backend").  it also quickly snowballs (migrate object to a different 
rados pool, from the same set you can pick when creating the bucket?  
migrate to different zone/region?  migrate to an external service like 
glacier?)

Expiration sounds like a good first step...

> 1. Lifecycle rules will be configured on the bucket instance info
> 
> We hold the bucket instance info whenever we read an object, and it is cached. Since rules are configured to affect specific object prefixes, it will be quick and easy to determine whether an object is affected by any lifecycle rule.
> 
> 2. New bucket index objclass operation to list objects that need to be expired / transitioned
> 
> The operation will get the existing rules as input, and will return the list of objects that need to be handled. The request will be paged. Note that number of rules is constrained, so we only need to limit the number of returned entries.

Will this be an O(n) scan over the index keys, or would we add some 
time-based keys or something to make it faster?

sage

 
> 3. Maintain a (sharded) list of bucket instances that have had lifecycle set on them
> 
> Whenever creating a new lifecycle rule on a bucket, update that list. It will be kept as omap on objects in the log pool
> 
> 4. A new thread that will run daily to handle object expiration / transition
> 
> The (potentially more than one) thread will go over the lifecycle objects in the log pool, try to set a lease on one, if successful then it'll start processing it:
>  - get list of buckets
>  - for each bucket:
>   - read rules
>   - get list of objects affected by rules
>   - for each object:
>     - expire / transition
>     - renew lease if needed
>  - unlock log object
> 
> Note that this is racy. If a rule is removed after we read the rules, we're still going to apply it. Reading through the Amazon api, they have similar issues as far as I can tell. We can reduce the race window by verifying that the rule is still in effect before removing each object. This information should be cached, so there's not much overhead.
> 
> 5. when reading object, check whether its bucket has a rule that affects it. If so reflect that in the response headers.
> 
> 6. extend RESTful api to support rules creation, and removal, as well as reading the list of rules per bucket.
> 
> 7. (optional) don't allow access to objects that have been expired.
> 
> 8. (optional) don't list objects that have been expired.
> 
> Not sure we need or want (7) and (8).
> 
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
