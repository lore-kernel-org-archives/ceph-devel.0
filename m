From: Travis Rhoden <trhoden@gmail.com>
Subject: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 15:38:38 -0400
Message-ID: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61700 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621Ab2HPTjA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 15:39:00 -0400
Received: by qcro28 with SMTP id o28so2462707qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 12:38:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

I've seen a couple threads in the past about /etc/init.d/ceph not
working right when the output of 'hostname' did not match the 'host'
entry in ceph.conf.  I'm hoping you can advise me on how to get the
following setup working.

I have multiple nodes that both a GigE connection and a secondary
high-speed connection (either 10GbE or IPoIB -- I've got both setups).
 I want to use the high-speed connection for everything (both node
replication, and client<-->node traffic), but the hostnames on the
storage nodes are mapped to the GbE address.  You can think of the
following being in /etc/hosts:

10.1.0.1   ceph0
10.30.0.1 ceph0-ib


If I ssh to ceph0 and type "hostname", the output will be 'ceph0'. I
think that part is pretty straightforward.  However, I have entries
like this in ceph.conf:

[mon.a]
        host = ceph0-ib
        mon addr = 10.30.0.1:6789

[osd.0]
        host = ceph0-ib


Because these hostnames don't match, things like "ceph -a status"
don't work as intended.  Although the cluster functions fine, and uses
the high-speed network.  Is there a different way I should populate
ceph.conf to get everything to work correct?

For the [mon.x] section, how is the 'host' param used?  is it mapped
to an IP address?  If it is, why the 'mon addr' field?  If it is not,
then I could just use 'ceph0' instead of 'ceph0-ib' and things would
be happy.

For the [osd.x] section I have the same question.  Is "host" mapped to
an IP address?  I would assume so, and thus I am force to put the -ib
version of the hostname.  Is there something else I could do in this
scenario?

Thanks,

 - Travis
