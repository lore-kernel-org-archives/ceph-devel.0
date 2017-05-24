From: Alfredo Deza <adeza@redhat.com>
Subject: Re: subpackages for mgr modules
Date: Wed, 24 May 2017 16:15:37 -0400
Message-ID: <CAC-Np1y+JKiKEpmLkSKiwMOK=6LCQ3Y1nZr-Eir7RXssqoeifg@mail.gmail.com>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
 <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
 <CALe9h7eXUq-aRdOPLjDtRMFg_0bEUEHNuLR7G=QaONPZgFXOKg@mail.gmail.com> <CALqRxCzJr4UAXQ4=KAE260=geE3bDsnoc7nCqVzDcj+1bDwhVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33340 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032254AbdEXUPj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 16:15:39 -0400
Received: by mail-wr0-f172.google.com with SMTP id w50so61349585wrc.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 13:15:38 -0700 (PDT)
In-Reply-To: <CALqRxCzJr4UAXQ4=KAE260=geE3bDsnoc7nCqVzDcj+1bDwhVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: John Spray <jspray@redhat.com>, Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 22, 2017 at 11:45 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Sun, May 21, 2017 at 4:31 PM, John Spray <jspray@redhat.com> wrote:
>> My preferred solution would be mon commands for toggling modules "ceph
>> mgr module [enable|disable] <module>", and a record in the MgrMap that
>> says which are enabled.
>
> Sure. It's just another command users have to do to get to a preferred state.
>
> The classic response on these things has been "ceph setup is hard,
> let's wrap it in ceph-ansible" (or whatever higher-level tool will do
> all these tricky steps). Then ceph-ansible becomes more and more
> complex, and I wonder whether the complexity could be addressed
> elsewhere by simply scaling down the flexibility.

I can agree here with how these helpful commands tend to add
complexity on the deployment systems.

Maybe a good compromise would be the allow both? That is: installation
would enable a module, but that
could also be disabled (and re-enabled) by the CLI. That way, we
aren't forcing users to uninstall always and keeps
other systems like ceph-ansible lean.

>
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
