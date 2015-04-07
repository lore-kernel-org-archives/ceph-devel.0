From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial newstore vs filestore results
Date: Tue, 07 Apr 2015 14:16:37 -0500
Message-ID: <55242D15.8080800@redhat.com>
References: <5523F069.3000400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbDGTQk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Apr 2015 15:16:40 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t37JGdew022584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 7 Apr 2015 15:16:40 -0400
Received: from [10.3.112.84] (ovpn-112-84.phx2.redhat.com [10.3.112.84])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t37JGbeV026661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 7 Apr 2015 15:16:39 -0400
In-Reply-To: <5523F069.3000400@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 04/07/2015 09:57 AM, Mark Nelson wrote:
> Hi Guys,
>
> I ran some quick tests on Sage's newstore branch.  So far given that
> this is a prototype, things are looking pretty good imho.  The 4MB
> object rados bench read/write and small read performance looks
> especially good.  Keep in mind that this is not using the SSD journals
> in any way, so 640MB/s sequential writes is actually really good
> compared to filestore without SSD journals.
>
> small write performance appears to be fairly bad, especially in the RBD
> case where it's small writes to larger objects.  I'm going to sit down
> and see if I can figure out what's going on.  It's bad enough that I
> suspect there's just something odd going on.
>
> Mark

Seekwatcher/blktrace graphs of a 4 OSD cluster using newstore for those 
interested:

http://nhm.ceph.com/newstore/

Interestingly small object write/read performance with 4 OSDs was about 
1/3-1/4 the speed of the same cluster with 36 OSDs.

Note: Thanks Dan for fixing the directory column width!

Mark
