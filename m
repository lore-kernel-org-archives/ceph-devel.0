From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Docs: build check failed
Date: Mon, 2 Oct 2017 10:20:11 -0400
Message-ID: <CAC-Np1xwbGd_eNnmPBoMrZpiR90Dk+XjLu-Ra3AVE=iJTKcUqA@mail.gmail.com>
References: <ee4a39c3-fe12-99f7-4e07-5d096a54a8c4@redhat.com> <CALe9h7dvfWg0-xTg6q=Aik8LWEghWBOwbdYdnzw3_ydx80UCpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54703 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdJBOUN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 10:20:13 -0400
Received: by mail-wm0-f45.google.com with SMTP id i124so10918329wmf.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 07:20:12 -0700 (PDT)
In-Reply-To: <CALe9h7dvfWg0-xTg6q=Aik8LWEghWBOwbdYdnzw3_ydx80UCpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Jos Collin <jcollin@redhat.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On Tue, Sep 26, 2017 at 6:34 AM, John Spray <jspray@redhat.com> wrote:
> Kefu fixed it: https://github.com/ceph/ceph/pull/17961
>
> John
>
> On Tue, Sep 26, 2017 at 11:21 AM, Jos Collin <jcollin@redhat.com> wrote:
>> Docs: build check failed for all PRs today.
>>
>>
>> Identified problems
>>
>> No identified problem
>> No problems were identified. If you know why this problem occurred, please
>> add a suitable Cause for it.

Please note that the message above is for a *plugin* that *parses the
log output* and if a regex is matched
it will display that as an "identified problem".

It *does not mean* that there aren't any problems :)

It is always necessary to go read the logs, which in this case were
indicating what the actual problem was (and was later fixed by Kefu)


>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
