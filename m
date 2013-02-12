From: Sage Weil <sage@inktank.com>
Subject: Re: rest mgmt api
Date: Mon, 11 Feb 2013 16:51:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302111646290.27987@cobra.newdream.net>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net> <5112B43D.6070602@bmrb.wisc.edu>
 <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net> <CAPYLRzh5JD3hvxB5VFrmEXq2g9JuEk-ODQquahPMwGMRiqSc6g@mail.gmail.com> <alpine.DEB.2.00.1302111345000.27987@cobra.newdream.net> <CAPYLRzhfsYeqRVhxt+i7N7Djer7TfwVzZy67jJuyZ6LVM0P2yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41587 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674Ab3BLAv3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 19:51:29 -0500
In-Reply-To: <CAPYLRzhfsYeqRVhxt+i7N7Djer7TfwVzZy67jJuyZ6LVM0P2yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 11 Feb 2013, Gregory Farnum wrote:
> [...]
> ...but my instinct is to want one canonical code path in the monitors,
> not two. Two allows for discrepancies in what each method allows to
> [...]

Yeah, I'm convinced.

Just chatted with Dan and Josh a bit about this.  Josh had the interesting 
idea that the specification of what commands are supported could be 
requested from the monitor is some canonical form (say, a blob of JSON), 
and then enforced at the client.  That would be translated into an 
argparse config for the CLI, and a simple matching/validation table for 
the REST endpoint.

That might be worth the complexity to get the best of both worlds... but 
first Dan is looking at whether Python's argparse will do everything we 
want for the CLI end of things.

In the meantime, the first set of tasks still stand: move the ceph tool 
cruft into MonClient and Objecter and out of tool/common.cc for starters.

sage
