From: Samuel Just <sjust@redhat.com>
Subject: Re: Status of static analysis
Date: Mon, 19 Dec 2016 09:30:06 -0800
Message-ID: <CAN=+7FV0ofLTufVNE2pVtPqS=zK3w7FrkdVdn8pup+NEBXcdbw@mail.gmail.com>
References: <20161219024554.GA6396@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36750 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755531AbcLSRaH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2016 12:30:07 -0500
Received: by mail-qk0-f176.google.com with SMTP id n21so16968653qka.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2016 09:30:07 -0800 (PST)
In-Reply-To: <20161219024554.GA6396@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Very cool!
-Sam

On Sun, Dec 18, 2016 at 6:45 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> As you would have noticed in recent weeks we have returned to  running a
> Coverity test over the source tree on a weekly basis. In addition, I have been
> running Clang Static Analyzer and Cppcheck scans. Until we can find a better
> home for these and include at least one of them in our CI processes I will be
> hosting them at http://people.redhat.com/bhubbard/
>
> --
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
