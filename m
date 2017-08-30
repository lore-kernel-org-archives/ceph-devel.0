From: kefu chai <tchaikov@gmail.com>
Subject: Re: Commit messages + labels for mgr modules
Date: Wed, 30 Aug 2017 12:32:54 +0800
Message-ID: <CAJE9aOPnur2uN3aaQ1usruXnPphEi_C4zWBE1CSOkNecqu=bpQ@mail.gmail.com>
References: <CALe9h7fWg=E9napbLAQMBefOHZsbnBvzP16f-M72P469we4NDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34480 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdH3Ecz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 00:32:55 -0400
Received: by mail-oi0-f43.google.com with SMTP id w10so43009387oie.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 21:32:54 -0700 (PDT)
In-Reply-To: <CALe9h7fWg=E9napbLAQMBefOHZsbnBvzP16f-M72P469we4NDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 29, 2017 at 9:42 PM, John Spray <jspray@redhat.com> wrote:
> Hi all,
>
> mgr modules live in src/pybind/mgr/<module>, so we've had sort of a
> mixture of styles in commit messages like "mgr: ", "mgr/<module>",
> "pybind:", etc.
>
> I'd like to standardize on "mgr/<module>:", even though it doesn't
> strictly match the source code path.  Also, to always use the "mgr"
> label rather than the pybind one.  Sound okay?

makes sense to me. another reason to do so: the mgr plugins are also
packaged along with ceph-mgr.

>
> I guess we could also move the modules into mgr/modules or something
> instead of pybind, but I think in that case I would still want to use
> mgr/<module> to be nice and terse.
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
