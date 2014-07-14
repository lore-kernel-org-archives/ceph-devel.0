From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: v0.80.2?
Date: Mon, 14 Jul 2014 16:35:24 +0200
Message-ID: <CAF6-1L6MHOUWd_yrzf8ZyxpVVNEm86AoasoV1Azv9iTWogGnwA@mail.gmail.com>
References: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
	<CAF6-1L6bYp9EUidFnKZDwh1Qsf6wRrRpyL4gm7nP7aHS+VHEng@mail.gmail.com>
	<alpine.DEB.2.00.1407111259580.3932@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:56772 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbaGNOfY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jul 2014 10:35:24 -0400
Received: by mail-pd0-f175.google.com with SMTP id v10so5314106pde.20
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jul 2014 07:35:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407111259580.3932@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> Ideally the thing to do here is run s3-tests on your end and confirm that
> the tests are failing with the patch and figure out why.  Or, if it passes
> for you, we can figure out what is different between your environment and
> QA.  And then, ideally, we can extend s3-tests to reproduce the failure
> that you are seeing with the patch reverted so that we can confirm it is
> fixed (and stays fixed).

I just tried some tests on various revisions. It's not s3-tests
because I couldn't figure out how to just run the relevant test
(trying to just select the multipart test yields 0 tests run ... and
the full suite fails because I run lighttpd and some error codes are
different, and it also takes forever)

So I have my own create bucket - upload multi part - download it back
- delete bucket  test with just boto in python.
It's part of the test I use internally to validate S3 before deploying
it to prod (it tests all the stuff we use including some weird stuff).

I know the test fails on 0.80.1. I also knows it works fine on our own
internal package of firefly (which are based on some intermediate
version of firefly branch between 0.80.1 and 0.80.2 + some patches I
backported myself).


* 8589c108dd5f00471986deae72d88811ccf0627f  (which should be 0.80.3)
   -> Fails to do the multipart upload

* Re-applying b300318113b162522759d4794b1cfa3d1d9398e4 over it
   -> Actually crashes / segfault ... so yeah, really not good.

So I tried going back to d43e7113dd501aea1db33fdae30d56e96e9c3897
which is the revision I based my packages on. And I applied
b300318113b162522759d4794b1cfa3d1d9398e4.
   -> Multi part upload works and no crash !


So something between d43e7113dd501aea1db33fdae30d56e96e9c3897 and
8589c108dd5f00471986deae72d88811ccf0627f is causing the fix to
misbehave ...


Cheers,

    Sylvain
