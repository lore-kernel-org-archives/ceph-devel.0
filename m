From: John Spray <jspray@redhat.com>
Subject: Re: multiple cherrypys in ceph-mgr modules stomp on each other
Date: Tue, 11 Apr 2017 12:38:53 +0100
Message-ID: <CALe9h7frJdDbqtTgTctqE-aLHs7zHRpB7zV4us9hV1Wu-Xgycg@mail.gmail.com>
References: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com> <458F8704-74E1-4446-BAAC-4BEE1366EBC7@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37805 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754768AbdDKLjP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Apr 2017 07:39:15 -0400
Received: by mail-wm0-f41.google.com with SMTP id u2so58739473wmu.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Apr 2017 04:39:14 -0700 (PDT)
In-Reply-To: <458F8704-74E1-4446-BAAC-4BEE1366EBC7@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>
Cc: Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Apr 11, 2017 at 12:17 PM, Ricardo Dias <rdias@suse.com> wrote:
> Hi,
>
> What if ceph-mgr modules could actually depend on each other. That way,
> we could have a single cherrypy module and other modules could depend
> on the cherrypy module.
> The cherrypy module would redirect requests to the corresponding module.
> Would that be an option?

That's already possible, it's just that the cherrypy module wouldn't
be a mgr module per se, it would just be a python module that the mgr
modules used.

John

> I know nothing about the ceph-mgr architecture, so ignore my suggestion if
> does not make sense at all.
>
> Ricardo Dias
>
>> On 11 Apr 2017, at 11:41, Tim Serong <tserong@suse.com> wrote:
>>
>> Hi All,
>>
>> We have a problem using cherrypy in mgr modules.  Specifically, multiple
>> modules that use cherrypy stomp on each other.  I discovered this while
>> playing with John's guilolz experiment
>> (https://github.com/ceph/ceph/pull/13725).
>>
>> Both rest and guilolz modules follow this pattern:
>>
>>  cherrypy.config.update({'server.socket_port': ....})
>>  cherrypy.tree.graft(...)  # or cherrypy.tree.mount(...)
>>  cherrypy.engine.start()
>>  cherrypy.engine.block()
>>
>> So:
>>
>> - They're both first setting the port to listen on globally.
>> - They both eat the whole web namespace (graft/mount).
>> - They both call cherrypy.engine.start() to start the server.
>>
>> In each of the above cases, the first module loaded will win and the
>> other won't (or, it might be racey and you'll kinda get a mix?).  For
>> example, the second call to cherrypy.engine.start() fails complaining it
>> can't be called more than once from the same thread.
>>
>> I'm not sure how best to deal with this.  Assuming we *do* want it to be
>> possible for multiple modules that provide a web service to be loaded
>> simultaneously, we need to:
>>
>> - not set the port globally.
>> - not stomp on each others namespaces.
>> - only call cherrypy.engine.start() once.
>>
>> You can have multiple cherrypy servers listening on different ports, so
>> that gets us part of the way there, e.g.:
>>
>>  from cherrypy._cpserver import Server
>>  server = Server()
>>  server.socket_port = .... # whatever
>>  server.subscribe()
>>
>> But, this doesn't fix the namespace eating problem.  That might be
>> doable with cherrypy virtualhosts
>> (http://tools.cherrypy.org/wiki/VirtualHosts), but I haven't
>> experimented further with that yet.
>>
>> Also, those subscribe()s have to happen before the
>> cherrypy.engine.start() call or they have no effect.  One way to do that
>> would be to have some magic cherrypy module which is always loaded last
>> to start the engine, but that might be ugly.
>>
>> Another option might be to have a separate python interpreter per module
>> (can't stomp on each other then, right?) but that might be too resource
>> intensive.
>>
>> Thoughts?
>>
>> Thanks,
>>
>> Tim
>> --
>> Tim Serong
>> Senior Clustering Engineer
>> SUSE
>> tserong@suse.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
