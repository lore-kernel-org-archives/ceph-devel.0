From: Haomai Wang <haomai@xsky.com>
Subject: Re: Ceph 12.0.0/master + DPDK = compilation failed
Date: Mon, 3 Apr 2017 20:18:20 +0800
Message-ID: <CACJqLybmU0oO_26OiVFY+v=r9yVpc7vLc4BCzyuykZGZP4p4ug@mail.gmail.com>
References: <e4303dd9-f37e-9a98-344e-df9fc43bc754@tionix.ru> <d4410ce1-5767-f1f8-5699-2288f484fb86@tionix.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0093.outbound.protection.outlook.com ([104.47.125.93]:32736
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752956AbdDCMSd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 3 Apr 2017 08:18:33 -0400
Received: by mail-io0-f175.google.com with SMTP id z13so73774236iof.2
        for <ceph-devel@vger.kernel.org>; Mon, 03 Apr 2017 05:18:25 -0700 (PDT)
In-Reply-To: <d4410ce1-5767-f1f8-5699-2288f484fb86@tionix.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aynur Shakirov <ajnur.shakirov@tionix.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

it looks a few binary met linking problem, we could fix that in CMakefiles

On Mon, Apr 3, 2017 at 7:46 PM, Aynur Shakirov <ajnur.shakirov@tionix.ru> wrote:
> Hello all!
>
> Meta:
> OS: Ubuntu 16.04.1 up-to-date
> Kernel: 4.8.0-42-generic
> GCC: 5.4.0 (ubuntu)
> Compiler flags: -O2, march=native or broadwell, -j 4
> Ceph: 12.0.0, 12.0.1, master (from git)
> DPDK: 16.07.2, 16.11, 16.11.1, submodule or upstream.
>
> Description.
> I want to use the DPDK messenger for Ceph, but upstream packages (looks
> like) doesn't contain the messenger as option. OK, I can compile Ceph with
> neccesary flags (-DWITH_DPDK=ON -DCRYPTOPP=ON) and build deb packages
> (thanks for make-debs script!).
>
> To make-debs.sh I added the commands for adding flags for dpdk and crypto++
> into debian/rules. Script starts, but when gcc are trying linking for
> ceph-syn with DPDK libraries I gets compile error. Logs of compilation from
> beginning is here: http://paste.ubuntu.com/24306084/ (error messages starts
> from 19056).
>
> I tried to compile with another versions of DPDK and Ceph, but without
> success (see Meta for versions).
>
> Why is this happening?  What am I doing wrong? :)
>
> Thanks a lot!
>
> ---
> Sincerely,
> Aynur Shakirov, 27.
> TIONIX Russia.
> Planet Earth, Solar System, Milky Way.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
