From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [ceph-users] Ceph.conf
Date: Thu, 10 Sep 2015 09:57:52 +0100
Message-ID: <CAJ4mKGbF1zME=hQxjk5SOxqxnYDxPeJZgsZ=Sf3m=TNW-9e=eg@mail.gmail.com>
References: <719445511.14807548.1441873777873.JavaMail.zimbra@redhat.com>
	<945773049.14811634.1441874647066.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34115 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbbIJI5x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 04:57:53 -0400
Received: by wicfx3 with SMTP id fx3so19438855wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2015 01:57:52 -0700 (PDT)
In-Reply-To: <945773049.14811634.1441874647066.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 10, 2015 at 9:44 AM, Shinobu Kinjo <skinjo@redhat.com> wrote:
> Hello,
>
> I'm seeing 859 parameters in the output of:
>
>     $ ./ceph --show-config | wc -l
>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>     859
>
> In:
>
>     $ ./ceph --version
>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>     ceph version 9.0.2-1454-g050e1c5 (050e1c5c7471f8f237d9fa119af98c1efa9a8479)
>
> Since I'm quite new to Ceph, so my question is:
>
>     Where can I know what each parameter exactly mean?
>
> I am probably right. Some parameters are just for tes-
> ting purpose.

Yes. A bunch shouldn't ever be set by users. A lot of the ones that
should be are described as part of various operations in
ceph.com/docs, but I don't know which ones of interest are missing
from there. It's not very discoverable right now, unfortunately.
-Greg

>
> Thank you for your help in advance.
>
> Shinobu
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
