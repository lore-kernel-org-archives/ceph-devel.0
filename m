From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Bucket lifecycle (object expiration)
Date: Fri, 6 Feb 2015 17:13:45 -0500 (EST)
Message-ID: <1649887477.485245.1423260825116.JavaMail.zimbra@redhat.com>
References: <313711066.475076.1423258498528.JavaMail.zimbra@redhat.com> <1033454365.478048.1423259167886.JavaMail.zimbra@redhat.com> <CAC6JEv8qVphsRf=_K9MhegU_uZq1XGb6_zdtvEX1wV-qL7K8Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:34127 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462AbbBFWNq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 17:13:46 -0500
In-Reply-To: <CAC6JEv8qVphsRf=_K9MhegU_uZq1XGb6_zdtvEX1wV-qL7K8Rw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Gregory Farnum" <greg@gregs42.com>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Friday, February 6, 2015 2:02:41 PM
> Subject: Re: Bucket lifecycle (object expiration)
> 
> On Fri, Feb 6, 2015 at 1:46 PM, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
> wrote:
> > I have been recently looking at implementing object expiration in rgw.
> > First, a brief description of the feature:
> >
> > S3 provides mechanisms to expire objects, and/or to transition them into
> > different storage class. The feature works at the bucket level. Rules can
> > be set as to which objects will expire and/or transitioned , and when.
> > Objects are specified by using prefixes, the configuration is not
> > per-object. Time is set in days (since object creation), and events are
> > always rounded to the start of the next day.
> > The rules can also work in conjuction with object versioning. When a
> > versioned object (a current object) expires, a delete marker is created.
> > Non-current versioned objects can be set to be removed after a specific
> > amount of time since the point where they became non-current.
> > As mentioned before, objects can be configured to transition to a different
> > storage class (e.g., Amazon Glacier). It is possible to configure an
> > object to be transitioned after a specific period, and after another
> > period to be completely removed.
> > When reading object information, it will specify when it is scheduled for
> > removal. It is not yet clear to me whether an object can be accessed after
> > that time, or whether it appears as gone immediately (either when trying
> > to access it, or when listing the bucket).
> > Rules cannot intersect. Each object cannot be affected by more than one
> > rule.
> >
> > Swift provides a completely different object expiration system. In swift
> > the expiration is set per object, and with an explicit time for it to be
> > removed.
> >
> > In accordance with previous work, I'll currently focus on an S3
> > implementation. We do not yet support object transition to a different
> > storage class, so either we implement that first, or out first lifecycle
> > implementation will not include that.
> >
> > 1. Lifecycle rules will be configured on the bucket instance info
> >
> > We hold the bucket instance info whenever we read an object, and it is
> > cached. Since rules are configured to affect specific object prefixes, it
> > will be quick and easy to determine whether an object is affected by any
> > lifecycle rule.
> >
> > 2. New bucket index objclass operation to list objects that need to be
> > expired / transitioned
> >
> > The operation will get the existing rules as input, and will return the
> > list of objects that need to be handled. The request will be paged. Note
> > that number of rules is constrained, so we only need to limit the number
> > of returned entries.
> >
> > 3. Maintain a (sharded) list of bucket instances that have had lifecycle
> > set on them
> >
> > Whenever creating a new lifecycle rule on a bucket, update that list. It
> > will be kept as omap on objects in the log pool
> >
> > 4. A new thread that will run daily to handle object expiration /
> > transition
> >
> > The (potentially more than one) thread will go over the lifecycle objects
> > in the log pool, try to set a lease on one, if successful then it'll start
> > processing it:
> >  - get list of buckets
> >  - for each bucket:
> >   - read rules
> >   - get list of objects affected by rules
> >   - for each object:
> >     - expire / transition
> >     - renew lease if needed
> >  - unlock log object
> >
> > Note that this is racy. If a rule is removed after we read the rules, we're
> > still going to apply it. Reading through the Amazon api, they have similar
> > issues as far as I can tell. We can reduce the race window by verifying
> > that the rule is still in effect before removing each object. This
> > information should be cached, so there's not much overhead.
> >
> > 5. when reading object, check whether its bucket has a rule that affects
> > it. If so reflect that in the response headers.
> >
> > 6. extend RESTful api to support rules creation, and removal, as well as
> > reading the list of rules per bucket.
> >
> > 7. (optional) don't allow access to objects that have been expired.
> >
> > 8. (optional) don't list objects that have been expired.
> >
> > Not sure we need or want (7) and (8).
> 
> It sounds like we know whether rules apply to an object whenever the
> object is created. Is there a reason to implement this as a pull model
> (go look at the bucket) instead of a push model (give the object name
> to a set of cleanup objects sorted by date)?
> There might be some concurrency issues that make this infeasible, but
> it seems like that would involve accessing less data and minimizing
> how much time each bucket index spends (b)locked to service object
> expiration.

It's not going to work. New rules can be created after the objects were created, old rules can be removed. It can be very dynamic. You'd also add another write on each object creation, and it'll be a write across multiple objects, which is always an issue.

Yehuda
