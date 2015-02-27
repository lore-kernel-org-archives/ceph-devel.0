From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: s3-tests development
Date: Fri, 27 Feb 2015 14:26:22 +0530
Message-ID: <CANA9Uk5jmx1Nvf1ix=e00DsaDx2G5FCkubPUutEjvmhmU8FstQ@mail.gmail.com>
References: <20150227023734.GE21215@sherlock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33358 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbB0I4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 03:56:23 -0500
Received: by iecar1 with SMTP id ar1so28027915iec.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 00:56:22 -0800 (PST)
In-Reply-To: <20150227023734.GE21215@sherlock>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Gaul <andrew@gaul.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Can you please share the pull requests urls..we can do quick review..

Thanks
Swami

On Fri, Feb 27, 2015 at 8:07 AM, Andrew Gaul <andrew@gaul.org> wrote:
> Hello cephalopods, I use s3-tests to test S3Proxy[1], Apache jclouds,
> and an internal project.  While s3-tests has good functionality as it
> exists, the project has not progressed much over the last six months.  I
> have submitted over 20 pull requests to fix incorrect tests and for
> additional test coverage but most remain unreviewed[2].  Further
> s3-tests remains biased towards Ceph and not the AWS de facto standard,
> failing to run against the latter due to TooManyBuckets failures[3].
> Finally some features like V4 signature support[4] will require more
> extensive changes.  We are at-risk of diverging; how can we best move
> forward together?
>
> [1] https://github.com/andrewgaul/s3proxy
> [2] https://github.com/ceph/s3-tests/pulls?q=is%3Aopen+is%3Apr
> [3] https://github.com/ceph/s3-tests/issues/25
> [4] https://github.com/ceph/s3-tests/issues/35
>
> --
> Andrew Gaul
> http://gaul.org/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
