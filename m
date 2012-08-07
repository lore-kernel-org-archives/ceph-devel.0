From: Wido den Hollander <wido@widodh.nl>
Subject: Re: EU Ceph.com mirror for Debian/Ubuntu packages
Date: Tue, 07 Aug 2012 16:06:14 +0200
Message-ID: <502120D6.6010000@widodh.nl>
References: <500FAA87.3000501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:59970 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2HGOGJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 10:06:09 -0400
Received: from [IPv6:2a00:f10:113:0:18ea:9873:e92f:a6f7] (unknown [IPv6:2a00:f10:113:0:18ea:9873:e92f:a6f7])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id D1EEA76165
	for <ceph-devel@vger.kernel.org>; Tue,  7 Aug 2012 16:06:07 +0200 (CEST)
In-Reply-To: <500FAA87.3000501@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 07/25/2012 10:12 AM, Wido den Hollander wrote:
> Hi,
>
> On a couple of systems I'm using the Debian packages provided on
> Ceph.com, but these packages are hosted on a CA based server.
>
> In the EU that's rather slow, especially when updating multiple servers
> and when downloading the debug packages.
>
> As I'm lazy I don't want to maintain my own mirror with my own build
> packages, I rather use the ones build by Ceph.com
>
> Could we set up a EU mirror like eu.ceph.com or nl.ceph.com?
>
> deb http://eu.ceph.com/debian/ precise main
>
> That could update from the main mirror with rsync every hour.
>
> I could offer some space if needed?

Did anybody get a chance to take a look at this?

Wido

>
> Thanks,
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

