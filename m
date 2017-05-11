From: Jan Fajerski <jfajerski@suse.com>
Subject: Monitoring ceph and prometheus
Date: Thu, 11 May 2017 13:52:12 +0200
Message-ID: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35066 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbdEKLwR (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 11 May 2017 07:52:17 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,
I recently looked into Ceph monitoring with prometheus. There is already a ceph 
exporter for this purpose here https://github.com/digitalocean/ceph_exporter.

Prometheus encourages software projects to instrument their code directly and 
expose this data, instead of using an external piece of code. Several libraries 
are provided for this purpose: 
https://prometheus.io/docs/instrumenting/clientlibs/

I think there are arguments for adding this instrumentation to Ceph directly.  
Generally speaking it should reduce overall complexity in the code (no extra 
exporter component outside of ceph) and in operations (no extra package and 
configuration).

The direct instrumentation could happen in two places:
1)
Directly in Cephs C++ code using https://github.com/jupp0r/prometheus-cpp.  This 
would mean daemons expose their metrics directly via the prometheus http 
interface. This would be the most direct way of exposing metrics, prometheus 
would simply poll all endpoints. Service discovery for scrape targets, say added 
or removed OSDS, would however have to be handled somewhere. For orchestration 
tools à la k8s, ansible, salt, ... either have this feature already or it would 
be simple enough to add. Deployments not using a tool like that need another 
approach. Prometheus offer various mechanisms 
(https://prometheus.io/docs/operating/configuration/#%3Cscrape_config%3E) or a 
ceph component (say mon or mgr) could handle this.

2)
Add a ceph-mgr plugin that exposes the metrics available to ceph-mgr as a 
prometheus scrape target (using https://github.com/prometheus/client_python).  
This would handle the service discovery issue for ceph daemons out of the box 
(though not for the actual mgr-daemon which is the scrape target). The code 
would also be in a central location instead of being scattered in several 
places. It does however add a (maybe pointless) level of indirection 
($ceph_daemon -> ceph-mgr -> prometheus) and adds the need for two different 
scrape intervals (assuming mgr polls metrics from daemons).

I'm aware of the current dashboard efforts based on ceph-mgr exported data. I'm 
sure the data export for the dashboard and prometheus could be unified at some 
point.

Best,
Jan

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
