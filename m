From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: subpackages for mgr modules
Date: Mon, 22 May 2017 09:45:53 -0600
Message-ID: <CALqRxCzJr4UAXQ4=KAE260=geE3bDsnoc7nCqVzDcj+1bDwhVg@mail.gmail.com>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
 <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com> <CALe9h7eXUq-aRdOPLjDtRMFg_0bEUEHNuLR7G=QaONPZgFXOKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34031 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdEVPpy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 11:45:54 -0400
Received: by mail-ua0-f171.google.com with SMTP id u10so61745553uaf.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 08:45:54 -0700 (PDT)
In-Reply-To: <CALe9h7eXUq-aRdOPLjDtRMFg_0bEUEHNuLR7G=QaONPZgFXOKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, May 21, 2017 at 4:31 PM, John Spray <jspray@redhat.com> wrote:
> My preferred solution would be mon commands for toggling modules "ceph
> mgr module [enable|disable] <module>", and a record in the MgrMap that
> says which are enabled.

Sure. It's just another command users have to do to get to a preferred state.

The classic response on these things has been "ceph setup is hard,
let's wrap it in ceph-ansible" (or whatever higher-level tool will do
all these tricky steps). Then ceph-ansible becomes more and more
complex, and I wonder whether the complexity could be addressed
elsewhere by simply scaling down the flexibility.

- Ken
