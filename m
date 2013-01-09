From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: Are there significant performance enhancements in 0.56.x to be
 expected soon or planned in the near future?
Date: Wed, 09 Jan 2013 14:37:20 +0100
Message-ID: <50ED7290.9010409@conversis.de>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:44060 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729Ab3AINhX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 08:37:23 -0500
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
> I would now be loath to start benchmarking with 0.56.1 and then, a month or so later, detect that there have been significant performance enhancements in CEPH in the meantime.

There shouldn't be any major changes since v0.56.x is a stable release and
as such should only receive bug-/securityfixes and non-risky improvements.
Any changes that would result in a significant change in performance would
probably be too disruptive for a stable release series.

Regards,
  Dennis
