From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: build issues today
Date: Thu, 13 Jul 2017 08:25:45 -0500
Message-ID: <c9115edb-60ce-eb1a-724c-9b250d1e22c8@gmail.com>
References: <CAC-Np1wSahSXTNhFmPWf15iL8c9ttUkCJgowEVAzgBYGuG53Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36679 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdGMNZr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jul 2017 09:25:47 -0400
Received: by mail-it0-f42.google.com with SMTP id m68so38889892ith.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jul 2017 06:25:46 -0700 (PDT)
In-Reply-To: <CAC-Np1wSahSXTNhFmPWf15iL8c9ttUkCJgowEVAzgBYGuG53Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 07/13/2017 07:58 AM, Alfredo Deza wrote:
> We had OutOfMemory errors in the master Jenkins instance, and we had
> to bounce the service to be able to get back online.
>
> As a result, most builds in the past 6-8 hours may have been affected
> with failures.
>
> The system is now back online.
>
> To further prevent this will require some serious re-work of the
> master instance, but in the meantime we can improve this further by
> restarting the Jenkins process. We will start scheduling these
> restarts on Sunday's at 5am UTC to prevent impact.

Can we just throw more RAM at it for now?

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
