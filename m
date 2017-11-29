From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Questions regarding mds early reply
Date: Wed, 29 Nov 2017 16:33:45 +0800
Message-ID: <CAAM7YAm4Dnzcc9uz-5iL9kaigoFbKjsZJjVP9J_LQX00zeia2w@mail.gmail.com>
References: <CAEYCsVJCz4ecJNXyKLF0EyovJw8sLHwb_uzMBQaZVfasuuy+cw@mail.gmail.com>
 <CAEYCsVJAamRkFeH_3St0dMybks97q09P4b-h0+nVrFNPy_c-BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:32894 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK2Idq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 03:33:46 -0500
Received: by mail-ot0-f175.google.com with SMTP id h9so2364631oti.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Nov 2017 00:33:46 -0800 (PST)
In-Reply-To: <CAEYCsVJAamRkFeH_3St0dMybks97q09P4b-h0+nVrFNPy_c-BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 29, 2017 at 10:15 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Hi,
>
>       When reading the early reply logical,  i am not very understand
> why we can reply to the client before committing to journal?  Is there
> anywhere the change get persisted or we rely on client-replay when MDS
> failure happens?

Early reply is similar to the return of syscall on local filesystem.
It only tells request initiator that mds has made the change to its
cache. Later requests from the same client (request initiator) can
read the change. Other clients can not read the change until the
change get committed to journal.

>       If this is the case, what if the client also failed during this period?
>

If both mds and client failed, the change gets lost. This does not
compromise consistency because no other clients have seem the change.


>       Thanks for providing the hints.
>
> Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
