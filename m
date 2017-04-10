From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw: refactoring test_multi.py for teuthology
Date: Mon, 10 Apr 2017 10:59:07 -0400
Message-ID: <42d55d44-fcfd-d8cc-3de3-86a9142430b5@redhat.com>
References: <02431f0e-d420-b76f-fcfe-d240334be26f@redhat.com>
 <435027817.7434134.1483528782550.JavaMail.zimbra@redhat.com>
 <104748175.9087619.1484038356875.JavaMail.zimbra@redhat.com>
 <1014219555.87677510.1484085955314.JavaMail.zimbra@redhat.com>
 <1064077357.9340713.1484113756463.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35765 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbdDJO7O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 10:59:14 -0400
Received: by mail-qk0-f177.google.com with SMTP id f133so97528232qke.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Apr 2017 07:59:14 -0700 (PDT)
In-Reply-To: <1064077357.9340713.1484113756463.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>
Cc: Shilpa Manjarabad Jagannath <smanjara@redhat.com>

Hi Shilpa and list,

A big set of test_multi.py changes merged recently that added support 
for multiple zonegroups - see https://github.com/ceph/ceph/pull/14216 
(many thanks to @dongbula!). I was afraid that this would introduce a 
lot of conflicts with the refactoring work in progress, so I spent some 
time over the weekend doing that refactoring myself:

https://github.com/ceph/ceph/pull/14433

There are still some open questions about the layout and organization of 
the python stuff that I would love some feedback on. Any review and 
testing would also be appreciated. The next step will be to integrate 
them into a new rgw/multisite teuthology suite.

Thanks,
Casey

p.s. For those wondering how to run test_multi.py against a cmake build:

~/ceph/build $ nosetests ../src/test/rgw/test_multi.py


On 01/11/2017 12:49 AM, Shilpa Manjarabad Jagannath wrote:
> Sure, thanks Ali.
>
> Regards,
> Shilpa MJ.
>
> ----- Original Message -----
>> From: "Ali Maredia" <amaredia@redhat.com>
>> To: "Shilpa Manjarabad Jagannath" <smanjara@redhat.com>
>> Cc: "Casey Bodley" <cbodley@redhat.com>
>> Sent: Wednesday, January 11, 2017 3:35:55 AM
>> Subject: Re: rgw: refactoring test_multi.py for teuthology
>>
>> Shilpa,
>>
>> I talked to Casey today and have a good idea of how this is going to be split
>> up.
>>
>> I'm all ready for integrating the scripts in teuthology once you're done
>> splitting
>> out the generic code from test_multi.py and verifying that the vstart version
>> still works.
>>
>> -Ali
>>
>> ----- Original Message -----
>>> From: "Shilpa Manjarabad Jagannath" <smanjara@redhat.com>
>>> To: "Ali Maredia" <amaredia@redhat.com>
>>> Cc: "Casey Bodley" <cbodley@redhat.com>
>>> Sent: Tuesday, January 10, 2017 3:52:36 AM
>>> Subject: Re: rgw: refactoring test_multi.py for teuthology
>>>
>>> Hi Ali,
>>>
>>> I was going to start working on this. Just wanted to know if you are
>>> already
>>> at it?
>>>
>>>
>>> Regards,
>>> Shilpa MJ.
>>>
>>> ----- Original Message -----
>>>> From: "Shilpa Manjarabad Jagannath" <smanjara@redhat.com>
>>>> To: "Casey Bodley" <cbodley@redhat.com>
>>>> Cc: "Ali Maredia" <amaredia@redhat.com>, "The Sacred Order of the Squid
>>>> Cybernetic" <ceph-devel@vger.kernel.org>
>>>> Sent: Wednesday, January 4, 2017 4:49:42 PM
>>>> Subject: Re: rgw: refactoring test_multi.py for teuthology
>>>>
>>>>
>>>>
>>>> ----- Original Message -----
>>>>> From: "Casey Bodley" <cbodley@redhat.com>
>>>>> To: "Shilpa Manjarabad Jagannath" <smanjara@redhat.com>
>>>>> Cc: "Ali Maredia" <amaredia@redhat.com>, "The Sacred Order of the Squid
>>>>> Cybernetic" <ceph-devel@vger.kernel.org>
>>>>> Sent: Wednesday, January 4, 2017 2:12:50 AM
>>>>> Subject: rgw: refactoring test_multi.py for teuthology
>>>>>
>>>>> Hi Shilpa, Ali, and list,
>>>>>
>>>>> The rgw multisite tests are currently running out of
>>>>> src/test/rgw/test_multi.py, and use shell scripts to set up multiple
>>>>> vstart clusters. We'd like to adapt these tests so they can run inside
>>>>> of teuthology as well (while preserving the ability to run them
>>>>> manually). Running inside of teuthology means using an existing
>>>>> multisite configuration, rather than building one up with the shell
>>>>> scripts.
>>>>>
>>>>> The python script currently has classes for RGWRealm, RGWCluster, and
>>>>> RGWMulti. The RGWMulti.setup() method creates an RGWRealm and builds an
>>>>> array of RGWClusters. RGWCluster.start() calls the mstart.sh script to
>>>>> create a vstart cluster in a subdirectory. RGWRealm.init_zone() is then
>>>>> running all of the radosgw-admin commands to configure that
>>>>> zonegroup/zone/etc.
>>>>>
>>>>> These seem like good base classes for this abstraction. For example, we
>>>>> can derive VRealm/VCluster/VMulti to represent the existing vstart
>>>>> implementation, and TRealm/TCluster/TMulti to represent their
>>>>> teuthology
>>>>> counterparts.
>>>>>
>>>>> The existing unit tests only need to know the realm, which they access
>>>>> as a global variable. We can turn the generic part (the test_*
>>>>> functions
>>>>> and their helper functions like check_*) into a separate module like
>>>>> src/test/rgw/rgw_multi.py, and add a set_realm() function to set this
>>>>> global variable.
>>>>>
>>>>> Then the vstart version of the test (src/test/rgw/test_multi.py) can
>>>>> import rgw_multi, instantiate its VRealm/etc to run the cluster
>>>>> creation/configuration, then pass its realm to set_realm() for the unit
>>>>> tests. In order for nosetests to find and run the test_* functions in
>>>>> rgw_multi.py, test_multi.py needs to use 'from rgw_multi import *'.
>>>>>
>>>>> A separate python script, probably under qa/tasks/, would implement the
>>>>> TRealm/etc subclasses by making the appropriate calls into teuthology.
>>>>> Instead of creating the cluster during initialization, it would read
>>>>> the
>>>>> existing multisite configuration - either by interpreting the
>>>>> teuthology
>>>>> 'config', or by running radosgw-admin commands like 'period get'.
>>>>>
>>>>> It seems like a good first step would be to split out the generic code
>>>>> from test_multi.py into rgw_multi.py and verify that the vstart version
>>>>> still works.
>>>>>
>>>>> Casey
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>

