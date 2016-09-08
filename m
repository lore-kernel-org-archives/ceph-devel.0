From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: librados.h version numbers
Date: Wed, 7 Sep 2016 18:08:20 -0700
Message-ID: <CAJ4mKGaLv+n8JsJkAYSoNz+3N3rsJHe+tjwoReN_B3AQPibAKQ@mail.gmail.com>
References: <1843378866.3701.1473189527273@ox.pcextreme.nl> <37bd7608-3352-5057-d238-e04517640f5b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33454 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbcIHBIW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2016 21:08:22 -0400
Received: by mail-vk0-f46.google.com with SMTP id f76so28219343vke.0
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2016 18:08:21 -0700 (PDT)
In-Reply-To: <37bd7608-3352-5057-d238-e04517640f5b@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 6, 2016 at 4:16 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 09/06/2016 12:18 PM, Wido den Hollander wrote:
>>
>> Hi,
>>
>> wido@wido-laptop:~$ python -c "import rados; r = rados.Rados();
>> print(r.version())"
>> 0.69.1
>> wido@wido-laptop:~$ dpkg -l|grep rados|awk '{print $2" "$3}'
>> librados-dev 10.2.2-1trusty
>> librados2 10.2.2-1trusty
>> libradosstriper1 10.2.2-1trusty
>> python-rados 10.2.2-1trusty
>> wido@wido-laptop:~$
>>
>> Looking at librados.h in master I see:
>>
>> #define LIBRADOS_VER_MAJOR 0
>> #define LIBRADOS_VER_MINOR 69
>> #define LIBRADOS_VER_EXTRA 1
>>
>> Is this something which has just been forgotten to update?
>
>
> Pretty much. Not much has relied on the librados/librbd version numbers
> of this style. Adding tests for particular functions can be more
> reliable than checking version numbers, since sometimes functions are
> backported.
>
>> Looking at the 'ceph' tool I see:
>>
>> CEPH_GIT_NICE_VER="10.2.2"
>>
>> This is updated during packaging/build it seems.
>>
>> Should we maybe do that for librados.h as well?
>
>
> I see no reason not to.

We at one point were trying to only increment the librados library
version when stuff actually changed. Shockingly, that manual
maintenance mostly resulted in it not getting updated. ;)
But is it really that helpful to just provide another way of exposing
the package version, instead of doing something that actually
illustrates what functions are around? :/
-Greg
