From: Tom Lanyon <tom@netspot.com.au>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance impact
Date: Mon, 14 Jan 2013 23:58:21 +1030
Message-ID: <B1D1B77B-F5D7-4048-9C07-CDC9EEB3F224@netspot.com.au>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.adl-na.netspot.com.au ([203.30.161.27]:35067 "EHLO
	mail.adl-na.netspot.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756378Ab3ANN6H convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jan 2013 08:58:07 -0500
In-Reply-To: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On 14/01/2013, at 10:47 PM, Florian Haas <florian@hastexo.com> wrote:
<snip>
> http://www.hastexo.com/resources/hints-and-kinks/solid-state-drives-and-ceph-osd-journals
> 
> It's probably easiest to comment directly on that page, but if you
> prefer instead to just respond in this thread, that's perfectly fine
> too.
<snip>


Hi Florian,

Thanks for putting this together.

A couple of minor questions/comments:

* One of the conclusions is to use the SSDs (assuming 2) un-RAIDed, but the article doesn't actually explain why using them in a RAID-1 is a poor idea.

* Should the end of this sentence:
	"Another option is to use, say, one partition on each of your SSD in a RAID for the operating system installation, and then chop up the rest of your SSDs an non-RAIDed Ceph OSDs."

...instead read:

	"Another option is to use, say, one partition on each of your SSD in a RAID for the operating system installation, and then chop up the rest of your SSDs an non-RAIDed Ceph **OSD journals**." ?

Regards,
Tom

