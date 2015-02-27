From: Alfredo Deza <adeza@redhat.com>
Subject: Re: s3-tests development
Date: Fri, 27 Feb 2015 15:36:52 -0500 (EST)
Message-ID: <1106287368.12570538.1425069412257.JavaMail.zimbra@redhat.com>
References: <20150227023734.GE21215@sherlock> <89668076.12410416.1425057105722.JavaMail.zimbra@redhat.com> <20150227182623.GA15693@sherlock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57818 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbB0Ugy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 15:36:54 -0500
In-Reply-To: <20150227182623.GA15693@sherlock>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Gaul <andrew@gaul.org>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel@vger.kernel.org



----- Original Message -----
From: "Andrew Gaul" <andrew@gaul.org>
To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
Cc: ceph-devel@vger.kernel.org, "Alfredo Deza" <adeza@redhat.com>
Sent: Friday, February 27, 2015 1:26:23 PM
Subject: Re: s3-tests development

On Fri, Feb 27, 2015 at 12:11:45PM -0500, Yehuda Sadeh-Weinraub wrote:
> Andrew Gaul wrote:
> > While s3-tests has good functionality as it
> > exists, the project has not progressed much over the last six months.  I
> > have submitted over 20 pull requests to fix incorrect tests and for
> > additional test coverage but most remain unreviewed[2].
> 
> Right. We do need to be more responsive. The main reason we took our time was that these tests are used for the ceph nightly qa tests, and any changes in these that exposes new incompatibility will fail these. We'd rather first have the issue fixed, then merge the change. An alternative way to doing it is to open a ceph tracker issue about the incompatibility, mark the test as 'fails_on_rgw', in which case we could merge it immediately.

Instead of testing against master, perhaps you can tag a s3-tests 1.0.0
release and Ceph can use that?  Alternatively you can run your tests
against a specific commit hash.  In addition to running s3-tests against
Ceph, it would be good to run it against AWS, although we are blocked as
discussed below.

> > s3-tests remains biased towards Ceph and not the AWS de facto standard,
> > failing to run against the latter due to TooManyBuckets failures[3].
> 
> Not sure what's the appropriate way to attack this one. Maybe the create_bucket function could keep a list of created buckets and then remove them if encountering this error using lru.

jclouds uses an LRU scheme to recycle buckets between tests which works
well.  Alternatively s3-tests could remove buckets immediately after
each test although this has some tooling challenges discussed in the
issue.

> > Finally some features like V4 signature support[4] will require more
> > extensive changes.  We are at-risk of diverging; how can we best move
> > forward together?
> 
> We'd be happy with more tests, and with more features tested even if these weren't implemented yet. It can later help with the development of these features. E.g., I looked a few weeks back at v4 signatures, and having such a test would have helped. The only thing we need though would be a way to easily disable such tests. So adding 'fails_on_rgw', or some other way to detect would help a lot.

Annotating every failing test will not scale with additional providers;
I have almost 100 annotations for S3Proxy presently[1].  Could we
implement an external profile mechanism which tracks which tests should
or should not run?  Perhaps nosetests has a way to do this already?

Like I mentioned, we are working to port these to py.test with a re-organization included that should allow to configure what tests are run
and how failures are treated.



[1] https://github.com/andrewgaul/s3-tests/commit/7891cb4d9a1cd6e6f4d8119f33c4f0bdb35348d3

-- 
Andrew Gaul
http://gaul.org/
