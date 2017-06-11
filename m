From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure_code_version() for a new erasure code
Date: Sun, 11 Jun 2017 08:51:06 +0200
Message-ID: <bb2cbb3a-cb7a-d4cd-ed6e-187dd1b61677@dachary.org>
References: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
 <ad68008d-59ab-2cd0-03c7-b7896ac955ea@dachary.org>
 <CAODUPsFQ+7Je-pahjaayrqy8+uDHFAc+2Atz6atjmROJ5hV+Mw@mail.gmail.com>
 <aa4efbd2-c28d-2255-a536-892ecc89157c@dachary.org>
 <CAODUPsEzgwXH32CoyvuLe+JMdrOUnG6tjTD01WCdwfQvgMan-A@mail.gmail.com>
 <e1caaa40-5981-0dba-9dfe-eb2b6d1f682e@dachary.org>
 <eab906b8-d64d-aaa3-ac82-84d73a9bb947@suse.cz>
 <CAODUPsE0VHUgKVPrkQn0Faq8f=fsHJswHu=C6meo7YdW15jYRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35730 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdFKGvK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jun 2017 02:51:10 -0400
In-Reply-To: <CAODUPsE0VHUgKVPrkQn0Faq8f=fsHJswHu=C6meo7YdW15jYRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel@vger.kernel.org



On 06/11/2017 06:21 AM, Oleg Kolosov wrote:
> Hi Nathan, 
> I've used branch 10.2.2

You should try with the master branch instead. This is where new features need to be contributed.

Cheers

> 
> Thanks,
> Oleg
> 
> On Jun 11, 2017 7:19 AM, "Nathan Cutler" <ncutler@suse.cz <mailto:ncutler@suse.cz>> wrote:
> 
>             I've tried renaming lrc lib to the name of my code (I've edited
>             Makefile.am and CMakeLists.txt to match the new name), to see whether
>             it'll run, but again I got the same error.
> 
> 
>         Makefile.am is not used anymore, you can ignore it.
> 
> 
>     There is no Makefile.am at all in master; it was ripped out. So presumably Oleg is not basing his changes on master.
> 
>     The "jewel" branch does have both Makefile.am and CMakeLists.txt, but cmake in jewel is not expected to work. Oleg, which branch are you basing your changes on?
> 
>     Nathan
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
