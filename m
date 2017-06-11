From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: erasure_code_version() for a new erasure code
Date: Sun, 11 Jun 2017 07:48:13 +0300
Message-ID: <CAODUPsG_n9ug2TV92gRyGsPjuKWTziP30QfEdV=bw+UwdY2AjQ@mail.gmail.com>
References: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
 <ad68008d-59ab-2cd0-03c7-b7896ac955ea@dachary.org> <CAODUPsFQ+7Je-pahjaayrqy8+uDHFAc+2Atz6atjmROJ5hV+Mw@mail.gmail.com>
 <aa4efbd2-c28d-2255-a536-892ecc89157c@dachary.org> <CAODUPsEzgwXH32CoyvuLe+JMdrOUnG6tjTD01WCdwfQvgMan-A@mail.gmail.com>
 <e1caaa40-5981-0dba-9dfe-eb2b6d1f682e@dachary.org> <eab906b8-d64d-aaa3-ac82-84d73a9bb947@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33544 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdFKEsP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jun 2017 00:48:15 -0400
Received: by mail-oi0-f52.google.com with SMTP id s3so42775435oia.0
        for <ceph-devel@vger.kernel.org>; Sat, 10 Jun 2017 21:48:14 -0700 (PDT)
In-Reply-To: <eab906b8-d64d-aaa3-ac82-84d73a9bb947@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

Hi Nathan,
I've used branch 10.2.2

Thanks,
Oleg

On Sun, Jun 11, 2017 at 7:19 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> I've tried renaming lrc lib to the name of my code (I've edited
>>> Makefile.am and CMakeLists.txt to match the new name), to see whether
>>> it'll run, but again I got the same error.
>>
>>
>> Makefile.am is not used anymore, you can ignore it.
>
>
> There is no Makefile.am at all in master; it was ripped out. So presumably
> Oleg is not basing his changes on master.
>
> The "jewel" branch does have both Makefile.am and CMakeLists.txt, but cmake
> in jewel is not expected to work. Oleg, which branch are you basing your
> changes on?
>
> Nathan
