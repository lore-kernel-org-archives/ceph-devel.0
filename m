From: Loic Dachary <loic@dachary.org>
Subject: Re: Standalone libcrush: call for participation
Date: Mon, 23 Jan 2017 22:59:40 +0100
Message-ID: <8256c0b6-a1b4-0c91-8832-35183dfdc9ed@dachary.org>
References: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
 <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com>
 <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
 <CAOi1vP8U_YFZ18qr0PT1afcRRNT5-5P3Ei3TCQ8udWjtAQ5Ckw@mail.gmail.com>
 <5d8fcfa6-3bf7-b29e-22a9-4d2864194afd@dachary.org>
 <CAOi1vP-g0F9-K4qyzk3ft3bQD9GV5Xs6PFuBjgws3FgHhQDKag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43602 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdAWWA3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 17:00:29 -0500
In-Reply-To: <CAOi1vP-g0F9-K4qyzk3ft3bQD9GV5Xs6PFuBjgws3FgHhQDKag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/23/2017 10:44 PM, Ilya Dryomov wrote:
> On Mon, Jan 23, 2017 at 9:16 PM, Loic Dachary <loic@dachary.org> wrote:
>>
>>> Some documentation will probably need to be added to cover things like
>>> basic kernel compatibility (no floating point, stubs for asserts, etc)
>>> and coding style for the C bits.
>>
>> I added this
>>
>> http://libcrush.org/main/libcrush/blob/wip-2-doxygen/doc/contributing.md#linux-kernel
>>
>> Do you have anything else in mind ?
> 
> No need to try to list all the kernel quirks -- just point to
> crush_compat.h.
> 
> These are the files that are shared:
> 
> - crush.[ch]
> - crush_ln_table.h
> - hash.[ch]
> - mapper.[ch]
> 
> Everything else is fair game, notably builder.[ch].

Understood :-)

Is this http://libcrush.org/main/libcrush/blob/wip-2-doxygen/doc/mainpage.dox#L47 better ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
