From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: CLI test for rbd
Date: Mon, 17 Jul 2017 08:48:06 -0400
Message-ID: <CA+aFP1CU4igK=byYaRvkLbWndgaizzZC8_3sN0Gc3PCO_SwgtA@mail.gmail.com>
References: <59aa8ba0-42e8-feaa-d6aa-ec16131fd062@digiware.nl>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33439 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdGQMsH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jul 2017 08:48:07 -0400
Received: by mail-yb0-f180.google.com with SMTP id w187so16676676ybc.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jul 2017 05:48:07 -0700 (PDT)
In-Reply-To: <59aa8ba0-42e8-feaa-d6aa-ec16131fd062@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Feel free to disable that under FreeBSD -- I'm sure it's not the only
test disabled. I don't want to remove the test outright since it
exercises a normally untested code path and it helps to focus
attention to the CLI documentation during reviews.

On Sun, Jul 16, 2017 at 5:25 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> with the creation of rbd-ggate with FreeBSD we have run into a testing
> snag..
>
> Of rbd tehere is a CLI command help test, that verifies that help generates
> help.
> But under FreeBSD that help is augmented with some ggate commands.
>
> Do we really want/need that test?
> And might I suggest to remove it, as it is IMHO not al that informative.
>
> Otherwise we need to come up with something rather complex to make
> run-cli-tests work on FreeBSD as well.
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
