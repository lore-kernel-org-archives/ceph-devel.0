From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Java binding for RADOS API
Date: Mon, 15 Nov 2010 14:21:22 +0100
Message-ID: <1289827282.3070.20.camel@wido-desktop>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
	 <1289568944.4894.16.camel@wido-desktop>
	 <AANLkTins-08+N4Wqj-0qSE4XrZ1LaestckCd4RL9w+R2@mail.gmail.com>
	 <1289808125.1367.2.camel@wido-laptop.pcextreme.nl>
	 <AANLkTimbogvHcoZsFTUPQ9imKcvt9eafOoCp08-dpDgE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42806 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab0KONVV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 08:21:21 -0500
In-Reply-To: <AANLkTimbogvHcoZsFTUPQ9imKcvt9eafOoCp08-dpDgE@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

Hi,


On Mon, 2010-11-15 at 08:20 +0000, Takuya ASADA wrote:
> Hi,
> 
> > How did you do this? Did you map all Walrus objects 1:1 to RADOS? If so,
> > that should give you pretty large RADOS objects. That is not a problem,
> > RADOS can handle that, but performance-wise it isn't the best way to go.
> >
> > Or does Walrus split it's internal objects into smaller ones?
> 
> I didn't know there's performance penalty, so currently it's just 1:1.
> I think eucalyptus administration tool split up a VM image to multiple
> objects when store it into Walrus,
> but that's only for VM image.
> Normal S3 put go directly 1:1.
> 
> What is the best size when split it up anyway?
> Maybe I should refer rbd code?

The general rule is to split objects up into smaller pieces of 4MB,
that's what the filesystem Ceph and RBD do.

You could refer to the RBD code, but i'm not fully into RBD, Yehuda
Sadeh might be able to tell you more.

The problem is, that when you put everything in one RADOS object, it
might fill up a single OSD.

For example, you have ten OSD's, all with a 500GB disk, this would give
you 5TB of storage. But when you create a image of 1TB (which is mapped
into a single RADOS object), this object would grow over 500GB and fill
up that OSD.

When splitting it into smaller object, these can be striped over the
OSD's, giving you more space, but also more performance.

> 
> >> So these are different services, which can work together.
> >> I think if both services could integrated into Eucalyptus(or the
> >> another IaaS platform such as OpenStack) that will be exciting.
> >>
> >> Ceph already has radosgw for S3 compatible service anyway, but it
> >> looks much easier to use RADOS API from Walrus, so I implemented that
> >> way.
> >
> > Yes, the radosgw from Ceph is proof-of-concept, what RADOS/Ceph is
> > capable of. Do you have your Walrus integration online somewhere?
> 
> Well, currently my testing environment is on the internal network.
> If you want to test it I can setup.

Oh no, I meant the code to implement it into Walrus, is that available
somewhere?

> 
> >>
> >> > But great work! I think a lot of people don't see the full potential of
> >> > RADOS, hope your bindings and phprados will make more people use RADOS.
> >> >
> >> > If you ask Sage, he might want to setup a new GIT repo for you and a
> >> > project in the tracker, so we can keep track of bugs and features.
> >> >
> >> > Thanks,
> >> >
> >> > Wido
> >
> > About the Wiki, you are free to create a page :-)
> Okay, thanks.
> 
> syuu

Wido

