From: David Galloway <dgallowa@redhat.com>
Subject: Re: tracker.ceph.com
Date: Mon, 19 Dec 2016 14:57:08 -0500
Message-ID: <c6a0103f-5f03-b3f6-7a87-80e73e9d49ef@redhat.com>
References: <8421d2fe-067f-97c0-4a79-083c37baee35@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756369AbcLST5K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Dec 2016 14:57:10 -0500
In-Reply-To: <8421d2fe-067f-97c0-4a79-083c37baee35@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com


On 12/17/2016 05:25 PM, Dan Mick wrote:
> tracker.ceph.com is having issues. I'm looking at it.
>
> --

The Tracker VM's disk was corrupted during an Openstack live migration.

A new VM was created and the Tracker data has been restored from a 
backup dated 12-17-2016 07:30 UTC.  Any changes made to bugs after that 
time are gone.

The Agile plugin has been restored and file attachments have been 
rsynced to the new VM.

Please let me know if you notice anything is amiss.
