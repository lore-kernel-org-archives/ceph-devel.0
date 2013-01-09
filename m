From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Are there significant performance enhancements in 0.56.x to be
 expected soon or planned in the near future?
Date: Wed, 09 Jan 2013 06:20:25 -0800
Message-ID: <50ED7CA9.1060407@inktank.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:65352 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757599Ab3AIOU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 09:20:26 -0500
Received: by mail-pb0-f48.google.com with SMTP id rq13so988529pbb.7
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 06:20:26 -0800 (PST)
In-Reply-To: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Performance work is always ongoing, but I am not aware of any
significant imminent enhancements.  We are just wrapping up an
investigation of the effects of various file system and I/O
options on different types of traffic, and the next major area
of focus will be RADOS Block Device and VMs over RBD.  This is
pretty far away from Hadoop and probably won't yield much fruit
until March.

There are a few people working on Hadoop integration, and I
have not been closely following their activities, but I do
not believe that any major performance work will be forthcoming
in the next few weeks

On 01/09/2013 04:51 AM, Lachfeld, Jutta wrote:
> Hi all,
>
> in expectation of better performance, we are just switching from CEPH version 0.48 to 0.56.1
> for comparisons between Hadoop with HDFS and Hadoop with CEPH FS.
>
> We are now wondering whether there are currently any development activities
> concerning further significant performance enhancements,
> or whether further significant performance enhancements are already planned for the near future.
>
> I would now be loath to start benchmarking with 0.56.1 and then, a month or so later, detect that there have been significant performance enhancements in CEPH in the meantime.
