From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Thu, 8 Sep 2016 17:05:42 -0400 (EDT)
Message-ID: <1857033161.83221781.1473368742739.JavaMail.zimbra@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com> <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com> <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com> <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:39949 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbcIHVFp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 17:05:45 -0400
In-Reply-To: <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

inline

----- Original Message -----
> From: "Radoslaw Zarzynski" <rzarzynski@mirantis.com>
> To: "Casey Bodley" <cbodley@redhat.com>
> Cc: "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Thursday, September 8, 2016 1:19:11 PM
> Subject: Re: rgw: feedback on auth engine selection
> 

> 
> At the moment RGWHandler is dynamically allocated on each
> request. Do we plan to remove only the allocations or go even
> further and make handlers entirely state-less?

That's been on my list of things to eventually do, for a while--in the librgw front-end, it already is.

> 
> > - req_state: contains too many unrelated fields, some of which are
> > transformed in confusing ways over the lifetime of the request. needs to be
> > broken up into smaller, better encapsulated sub-objects
> 
> I'm 100% behind that.

Me too.  Eventually, I'd like avoid needing separate allocations for any subobjects.  This was one of the main places I hoped we copuld use the polymorphic union idea that you called "static pointer." :)

> 
> > - concurrency: move away from a synchronous process_request() to build on
> > asio frontend work
> 
> Sound really interesting.
> 
> 
> Let me propose another requirement:
>  - critical components should facilitate unit testing. In the future
>    they should be covered by reasonable set of unit tests.

sure

> 
> What do you think?
> 
> Regards,
> Radek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
