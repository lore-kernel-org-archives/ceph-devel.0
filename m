From: Alfredo Deza <adeza@redhat.com>
Subject: Re: s3-tests development
Date: Fri, 27 Feb 2015 12:19:16 -0500 (EST)
Message-ID: <2022216115.12417846.1425057556403.JavaMail.zimbra@redhat.com>
References: <20150227023734.GE21215@sherlock> <89668076.12410416.1425057105722.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47587 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbB0RTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 12:19:18 -0500
In-Reply-To: <89668076.12410416.1425057105722.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Andrew Gaul <andrew@gaul.org>, ceph-devel@vger.kernel.org



----- Original Message -----
From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
To: "Andrew Gaul" <andrew@gaul.org>
Cc: ceph-devel@vger.kernel.org, "Alfredo Deza" <adeza@redhat.com>
Sent: Friday, February 27, 2015 12:11:45 PM
Subject: Re: s3-tests development



----- Original Message -----
> From: "Andrew Gaul" <andrew@gaul.org>
> To: ceph-devel@vger.kernel.org
> Sent: Thursday, February 26, 2015 6:37:35 PM
> Subject: s3-tests development
> 
> Hello cephalopods, I use s3-tests to test S3Proxy[1], Apache jclouds,
> and an internal project.  While s3-tests has good functionality as it
> exists, the project has not progressed much over the last six months.  I
> have submitted over 20 pull requests to fix incorrect tests and for
> additional test coverage but most remain unreviewed[2].  Further

Right. We do need to be more responsive. The main reason we took our time was that these tests are used for the ceph nightly qa tests, and any changes in these that exposes new incompatibility will fail these. We'd rather first have the issue fixed, then merge the change. An alternative way to doing it is to open a ceph tracker issue about the incompatibility, mark the test as 'fails_on_rgw', in which case we could merge it immediately.

> s3-tests remains biased towards Ceph and not the AWS de facto standard,
> failing to run against the latter due to TooManyBuckets failures[3].

I have started some work to have a much cleaner way to identify documented API vs actual tests (making it clear where new tests should go) and to be able
to have leaner tests (vs. the current approach that stacks decorators).

This will also mean that we would move away from using the current test runner as it doesn't allow for such abstractions (in favor of py.test).

It will take some time to accomplish this, however we do still think that new tests and fixes should still be submitted while the new implementation is being worked on.

Not sure what's the appropriate way to attack this one. Maybe the create_bucket function could keep a list of created buckets and then remove them if encountering this error using lru.

> Finally some features like V4 signature support[4] will require more
> extensive changes.  We are at-risk of diverging; how can we best move
> forward together?

We'd be happy with more tests, and with more features tested even if these weren't implemented yet. It can later help with the development of these features. E.g., I looked a few weeks back at v4 signatures, and having such a test would have helped. The only thing we need though would be a way to easily disable such tests. So adding 'fails_on_rgw', or some other way to detect would help a lot.

Thanks,
Yehuda

> 
> [1] https://github.com/andrewgaul/s3proxy
> [2] https://github.com/ceph/s3-tests/pulls?q=is%3Aopen+is%3Apr
> [3] https://github.com/ceph/s3-tests/issues/25
> [4] https://github.com/ceph/s3-tests/issues/35
> 


