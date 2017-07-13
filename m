From: Alfredo Deza <adeza@redhat.com>
Subject: Re: build issues today
Date: Thu, 13 Jul 2017 09:47:21 -0400
Message-ID: <CAC-Np1wmN231Uu=FAh8phWdVRt3ggs-xbkJHm4hF=9hEkBDb0Q@mail.gmail.com>
References: <CAC-Np1wSahSXTNhFmPWf15iL8c9ttUkCJgowEVAzgBYGuG53Kg@mail.gmail.com>
 <c9115edb-60ce-eb1a-724c-9b250d1e22c8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36369 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdGMNrX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jul 2017 09:47:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id 62so24196992wmw.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jul 2017 06:47:23 -0700 (PDT)
In-Reply-To: <c9115edb-60ce-eb1a-724c-9b250d1e22c8@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 13, 2017 at 9:25 AM, Mark Nelson <mark.a.nelson@gmail.com> wrote:
> On 07/13/2017 07:58 AM, Alfredo Deza wrote:
>>
>> We had OutOfMemory errors in the master Jenkins instance, and we had
>> to bounce the service to be able to get back online.
>>
>> As a result, most builds in the past 6-8 hours may have been affected
>> with failures.
>>
>> The system is now back online.
>>
>> To further prevent this will require some serious re-work of the
>> master instance, but in the meantime we can improve this further by
>> restarting the Jenkins process. We will start scheduling these
>> restarts on Sunday's at 5am UTC to prevent impact.
>
>
> Can we just throw more RAM at it for now?

This is tricky, since we are using a machine with ~30GB of ram already
and it would involve moving to a new machine.

>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
