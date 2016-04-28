From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: building boost statically
Date: Thu, 28 Apr 2016 16:05:59 -0700
Message-ID: <CADRKj5T5oJrrbhHDECFgkphejab6o=ApBQ7sHhpcuCWqYEL_Pg@mail.gmail.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34360 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcD1XGC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 19:06:02 -0400
Received: by mail-yw0-f173.google.com with SMTP id j74so133280533ywg.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 16:06:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Dreyer, Ken" <kdreyer@redhat.com>

On Thu, Apr 28, 2016 at 3:47 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi all,
>
> We'd really like to use the latest boost, mainly so that we can use
> small_vector in a zillion places and avoid extra memory allocations.  The
> distros, as always, are behind.
>
> The thoguht is to bring it in as yet another submodule, build it
> statically (it's pretty fast), and link statically.  There are a handful
> of places where the distro boost links dynamically.  For example, on
> xenial, it's
>
> libboost-iostreams1.58.0
> libboost-program-options1.58.0
> libboost-random1.58.0
> libboost-system1.58.0
> libboost-thread1.58.0
>
> I'm not sure how we should deal with that.  We could simply link it
> statically.  Alternatively, we could ship packages.. but if we do that we
> might as well just conditionally build against the new features and then
> build a full set of backported boost packages for the distros we care
> about.
>
> I'm not sure how to best proceed.  But it would be really great to get
> access to new boost features like small_vector...
>

If we need to have it as a submodule then build it conditionally. Then
make a decision per distro, whether we want to not use new
functionality, or backport packages, or have it linked statically.

Yehuda
