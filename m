From: Dan van der Ster <dan@vanderster.com>
Subject: Re: fs: mandatory client quota
Date: Fri, 5 May 2017 16:54:19 +0200
Message-ID: <CABZ+qqnFwaV9Va-B4WHp=ntPgKZdsDA1P=m67pLPWU7Y9Tyu+Q@mail.gmail.com>
References: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37870 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdEEOzC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 May 2017 10:55:02 -0400
Received: by mail-it0-f51.google.com with SMTP id x188so7204871itb.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 May 2017 07:55:02 -0700 (PDT)
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com. [209.85.214.43])
        by smtp.gmail.com with ESMTPSA id a68sm1035707itd.30.2017.05.05.07.55.01
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 07:55:01 -0700 (PDT)
Received: by mail-it0-f43.google.com with SMTP id x188so7204164itb.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 May 2017 07:55:01 -0700 (PDT)
In-Reply-To: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 5, 2017 at 4:36 PM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi all,
>
> It would be really nice if for Luminous client quotas were always
> enabled -- it should be impossible to disable quota enforcement on the
> client side.
>
> From the looks of things, the patch to remove client_quota and
> client_quota_df would be trivial.
> Is there some reason we need to leave that optional?

PR: 14978
