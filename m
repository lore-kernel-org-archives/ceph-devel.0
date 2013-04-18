From: "Plaetinck, Dieter" <dieter@vimeo.com>
Subject: erasure coding (sorry)
Date: Thu, 18 Apr 2013 16:28:42 -0400
Message-ID: <20130418162842.0c61d1e2@dieter-t420s>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lav-excas.iac.com ([208.185.199.15]:11362 "EHLO
	ny-iacmail.iac.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936525Ab3DRUeC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 16:34:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

sorry to bring this up again, googling revealed some people don't like the subject [anymore].

but I'm working on a new +- 3PB cluster for storage of immutable files.
and it would be either all cold data, or mostly cold. 150MB avg filesize, max size 5GB (for now)
For this use case, my impression is erasure coding would make a lot of sense
(though I'm not sure about the computational overhead on storing and loading objects..? outbound traffic would peak at 6 Gbps, but I can make it way less and still keep a large cluster, by taking away the small set of hot files.
inbound traffic would be minimal)

I know that the answer a while ago was "no plans to implement erasure coding", has this changed?
if not, is anyone aware of a similar system that does support it? I found QFS but that's meant for batch processing, has a single 'namenode' etc.

thanks,
Dieter
