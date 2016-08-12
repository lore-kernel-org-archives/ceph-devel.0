From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: 0.94.8 to QE
Date: Fri, 12 Aug 2016 16:17:21 +0200
Message-ID: <CABo9giTv1J2ZuR7VcXWES4bL+ZrZSERpm710z9edg-sE8Su4Sw@mail.gmail.com>
References: <20160810162336.GA10146@wilbur.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38238 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcHLORX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 10:17:23 -0400
Received: by mail-wm0-f46.google.com with SMTP id o80so36808297wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 07:17:22 -0700 (PDT)
In-Reply-To: <20160810162336.GA10146@wilbur.suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Yehuda Sadeh <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Nathan,
We are still missing two pr:
https://github.com/ceph/ceph/pull/7184
https://github.com/ceph/ceph/pull/10509

I scheduled a teuthology run for them and if it is successful I will merge them.
I am not aware of other pending rgw backports.

Orit

On Wed, Aug 10, 2016 at 6:23 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Yehuda:
>
> Do you think 0.94.8 is ready for QE to start testing, from RGW perspective?
>
> Regards,
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
