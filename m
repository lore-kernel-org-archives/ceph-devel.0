From: John Spray <jspray@redhat.com>
Subject: Re: subpackages for mgr modules
Date: Wed, 24 May 2017 21:53:49 +0100
Message-ID: <CALe9h7cSNSccp-tp-vAcnKHRTiHFvunMJCdMi8ao4avExL+jCw@mail.gmail.com>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
 <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
 <CALe9h7eXUq-aRdOPLjDtRMFg_0bEUEHNuLR7G=QaONPZgFXOKg@mail.gmail.com>
 <CALqRxCzJr4UAXQ4=KAE260=geE3bDsnoc7nCqVzDcj+1bDwhVg@mail.gmail.com> <CAC-Np1y+JKiKEpmLkSKiwMOK=6LCQ3Y1nZr-Eir7RXssqoeifg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33366 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbdEXUyV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 16:54:21 -0400
Received: by mail-wr0-f171.google.com with SMTP id w50so61818116wrc.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 13:54:16 -0700 (PDT)
In-Reply-To: <CAC-Np1y+JKiKEpmLkSKiwMOK=6LCQ3Y1nZr-Eir7RXssqoeifg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 24, 2017 at 9:15 PM, Alfredo Deza <adeza@redhat.com> wrote:
> On Mon, May 22, 2017 at 11:45 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> On Sun, May 21, 2017 at 4:31 PM, John Spray <jspray@redhat.com> wrote:
>>> My preferred solution would be mon commands for toggling modules "ceph
>>> mgr module [enable|disable] <module>", and a record in the MgrMap that
>>> says which are enabled.
>>
>> Sure. It's just another command users have to do to get to a preferred state.
>>
>> The classic response on these things has been "ceph setup is hard,
>> let's wrap it in ceph-ansible" (or whatever higher-level tool will do
>> all these tricky steps). Then ceph-ansible becomes more and more
>> complex, and I wonder whether the complexity could be addressed
>> elsewhere by simply scaling down the flexibility.
>
> I can agree here with how these helpful commands tend to add
> complexity on the deployment systems.
>
> Maybe a good compromise would be the allow both? That is: installation
> would enable a module, but that
> could also be disabled (and re-enabled) by the CLI. That way, we
> aren't forcing users to uninstall always and keeps
> other systems like ceph-ansible lean.

Oops, I wrote a reply to Ken but then failed to click send on it... it
was wordy so I'll be briefer now:

We do need a way to define what the default set of enabled modules
should be, so it probably makes sense to do that via a config setting
(perhaps just the existing config setting), and then let installation
tools give their preference via that interface too, killing two birds
with one stone.  I still think none of this should be triggered by
packaging.

If the user has never used the CLI to enable/disable things, then
updates to the config setting would continue to be authoritative.  If
a user has explicitly disabled a module using the CLI, then that would
take precedence over what was in the config setting.

That would mean that if an ansible-like tool wanted to definitely
enabled a module (even if the user had used the CLI to disable it)
then it would need to understand the CLI too.  However, if a user was
configuring everything using ansible, then ansible would never need to
touch the CLI.

John





>
>>
>> - Ken
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
