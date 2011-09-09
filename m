From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: questions of pg scrub
Date: Fri, 09 Sep 2011 06:52:28 -0500
Message-ID: <6d1d94168ce096e5bff3f51c98c0b8b4@pl1.haspere.com>
References: <CABAwU-Zfvy_Un1YQirpiDhontLDPi4DRjJDBK=Z4KutA2dpOOw@mail.gmail.com>
 <CAF3hT9CxANXA4M79QsXKuipWDN_rOE4WKoq=t9U1Wd8-iVPbGg@mail.gmail.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:35880 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933390Ab1IIL55 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Sep 2011 07:57:57 -0400
In-Reply-To: <CAF3hT9CxANXA4M79QsXKuipWDN_rOE4WKoq=t9U1Wd8-iVPbGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

 On Thu, 8 Sep 2011 17:35:46 -0700, Gregory Farnum wrote:

> [resend to list]
>
> 2011/9/7 huang jun :
>> hi,all Recently,i read the source code of PG scrub.The ceph
>> periodically shed_scrub if the system load is not too high. And
>> adminstrator can manually scrub the specified OSD or PG using cmds. 
>> but
>> many questions come along with me when i got thourgh . why did ceph
>> need scrub? what scrub used for?
> Scrubbing is intended to do a few things. First, any large storage 
> system
> needs to periodically look at the data it's holding in order to make 
> sure
> the data stays safe -- that the underlying hardware is still working 
> (and
> the sectors are good), that cosmic rays haven't flipped bits, etc. 
> Right
> now, Ceph's scrubbing is primitive: it only looks at the file sizes 
> and a
> few other metadata attributes, and compares them to the ones it 
> thinks
> the file should have and to what other storage nodes have. 
> Eventually, it
> will be a great deal more involved than that, though!

 Will there be some kind of cryptographic checksum used to validate the 
 data has not changed (i.e. Something like what GIT does internally)?

 Dyweni


