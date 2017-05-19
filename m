From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: subpackages for mgr modules
Date: Fri, 19 May 2017 12:25:41 -0600
Message-ID: <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36458 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755418AbdESS0g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 14:26:36 -0400
Received: by mail-ua0-f177.google.com with SMTP id j17so30706218uag.3
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 11:25:43 -0700 (PDT)
In-Reply-To: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 19, 2017 at 12:19 AM, Tim Serong <tserong@suse.com> wrote:
> We can't have mgr just load everything that exists (someone might want
> to disable some modules, without necessarily uninstalling them).

I'm curious why not?

Ceph is already hard to configure, and "install to enable / uninstall
to disable" would make it simpler to use.

- Ken
