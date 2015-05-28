From: Marcel Lauhoff <ml@irq0.org>
Subject: Re: OSD-Based Object Stubs
Date: Thu, 28 May 2015 12:01:54 +0200
Message-ID: <87617dc965.fsf@irq0.org>
References: <87a8wqct38.fsf@irq0.org> <CAC6JEv8KPsi1w37-XvNg00s4gC6hv=N5p5NWty56dFv3=e3eQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:43769 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbbE1KBw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 06:01:52 -0400
Received: from janelane.irq0.org (x5d82518d.dyn.telefonica.de [93.130.81.141])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id 6FDA78029A
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 10:01:50 +0000 (UTC)
In-reply-to: <CAC6JEv8KPsi1w37-XvNg00s4gC6hv=N5p5NWty56dFv3=e3eQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Gregory Farnum <greg@gregs42.com> writes:

> On Wed, May 27, 2015 at 1:39 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>> Hi,
>>
>> I wrote a prototype for an OSD-based object stub feature. An object stub
>> being an object with it's data moved /elsewhere/. I hope to get some
>> feedback, especially whether I'm on the right path here and if it
>> is a feature you are interested in.
>>
>>
>>
>> Code is in my "osd-stubs" branch:
>>  https://github.com/ceph/ceph/compare/master...irq0:osd-stubs
>>  https://github.com/irq0/ceph/tree/osd-stubs
>>
>>  Tools to toy around with osd-stubs + web server to send stubs to:
>>  https://github.com/irq0/ceph_osd-stub_tools
>>
>>
>>
>> Related:
>> - https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/osd:_tiering:_object_redirects
>
> Do you have a shorter summary than the code of how these stub and
> unstub operations relate to the object redirects? We didn't make a
> great deal of use of them but the basic data structures are mostly
> present in the codebase, are interpreted in at least some of the right
> places, and were definitely intended to cover this kind of use case.
> :)
> -Greg


As far as I understood the redirect feature it is about pointing to
other objects inside the Ceph cluster. The stubs feature allows
pointing to anything. An HTTP server in concept code.

Then stubs use an IMHO simpler approach to getting objects back: It's
the task of the OSD. Stubbed objects just take longer to access, due to
unstubbing it first.
Redirects on the other hand leave this to the client: Object redirected
-> Tell client to retrieve it elsewhere.

~marcel

--
Marcel Lauhoff
Mail/XMPP: ml@irq0.org
http://irq0.org
