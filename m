From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Moving to 1.66 Boost
Date: Mon, 1 Jan 2018 12:13:16 +0100
Message-ID: <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
References: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
 <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:31153 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbeAALNP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 1 Jan 2018 06:13:15 -0500
In-Reply-To: <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 31/12/2017 06:30, kefu chai wrote:
> + ceph-devl
> 
> On Wed, Dec 27, 2017 at 5:47 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi Kefu,
>>
>> In FreeBSD the portmanager of Boost wants to move to 1.66, and so normally
>> they do a test run on all 33.000 ports to see what breaks.
>>
>> Now one of the things that breaks is Ceph, but i a way I do not
>> understand...
>>
>> When linking ceph-common references to the /usr/local/lib/libboost_*.so
>> files on Boost 1.65 are now replaced by -lBoost::thread invocations 1.66??
> 
> could you pastebin the error message? Boost::thread is the library name. but I
> don't think it can be passed to the linker. if you see this in the
> command line,
> something is wrong.

It was the now traditional problem that a CMake upgrade does not run in 
sync with Boost upgrades. Took quite some runs, but now FreeBSD ports is 
at 12.2.2, and in preparation on the 1.66 Boost release it builds 
without Beast by execluding WITH_RADOSGW_BEAST_FRONTEND.

Which will be switched back on once the 1.66 Beast works with v12.2.2.

--WjW

