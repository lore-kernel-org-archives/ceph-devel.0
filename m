From: kefu chai <tchaikov@gmail.com>
Subject: adding "{mds,mon} metadata" asok command
Date: Fri, 20 Mar 2015 13:39:00 +0800
Message-ID: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37206 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbCTFjA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 01:39:00 -0400
Received: by igcqo1 with SMTP id qo1so9413460igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 22:39:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi ceph,

to pave the road to http://tracker.ceph.com/issues/10904, where we
need to add a command to list the hostname of nodes in a ceph cluster,
i would like to add the "{mds,mon} metadata" commands to print the
system information including, but not limited to hostname,
mem_{total,swap}_kb, and distro info, of specified mds and mon.

the implementation follow the mechanism of "osd metadata":

on the mds side i would like to reuse the MDSMonitor service:
1. piggy back a map for the metadata in MMDSBeacon message,
2. put the metadata into the same DBStore transaction but with another
prefix when storing the pending inc into local storage.
3. and expose it using the "mds metadata" and later on the "service
ls" (not sure about the name ...)

@greg and @zyan, are you good with this? not sure this will overburden
the mds or not. i will use uname(2) and grep /proc/meminfo to get the
metadata in the same way of OSD.

on the mon side, i will apply the same approach to MMonJoin and
MonmapMonitor, but with another prefix when putting encoding metadata
into transaction.

@joao, IIRC, you were suggesting me to add another paxos service for
this purpose but is it feasible to put this data into MMonJoin and
persist it into the paxos service's storage?

any suggestion or comments would be appreciated. if no objections, i
will be on it.

thanks =)

-- 
Regards
Kefu Chai
