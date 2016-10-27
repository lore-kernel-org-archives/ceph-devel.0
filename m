From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: rgw and the next jewel release v10.2.4
Date: Thu, 27 Oct 2016 20:33:55 +0200
Message-ID: <CABo9giSD3B=83d7yRyJLX7zg1NTrELFM4jK+uNLNzZ0sgMmSOQ@mail.gmail.com>
References: <5811C853.1070706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36773 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935043AbcJ0Sd7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 14:33:59 -0400
Received: by mail-wm0-f51.google.com with SMTP id b80so51211605wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 11:33:58 -0700 (PDT)
In-Reply-To: <5811C853.1070706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi Loic,
We still need :
https://github.com/ceph/ceph/pull/11472
https://github.com/ceph/ceph/pull/11669 (needs teuthology run)

Nice to have:
http://tracker.ceph.com/issues/17372
http://tracker.ceph.com/issues/17571

Thanks,
Orit

On Thu, Oct 27, 2016 at 11:26 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yehuda,
>
> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the rgw suite (http://tracker.ceph.com/issues/17487#note-18). Do you think the jewel branch is ready for QE to start their own round of testing ?
>
> Cheers
>
> --
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
