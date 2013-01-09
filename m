From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Are there significant performance enhancements in 0.56.x to be
 expected soon or planned in the near future?
Date: Wed, 09 Jan 2013 14:11:59 +0100
Message-ID: <50ED6C9F.5030107@widodh.nl>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:53088 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757766Ab3AINMC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 08:12:02 -0500
In-Reply-To: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/09/2013 01:51 PM, Lachfeld, Jutta wrote:
> Hi all,
>
> in expectation of better performance, we are just switching from CEPH version 0.48 to 0.56.1
> for comparisons between Hadoop with HDFS and Hadoop with CEPH FS.
>
> We are now wondering whether there are currently any development activities
> concerning further significant performance enhancements,
> or whether further significant performance enhancements are already planned for the near future.
>

Yes, 0.56(.1) has a significant performance increase compared to 0.48

Two blogposts which might be interesting to read:
* http://ceph.com/dev-notes/whats-new-in-the-land-of-osd/
* http://ceph.com/uncategorized/argonaut-vs-bobtail-performance-preview/

I'm not running with HDFS, but I see a good performance increase with 
Virtual Machines running on RBD.

Wido

> I would now be loath to start benchmarking with 0.56.1 and then, a month or so later, detect that there have been significant performance enhancements in CEPH in the meantime.
>
> Regards,
> Jutta.
>
> -
> jutta.lachfeld@ts.fujitsu.com, Fujitsu Technology Solutions PBG PDG ES&S SWE SOL 4, "Infrastructure Solutions", MchD 5B, Tel. ..49-89-3222-2705, Company Details: http://de.ts.fujitsu.com/imprint
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

