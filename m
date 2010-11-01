From: Sage Weil <sage@newdream.net>
Subject: Re: osd sequence number mismatches and timeout's
Date: Mon, 1 Nov 2010 15:57:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1011011549520.26372@cobra.newdream.net>
References: <E1PD2eA-0005Tn-G4@tytso-glaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43289 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab0KAWy3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Nov 2010 18:54:29 -0400
In-Reply-To: <E1PD2eA-0005Tn-G4@tytso-glaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: ceph-devel@vger.kernel.org

Hi Ted,

On Mon, 1 Nov 2010, Theodore Ts'o wrote:
> I've just updated to v0.22.2 and am now using a 2.6.36 client (with
> d91f2438d reverted, since this is known as a bad commit).  I have
> recorded the following performance numbers using a single client:
> 
>                         1           8           32
> large file creates   108 MB/sec   110 MB/sec   109 MB/sec
> sequential reads     35.3 MB/sec  129 MB/sec   125 MB/sec
> random reads         1.39 MB/sec  5.93 MB/sec  11.5 MB/sec
> random writes        484 MB/sec   483 MB/sec   663 MB/sec

The random writes still look a little high for a gig connection :).  Is 
the benchmark not running long enough to hit any memory pressure?  Or is 
it overwriting the same file regions?

> These numbers are more reasonable, compared to what we had before.  I
> haven't changed the FFSB profiles, even though people have noted that 4k
> random reads might not be entirely fair.  Point noted, and I'll probably
> try to change the FFSB profiles to get better/fairer numbers.  But I
> didn't want to make changes in what I was measuring until things were
> stable.  I also want to do multi-client runs to so we can determine what
> sort of aggregate I/O bandwidth numbers we can achieve.
> 
> But before we do that, I wanted to check one thing.  It looks like I'm
> still seeing these messages (see below).  Is there something I should do
> to try to eliminate them?  

Is there something in dmesg before the osd22 seq number errors pop up?  
Something originally caused the seq's to get out of sync.  I suspect it 
was a transient network error that made the TCP session drop and 
reconnect, and it's not skipping already-received messages.  There was a 
bug in the skip code (so they stayed out of sync and osd22 eventually 
timed out).  I pushed a fix for that to the ceph-client.git master branch 
(df9f86fa).

> There's been some commentary on the list
> about this possibly being caused by using multiple MDS's?   Should I try
> switching to a single MDS?

I don't think multiple MDS's would affect this, but since that isn't as 
stable, I would switch to a single MDS for the time being to eliminate 
that possibility.

Thanks!
sage


> 
> 						- Ted
> 
> [233480.882885] ceph: skipping osd22 10.138.138.13:6804 seq 2016, expected 2017
> [233480.882919] ceph: skipping osd22 10.138.138.13:6804 seq 2017, expected 2018
> [233480.882963] ceph: skipping osd22 10.138.138.13:6804 seq 2018, expected 2019
> [233480.883488] ceph: skipping osd22 10.138.138.13:6804 seq 2019, expected 2020
> [233485.034717] ceph:  tid 6542714 timed out on osd49, will reset osd
> [233485.219558] ceph: skipping osd22 10.138.138.13:6804 seq 2020, expected 2021
> [233485.906595] ceph: skipping osd22 10.138.138.13:6804 seq 2021, expected 2022
> [233490.233139] ceph:  tid 6772034 timed out on osd16, will reset osd
> [233490.379536] ceph: skipping osd22 10.138.138.13:6804 seq 2022, expected 2023
> [233495.399475] ceph:  tid 6549630 timed out on osd43, will reset osd
> [233495.523260] ceph: skipping osd22 10.138.138.13:6804 seq 2023, expected 2024
> [233495.923194] ceph: skipping osd22 10.138.138.13:6804 seq 2024, expected 2025
> [233500.534614] ceph:  tid 6023602 timed out on osd22, will reset osd
> [233597.102570] ceph:  tid 7099738 timed out on osd15, will reset osd
> [233597.575729] ceph:  tid 7100026 timed out on osd39, will reset osd
> [233598.071068] ceph:  tid 7101189 timed out on osd21, will reset osd
> [233598.569831] ceph:  tid 7173652 timed out on osd14, will reset osd
> [233604.118653] ceph:  tid 7410069 timed out on osd43, will reset osd
> [233609.507340] ceph:  tid 7542773 timed out on osd12, will reset osd
> [233609.773541] ceph:  tid 7549315 timed out on osd8, will reset osd
> [233610.041809] ceph:  tid 7610505 timed out on osd47, will reset osd
> [233660.579973] ceph:  tid 7487446 timed out on osd15, will reset osd
> [233660.644269] ceph:  tid 7798841 timed out on osd39, will reset osd
> [233660.705660] ceph:  tid 7816920 timed out on osd21, will reset osd
> [233660.767192] ceph:  tid 7674137 timed out on osd14, will reset osd
> [235047.049619] ceph: mds0 caps went stale, renewing
> [235076.161656] ceph: mds0 caps renewed
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
