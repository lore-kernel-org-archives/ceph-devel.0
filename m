From: Jonathan Proulx <jon@csail.mit.edu>
Subject: Re: Ideal hardware spec?
Date: Wed, 22 Aug 2012 11:46:15 -0400
Message-ID: <20120822154615.GF10015@csail.mit.edu>
References: <20120822135530.GB10015@csail.mit.edu>
 <5034E9F3.10001@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from outgoing.csail.mit.edu ([128.30.2.149]:38887 "EHLO
	outgoing.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab2HVPqR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 11:46:17 -0400
Content-Disposition: inline
In-Reply-To: <5034E9F3.10001@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 22, 2012 at 04:17:23PM +0200, Wido den Hollander wrote:

:On 08/22/2012 03:55 PM, Jonathan Proulx wrote:

:You can also use the USB sticks[0] from Stec, they have servergrade
:onboard USB sticks for these kind of applications.

Those look quite interesting.

:A couple of questions still need to be answered though:
:* Which OS are you planning on using? Ubuntu 12.04 is recommended

Ubuntu 12.04 is our current preferred OS

:* Which filesystem do you want to use underneath the OSDs?

Whatever I can get to work best in testing :)

Since this is for a research platform not a product I'd likely start with
BTRFS and see if it is "stable enough" and "performant enough" with
fall back to XFS if needed

-Jon

:Wido
:
:[0]: http://www.stec-inc.com/product/ufm.php
