From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Testing with Bluestore and Filestore
Date: Thu, 2 Mar 2017 14:02:25 -0600
Message-ID: <02cc6e71-c469-9e3b-8883-afe2bd7aecb9@redhat.com>
References: <CAMdDSN2xU=eRCxEDrq3qP0zmXxxTLAZrSboHcB8N4EH2ZhU8PQ@mail.gmail.com>
 <CAJ4mKGaq+d6EzFHsADSnO-nC3VbbugrxgkmrhY=3d5cqDjFBqQ@mail.gmail.com>
 <CA+aFP1BrsLFXr=nu2aucFT1RzR3eufY4Ut4XKp9UkafNfXhujA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbdCBU1T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Mar 2017 15:27:19 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 720663D94F
        for <ceph-devel@vger.kernel.org>; Thu,  2 Mar 2017 20:02:27 +0000 (UTC)
In-Reply-To: <CA+aFP1BrsLFXr=nu2aucFT1RzR3eufY4Ut4XKp9UkafNfXhujA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com, Gregory Farnum <gfarnum@redhat.com>
Cc: Brett Niver <bniver@redhat.com>, John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 03/02/2017 12:40 PM, Jason Dillaman wrote:
> On Thu, Mar 2, 2017 at 1:36 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Thu, Mar 2, 2017 at 8:36 AM, Brett Niver <bniver@redhat.com> wrote:
>>> Sage,
>>>
>>> Perhaps this has already been discussed, but Jason had a good idea,
>>> that perhaps instead of testing both BS and FS upstream independently,
>>>  and doubling our testing, we might have teuthology randomly pick
>>> which to use.
>>>
>>> That would potentially reduce TCs and also give us the testing that
>>> would help prepare for working thru the migration/transition once BS
>>> is ready.
>>
>> This is really what the subset functionality is for, although I think
>> John had started working on a feature in this area that would let the
>> subset functionality go across the rados configuration options while
>> guaranteeing full combinatorial explosion on the FS tests.
>> -Greg
>
> I was actually thinking that OSDs should be randomly assigned an
> object store by teuthology (i.e. roughly 50% FileStore vs 50%
> BlueStore in the same cluster in the same test run). Right now, the
> tests (at least for RBD) running 100% FileStore or 100% BlueStore with
> no intermixing (and no verification that PGs comprised of FileStore
> and BlueStore OSDs behave properly). That would also have the added
> benefit of eliminating half the test cases in the RBD suite even
> before you apply a subset.

Seems reasonable to me.  If the clusters are small we'll get pure 
bluestore and pure filestore every once and a while too which would be good.

Mark

>
>>>
>>> Brett
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
