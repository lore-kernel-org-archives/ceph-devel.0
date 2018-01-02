From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Moving to 1.66 Boost
Date: Tue, 2 Jan 2018 11:13:24 -0500
Message-ID: <210a83ee-b767-54fc-fea9-2ef3decaff1c@redhat.com>
References: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
 <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com>
 <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41362 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeABQN1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 11:13:27 -0500
Received: by mail-ot0-f196.google.com with SMTP id q39so37444205otb.8
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 08:13:27 -0800 (PST)
In-Reply-To: <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, kefu chai <tchaikov@gmail.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



On 01/01/2018 06:13 AM, Willem Jan Withagen wrote:
> On 31/12/2017 06:30, kefu chai wrote:
>> + ceph-devl
>>
>> On Wed, Dec 27, 2017 at 5:47 PM, Willem Jan Withagen 
>> <wjw@digiware.nl> wrote:
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
>> could you pastebin the error message? Boost::thread is the library 
>> name. but I
>> don't think it can be passed to the linker. if you see this in the
>> command line,
>> something is wrong.
>
> It was the now traditional problem that a CMake upgrade does not run 
> in sync with Boost upgrades. Took quite some runs, but now FreeBSD 
> ports is at 12.2.2, and in preparation on the 1.66 Boost release it 
> builds without Beast by execluding WITH_RADOSGW_BEAST_FRONTEND.
>
> Which will be switched back on once the 1.66 Beast works with v12.2.2.
>

Okay, thanks. The rgw/beast changes for boost 1.66 are staged in 
https://github.com/ceph/ceph/pull/19054. If there are delays in merging 
that, I'm happy to pull them into a separate pr. And thanks for pointing 
out that we'll need to backport those pieces for luminous.

> --WjW
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

