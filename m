From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Master needs newer version of boost on centos?
Date: Fri, 14 Feb 2014 16:28:09 -0800
Message-ID: <52FEB499.1000902@inktank.com>
References: <1695703986.191.1392423983997.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52730 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbaBOAaA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 19:30:00 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so12658118pdj.11
        for <ceph-devel@vger.kernel.org>; Fri, 14 Feb 2014 16:29:59 -0800 (PST)
In-Reply-To: <1695703986.191.1392423983997.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>, Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Sandon Van Ness <sandon@inktank.com>

ICL was added in 1.46 according to http://www.boost.org/doc/libs/.
This also fails on debian wheezy with only 1.42 available:

http://tracker.ceph.com/issues/7422

On 02/14/2014 04:26 PM, Matt W. Benjamin wrote:
> according to google, 1.41 ahould have it.
>
> ----- "Sage Weil" <sage@inktank.com> wrote:
>
>> On Fri, 14 Feb 2014, Matt W. Benjamin wrote:
>>> but we haven't built on centos, to my knowledge...
>>
>> I think the question is really: is there an interval_set in boost 1.41
>>
>> that you can use, can you use something else instead, or do we need to
>> do
>> a boost backport in order to build for centos/rhel 6.x?
>>
>> sage
>>
>>>
>>> ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
>>>
>>>> oh, ok.  I think they need an extra boost rpm?
>>>>
>>>> ----- "Sage Weil" <sage@inktank.com> wrote:
>>>>
>>>>> Hey Matt,
>>>>>
>>>>> This is in the libcephfs code I merged yesterday.  Any ideas?
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>>>
>>>>> On Fri, 14 Feb 2014, Sandon Van Ness wrote:
>>>>>
>>>>>>
>>>>>> The last couple builds of master have been failing on the
>> centos
>>>>> gitbuilder.
>>>>>> here is the build log:
>>>>>>
>>>>>>
>>>>>
>>>>
>> http://gitbuilder.sepia.ceph.com/gitbuilder-centos6-amd64/log.cgi?log=f47062d8a66b94743888aaea13e0766579379395
>>>>>>
>>>>>> Its running into:
>>>>>>
>>>>>> CXX mds/Capability.lo
>>>>>> CXX mds/Dumper.lo
>>>>>> In file included from client/Client.h:38,
>>>>>> from libcephfs.cc:21:
>>>>>>
>>>>>>       error: client/barrier.h:25:38:
>> boost/icl/interval_set.hpp:
>>>> No
>>>>> such
>>>>>>       file or directory
>>>>>>
>>>>>> It looks like its not effecting fedora gitbuilders that have
>> a
>>>> newer
>>>>> version
>>>>>> of boost but on centos/rhel the version is only 1.41.0-18. Is
>>>> there
>>>>> something
>>>>>> we can do to get around this without back-porting or will
>>>>> backporting a newer
>>>>>> boost for rhel/centos be necessary?
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at
>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>
>>>> --
>>>> Matt Benjamin
>>>> The Linux Box
>>>> 206 South Fifth Ave. Suite 150
>>>> Ann Arbor, MI  48104
>>>>
>>>> http://linuxbox.com
>>>>
>>>> tel.  734-761-4689
>>>> fax.  734-769-8938
>>>> cel.  734-216-5309
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> Matt Benjamin
>>> The Linux Box
>>> 206 South Fifth Ave. Suite 150
>>> Ann Arbor, MI  48104
>>>
>>> http://linuxbox.com
>>>
>>> tel.  734-761-4689
>>> fax.  734-769-8938
>>> cel.  734-216-5309
>>>
>>>
>

