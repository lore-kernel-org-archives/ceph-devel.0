From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Wed, 14 Jun 2017 13:45:52 -0700
Message-ID: <CADRKj5RNeFv_xNYSzADmY3NahHe7pqoqo=UgF4eh0_1-jb2QgQ@mail.gmail.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
 <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com> <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:32896 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdFNUpy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 16:45:54 -0400
Received: by mail-qt0-f169.google.com with SMTP id u12so15295480qth.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 13:45:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 14, 2017 at 12:50 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 14 Jun 2017, Yehuda Sadeh-Weinraub wrote:
>> On Sun, Jun 11, 2017 at 5:04 AM, John Spray <jspray@redhat.com> wrote:
>> > MgrClient instances (such as those in the daemons, and those in every
>> > librados instance) open a session with ceph-mgr where they identify
>> > themselves by entity name and type.  ceph-mgr sends a MgrConfigure
>> > message, which tells the client whether to both sending stats and how
>> > often.  ceph-mgr also keeps a copy of the metadata (a la "ceph osd
>> > metadata...") for OSD and MDS daemons -- it loads all that up at
>> > startup, and then also freshens it when it sees a daemon restart or
>> > sees a new daemon.
>> >
>> > We would like to have something similar so that the mgr can be aware
>> > of the existence of other services like RGW gateways, RBD mirror
>> > services, perhaps also NFS gateways.
>> >
>> > The information about each daemon would at a minimum be its identity,
>> > type, and some static metadata.  It might also include some dynamic
>> > state/health structure.  The challenging part here is how to expose
>> > that to the various daemons, given that things like RGW are not known
>> > in advance to core Ceph and that they just consume the librados
>> > interface.
>>
>>
>> To start with, for radosgw process we could provide:
>
> It seems like these fall into two categories:
>
> 1/ static information about the daemon instance
>
>>  - realm name (+ id)
>>  - zonegroup name (+ id)
>>  - zone name (+ id )
>>  - instance id # (changes between runs)
>>  - listening ip:port
>>  - list of domains handled (maybe? can be quite large)
>>  - max number of concurrent requests
>
> This stuff would populate a 'running rgw daemons' type view, and could be
> used by an agent that dynamically configures a load balancer (haproxy or
> whatever).
>
> 2/ dynamic values that can be exposed as perfcounters
>
>>  - current period
>>  - current # of requests (or max # of requests in the past X minutes)
>  - current bandwidth
>  - etc
>
> Is there anything that is updated at runtime (not startup) that
> doesn't fit into a perfcounter?  It not, then a single call to something
> like rados_register_daemon(name, metadata_map) (and some mechanism
> for cleaning out dead people) ought to suffice?
>
>> There is some other info that falls under different aspects of the rgw
>> cluster, e.g., all the realm info / structure, the zonegroup config,
>> zone config. This kind of data should be a category of its own, and
>> more of a container to the specific radosgw process info. Does it make
>> sense in the ceph-mgr context?
>
> This stuff any potential mgr module can pull out of the zone metadata pool
> itself to display, right?  rgw doesn't need to translate it and
> report it?

Right, that's another option.

>
>> > It doesn't feel like a particularly natural thing for librados, but
>> > ultimately whatever we expose to rgw/rbd is de-facto librados, even if
>> > we put it in a different library or whatever.
>> >
>> > So far I've got as far as thinking we should have an extra call just
>> > in the C++ bindings that lets callers say "Hi, I'm a service not just
>> > a client, and here's a map of metadata", that they call one time
>> > between creating their RadosClient and connecting to the cluster.
>> >
>>
>>
>> It'd be great if the client itself could provide a flexible schema
>> mapping of the info that it needs to expose. Or if there was some
>> other generic way to do it. Was thinking something like the way you
>> send a json to elasticsearch and it generates a doc out of it, but
>> there's also a way to create a fixed mapping for the stored data.
>
> Hmm, instead of a map<string,string> it could just be a json blob that
> the mgr stores that it is up to the user to parse and interpret.  Or, if
> there is info that doesn't fit into a simple dict, then one dict item
> ("extra_stuff") can have a value consisting of encoded json.
>

Providing a json is probably easy and generic enough.

Yehuda
