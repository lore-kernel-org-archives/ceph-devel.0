From: Marcus Watts <mwatts@redhat.com>
Subject: Re: jewel PRs
Date: Tue, 7 Jun 2016 16:48:58 -0400
Message-ID: <20160607204858.GA26047@degu.eng.arb.redhat.com>
References: <CAN=+7FUh9ahiYRtYvfQ=1yxURNekYYm_-5HgwgTO7KkV7ih7JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162286AbcFGUtG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jun 2016 16:49:06 -0400
Content-Disposition: inline
In-Reply-To: <CAN=+7FUh9ahiYRtYvfQ=1yxURNekYYm_-5HgwgTO7KkV7ih7JA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 07, 2016 at 11:36:07AM -0700, Samuel Just wrote:
> We're trying to get a jewel point release out this week.  Are the
> Jewel PRs in github tested, or are they still in need of testing?
> -Sam

Can we get "make openssl easier to use. #8339"
into this point release?

This will make Jon Wilkins much happier.  Probably anyone
else who wants ssl in radosgw too.

gitbuilder has a red X against it - I think the reasons it wasn't
buildable were due to environment issues or unrelated problems elsewhere
in master at that point (or at least that's my recollection of what
it said...)

				-Marcus Watts
