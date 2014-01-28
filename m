From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Re: RADOS + deep scrubbing performance issues in production
 environment
Date: Tue, 28 Jan 2014 20:12:46 +0200
Message-ID: <20140128181246.GB11532@philipgian-mac>
References: <20140127151321.GD26390@philipgian-mac>
 <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:29355 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755205AbaA1SMv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jan 2014 13:12:51 -0500
Content-Disposition: inline
In-Reply-To: <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

On Mon, Jan 27, 2014 at 01:10:23PM -0500, Kyle Bader wrote:
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

Thanks Kyle but this does not solve the performance degradation when the deep
scrubbing is actually running. Plus, it can take several days to complete.

Kind Regards,
-- 
Filippos
<philipgian@grnet.gr>
