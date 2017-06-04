From: kefu chai <tchaikov@gmail.com>
Subject: Re: VLA detection ...
Date: Sun, 4 Jun 2017 11:28:29 +0800
Message-ID: <CAJE9aONhiWL+gHMKaeeg95mnSpua+DeDbArks+O=okKDh3k=YQ@mail.gmail.com>
References: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35406 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDD2b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jun 2017 23:28:31 -0400
Received: by mail-vk0-f48.google.com with SMTP id w1so54490377vkd.2
        for <ceph-devel@vger.kernel.org>; Sat, 03 Jun 2017 20:28:30 -0700 (PDT)
In-Reply-To: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Jesse Williamson <jwilliamson@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jun 3, 2017 at 2:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> Now that we have -Wvla set:
> ===
>     Adds C++ warning flag for C Variable-Length Arrays.
>
>     C VLAs are not supported in C++. However, the GNU compiler allows
>     them as an extension, which it does not warn about when not in
>     pedantic mode. Unfortunately, it's easy to accidentally write
>     a VLA, even unintentionally-- adding this warning will help us
>     catch that.
> ===
>
> Are there going to be attempts to eradicate this usage?
> Note that Clang also supports VLAs:
> ===
> GCC and C99 allow an array's size to be determined at run time. This
> extension is not permitted in standard C++. However, Clang supports such
> variable length arrays for compatibility with GNU C and C99 programs.
> ===
>

it's not in C++11 standard. but it's a handy feature in practice. i
still have trouble understanding we want to have -Wvla. i was trying
to silence this warning option last night but failed to move further
after several attempts. see https://github.com/ceph/ceph/pull/15441.

probably, Jesse have more insights on this.



> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
