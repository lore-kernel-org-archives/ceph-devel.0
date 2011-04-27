From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Java-rados announcement
Date: Wed, 27 Apr 2011 14:22:46 -0700
Message-ID: <82250CCC-5986-4167-90D3-BBC0A2549872@cs.ucsc.edu>
References: <D20F8B6A-0A44-41BA-B98C-5956E8CBA55E@cs.ucsc.edu> <BANLkTimWCgtkpMfLX3HsMCAqacYkF=oydg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:51767 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1D0VW6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 17:22:58 -0400
In-Reply-To: <BANLkTimWCgtkpMfLX3HsMCAqacYkF=oydg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

On Apr 26, 2011, at 4:22 PM, Colin McCabe wrote:

> PHPRados has its own wiki page and a separate repo. It's at:
> http://ceph.newdream.net/wiki/Phprados
> 
> We should set up something similar for this, I think.

Sounds good to me. Plus, it makes things a bit simpler. I'll get this repo put together later in the week.

> P.S. 
> functions. That's what ceph-pybind-test.py. Is it possible to make
> something like that for the Java and PHP bindings?

Yes, this is definitely possible. I checked out ceph-pybind-test.py, and the unit tests I included with the Java bindings behave similarly--verifying basic functionality of each wrapped function. Driving the test suite from a script should be trivial.

Thanks for the feedback,
Noah