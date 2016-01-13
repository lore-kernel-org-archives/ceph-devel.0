From: John Spray <jspray@redhat.com>
Subject: Ideas for new ceph-mgr service
Date: Wed, 13 Jan 2016 13:13:27 +0000
Message-ID: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34129 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbcAMNNs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 08:13:48 -0500
Received: by mail-lf0-f49.google.com with SMTP id 17so52719463lfz.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 05:13:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

We currently have an unfulfilled need for a high level
management/monitoring service that can take some of the non-essential
tasks away from the mon (like handling the volume of advisory pg
stats), and provide a place to implement new features (like
cluster-wide command and control of the new scrub stuff in cephfs).

We've had a couple of attempts in this area historically:
 * ceph-rest-api, which is a stateless HTTP wrapper around the
MonCommand interface.  All calls hit the mons directly, it's really
just a protocol converter, and it's really more RPC than REST.
 * Calamari, which has a very extensible architecture, but suffers
from being rather heavyweight, with lots of dependencies like its own
database, and requires its own separate agents running on all the Ceph
servers.

So, the idea is to create a new lightweight service (ceph-mgr) that
runs alongside the mon, and uses the existing Ceph network channels to
talk to remote hosts.  The address of this service would be published
in the OSDMap, and OSDs and other daemons would send their
non-essential stats to the mgr instead of the mon.  For HA we would
probably run a mgr alongside each mon, and use whichever mgr instance
lived with the current leader mon.

Internally, the mgr itself then has three main components:
 * The server (a Messenger), which receives telemetry from daemons
elsewhere in the system, and receives cluster map updates from the mon
 * A simple in memory store of all the structures that we receive from
the cluster (the maps, the daemon metadata, the pg stats)
 * An embedded python interpreter that hosts high level functionality
like a REST API.

The mgr embodies the interface between "C++ Ceph land" (cephx auth,
Messenger, and ::encode/::decode serialization) and "admin land"
(JSON-like structures, REST APIs, Python modules).  The reason for
doing this in one process, rather than putting the Python parts in a
separate service (like calamari) is twofold:
 * Code simplicity: avoid inventing a C++->Python network API that
re-implements things like cluster map subscription and incremental
OSDmaps.
 * Efficiency: transmit data in its native encoding, hold it in memory
in native structs, and only expose what's needed up into Python-land
at runtime.

That last part involves a bit of a trick: because Python (specifically
the CPython interpreter) is so flexible, we can do neat things like
implementing functions in C++ that have access to our native Ceph data
structures, but are callable from high level Python code.  We can also
cast our C++ structures into Python dicts directly, without an
intermediate JSON step, using a magic Formatter subclass that
generates python objects instead of serializing.  In general the
PyFormatter is still not quite as efficient as writing full blown
wrappers for C++ structures, but it's way more efficient that
serializing stuff to JSON and sending it over the network.

Most of the business logic would then be written in python.  This
would include the obvious status/health REST APIs, but potentially
also things like pool management (similar to how the Calamari API
handles these).  As well as being accessible via a REST API, the stats
that live in the mgr could also be streamed on to a full featured time
series database like influxdb, for users that want to deploy that kind
of thing.  Our service would store some very recent history, so that
folks without a full featured TSDB can still load things like the last
60s of bandwidth into a graph in their GUI, if they have a GUI that
uses our API.

I've written a small proof-of-concept service that just subscribes to
cluster maps, loads a python module that acts as an HTTP server, and
exposes the maps to the module.  It's here:
https://github.com/jcsp/ceph/tree/wip-pyfoo/src/pyfoo

I appreciate that this might not all be completely clear in text form,
probably some more detailed design and pictures will be needed in due
course, but I wanted to put this out there to get feedback.

Cheers,
John
