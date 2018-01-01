From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Moving to 1.66 Boost
Date: Mon, 1 Jan 2018 18:07:54 +0100
Message-ID: <11331bc5-b0c5-29fd-0f1f-95af8698b489@digiware.nl>
References: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
 <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com>
 <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
 <CAJE9aOP6zETWTREUoD3WFj6trXZHQ7aYOr2=KEK=EiB7tWyLWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43787 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbeAARH5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 1 Jan 2018 12:07:57 -0500
In-Reply-To: <CAJE9aOP6zETWTREUoD3WFj6trXZHQ7aYOr2=KEK=EiB7tWyLWw@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 01/01/2018 13:13, kefu chai wrote:
> On Mon, Jan 1, 2018 at 7:13 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 31/12/2017 06:30, kefu chai wrote:
>>>
>>> + ceph-devl
>>>
>>> On Wed, Dec 27, 2017 at 5:47 PM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>>
>>>> Hi Kefu,
>>>>
>>>> In FreeBSD the portmanager of Boost wants to move to 1.66, and so
>>>> normally
>>>> they do a test run on all 33.000 ports to see what breaks.
>>>>
>>>> Now one of the things that breaks is Ceph, but i a way I do not
>>>> understand...
>>>>
>>>> When linking ceph-common references to the /usr/local/lib/libboost_*.so
>>>> files on Boost 1.65 are now replaced by -lBoost::thread invocations
>>>> 1.66??
>>>
>>>
>>> could you pastebin the error message? Boost::thread is the library name.
>>> but I
>>> don't think it can be passed to the linker. if you see this in the
>>> command line,
>>> something is wrong.
>>
>>
>> It was the now traditional problem that a CMake upgrade does not run in sync
>> with Boost upgrades. Took quite some runs, but now FreeBSD ports is at
> 
> i don't really follow. guess what you mean is that: it's back to normal..

Sorry to be cryptic ..
But yes, back to normal.

--WjW


