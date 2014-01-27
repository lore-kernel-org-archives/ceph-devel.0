From: Sage Weil <sage@inktank.com>
Subject: Re: RADOS + deep scrubbing performance issues in production
 environment
Date: Mon, 27 Jan 2014 10:45:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
References: <20140127151321.GD26390@philipgian-mac> <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33663 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbaA0Sps (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 13:45:48 -0500
In-Reply-To: <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: Filippos Giannakos <philipgian@grnet.gr>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

There is also 

 ceph osd set noscrub

and then later

 ceph osd unset noscrub

I forget whether this pauses an in-progress PG scrub or just makes it stop 
when it gets to the next PG boundary.

sage

On Mon, 27 Jan 2014, Kyle Bader wrote:

> > Are there any tools we are not aware of for controlling, possibly pausing,
> > deep-scrub and/or getting some progress about the procedure ?
> > Also since I believe it would be a bad practice to disable deep-scrubbing do you
> > have any recommendations of how to work around (or even solve) this issue ?
> 
> The periodicity of scrubs is controllable with these tunables:
> 
> osd scrub max interval
> osd deep scrub interval
> 
> You may also be interested in adjusting:
> 
> osd scrub load threshold
> 
> More information on the docs page:
> 
> http://ceph.com/docs/master/rados/configuration/osd-config-ref/#scrubbing
> 
> Hope that helps some!
> 
> -- 
> 
> Kyle
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
