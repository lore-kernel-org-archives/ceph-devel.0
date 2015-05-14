From: Samuel Just <sjust@redhat.com>
Subject: Re: which osds get used for ec pool reads?
Date: Thu, 14 May 2015 12:52:28 -0400 (EDT)
Message-ID: <1146045701.21089476.1431622348438.JavaMail.zimbra@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166448682@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:36145 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933006AbbENQwb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 12:52:31 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166448682@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Deneau <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

There is a branch which may merge soonish which will optionally read from all shards and use the first N.  It's not merged yet.  If the pgs are healthy, the current behavior is to read from the data shards (since you don't need to perform a decode in that case).
-Sam

----- Original Message -----
From: "Tom Deneau" <tom.deneau@amd.com>
To: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Thursday, May 14, 2015 9:27:14 AM
Subject: which osds get used for ec pool reads?

I am looking at disk activity on reads from an erasure coded pool (k=2, m=1).
I have a contrived setup where I am reading a bunch of names that are
all in the same PG.  I see disk activity only from the 2 K osds, not the M osd.

As I understand http://ceph.com/docs/master/architecture/,  in this situation
all 3 osds would be read and the first two to return would be used but that is not what I see.

In this particular contrived setup, all of the OSDs are on a single node,
would that be causing the 2-OSD read behavior that I am seeing?

-- Tom Deneau


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


