From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial newstore vs filestore results
Date: Thu, 09 Apr 2015 12:00:52 -0500
Message-ID: <5526B044.2090002@redhat.com>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com> <55248856.1010808@redhat.com> <alpine.DEB.2.00.1504071951120.4469@cobra.newdream.net> <5525EFCC.3070607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753680AbbDIRAz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Apr 2015 13:00:55 -0400
In-Reply-To: <5525EFCC.3070607@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/08/2015 10:19 PM, Mark Nelson wrote:
> On 04/07/2015 09:58 PM, Sage Weil wrote:
>> What would be very interesting would be to see the 4KB performance
>> with the defaults (newstore overlay max = 32) vs overlays disabled
>> (newstore overlay max = 0) and see if/how much it is helping.
>
> And here we go.  1 OSD, 1X replication.  16GB RBD volume.
>
> 4MB        write    read    randw    randr
> default overlay    36.13    106.61    34.49    92.69
> no overlay    36.29    105.61    34.49    93.55
>
> 128KB        write    read    randw    randr
> default overlay    1.71    97.90    1.65    25.79
> no overlay    1.72    97.80    1.66    25.78
>
> 4KB        write    read    randw    randr
> default overlay    0.40    61.88    1.29    1.11
> no overlay    0.05    61.26    0.05    1.10
>

Update this morning.  Also ran filestore tests for comparison.  Next 
we'll look at how tweaking the overlay for different IO sizes affects 
things.  IE the overlay threshold is 64k right now and it appears that 
128K write IOs for instance are quite a bit worse with newstore 
currently than with filestore.  Sage also just committed changes that 
will allow overlay writes during append/create which may help improve 
small IO write performance as well in some cases.

4MB		write	read	randw	randr
default overlay	36.13	106.61	34.49	92.69
no overlay	36.29	105.61	34.49	93.55
filestore	36.17	84.59	34.11	79.85
				
128KB		write	read	randw	randr
default overlay	1.71	97.90	1.65	25.79
no overlay	1.72	97.80	1.66	25.78
filestore	27.15	79.91	8.77	19.00
				
4KB		write	read	randw	randr
default overlay	0.40	61.88	1.29	1.11
no overlay	0.05	61.26	0.05	1.10
filestore	4.14	56.30	0.42	0.76

Seekwatcher movies and graphs available here:

http://nhm.ceph.com/newstore/20150408/

Note for instance the very interesting blktrace patterns for 4K random 
writes on the OSD in each case:

http://nhm.ceph.com/newstore/20150408/filestore/RBD_00004096_randwrite.png
http://nhm.ceph.com/newstore/20150408/default_overlay/RBD_00004096_randwrite.png
http://nhm.ceph.com/newstore/20150408/no_overlay/RBD_00004096_randwrite.png

Mark
