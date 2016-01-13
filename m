From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Ideas for new ceph-mgr service
Date: Wed, 13 Jan 2016 12:02:12 -0600
Message-ID: <56969124.4040604@redhat.com>
References: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com> <156637337.14721161.1452700430079.JavaMail.zimbra@redhat.com> <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbcAMSCR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 13:02:17 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 01B27C09FAA9
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 18:02:16 +0000 (UTC)
In-Reply-To: <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/13/2016 11:27 AM, John Spray wrote:
> On Wed, Jan 13, 2016 at 3:53 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
>> Hi,
>>
>>
>> ----- Original Message -----
>>> From: "John Spray" <jspray@redhat.com>
>>> To: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Wednesday, January 13, 2016 8:13:27 AM
>>> Subject: Ideas for new ceph-mgr service
>>>
>>> Hi all,
>>>
>>> We currently have an unfulfilled need for a high level
>>> management/monitoring service that can take some of the non-essential
>>> tasks away from the mon (like handling the volume of advisory pg
>>> stats), and provide a place to implement new features (like
>>> cluster-wide command and control of the new scrub stuff in cephfs).
>>
>> I (and our group as a whole) think this will be a HUGE win, it's something we've talked about conceptually for years.  Thank you sincerely for proposing and prototyping this!
>
> Good to hear!
>
>>>
>>> We've had a couple of attempts in this area historically:
>>>   * ceph-rest-api, which is a stateless HTTP wrapper around the
>>> MonCommand interface.  All calls hit the mons directly, it's really
>>> just a protocol converter, and it's really more RPC than REST.
>>>   * Calamari, which has a very extensible architecture, but suffers
>>> from being rather heavyweight, with lots of dependencies like its own
>>> database, and requires its own separate agents running on all the Ceph
>>> servers.
>>>
>>> So, the idea is to create a new lightweight service (ceph-mgr) that
>>> runs alongside the mon, and uses the existing Ceph network channels to
>>> talk to remote hosts.  The address of this service would be published
>>> in the OSDMap, and OSDs and other daemons would send their
>>> non-essential stats to the mgr instead of the mon.  For HA we would
>>> probably run a mgr alongside each mon, and use whichever mgr instance
>>> lived with the current leader mon.
>>>
>>> Internally, the mgr itself then has three main components:
>>>   * The server (a Messenger), which receives telemetry from daemons
>>> elsewhere in the system, and receives cluster map updates from the mon
>>>   * A simple in memory store of all the structures that we receive from
>>> the cluster (the maps, the daemon metadata, the pg stats)
>>>   * An embedded python interpreter that hosts high level functionality
>>> like a REST API.
>>>
>>> The mgr embodies the interface between "C++ Ceph land" (cephx auth,
>>> Messenger, and ::encode/::decode serialization) and "admin land"
>>> (JSON-like structures, REST APIs, Python modules).  The reason for
>>> doing this in one process, rather than putting the Python parts in a
>>> separate service (like calamari) is twofold:
>>>   * Code simplicity: avoid inventing a C++->Python network API that
>>> re-implements things like cluster map subscription and incremental
>>> OSDmaps.
>>>   * Efficiency: transmit data in its native encoding, hold it in memory
>>> in native structs, and only expose what's needed up into Python-land
>>> at runtime.
>>
>> I defer to your intuition on keeping this localized in the ceph-mon process (there are obviously a ton of reaosns to do this).
>>
>> I would -strongly- request that we not use a hybrid C++ & Python server as a production version of this capability.  If the proof of concept is as successful as I intuit, I think it would be highly desirable to design a scalable, native-code framework for the core management service runtime.
>>
>> Any apparent advantage from flexibility of Cython interfacing is, honestly, I think, strongly outweighed by the drawbacks of supporting the hybrid interfaces, not to mention the pervasive serialization and latency properties of a Python-driven runtime model.  (That's not to say I think that Python shouldn't be used to implement routines called from a core management runtime, if you strongly prefer not to run such code out-of-process [as systems like Salt, iirc, do].)
>
> The idea is that the core of the service is in C++, handling talking
> to the Ceph cluster, and updating all the state.  The python stuff
> would be loaded and plug into a very narrow interface: actually pretty
> similar to what the python code in the current CLI can do (send
> commands, read status json objects), but without the serialization
> overhead, and with efficient notifications for subscribing to cluster
> map updates.  What I definitely *don't* want to do is write thousands
> of lines of wrapper/interface code.
>
> Latency: the python layer is stuff that will be called remotely over
> HTTP from GUIs or other tools: once you're going down the whole
> HTTP/JSON route, the efficiency of the language runtime tends to
> become less significant, and the chances are that the code at the
> other end of the collection is not super-efficient either.  The key
> efficiency part IMHO is how we handle the firehose of data coming from
> the cluster (in C++) rather than the individual request handling (in
> Python).  I tend to think of the C++ side as the "downwards" interface
> to Ceph, and the Python as the "upwards" interface to the wider world,
> and this process is really straddling the line between the part where
> raw execution performance is very important, and the part where ease
> of integration with other code is most important.
>
> Aside from performance, I recognise that there would be an argument to
> use C++ throughout in the interests of uniformity.  For me, that's
> outweighed by the how radically quicker it is to build web services in
> Python, and an outward-facing REST API would be one of the biggest
> parts of this service LOC-wise.

My gut instinct is to agree with Matt on this one, but I know the pain 
of trying to develop web services in C++ so I can't get too ornery about 
it.  If there are ways to keep it C++ throughout without too much pain 
I'd advocate that route.

>
> All that said... my big get-out here is that I don't think it's an
> either-or choice.  We could readily define the interface to these
> modules in C++ terms, and then implement the python-wrapping as a
> special C++ module that happens to just load up and run python code.
> That way, when there were pieces of functionality that made sense in
> C++ (for example if we wanted to efficiently scan over lots of PG data
> to generate some other statistics or state) we could use it, and in
> other cases (for example a third party wants to plug our stats output
> into their system) they can write lightweight python modules.

If nothing else it's a good sales pitch anyway! :)  Seriously, it does 
sound nice.  Just the hairs on the back of my neck go up a bit.

>
> John
>
> P.S. I think this was just a typo in your mail but to clarify, I'm
> talking about CPython (the default python interpreter) rather than
> Cython (the static compiler for python)
>
>>
>> Matt
>>
>>>
>>> That last part involves a bit of a trick: because Python (specifically
>>> the CPython interpreter) is so flexible, we can do neat things like
>>> implementing functions in C++ that have access to our native Ceph data
>>> structures, but are callable from high level Python code.  We can also
>>> cast our C++ structures into Python dicts directly, without an
>>> intermediate JSON step, using a magic Formatter subclass that
>>> generates python objects instead of serializing.  In general the
>>> PyFormatter is still not quite as efficient as writing full blown
>>> wrappers for C++ structures, but it's way more efficient that
>>> serializing stuff to JSON and sending it over the network.
>>>
>>> Most of the business logic would then be written in python.  This
>>> would include the obvious status/health REST APIs, but potentially
>>> also things like pool management (similar to how the Calamari API
>>> handles these).  As well as being accessible via a REST API, the stats
>>> that live in the mgr could also be streamed on to a full featured time
>>> series database like influxdb, for users that want to deploy that kind
>>> of thing.  Our service would store some very recent history, so that
>>> folks without a full featured TSDB can still load things like the last
>>> 60s of bandwidth into a graph in their GUI, if they have a GUI that
>>> uses our API.
>>>
>>> I've written a small proof-of-concept service that just subscribes to
>>> cluster maps, loads a python module that acts as an HTTP server, and
>>> exposes the maps to the module.  It's here:
>>> https://github.com/jcsp/ceph/tree/wip-pyfoo/src/pyfoo
>>>
>>> I appreciate that this might not all be completely clear in text form,
>>> probably some more detailed design and pictures will be needed in due
>>> course, but I wanted to put this out there to get feedback.
>>>
>>> Cheers,
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> --
>> Matt Benjamin
>> Red Hat, Inc.
>> 315 West Huron Street, Suite 140A
>> Ann Arbor, Michigan 48103
>>
>> http://www.redhat.com/en/technologies/storage
>>
>> tel.  734-707-0660
>> fax.  734-769-8938
>> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
