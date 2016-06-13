From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Little update on the build platform
Date: Mon, 13 Jun 2016 09:41:43 -0600
Message-ID: <CALqRxCz-_pfdbVmbQ-hUEYG0EZR4MrELB1k81UB9j08Evk_Qow@mail.gmail.com>
References: <902296593.97770947.1464716952266.JavaMail.zimbra@redhat.com>
	<574FEA29.7040508@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33746 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424217AbcFMPlo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2016 11:41:44 -0400
Received: by mail-vk0-f50.google.com with SMTP id d185so59847264vkg.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2016 08:41:44 -0700 (PDT)
In-Reply-To: <574FEA29.7040508@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Erwan Velu <evelu@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 2, 2016 at 2:11 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> - An diagnosis helper is now in place to spot known build failures  :
>> A list of common issues have been entered (like gcc or jenkins failures,
>> segfaults, etc...)
>> A typical output looks like :
>> https://jenkins.ceph.com/job/ceph-pull-requests/6448/
>
>
> Thanks, guys, this looks like an excellent improvement.
>
> Now I have a PR with failing make check and it appears that Jenkins is aware
> of the failures:
>
> https://jenkins.ceph.com/job/ceph-pull-requests/6550/consoleFull#17782142537ba86caa-bd6c-4071-8005-3f6d80f92e07
>
> The two recognized failures are highlighted in red:
>
> FATAL: java.io.IOException: Unexpected termination of the channel
>
> java.lang.NullPointerException: no workspace from node
> hudson.slaves.DumbSlave[158.69.84.81+trusty_huge__c69f129f-3dff-46c2-9bd4-d14364fcb62f]
> which is computer hudson.slaves.SlaveComputer@1957dd58 and has channel null
>
> But I don't know what to do about them? Do we have documentation of the
> common failure cases and what can be done to fix them?

This sounds like a network issue in OVH (cloud provider where Jenkins
is hosted)?
