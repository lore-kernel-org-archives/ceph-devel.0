From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: migrating dmcrypt keys ?
Date: Mon, 20 Feb 2017 15:17:50 -0500
Message-ID: <CAGbviv+5PvSYJCxrGWY5-TcDOTEu-h_z_-qbgdzuqk4zSN0V1w@mail.gmail.com>
References: <CAGbvivJVPkqdMhWuf=5Lx6DSi9UR9aYnAGtqT7K23NO31y_bPg@mail.gmail.com>
 <dd16ff32-75e9-3f58-b0cc-50a162774d0a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36130 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdBTURw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 15:17:52 -0500
Received: by mail-it0-f54.google.com with SMTP id h10so80190135ith.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 12:17:51 -0800 (PST)
In-Reply-To: <dd16ff32-75e9-3f58-b0cc-50a162774d0a@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Can you elaborate - specifically what would I look for in ceph-disk?
I would be interested in writing the migration tool if I knew where to
start digging.

thanks!

On Mon, Feb 20, 2017 at 2:56 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> On 02/20/2017 08:49 PM, Wyllys Ingersoll wrote:
>> Is it possible to migrate a legacy (i..e pre-Jewel) osd device that
>> was originally setup with dmcrypt keys in /etc/ceph/dmcrypt-keys to
>> use the newer osd-lockbox scheme without having to destroy the osd and
>> re-prepare it?
>
> You can do it manually by mimicing what ceph-disk does. It would be nice =
to have a tool to do that.
>
> Cheers
>
>>
>> Thanks
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
