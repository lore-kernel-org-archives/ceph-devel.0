From: Tim Serong <tserong@suse.com>
Subject: multiple cherrypys in ceph-mgr modules stomp on each other
Date: Tue, 11 Apr 2017 20:41:22 +1000
Message-ID: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60435 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdDKKle (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 11 Apr 2017 06:41:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

We have a problem using cherrypy in mgr modules.  Specifically, multiple
modules that use cherrypy stomp on each other.  I discovered this while
playing with John's guilolz experiment
(https://github.com/ceph/ceph/pull/13725).

Both rest and guilolz modules follow this pattern:

  cherrypy.config.update({'server.socket_port': ....})
  cherrypy.tree.graft(...)  # or cherrypy.tree.mount(...)
  cherrypy.engine.start()
  cherrypy.engine.block()

So:

- They're both first setting the port to listen on globally.
- They both eat the whole web namespace (graft/mount).
- They both call cherrypy.engine.start() to start the server.

In each of the above cases, the first module loaded will win and the
other won't (or, it might be racey and you'll kinda get a mix?).  For
example, the second call to cherrypy.engine.start() fails complaining it
can't be called more than once from the same thread.

I'm not sure how best to deal with this.  Assuming we *do* want it to be
possible for multiple modules that provide a web service to be loaded
simultaneously, we need to:

- not set the port globally.
- not stomp on each others namespaces.
- only call cherrypy.engine.start() once.

You can have multiple cherrypy servers listening on different ports, so
that gets us part of the way there, e.g.:

  from cherrypy._cpserver import Server
  server = Server()
  server.socket_port = .... # whatever
  server.subscribe()

But, this doesn't fix the namespace eating problem.  That might be
doable with cherrypy virtualhosts
(http://tools.cherrypy.org/wiki/VirtualHosts), but I haven't
experimented further with that yet.

Also, those subscribe()s have to happen before the
cherrypy.engine.start() call or they have no effect.  One way to do that
would be to have some magic cherrypy module which is always loaded last
to start the engine, but that might be ugly.

Another option might be to have a separate python interpreter per module
(can't stomp on each other then, right?) but that might be too resource
intensive.

Thoughts?

Thanks,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
