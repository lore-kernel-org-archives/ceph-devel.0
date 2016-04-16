From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: Ann Arbor Team's Flexible I/O Proposals (Ceph Next)
Date: Fri, 15 Apr 2016 20:34:44 -0400 (EDT)
Message-ID: <69053371.12352935.1460766884621.JavaMail.zimbra@redhat.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com> <1382159806.12350948.1460765279854.JavaMail.zimbra@redhat.com> <CAFdRU72-CyuFRodb-HoNrBHWZRV7Xj4Ki-yHvxHPKAZeZ213Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:42326 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbcDPAep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 20:34:45 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3G0YiVn006986
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 20:34:44 -0400
In-Reply-To: <CAFdRU72-CyuFRodb-HoNrBHWZRV7Xj4Ki-yHvxHPKAZeZ213Wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

> The complicating case here is the OSD status set.  Running this
> through a single Paxos limits the number of OSDs that can coexist in a
> cluster.  We ought split the set of OSDs between multiple masters to

Does multiple masters you mentioned here mean logical OSDs running in
one osd process described in # Interfaces #?

> distribute the load. Each 'Up' or 'Down' event is independent of
> others, so all we require is that events get propagated into the
> correct OSDs and primaries and followers act as they're supposed to.
> 
> Versioning is a bigger problem here. We might have all masters
> increment their version when one increments its version if that could
> be managed without inefficiency. We might send a compound version with
> `MOSDOp`s, but combining that with the compound version above might be
> unwieldly. (Feedback on this issue would be greatly appreciated.)

Cheers,
S

----- Original Message -----
> From: "Adam C. Emerson" <aemerson@redhat.com>
> To: "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Friday, April 15, 2016 5:05:37 PM
> Subject: Ann Arbor Team's Flexible I/O Proposals (Ceph Next)
>
> Ceph Developers,
>
> We've put together a few of the main ideas from our previous work in a
> brief form that we hope people will be able to digest, consider, and
> debate. We'd also like to discuss them with you at Ceph Next this
> Tuesday.
>

>
> ## The OSD Set ##
>
> The complicating case here is the OSD status set.  Running this
> through a single Paxos limits the number of OSDs that can coexist in a
> cluster.  We ought split the set of OSDs between multiple masters to
> distribute the load. Each 'Up' or 'Down' event is independent of
> others, so all we require is that events get propagated into the
> correct OSDs and primaries and followers act as they're supposed to.
>
> Versioning is a bigger problem here. We might have all masters
> increment their version when one increments its version if that could
> be managed without inefficiency. We might send a compound version with
> `MOSDOp`s, but combining that with the compound version above might be
> unwieldly. (Feedback on this issue would be greatly appreciated.)

When Tom Keiser and I considered the problem of distributing AFS3 data
for a single vnode across multiple data servers, iirc, we both arrived
at the notion of compound DataVersion (or "range dv") as the extension
of DataVersion to the partitioned object.

It feels like a similar structure naturally arises here, I admit I have
not thought about this problem in a while.

Regards,

Matt

--
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Email:
shinobu@linux.com
GitHub:
shinobu-x
Blog:
Life with Distributed Computational System based on OpenSource
