From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: [ceph-users] Ceph Rust Librados
Date: Thu, 22 Sep 2016 14:38:57 +1000
Message-ID: <CAF-wwdHKBTn9hMbnrBeFGY7PpoFOfsne6+vYnwCenuY0Cde=Zg@mail.gmail.com>
References: <CAO4wRRTxiZLynydFfk+9hC_p6=05Aopd7mLeO4ji9Ue1Qxh5aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38634 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbcIVEjA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 00:39:00 -0400
Received: by mail-wm0-f46.google.com with SMTP id l132so125730334wmf.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 21:38:59 -0700 (PDT)
In-Reply-To: <CAO4wRRTxiZLynydFfk+9hC_p6=05Aopd7mLeO4ji9Ue1Qxh5aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Jones <chris.jones@lambdastack.io>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 22, 2016 at 1:42 AM, Chris Jones <chris.jones@lambdastack.io> wrote:
> Ceph-rust for librados has been released. It's an API interface in Rust for
> all of librados that's a thin layer above the C APIs. There are low-level
> direct access and higher level Rust helpers that make working directly with
> librados simple.
>
> The official repo is:
> https://github.com/ceph/ceph-rust
>
> The Rust Crate is:
> ceph-rust
>
> Rust is a systems programing language that gives you the speed and low-level
> access of C but with the benefits of a higher level language. The main
> benefits of Rust are:
> 1. Speed
> 2. Prevents segfaults
> 3. Guarantees thread safety
> 4. Strong typing
> 5. Compiled
>
> You can find out more at: https://www.rust-lang.org
>
> Contributions are encouraged and welcomed.
>
> This is the base for a number of larger Ceph related projects.

Can you give us any hints to what these projects will entail?

> Updates to
> the library will be frequent.
>
> Also, there will be new Ceph tools coming soon and you can use the following
> for RGW/S3 access from Rust: (Supports V2 and V4 signatures)
> Crate: aws-sdk-rust - https://github.com/lambdastackio/aws-sdk-rust
>
> Thanks,
> Chris Jones
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Cheers,
Brad
