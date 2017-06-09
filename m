From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure_code_version() for a new erasure code
Date: Fri, 9 Jun 2017 16:19:05 +0200
Message-ID: <ad68008d-59ab-2cd0-03c7-b7896ac955ea@dachary.org>
References: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39175 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdFIOTJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 10:19:09 -0400
In-Reply-To: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>, ceph-devel@vger.kernel.org

Hi Oleg,

Did you "make" in the build directory ? Or did not only run make on part of the files ? When you run make it takes care of all the dependencies and you should not be in this situation.

Cheers

On 06/09/2017 03:57 PM, Oleg Kolosov wrote:
> Hi,
> I've written a new erasure code for my study purposes. The code has
> compiled, but when trying to set a profile with it I get the following
> error:
> 
> Error EXDEV: expected plugin
> /home/ubuntu/ceph/build/lib/libec_optlrc.so version v10.2.2-9-g31e3fbb
> but it claims to be an older version instead
> 
> I've traced the error to: ErasureCodePlugin.cc :
>   if (erasure_code_version == NULL)
>     erasure_code_version = an_older_version;
>   if (erasure_code_version() != string(CEPH_GIT_NICE_VER)) {
>     *ss << "expected plugin " << fname << " version " << CEPH_GIT_NICE_VER
>         << " but it claims to be " << erasure_code_version() << " instead";
> 
> For some reason, my definition of erasure_code_version doesn't
> propagate as it should.
> The ErasureCodePlugin cc file of my code is similar to the other
> erasure code. With this defined:
> const char *__erasure_code_version() { return CEPH_GIT_NICE_VER; }
> 
> Can you think of any reason it should behave like this?
> Is there any log or method to discover the reason for this issue?
> 
> I'd appreciate your help.
> 
> Thanks,
> Oleg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
