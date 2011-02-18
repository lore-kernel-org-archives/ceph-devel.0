From: Wido den Hollander <wido@widodh.nl>
Subject: Re: A Few Questions about Ceph
Date: Fri, 18 Feb 2011 21:42:14 +0100
Message-ID: <1298061734.2423.22.camel@wido-laptop.pcextreme.nl>
References: <loom.20110218T053907-813@post.gmane.org>
	 <1298039091.2366.65.camel@wido-desktop>
	 <AANLkTik1x1pcNK4PMCwkAvHBrPdn9t=xemmG+0Oyu+VN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39553 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab1BRUmS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 15:42:18 -0500
In-Reply-To: <AANLkTik1x1pcNK4PMCwkAvHBrPdn9t=xemmG+0Oyu+VN@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsuna <tsunanet@gmail.com>
Cc: Mark Nigh <mnigh@netelligent.com>, ceph-devel@vger.kernel.org

Hi,

On Fri, 2011-02-18 at 10:00 -0800, tsuna wrote:
> On Fri, Feb 18, 2011 at 6:24 AM, Wido den Hollander <wido@widodh.nl> wrote:
> > While every new user is welcome to Ceph, please do understand that is
> > still under heavy development and is NOT production ready.
> 
> > I'm just going to repeat myself. Ceph is great, but it is still under
> > heavy development. Testing and feedback is needed and very welcome, but
> > right now it's not suitable for production.
> 
> Hi Wido,
> what exactly is missing in Ceph to be considered suitable for production?

Ofcourse, it depends on your demands, but right now Ceph still
experiences some crashes, so does btrfs, this combination can be
dangerous for your data.

I'd recommend everybody to test Ceph, run if for some time and make your
own decision, but I personally think that at this point, Ceph is not
ready for production in terms of stability and data safety.

Wido

