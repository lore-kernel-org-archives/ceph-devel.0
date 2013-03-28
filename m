From: Lorieri <lorieri@gmail.com>
Subject: Re: radosgw S3 api
Date: Thu, 28 Mar 2013 01:33:34 -0300
Message-ID: <CAPHxCcRcotZbVDTbQVvrwLZ-xgQs5ObKmJyt9989wNwM2si3LQ@mail.gmail.com>
References: <CAPHxCcSX7CRS2+-CWA7hGYAZKSm2PDn+hYd6+EtqHtSm+8fN3w@mail.gmail.com>
	<CAC-hyiEzLgZ6LKt2hX43Ac9xWUETz0CP_XzL77aaFx6M+=JheA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54595 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3C1Edf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Mar 2013 00:33:35 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so6588787ieb.8
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 21:33:34 -0700 (PDT)
In-Reply-To: <CAC-hyiEzLgZ6LKt2hX43Ac9xWUETz0CP_XzL77aaFx6M+=JheA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

great!
I will try this.
Will it affect objects later put through S3 api ?

On Wed, Mar 27, 2013 at 11:12 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>
> On Wed, Mar 27, 2013 at 4:03 PM, Lorieri <lorieri@gmail.com> wrote:
> > Hi,
> >
> > There is a behavior in AWS S3 I could not reproduce in radosgw.
> >
> > If you create an empty bucket and makes it public, any object you put
> > there will be public too, and will automatically be possible to access
> > it by its http url.
> > It is very helpful when people use some tools and browsers plugins to
> > upload content or do a bulk sync.
> >
> > am I missing something ?
>
> The S3 ACLs don't allow that. Amazon provides a different orthogonal
> scheme (bucket policies) that we don't support and that makes it
> possible.
> With the rados gateway you can achieve that if you're using the swift
> api and setting the bucket public through it.
>
>
> Yehuda
