From: Michael Metz-Martini | SpeedPartner GmbH <metz@speedpartner.de>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Wed, 13 Apr 2016 14:51:58 +0200
Message-ID: <570E40EE.40202@speedpartner.de>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
 <570C9D03.6020701@speedpartner.de>
 <20160413112930.49906f15@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.speedpartner.de ([91.184.32.3]:57406 "EHLO
	mail.speedpartner.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098AbcDMMwE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 08:52:04 -0400
In-Reply-To: <20160413112930.49906f15@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Balzer <chibi@gol.com>, ceph-users@ceph.com
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

Hi,

Am 13.04.2016 um 04:29 schrieb Christian Balzer:
> On Tue, 12 Apr 2016 09:00:19 +0200 Michael Metz-Martini | SpeedPartner
> GmbH wrote:
>> Am 11.04.2016 um 23:39 schrieb Sage Weil:
>>> ext4 has never been recommended, but we did test it.  After Jewel is
>>> out, we would like explicitly recommend *against* ext4 and stop
>>> testing it.
>> Hmmm. We're currently migrating away from xfs as we had some strange
>> performance-issues which were resolved / got better by switching to
>> ext4. We think this is related to our high number of objects (4358
>> Mobjects according to ceph -s).
> It would be interesting to see on how this maps out to the OSDs/PGs.
> I'd guess loads and loads of subdirectories per PG, which is probably where
> Ext4 performs better than XFS.
A simple ls -l takes "ages" on XFS while ext4 lists a directory
immediately. According to our findings regarding XFS this seems to be
"normal" behavior.

pool name       category                 KB      objects
data            -                       3240   2265521646
document_root   -                     577364        10150
images          -                96197462245   2256616709
metadata        -                    1150105     35903724
queue           -                  542967346       173865
raw             -                36875247450     13095410

total of 4736 pgs, 6 pools, 124 TB data, 4359 Mobjects

What would you like to see?
tree? du per Directory?

As you can see we have one data-object in pool "data" per file saved
somewhere else. I'm not sure what's this related to, but maybe this is a
must by cephfs.

-- 
Kind regards
 Michael Metz-Martini
