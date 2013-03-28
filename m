From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw S3 api
Date: Wed, 27 Mar 2013 19:12:18 -0700
Message-ID: <CAC-hyiEzLgZ6LKt2hX43Ac9xWUETz0CP_XzL77aaFx6M+=JheA@mail.gmail.com>
References: <CAPHxCcSX7CRS2+-CWA7hGYAZKSm2PDn+hYd6+EtqHtSm+8fN3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:50994 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab3C1CMU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 22:12:20 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so16905363lab.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 19:12:19 -0700 (PDT)
In-Reply-To: <CAPHxCcSX7CRS2+-CWA7hGYAZKSm2PDn+hYd6+EtqHtSm+8fN3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lorieri <lorieri@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Mar 27, 2013 at 4:03 PM, Lorieri <lorieri@gmail.com> wrote:
> Hi,
>
> There is a behavior in AWS S3 I could not reproduce in radosgw.
>
> If you create an empty bucket and makes it public, any object you put
> there will be public too, and will automatically be possible to access
> it by its http url.
> It is very helpful when people use some tools and browsers plugins to
> upload content or do a bulk sync.
>
> am I missing something ?

The S3 ACLs don't allow that. Amazon provides a different orthogonal
scheme (bucket policies) that we don't support and that makes it
possible.
With the rados gateway you can achieve that if you're using the swift
api and setting the bucket public through it.


Yehuda
