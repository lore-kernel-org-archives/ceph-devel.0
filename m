From: John Spray <jspray@redhat.com>
Subject: Re: ceph osd metadata fails if any osd is down
Date: Wed, 21 Sep 2016 22:12:40 +0100
Message-ID: <CALe9h7dR7oqP73JfBHHFwQYK8TkhRVM2fKtvCi4YoZEk4s4Z8g@mail.gmail.com>
References: <CAGbviv+8SkMApa8sbc4-ZjvRxRUVM-SZR+dt2u1CvGshVRoinA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33890 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754708AbcIUVNB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 17:13:01 -0400
Received: by mail-qk0-f175.google.com with SMTP id n185so58854984qke.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 14:13:01 -0700 (PDT)
In-Reply-To: <CAGbviv+8SkMApa8sbc4-ZjvRxRUVM-SZR+dt2u1CvGshVRoinA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 6:29 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> In 10.2.2 when running "ceph osd metadata" (defaulting to get metdata for
> "all" OSDs), if even 1 OSD is currently marked "down", the entire command
> fails and returns an error:
>
> $ ceph osd metadata
> Error ENOENT:
>
> - One OSD in the cluster was "down", I removed that OSD and re-ran the
> command successfully.
>
> It seems that the "metadata" command should be able to dump the data for
> the OSDs that are up and ignore the ones that are down.  Is this a known
> bug?

Probably fixed by
https://github.com/ceph/ceph/commit/f5db5a4b0bb52fed544f277c28ab5088d1c3fc79
which is in 10.2.3

John

>
> -Wyllys Ingersoll
>  Keeper Technology, LLC
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
