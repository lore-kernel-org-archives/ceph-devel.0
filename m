From: Haomai Wang <haomai@xsky.com>
Subject: Re: building boost statically
Date: Thu, 28 Apr 2016 21:31:34 -0500
Message-ID: <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0094.outbound.protection.outlook.com ([104.47.125.94]:61107
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752793AbcD2Cqd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2016 22:46:33 -0400
Received: by mail-yw0-f180.google.com with SMTP id j74so139975687ywg.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 19:31:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ken Dreyer <kdreyer@redhat.com>

On Thu, Apr 28, 2016 at 5:47 PM, Sage Weil <sweil@redhat.com> wrote:
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

Yes, I'm always glad to see more deps removed!

And I think we can remove part of boost library deps totally to reduce
adding static lib size? like libboost-random and libboost-thread or
anything else. We may replace with c++11 lib(I'm not a boost fan....).

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
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
