From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Question about rbd layering kernel warning
Date: Sun, 13 Mar 2016 14:47:34 +0100
Message-ID: <CAOi1vP_dW7V2G8zg2QL=qzhARqxYQRPSgq4BZfNQQLvob-abiw@mail.gmail.com>
References: <CA+a=Yy48ZQan3AKU_GrtOefaENaju5dKgrCaxxL-RBjq5VZg7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35924 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbcCMNrg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Mar 2016 09:47:36 -0400
Received: by mail-lb0-f171.google.com with SMTP id x1so208462203lbj.3
        for <ceph-devel@vger.kernel.org>; Sun, 13 Mar 2016 06:47:35 -0700 (PDT)
In-Reply-To: <CA+a=Yy48ZQan3AKU_GrtOefaENaju5dKgrCaxxL-RBjq5VZg7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peng Tao <bergwolf@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>

On Sun, Mar 13, 2016 at 12:45 PM, Peng Tao <bergwolf@gmail.com> wrote:
> Hi,
>
> The warning about rbd layering in kernel client code has been there
> for more than three years, since it was first activated by commit
> 770eba6e2 (rbd: activate support for layered images) in Oct 2012.
>
> Now users still get "WARNING: kernel layering is EXPERIMENTAL!" when
> mapping an image with parent. Is it time to just drop the warning? Or
> is there still stability concern in some cases?

We certainly don't regard kernel layering as EXPERIMENTAL - any issue
with it will be treated the same as any other krbd issue, and I'm not
aware of any serious stability concerns with it, compared to the rest
of krbd.

OTOH, we are working on adding support for object-map and deep-flatten
features for krbd, bringing a fair amount of new code and complexity
into the layering code path.  The plan was to merge those features and
drop this warning some time after that.

Thanks,

                Ilya
