From: Casey Bodley <cbodley@redhat.com>
Subject: Re: 12.2.2 status
Date: Fri, 27 Oct 2017 09:57:11 -0400
Message-ID: <393a5637-16da-2c2f-36ab-334fddc01db1@redhat.com>
References: <87fua6c4xy.fsf@suse.com>
 <CADRKj5RuqjfQQoK+ri+WLqh07O9snWvsKSfr+83GmmRtBYiBHw@mail.gmail.com>
 <FCD206E6-9E88-478C-9230-D0FAD0F8BA4F@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:51084 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdJ0N5O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Oct 2017 09:57:14 -0400
Received: by mail-qt0-f180.google.com with SMTP id d9so8503237qtd.7
        for <ceph-devel@vger.kernel.org>; Fri, 27 Oct 2017 06:57:14 -0700 (PDT)
In-Reply-To: <FCD206E6-9E88-478C-9230-D0FAD0F8BA4F@suse.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Mroz <kmroz@suse.de>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>



On 10/26/2017 06:48 PM, Karol Mroz wrote:
> +CC Casey
>
> Hi Yehuda and Casey,
>
>
>> On Oct 26, 2017, at 9:50 AM, Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
> […]
>> I'd be happy to see these fixed:
>> http://tracker.ceph.com/issues/21819
> Opened backport ticket http://tracker.ceph.com/issues/21937
> https://github.com/ceph/ceph/pull/18539
>
>
>> http://tracker.ceph.com/issues/21735
> Opened backport ticket http://tracker.ceph.com/issues/21938
> Final commit of https://github.com/ceph/ceph/pull/18198 appears dependent on at least: cbb84cb13db and 53526d5050a in master.  Please advise.

resolved this conflict in https://github.com/ceph/ceph/pull/18591

>> however, these are not in master yet, need validation.
>>
>> This one is ready I think:
>> http://tracker.ceph.com/issues/21500
> Opened: http://tracker.ceph.com/issues/21939
> https://github.com/ceph/ceph/pull/18569
>    - Still need https://github.com/ceph/s3-tests/pull/189 backported to ceph-luminous branch of s3tests

do you want me to cherry-pick that s3test before the backport merges? 
it's likely to cause failures for teuthology runs that don't include 
https://github.com/ceph/ceph/pull/18569

>
> Regards,
> Karol Mroz
> kmroz@suse.de
>
>
>

