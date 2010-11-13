From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: Java binding for RADOS API
Date: Sun, 14 Nov 2010 00:41:25 +0900
Message-ID: <AANLkTins-08+N4Wqj-0qSE4XrZ1LaestckCd4RL9w+R2@mail.gmail.com>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com> <1289568944.4894.16.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61998 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825Ab0KMPlr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Nov 2010 10:41:47 -0500
Received: by wwb28 with SMTP id 28so180727wwb.1
        for <ceph-devel@vger.kernel.org>; Sat, 13 Nov 2010 07:41:45 -0800 (PST)
In-Reply-To: <1289568944.4894.16.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi,

On Fri, Nov 12, 2010 at 10:35 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi Takuya,
>
> Great work! I've been following rados4j for a while now (Found you on
> Github), like the approach!
>
> Eucalyptus works with Qemu took right, wouldn't Qemu-RBD be a better
> solution? Or what are your plans with RADOS for Eucalyptus?

I know about qemu-rbd, that's for block device service similar to Amazon EBS.
I only implemented RADOS backend for "Walrus", that is similar to Amazon S3.
So these are different services, which can work together.
I think if both services could integrated into Eucalyptus(or the
another IaaS platform such as OpenStack) that will be exciting.

Ceph already has radosgw for S3 compatible service anyway, but it
looks much easier to use RADOS API from Walrus, so I implemented that
way.

> But great work! I think a lot of people don't see the full potential of
> RADOS, hope your bindings and phprados will make more people use RADOS.
>
> If you ask Sage, he might want to setup a new GIT repo for you and a
> project in the tracker, so we can keep track of bugs and features.
>
> Thanks,
>
> Wido
