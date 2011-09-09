From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: questions of pg scrub
Date: Fri, 9 Sep 2011 09:32:05 -0700
Message-ID: <CAF3hT9DX6RrpgQpBthjaND+PuPBf-zqwzW1Dk8F-pifR_PaKQw@mail.gmail.com>
References: <CABAwU-Zfvy_Un1YQirpiDhontLDPi4DRjJDBK=Z4KutA2dpOOw@mail.gmail.com>
	<CAF3hT9CxANXA4M79QsXKuipWDN_rOE4WKoq=t9U1Wd8-iVPbGg@mail.gmail.com>
	<6d1d94168ce096e5bff3f51c98c0b8b4@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54038 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab1IIQcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2011 12:32:07 -0400
Received: by pzk37 with SMTP id 37so2828574pzk.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Sep 2011 09:32:05 -0700 (PDT)
In-Reply-To: <6d1d94168ce096e5bff3f51c98c0b8b4@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

[resend to list]
On Fri, Sep 9, 2011 at 4:52 AM, Dyweni - Ceph-Devel
<YS3fpFE2ykfB@dyweni.com> wrote:
> On Thu, 8 Sep 2011 17:35:46 -0700, Gregory Farnum wrote:
>> Scrubbing is intended to do a few things. First, any large storage system
>> needs to periodically look at the data it's holding in order to make sure
>> the data stays safe -- that the underlying hardware is still working (and
>> the sectors are good), that cosmic rays haven't flipped bits, etc. Right
>> now, Ceph's scrubbing is primitive: it only looks at the file sizes and a
>> few other metadata attributes, and compares them to the ones it thinks
>> the file should have and to what other storage nodes have. Eventually, it
>> will be a great deal more involved than that, though!
>
> Will there be some kind of cryptographic checksum used to validate the data
> has not changed (i.e. Something like what GIT does internally)?
Eventually. I think our data structures already have the space for it,
even (somebody correct me if I'm wrong), but we need to build up other
parts of the system before that becomes a useful feature. :)
-Greg
