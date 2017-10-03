From: Jos Collin <jcollin@redhat.com>
Subject: Re: Docs: build check failed
Date: Tue, 3 Oct 2017 06:54:22 +0530
Message-ID: <0c4874b9-c68c-78ad-3ae8-f09e3d91263f@redhat.com>
References: <ee4a39c3-fe12-99f7-4e07-5d096a54a8c4@redhat.com>
 <CALe9h7dvfWg0-xTg6q=Aik8LWEghWBOwbdYdnzw3_ydx80UCpg@mail.gmail.com>
 <CAC-Np1xwbGd_eNnmPBoMrZpiR90Dk+XjLu-Ra3AVE=iJTKcUqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:46619 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdJCBY1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 21:24:27 -0400
Received: by mail-pf0-f174.google.com with SMTP id r68so3781159pfj.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 18:24:26 -0700 (PDT)
In-Reply-To: <CAC-Np1xwbGd_eNnmPBoMrZpiR90Dk+XjLu-Ra3AVE=iJTKcUqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Monday 02 October 2017 07:50 PM, Alfredo Deza wrote:
> On Tue, Sep 26, 2017 at 6:34 AM, John Spray <jspray@redhat.com> wrote:
>> Kefu fixed it: https://github.com/ceph/ceph/pull/17961
>>
>> John
>>
>> On Tue, Sep 26, 2017 at 11:21 AM, Jos Collin <jcollin@redhat.com> wrote:
>>> Docs: build check failed for all PRs today.
>>>
>>>
>>> Identified problems
>>>
>>> No identified problem
>>> No problems were identified. If you know why this problem occurred, please
>>> add a suitable Cause for it.
>
> Please note that the message above is for a *plugin* that *parses the
> log output* and if a regex is matched
> it will display that as an "identified problem".
>
> It *does not mean* that there aren't any problems :)

Yes, I'm aware of that. But it was already fixed by Kefu.

Thanks.
