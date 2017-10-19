From: John Spray <jspray@redhat.com>
Subject: Re: librados3
Date: Thu, 19 Oct 2017 11:43:52 +0100
Message-ID: <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:46718 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdJSKoN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 06:44:13 -0400
Received: by mail-wr0-f175.google.com with SMTP id l1so7830357wrc.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 03:44:13 -0700 (PDT)
In-Reply-To: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

On Thu, Oct 19, 2017 at 10:25 AM, kefu chai <tchaikov@gmail.com> wrote:
> in luminous, we introduced a change not backward compatible with
> pre-luminous librados. see see http://tracker.ceph.com/issues/21573.
> and i cannot see an obvious solution without bumping up the so version
> of librados to 3.
>
> if we have the luxury to do it,  we will be able to give librados an
> overhaul. for a todo list, see http://pad.ceph.com/p/librados3.
>
> what do you think?

I've added a couple of items to the pad for deprecated bits to remove
when we go up a version.

I guess we would do the version bump for Mimic and for Luminous we
will just have to apologetically tell people they need to recompile?

Or we could have a so.3 version (ABI change only) in Luminous that
just bumps the version to force a recompile, and a so.4 version in
Mimic that actually makes the API changes?

John

>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
