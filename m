From: Sage Weil <sage@inktank.com>
Subject: Re: rest mgmt api
Date: Wed, 6 Feb 2013 12:14:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net>
 <5112B43D.6070602@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47337 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab3BFUO3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 15:14:29 -0500
In-Reply-To: <5112B43D.6070602@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: ceph-devel@vger.kernel.org

On Wed, 6 Feb 2013, Dimitri Maziuk wrote:
> On 02/06/2013 01:34 PM, Sage Weil wrote:
> 
> > I think the one caveat here is that having a single registry for commands 
> > in the monitor means that commands can come in two flavors: vector<string> 
> > (cli) and URL (presumably in json form).  But a single command 
> > dispatch/registry framework will make that distinction pretty simple...
> 
> Any reason you can't have your CLI json-encode the commands (or,
> conversely, your cgi/wsgi/php/servlet URL handler decode them into
> vector<string>) before passing them on to the monitor?

We can, but they won't necessarily look the same, because it is unlikely 
we can make a sane 1:1 translation of the CLI to REST that makes sense, 
and it would be nice to avoid baking knowledge about the individual 
commands into the client side.

 ceph osd pool create <poolname> <numpgs>
   vs
 /osd/pool/?op=create&poolname=foo&numpgs=bar

or whatever.  I know next to nothing about REST API design best practices, 
but I'm guessing it doesn't look like a CLI.

sage
