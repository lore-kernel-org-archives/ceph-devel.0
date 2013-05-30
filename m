From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw: Files left over after deletion (even after the gc period/process)
Date: Thu, 30 May 2013 09:30:43 -0700
Message-ID: <CABBk=J-wEXMQMgmw4XEANEyNnYXZx2nePN8u7KfYsYFrs3ADqw@mail.gmail.com>
References: <CAF6-1L6pC8UqoFrqMzpZXKrZctwKELw_iKpHDtwvq6ZvRsx_FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:33264 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab3E3Qao (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 12:30:44 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so320785vcb.7
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 09:30:44 -0700 (PDT)
In-Reply-To: <CAF6-1L6pC8UqoFrqMzpZXKrZctwKELw_iKpHDtwvq6ZvRsx_FQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 30, 2013 at 3:21 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
> The basic operation I did was :
>
>  - Upload a file using multi-part upload
>  - Copy that file to a new key
>  - Delete that original file (which only creates a new head)
>  - Delete the copy
>
> And it seems all the multipart & shadow files are not properly deleted.
>

I opened ceph issue #5204 for this, and pushed a fix (on top of
cuttlefish) to the wip-5204 branch.

Thanks,
Yehuda
