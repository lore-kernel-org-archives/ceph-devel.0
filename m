From: Gregory Meno <gmeno@redhat.com>
Subject: Calamari 1.4
Date: Fri, 19 Feb 2016 17:14:02 -0800
Message-ID: <CABq-AySXr9TPruUTB_6V986XGRGaZAETV1djmsYTCTGf2ssPyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36256 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1428937AbcBTBOE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Feb 2016 20:14:04 -0500
Received: by mail-yw0-f177.google.com with SMTP id e63so80634488ywc.3
        for <ceph-devel@vger.kernel.org>; Fri, 19 Feb 2016 17:14:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-calamari@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

Coming soon to a jewel near you.

What is it:

Calamari is a REST API written in python. It seeks to give API
endpoints like /cluster,
/pool, and /osd and unsurprisingly allow HTTP requests to inspect and
modify the resources a Ceph cluster provides. It simplifies access to
the control-plane by making it available across the network.

What is changing from the calamari I knew:
Calamari is going on a diet. We're shedding dependencies on saltstack.
The new version will be able to be run along-side Ceph Monitor
processes on the monitor nodes.  Where before calamari sought to place
agents on all nodes on the clusters it managed and monitored;  we now
only care about the cluster we're setup on

What is staying the same:
The API -- http://calamari.readthedocs.org/en/latest/calamari_rest/index.html
This is really the part I'm most excited about. If you've used
calamari in the past I am committed to delivering compatibility in
this release


How can I try it out:
* note this is still development code -- don't put it on production clusters
* http://calamari.readthedocs.org/en/latest/development/dev_env.html#using-vagrant
* release candidate packages will be available soon


How can I help:
* Contribute doc improvements
* File bugs in https://github.com/ceph/calamari/issues
* Fix bugs :)
* help with packaging
* contribute to the future direction by discussing this on the mailing
list -- ceph-calamari@lists.ceph.com

regards,
Gregory
