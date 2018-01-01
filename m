From: kefu chai <tchaikov@gmail.com>
Subject: Re: Moving to 1.66 Boost
Date: Mon, 1 Jan 2018 20:13:17 +0800
Message-ID: <CAJE9aOP6zETWTREUoD3WFj6trXZHQ7aYOr2=KEK=EiB7tWyLWw@mail.gmail.com>
References: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
 <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com> <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46635 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAAMNS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jan 2018 07:13:18 -0500
Received: by mail-qt0-f195.google.com with SMTP id r39so60116304qtr.13
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jan 2018 04:13:18 -0800 (PST)
In-Reply-To: <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, Jan 1, 2018 at 7:13 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 31/12/2017 06:30, kefu chai wrote:
>>
>> + ceph-devl
>>
>> On Wed, Dec 27, 2017 at 5:47 PM, Willem Jan Withagen <wjw@digiware.nl>
>> wrote:
>>>
>>> Hi Kefu,
>>>
>>> In FreeBSD the portmanager of Boost wants to move to 1.66, and so
>>> normally
>>> they do a test run on all 33.000 ports to see what breaks.
>>>
>>> Now one of the things that breaks is Ceph, but i a way I do not
>>> understand...
>>>
>>> When linking ceph-common references to the /usr/local/lib/libboost_*.so
>>> files on Boost 1.65 are now replaced by -lBoost::thread invocations
>>> 1.66??
>>
>>
>> could you pastebin the error message? Boost::thread is the library name.
>> but I
>> don't think it can be passed to the linker. if you see this in the
>> command line,
>> something is wrong.
>
>
> It was the now traditional problem that a CMake upgrade does not run in sync
> with Boost upgrades. Took quite some runs, but now FreeBSD ports is at

i don't really follow. guess what you mean is that: it's back to normal..

> 12.2.2, and in preparation on the 1.66 Boost release it builds without Beast
> by execluding WITH_RADOSGW_BEAST_FRONTEND.
>
> Which will be switched back on once the 1.66 Beast works with v12.2.2.
>
> --WjW
>



-- 
Regards
Kefu Chai
