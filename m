From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Standalone libcrush: call for participation
Date: Mon, 23 Jan 2017 22:44:43 +0100
Message-ID: <CAOi1vP-g0F9-K4qyzk3ft3bQD9GV5Xs6PFuBjgws3FgHhQDKag@mail.gmail.com>
References: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
 <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com> <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
 <CAOi1vP8U_YFZ18qr0PT1afcRRNT5-5P3Ei3TCQ8udWjtAQ5Ckw@mail.gmail.com> <5d8fcfa6-3bf7-b29e-22a9-4d2864194afd@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38430 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdAWVpl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 16:45:41 -0500
Received: by mail-wm0-f44.google.com with SMTP id r144so178090969wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 13:44:44 -0800 (PST)
In-Reply-To: <5d8fcfa6-3bf7-b29e-22a9-4d2864194afd@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 9:16 PM, Loic Dachary <loic@dachary.org> wrote:
>
>> Some documentation will probably need to be added to cover things like
>> basic kernel compatibility (no floating point, stubs for asserts, etc)
>> and coding style for the C bits.
>
> I added this
>
> http://libcrush.org/main/libcrush/blob/wip-2-doxygen/doc/contributing.md#linux-kernel
>
> Do you have anything else in mind ?

No need to try to list all the kernel quirks -- just point to
crush_compat.h.

These are the files that are shared:

- crush.[ch]
- crush_ln_table.h
- hash.[ch]
- mapper.[ch]

Everything else is fair game, notably builder.[ch].

Thanks,

                Ilya
