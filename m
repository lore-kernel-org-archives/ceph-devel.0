From: Pritha Srivastava <prsrivas@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Thu, 8 Sep 2016 13:21:15 -0400 (EDT)
Message-ID: <513084813.83123312.1473355275673.JavaMail.zimbra@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com> <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com> <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:59715 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbcIHRVR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 13:21:17 -0400
In-Reply-To: <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


----- Original Message -----
> From: "Casey Bodley" <cbodley@redhat.com>
> To: "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Thursday, September 8, 2016 2:35:34 AM
> Subject: Re: rgw: feedback on auth engine selection
> 
> 
> On 09/07/2016 01:19 PM, Radoslaw Zarzynski wrote:
> > Anyway, before we start discussing the whole
> > auth stuff further, I guess it would be helpful to
> > write in one place all requirements/plans that
> > might affect this area. For instance, the idea of
> > RGWHandler rework can have such impact.
> >
> > Let me start the requirements with an item found
> > after a session with Swift's FormPost middleware:
> >
> > * the auth infrastructure must allow for easy-adoption
> >    of new AuthEngines as even FormPost would need
> >    one :-).
> 
> Some specific requirements that I recall from our past discussions include:
> 
> - don't heap allocate auth state per request
> - don't construct or call into AuthEngines that shouldn't be enabled for
> the given handler
> 
> I'll add some of the other refactoring goals we've discussed, but I
> don't think they place any strict requirements on the auth subsystem:
> 
> - RGWHandler: being able to reuse handler instances, instead of
> allocating a new one for each request
> - req_state: contains too many unrelated fields, some of which are
> transformed in confusing ways over the lifetime of the request. needs to
> be broken up into smaller, better encapsulated sub-objects
> - concurrency: move away from a synchronous process_request() to build
> on asio frontend work

One more requirement to add to the list:

- In case of AWS, two different methods (RGWPostObj_ObjStore_S3::get_policy() and RGW_Auth_S3::authorize), will be making use of the Auth Engines to authenticate a request and the auth key extraction method will be different for both of them. The auth infrastructure needs to take care of this.
