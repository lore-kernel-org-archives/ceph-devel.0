From: John Spray <jspray@redhat.com>
Subject: Re: multiple cherrypys in ceph-mgr modules stomp on each other
Date: Tue, 11 Apr 2017 12:17:33 +0100
Message-ID: <CALe9h7cT5z8-gAszW5e+xoFJbv42+D=-UW=uveqFHaY+LUAbCA@mail.gmail.com>
References: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38261 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbdDKLRz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Apr 2017 07:17:55 -0400
Received: by mail-wm0-f44.google.com with SMTP id t189so58530652wmt.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Apr 2017 04:17:54 -0700 (PDT)
In-Reply-To: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Apr 11, 2017 at 11:41 AM, Tim Serong <tserong@suse.com> wrote:
> Hi All,
>
> We have a problem using cherrypy in mgr modules.  Specifically, multiple
> modules that use cherrypy stomp on each other.  I discovered this while
> playing with John's guilolz experiment
> (https://github.com/ceph/ceph/pull/13725).
>
> Both rest and guilolz modules follow this pattern:
>
>   cherrypy.config.update({'server.socket_port': ....})
>   cherrypy.tree.graft(...)  # or cherrypy.tree.mount(...)
>   cherrypy.engine.start()
>   cherrypy.engine.block()
>
> So:
>
> - They're both first setting the port to listen on globally.
> - They both eat the whole web namespace (graft/mount).
> - They both call cherrypy.engine.start() to start the server.
>
> In each of the above cases, the first module loaded will win and the
> other won't (or, it might be racey and you'll kinda get a mix?).  For
> example, the second call to cherrypy.engine.start() fails complaining it
> can't be called more than once from the same thread.
>
> I'm not sure how best to deal with this.  Assuming we *do* want it to be
> possible for multiple modules that provide a web service to be loaded
> simultaneously, we need to:
>
> - not set the port globally.
> - not stomp on each others namespaces.
> - only call cherrypy.engine.start() once.
>
> You can have multiple cherrypy servers listening on different ports, so
> that gets us part of the way there, e.g.:
>
>   from cherrypy._cpserver import Server
>   server = Server()
>   server.socket_port = .... # whatever
>   server.subscribe()
>
> But, this doesn't fix the namespace eating problem.  That might be
> doable with cherrypy virtualhosts
> (http://tools.cherrypy.org/wiki/VirtualHosts), but I haven't
> experimented further with that yet.
>
> Also, those subscribe()s have to happen before the
> cherrypy.engine.start() call or they have no effect.  One way to do that
> would be to have some magic cherrypy module which is always loaded last
> to start the engine, but that might be ugly.
>
> Another option might be to have a separate python interpreter per module
> (can't stomp on each other then, right?) but that might be too resource
> intensive.

My assumption has been that the global cherrypy stuff was a
convenience that could be un-wrapped into something simpler as and
when, but that may not be the case...

We could have a small shared python module next to mgr_module.py that
modules could use to cooperate nicely on the global cherrypy bits.  It
wouldn't be a total hack, as it would make some of "make me a
webserver" code less repetitive between modules that want to do that.

Doing separate sub-interpreters would also be an option that would
give us more robustness generally in the face of python modules that
do global things.  I don't think there was any fundamental reason I
didn't use sub-interpreters when writing this stuff originally,
they're just a comparatively sparesely documented part of CPython.

I think either one is probably fine?

John

>
>
> Thoughts?
>
> Thanks,
>
> Tim
> --
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
