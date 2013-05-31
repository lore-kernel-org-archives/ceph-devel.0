From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rgw: Do not assume rest connection to be established
Date: Fri, 31 May 2013 09:32:20 -0700
Message-ID: <CABBk=J9ZA=y1Sk=qfyFU76XLZwEW7ZZJzUDuC7me7bwdcZNr9w@mail.gmail.com>
References: <CAA8043ghxcjqcUha0A+CbWPuSkeSN5RkraT1rJOJJ5r+_wwSVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:45546 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab3EaQcV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 12:32:21 -0400
Received: by mail-vc0-f171.google.com with SMTP id m16so568574vca.30
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 09:32:20 -0700 (PDT)
In-Reply-To: <CAA8043ghxcjqcUha0A+CbWPuSkeSN5RkraT1rJOJJ5r+_wwSVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I applied a slightly modified version of this one, as the base has
changed a bit since, and I also made some style fixes.

Thanks!
Yehuda

On Fri, May 31, 2013 at 1:07 AM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
> This patch fixes a bug in the wip-rgw-geo-2 branch.
>
> The bug is that if you do not have a region map, the rest connection
> will not be established, and reaching this code will lead to a
> segmentation fault.
>
> This patch prevents it.
>
> Best regards.
>
> --
> Christophe Courtaut
