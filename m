From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Osd failure detection
Date: Thu, 9 Nov 2017 13:25:30 +0100
Message-ID: <20171109122530.GA4634@mailware>
References: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
 <20171109120318.1946caf2@suse.de>
 <CAPpSHbUNw5xosaywDM6SVR3oAd7tVP_T+17QCj-296bj8+kYOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:49818 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754211AbdKIMdN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Nov 2017 07:33:13 -0500
Content-Disposition: inline
In-Reply-To: <CAPpSHbUNw5xosaywDM6SVR3oAd7tVP_T+17QCj-296bj8+kYOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Jin <wjin.cn@gmail.com>
Cc: David Disseldorp <ddiss@suse.de>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 09, 2017 at 08:13:57PM +0800, Wei Jin wrote:
> On Thu, Nov 9, 2017 at 7:03 PM, David Disseldorp <ddiss@suse.de> wrote:
> > On Thu, 9 Nov 2017 17:43:04 +0800, Wei Jin wrote:
> >> This is critical and we have no plan to upgrade to Luminous so far.
> >> Is there any plan to back port it Jewel? Or anybody know the related pr or patches? Maybe I could do it by myself.
> >
> > It was backported to Jewel, alongside a bunch of other async messenger
> > fixes, and submitted via https://github.com/ceph/ceph/pull/13212 . IIRC,
> > there's still a small async messenger leak blocking the PR.
> >
> 
> Yeah. It is still open and marked as DNM.
> And there are some issues with async messenger. As async is not the
> default one, why not just make it available for simple messenger?

Because the change is so vast that it would affect async messenger anyway.
In fact I didn't bother backporting it myself because I was certain that
maintainers/backporters wouldn't give it a green light anyway.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
