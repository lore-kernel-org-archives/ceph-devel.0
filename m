From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: full osdmaps in mon txns
Date: Tue, 6 Jan 2015 09:49:20 +0100
Message-ID: <CABZ+qqmejKW9ONDnUui6jd7EMXaqXaY=EhMQLY3nSoMuNmPydg@mail.gmail.com>
References: <alpine.DEB.2.00.1412231306170.28630@cobra.newdream.net> <CABZ+qqk9dW2eHnECci31xe6W0LvVUhZyiZc9ainCEqAEOtPd3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:20364 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbbAFIuE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Jan 2015 03:50:04 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so18988193lbv.14
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 00:50:00 -0800
 (PST)
In-Reply-To: <CABZ+qqk9dW2eHnECci31xe6W0LvVUhZyiZc9ainCEqAEOtPd3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: joao@redhat.com, gfarnum@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, Jan 5, 2015 at 10:12 AM, Dan van der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi Sage,
>
> On Tue, Dec 23, 2014 at 10:10 PM, Sage Weil <sweil@redhat.com> wrote:
>>
>> This fun issue came up again in the form of 10422:
>>
>>         http://tracker.ceph.com/issues/10422
>>
>> I think we have 3 main options:
>>
>> 1. Ask users to do a mon scrub prior to upgrade to
>> ensure it is safe.  If a mon is out of sync, manually kick it out, blow it
>> away, and resync.
>>
>
> I just tried ceph scrub on a cluster we already upgraded from dumpling
> to firefly:
>
> 2015-01-05 09:44:32.811194 mon.0 137.138.13.136:6789/0 622509 : [ERR]
> scrub mismatch
> 2015-01-05 09:44:32.811289 mon.0 137.138.13.136:6789/0 622510 : [ERR]
> mon.0 ScrubResult(keys
> {auth=90,logm=1163,mdsmap=3,monmap=5,osdmap=1541,pgmap=645,pgmap_meta=6,pgmap_osd=208,pgmap_pg=24704}
> crc {auth=2819756818,logm=2322364559,mdsmap=183360962,monmap=2103930516,osdmap=522825856,pgmap=2035077624,pgmap_meta=951037946,pgmap_osd=3980602023,pgmap_pg=502660406})
> 2015-01-05 09:44:32.811414 mon.0 137.138.13.136:6789/0 622511 : [ERR]
> mon.2 ScrubResult(keys
> {auth=90,logm=1163,mdsmap=3,monmap=5,osdmap=1541,pgmap=645,pgmap_meta=6,pgmap_osd=208,pgmap_pg=24704}
> crc {auth=2819756818,logm=2322364559,mdsmap=183360962,monmap=2103930516,osdmap=3364575095,pgmap=2035077624,pgmap_meta=951037946,pgmap_osd=3980602023,pgmap_pg=502660406})
>
> Is this the same issue as #10422? What would you do to recover?


For posterity, here is how I fixed this:

# service ceph stop
=== mon.2 ===
Stopping Ceph mon.2 on p05153026953834...kill 30708...done
# mv /var/lib/ceph/mon/mon.2/ /tmp/mon.2.old
# mkdir  /var/lib/ceph/mon/mon.2
# ceph-mon --mkfs -i 2 --keyring /var/lib/ceph/tmp/keyring.mon.2
ceph-mon: set fsid to dd535a7e-4647-4bee-853d-f34112615f81
ceph-mon: created monfs at /var/lib/ceph/mon/mon.2 for mon.2
#

Then service ceph start, let mon.2 resync, and running ceph scrub
afterwards gives:

2015-01-06 09:43:06.431919 mon.0 137.138.13.136:6789/0 63 : [INF]
scrub ok on 0,1,2: ScrubResult(keys
{auth=69,logm=1455,mdsmap=3,monmap=5,osdmap=1005,pgmap=695,pgmap_meta=6,pgmap_osd=208,pgmap_pg=24704}
crc {auth=2072984173,logm=1432725577,mdsmap=183360962,monmap=2103930516,osdmap=731548464,pgmap=2718145611,pgmap_meta=990631329,pgmap_osd=31335898,pgmap_pg=4049607692})


Cheers, Dan
