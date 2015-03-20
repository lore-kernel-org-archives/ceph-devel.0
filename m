From: John Spray <john.spray@redhat.com>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Fri, 20 Mar 2015 11:43:21 +0000
Message-ID: <550C07D9.30700@redhat.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbbCTLnZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Mar 2015 07:43:25 -0400
In-Reply-To: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 20/03/2015 05:39, kefu chai wrote:
> to pave the road to http://tracker.ceph.com/issues/10904, where we
> need to add a command to list the hostname of nodes in a ceph cluster,
> i would like to add the "{mds,mon} metadata" commands to print the
> system information including, but not limited to hostname,
> mem_{total,swap}_kb, and distro info, of specified mds and mon.
>
> the implementation follow the mechanism of "osd metadata":
>
> on the mds side i would like to reuse the MDSMonitor service:
> 1. piggy back a map for the metadata in MMDSBeacon message,
> 2. put the metadata into the same DBStore transaction but with another
> prefix when storing the pending inc into local storage.
> 3. and expose it using the "mds metadata" and later on the "service
> ls" (not sure about the name ...)
>
> @greg and @zyan, are you good with this? not sure this will overburden
> the mds or not. i will use uname(2) and grep /proc/meminfo to get the
> metadata in the same way of OSD.
It should be straightforward to include the metadata in MMDSBeacon only 
once per daemon lifetime, by checking if state is CEPH_MDS_STATE_BOOT -- 
that way we don't have to worry about any ongoing costs.  I expect that 
change can live entirely in Beacon.cc without touching any other MDS code.

As for the means of getting the information, I expect the generic 
kernel/mem/cpu/distro stuff from OSD::_collect_metadata can be moved up 
into common/ somewhere and reused as-is from mon+mds.

John
