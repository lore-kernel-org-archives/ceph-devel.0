From: John Spray <jspray@redhat.com>
Subject: Re: subpackages for mgr modules
Date: Sun, 21 May 2017 23:31:40 +0100
Message-ID: <CALe9h7eXUq-aRdOPLjDtRMFg_0bEUEHNuLR7G=QaONPZgFXOKg@mail.gmail.com>
References: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com> <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38163 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbdEUWcC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 21 May 2017 18:32:02 -0400
Received: by mail-wm0-f46.google.com with SMTP id e127so15306473wmg.1
        for <ceph-devel@vger.kernel.org>; Sun, 21 May 2017 15:32:02 -0700 (PDT)
In-Reply-To: <CALqRxCwjnU7wzPF49APaCZU0XSWfwBJMkPbNnnxKqTfkqcrgOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 19, 2017 at 7:25 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Fri, May 19, 2017 at 12:19 AM, Tim Serong <tserong@suse.com> wrote:
>> We can't have mgr just load everything that exists (someone might want
>> to disable some modules, without necessarily uninstalling them).
>
> I'm curious why not?

Perhaps "can't" is too strong a word, but the way it only loads
explicitly enabled modules is intentional.

The thinking was...
1. It's not a given that every module will be packaged independently.
That's not necessarily going to be useful in all cases -- if/when we
reach a point where some modules are so ubiquitous that we want them
everywhere, then having lots of separate packages may not be
desirable.  I'm thinking back to things like the
gstreamer-plugins-good/bad/ugly packaging, and the bajillion apache
sub-packages -- as a user I usually find this stuff really frustrating
because I have a big root partition and my life is simpler if I just
pre-emptively have all the modules (but that doesn't mean I want them
all running).
2. Which packages are installed on a system is usually something
controlled by an external tool, which tends to be different on
different sites/in diffferent products.  Consequently, the exact steps
required to turn off a module are not going to be consistent across
sites.  It is not a given that a support/admin person will know how to
turn off an individual package, unless they're also the person who
configured whatever orchestration tool was installing packages.
3. The "install to enable" convention is more welcome on some distros
than others.  For example, debian (I think) historically did/does this
for services, RPM distros historically didn't.

>
> Ceph is already hard to configure, and "install to enable / uninstall
> to disable" would make it simpler to use.

My preferred solution would be mon commands for toggling modules "ceph
mgr module [enable|disable] <module>", and a record in the MgrMap that
says which are enabled.  There would be a bit of extra data in the mgr
beacon message for the daemons to tell the MgrMonitor which modules
are available.  The MgrMonitor could also raise a health warning if
the mgr daemons have inconsistent plugins.

The major advantage of doing that is that all the mgr daemons see the
same setting.  That way, if someone enables a module on one of their
mgr nodes, they don't get a nasty shock when a failover happens and
the module is gone on the node they failed over to.

It would also let them do it without having to go and directly log
into each of their mgr nodes to make a change (as they currently have
to do with config files, or would also have to do with package
install/uninstall or symlinks).

John

>
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
