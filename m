From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: On FreeBSD: Could not find executable
 /home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
Date: Thu, 29 Jun 2017 13:52:17 -0400
Message-ID: <a66aa5ec-644b-ea5b-37a2-110a1af690a6@redhat.com>
References: <12a91c7f-df87-9415-8ced-c3928078f4d5@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35371 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbdF2RwV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 13:52:21 -0400
Received: by mail-qt0-f182.google.com with SMTP id f92so80564509qtb.2
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 10:52:20 -0700 (PDT)
In-Reply-To: <12a91c7f-df87-9415-8ced-c3928078f4d5@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 06/27/2017 05:18 AM, Willem Jan Withagen wrote:
> Something is dire missing to complete the test with success on FreeBSD.
> Perhaps because not everything is build that has to do with dmclock?
>
> --WjW
>
>         Start  57: unittest_mclock_priority_queue
> Could not find executable
> /home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
> Looked in the following places:

...

> home/jenkins/workspace/ceph-master/build/bin/Development/unittest_mclock_priority_queue
> Unable to find executable:
> /home/jenkins/workspace/ceph-master/build/bin/unittest_mclock_priority_queue
>  43/169 Test  #57: unittest_mclock_priority_queue ..........***Not Run
> 0.00 sec

Willem,

Did Kefu's response to your PR (https://github.com/ceph/ceph/pull/14997)
comment ('please make sure you run "make tests" before "make check" or
"ctest".') address your issue?

Eric
