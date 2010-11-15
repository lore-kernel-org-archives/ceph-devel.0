From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Java binding for RADOS API
Date: Mon, 15 Nov 2010 09:02:05 +0100
Message-ID: <1289808125.1367.2.camel@wido-laptop.pcextreme.nl>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
	 <1289568944.4894.16.camel@wido-desktop>
	 <AANLkTins-08+N4Wqj-0qSE4XrZ1LaestckCd4RL9w+R2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:34822 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566Ab0KOICJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 03:02:09 -0500
In-Reply-To: <AANLkTins-08+N4Wqj-0qSE4XrZ1LaestckCd4RL9w+R2@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

Hi Takuya,

On Sun, 2010-11-14 at 00:41 +0900, Takuya ASADA wrote:
> Hi,
> 
> On Fri, Nov 12, 2010 at 10:35 PM, Wido den Hollander <wido@widodh.nl> wrote:
> > Hi Takuya,
> >
> > Great work! I've been following rados4j for a while now (Found you on
> > Github), like the approach!
> >
> > Eucalyptus works with Qemu took right, wouldn't Qemu-RBD be a better
> > solution? Or what are your plans with RADOS for Eucalyptus?
> 
> I know about qemu-rbd, that's for block device service similar to Amazon EBS.
> I only implemented RADOS backend for "Walrus", that is similar to Amazon S3.

How did you do this? Did you map all Walrus objects 1:1 to RADOS? If so,
that should give you pretty large RADOS objects. That is not a problem,
RADOS can handle that, but performance-wise it isn't the best way to go.

Or does Walrus split it's internal objects into smaller ones?

> So these are different services, which can work together.
> I think if both services could integrated into Eucalyptus(or the
> another IaaS platform such as OpenStack) that will be exciting.
> 
> Ceph already has radosgw for S3 compatible service anyway, but it
> looks much easier to use RADOS API from Walrus, so I implemented that
> way.

Yes, the radosgw from Ceph is proof-of-concept, what RADOS/Ceph is
capable of. Do you have your Walrus integration online somewhere?

> 
> > But great work! I think a lot of people don't see the full potential of
> > RADOS, hope your bindings and phprados will make more people use RADOS.
> >
> > If you ask Sage, he might want to setup a new GIT repo for you and a
> > project in the tracker, so we can keep track of bugs and features.
> >
> > Thanks,
> >
> > Wido

About the Wiki, you are free to create a page :-)

Thanks,

Wido

