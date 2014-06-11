From: Guang Yang <yguang11@outlook.com>
Subject: Re: Changes of scrubbing?
Date: Wed, 11 Jun 2014 15:54:08 +0800
Message-ID: <BLU436-SMTP200935F4900B0A29C32286DDF2B0@phx.gbl>
References: <BLU436-SMTP155ED6E6FBB4FD0E72FC5CDF3C0@phx.gbl> <CAPYLRziTJKy4DQTASRwDZa2P5cy9qc4Zj7VM2P2QbrntFpKudg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s3.hotmail.com ([65.55.111.142]:49521 "EHLO
	BLU004-OMC4S3.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbaFKHyQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jun 2014 03:54:16 -0400
In-Reply-To: <CAPYLRziTJKy4DQTASRwDZa2P5cy9qc4Zj7VM2P2QbrntFpKudg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On Jun 11, 2014, at 6:33 AM, Gregory Farnum <greg@inktank.com> wrote:

> On Tue, May 20, 2014 at 6:44 PM, Guang Yang <yguang11@outlook.com> wrote:
>> Hi ceph-devel,
>> Like some users of Ceph, we are using Ceph for a latency sensitive project, and scrubbing (especially deep-scrubbing) impacts the SLA in a non-trivial way, as commodity hardware could fail in one way or the other, I think it is essential to have scrubbing enabled to preserve data durability.
>> 
>> Inspired by how erasure coding backend implement scrubbing[1], I am wondering if the following changes is valid to somehow reduce the performance impact from scrubbing:
>> 1. Store the CRC checksum along with each physical copy of the object on filesystem (via xattr or omap?)
>> 2. For read request, it checks the CRC locally and if it mismatch, redirect the request to a replica and mark the PG as inconsistent.
> 
> The problem with this is that you need to maintain the CRC across
> partial overwrites of the object. And the real cost of scrubbing isn't
> in the network traffic, it's in the disk reads, which you would have
> to do anyway with this method. :)
Thanks Greg for the response!
Partial update is the right concern if that happens frequently. However, the major benefit of this proposal is to postpone the CRC check to READ request instead of doing it from within a background job (although we may still need to do background check as deep-scrubbing, we can reduce the frequency dramatically). By checking the CRC at read time, in-consistent object are marked as inconsistent (PG) and further we can trigger a repair for the PG.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
>> 
>> This is just a general idea and details (like append) will need to further discussed.
>> 
>> By having such, we can schedule the scrubbing less aggresively but still preserve the durability for read.
>> 
>> Does this make some sense?
>> 
>> [1] http://ceph.com/docs/master/dev/osd_internals/erasure_coding/pgbackend/
>> 
>> Thanks,
>> Guang Yang--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

