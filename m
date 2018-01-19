From: Blaine Gardner <blaine.gardner@suse.com>
Subject: MDS modules and containers
Date: Fri, 19 Jan 2018 08:03:24 -0700
Message-ID: <2798364c-e952-74c6-7140-7458f9730afc@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:60935 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754542AbeASPD3 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 19 Jan 2018 10:03:29 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: rdias@suse.com

I've been talking with some of my colleagues about the manager and 
manager modules, and I have concerns that the manager might become 
bloated over time. I understand the need to have high-performant access 
to the cluster via C++ bindings, and I think that design decision makes 
sense.

I'm starting to see that there is a trend, however, and I'd like to talk 
about how we might realign to something better before there are too many 
modules. As an example, there are several manager modules which run 
their own web server. The dashboard, for instance, as well as the 
prometheus exporter, among others.

When I consider the manager in containerized contexts, the manager 
container might be running 5 web servers, and that feels rather wrong. I 
have a few thoughts for how this might be improved. Specifically, I've 
been thinking that manager modules can probably be broken into 3 
different paradigms.

1. Modules that collect information from the Ceph cluster and then send 
inputs to the cluster based on some automatic logic and that have 
sensitive time constraints. These modules make sense to be run alongside 
the manager.

2. Modules that collect a large amount of information from the cluster 
at once which is then consumed by the user. This would be like the 
Prometheus exporter. It can benefit from fast access to the cluster for 
gathering the data, but, at the end of the day, the information is 
consumed by the user, and the information is already subject to network 
latencies. It makes sense to run the data collection alongside the 
manager, but the rest of the application I don't think belongs.

3. Modules that collect information from the cluster to display to the 
user. This would be something like the dashboard. Most of the 
interaction users will have with these applications are bound by network 
speeds, and I don't think it makes sense to have them running alongside 
the manager when they could just as easily run in a separate container. 
It would make more sense to me to implement a REST API for the 
information the dashboard wishes to display and have the dashboard call 
the API to get/put the information.

Ricardo Dias has suggested that in addition to REST APIs, it might also 
be worth considering an RPC interface. With this, perhaps modules from 
paradigm #2 could live completely separate rather than parially separate.

I think these things are worth discussing before the manager becomes 
bloated with modules, both in lines of code, as well as system resources.

Thanks!
Blaine
