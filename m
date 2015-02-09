From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Bucket lifecycle (object expiration)
Date: Mon, 9 Feb 2015 13:47:08 -0500 (EST)
Message-ID: <783742805.1935502.1423507628883.JavaMail.zimbra@redhat.com>
References: <1033454365.478048.1423259167886.JavaMail.zimbra@redhat.com> <alpine.DEB.2.00.1502090335140.5710@cobra.newdream.net> <1478158629.1804470.1423496019494.JavaMail.zimbra@redhat.com> <CAC6JEv91Sf=RGkQpvp_bZatkq7KFTkLoVsrkfXQY_BBNXWtzjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:52244 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760210AbbBISrL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 13:47:11 -0500
In-Reply-To: <CAC6JEv91Sf=RGkQpvp_bZatkq7KFTkLoVsrkfXQY_BBNXWtzjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Gregory Farnum" <greg@gregs42.com>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "Sage Weil" <sage@newdream.net>, "Ceph Development" <ceph-devel@v=
ger.kernel.org>
> Sent: Monday, February 9, 2015 7:48:43 AM
> Subject: Re: Bucket lifecycle (object expiration)
>=20
> On Mon, Feb 9, 2015 at 7:33 AM, Yehuda Sadeh-Weinraub <yehuda@redhat.=
com>
> wrote:
> >
> >
> > ----- Original Message -----
> >> From: "Sage Weil" <sage@newdream.net>
> >> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> >> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> >> Sent: Monday, February 9, 2015 3:42:40 AM
> >> Subject: Re: Bucket lifecycle (object expiration)
> >>
> >> On Fri, 6 Feb 2015, Yehuda Sadeh-Weinraub wrote:
> >> > I have been recently looking at implementing object expiration i=
n rgw.
> >> > First, a brief description of the feature:
> >> >
> >> > S3 provides mechanisms to expire objects, and/or to transition t=
hem into
> >> > different storage class. The feature works at the bucket level. =
Rules
> >> > can
> >> > be set as to which objects will expire and/or transitioned , and=
 when.
> >> > Objects are specified by using prefixes, the configuration is no=
t
> >> > per-object. Time is set in days (since object creation), and eve=
nts are
> >> > always rounded to the start of the next day.
> >> > The rules can also work in conjuction with object versioning. Wh=
en a
> >> > versioned object (a current object) expires, a delete marker is =
created.
> >> > Non-current versioned objects can be set to be removed after a s=
pecific
> >> > amount of time since the point where they became non-current.
> >> > As mentioned before, objects can be configured to transition to =
a
> >> > different
> >> > storage class (e.g., Amazon Glacier). It is possible to configur=
e an
> >> > object to be transitioned after a specific period, and after ano=
ther
> >> > period to be completely removed.
> >> > When reading object information, it will specify when it is sche=
duled
> >> > for
> >> > removal. It is not yet clear to me whether an object can be acce=
ssed
> >> > after
> >> > that time, or whether it appears as gone immediately (either whe=
n trying
> >> > to access it, or when listing the bucket).
> >> > Rules cannot intersect. Each object cannot be affected by more t=
han one
> >> > rule.
> >> >
> >> > Swift provides a completely different object expiration system. =
In swift
> >> > the expiration is set per object, and with an explicit time for =
it to be
> >> > removed.
> >> >
> >> > In accordance with previous work, I'll currently focus on an S3
> >> > implementation. We do not yet support object transition to a dif=
ferent
> >> > storage class, so either we implement that first, or out first l=
ifecycle
> >> > implementation will not include that.
> >>
> >> While the tier transition seems like the most interesting part to =
me, it
> >> shares some overlap with the current cache tiering ("move older ob=
jects to
> >> an EC backend").  it also quickly snowballs (migrate object to a d=
ifferent
> >> rados pool, from the same set you can pick when creating the bucke=
t?
> >> migrate to different zone/region?  migrate to an external service =
like
> >> glacier?)
> >>
> >> Expiration sounds like a good first step...
> >
> > I agree. Thinking about migration, I don't think we're that far off=
=2E We'll
> > add the ability to define new storage classes that will map to spec=
ified
> > rados pools (or override existing placement targets -- storage poli=
cies?).
> > The manifest will need to reflect where the object's data is locate=
d.
> > We'll be able to copy the object into different storage classes, an=
d it'll
> > require a new service thread to do the migration. We might need to =
update
> > the bucket index about the new object location.
> >
> >>
> >> > 1. Lifecycle rules will be configured on the bucket instance inf=
o
> >> >
> >> > We hold the bucket instance info whenever we read an object, and=
 it is
> >> > cached. Since rules are configured to affect specific object pre=
fixes,
> >> > it
> >> > will be quick and easy to determine whether an object is affecte=
d by any
> >> > lifecycle rule.
> >> >
> >> > 2. New bucket index objclass operation to list objects that need=
 to be
> >> > expired / transitioned
> >> >
> >> > The operation will get the existing rules as input, and will ret=
urn the
> >> > list of objects that need to be handled. The request will be pag=
ed. Note
> >> > that number of rules is constrained, so we only need to limit th=
e number
> >> > of returned entries.
> >>
> >> Will this be an O(n) scan over the index keys, or would we add som=
e
> >> time-based keys or something to make it faster?
> >
> > It will be a scan over index keys that match the prefixes, for each=
 rule.
> > Not sure if time based keys can help in any way as we'd need to int=
ersect
> > time and prefixes in order to make it worthwhile, but the prefixes =
are
> > created willy nilly.
>=20
> It is at least restricted to bucket indexes which are using
> expiration, but I suspect a lot of those rules are going to be based
> on the empty prefix and need to scan over the whole index. I'm not at
> all clear on how expensive that is, but I'm thinking "very".
> Unfortunately the best way to avoid that which I can think of is to
> insert time-sorted expiration keys whenever we create an object along
> with a "rule version", and bump that version whenever we create a
> rule. Then when we do an expiration scan we could avoid doing the ful=
l
> scan as long as the bucket's rule version isn't out of date =E2=80=94=
 but if
> it is we'd need to do a linear scan again. :/

Not sure that it's worth at this point the extra complexity. If we find=
 that this is really needed we can add an optimization that would go al=
ong these lines to the bucket index. The bucket index would keep the ru=
les information. A new bucket index request will trigger a recompilatio=
n of the time based index (not sure how that would work as we need to b=
ound the execution of such request). Then with every object modificatio=
n the bucket index will also update the time based index if needed. Not=
 sure if this is a good idea, as we'll increase the size of the index, =
and will add extra writes for every relevant object.
One thing that we do need to do is to limit the total number of entries=
 that we iterate over in a single bucket listing request. So we'll coun=
t the total number of entries we went over (vs. counting the total numb=
er of entries that expired).

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
