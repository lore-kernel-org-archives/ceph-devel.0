From: John Spray <jspray@redhat.com>
Subject: Re: MDS modules and containers
Date: Mon, 22 Jan 2018 10:15:07 +0000
Message-ID: <CALe9h7d2y+BpDFdPJfXx1T7Uq+hyzUJjy4Q4gKjNpCZWGc0QVQ@mail.gmail.com>
References: <2798364c-e952-74c6-7140-7458f9730afc@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36106 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeAVKP3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jan 2018 05:15:29 -0500
Received: by mail-wr0-f175.google.com with SMTP id d9so7989224wre.3
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jan 2018 02:15:28 -0800 (PST)
In-Reply-To: <2798364c-e952-74c6-7140-7458f9730afc@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blaine Gardner <blaine.gardner@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ricardo Dias <rdias@suse.com>

Thoughts on this in no particular order:
 - Running modules in-process is primarily about simplicity (of
development+maintenance, and having fewer moving parts at runtime)
rather than performance
 - If modules are run somewhere else, you end up needing some other
path for configuring/installing/executing them: you lose the
simplicity of "ceph mgr module enable dashboard"
 - True APIs are not cheap: the primary cost is in maintaining them
over time (backward compat), documenting them and testing them well
enough for external consumption.
 - ceph-mgr is extremely lightweight at the moment (the instance on my
home cluster has 100MB memory resident, the prometheus module is only
~400 LOC, etc...) -- we have a great deal of headroom before bloat
becomes an issue.
 - I don't anticipate the number of *running* modules spiralling.
As/when more modules are added, they'll tend to be either/or choices.
For example, I don't expect a lot of people to run the influx module
and the prometheus module together, and if someone writes another GUI
module they probably won't run it at the same time as dashboard.
 - container orchestrators do change some things (e.g. standby mgrs
mostly no longer needed), but they don't change the costs around
avoiding creating extra remote APIs
 - we will continue to run in non-container environments for a long
time, so this all still needs to work smoothly in environments that
don't have an orchestrator to take the pain out of having a profusion
of processes.

 At the moment I think the design decisions that went into ceph-mgr in
Kraken mostly still apply, and we're better off building out the
features rather than rearchitecting.

Cheers,
John


On Fri, Jan 19, 2018 at 3:03 PM, Blaine Gardner <blaine.gardner@suse.com> wrote:
> I've been talking with some of my colleagues about the manager and manager
> modules, and I have concerns that the manager might become bloated over
> time. I understand the need to have high-performant access to the cluster
> via C++ bindings, and I think that design decision makes sense.
>
> I'm starting to see that there is a trend, however, and I'd like to talk
> about how we might realign to something better before there are too many
> modules. As an example, there are several manager modules which run their
> own web server. The dashboard, for instance, as well as the prometheus
> exporter, among others.
>
> When I consider the manager in containerized contexts, the manager container
> might be running 5 web servers, and that feels rather wrong. I have a few
> thoughts for how this might be improved. Specifically, I've been thinking
> that manager modules can probably be broken into 3 different paradigms.
>
> 1. Modules that collect information from the Ceph cluster and then send
> inputs to the cluster based on some automatic logic and that have sensitive
> time constraints. These modules make sense to be run alongside the manager.
>
> 2. Modules that collect a large amount of information from the cluster at
> once which is then consumed by the user. This would be like the Prometheus
> exporter. It can benefit from fast access to the cluster for gathering the
> data, but, at the end of the day, the information is consumed by the user,
> and the information is already subject to network latencies. It makes sense
> to run the data collection alongside the manager, but the rest of the
> application I don't think belongs.
>
> 3. Modules that collect information from the cluster to display to the user.
> This would be something like the dashboard. Most of the interaction users
> will have with these applications are bound by network speeds, and I don't
> think it makes sense to have them running alongside the manager when they
> could just as easily run in a separate container. It would make more sense
> to me to implement a REST API for the information the dashboard wishes to
> display and have the dashboard call the API to get/put the information.
>
> Ricardo Dias has suggested that in addition to REST APIs, it might also be
> worth considering an RPC interface. With this, perhaps modules from paradigm
> #2 could live completely separate rather than parially separate.
>
> I think these things are worth discussing before the manager becomes bloated
> with modules, both in lines of code, as well as system resources.
>
> Thanks!
> Blaine
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
