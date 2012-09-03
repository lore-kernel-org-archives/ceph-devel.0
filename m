From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Is there any way to throttle recovery?
Date: Mon, 03 Sep 2012 10:11:47 +0200
Message-ID: <50446643.2010705@widodh.nl>
References: <50445150.7080804@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:44490 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab2ICILw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Sep 2012 04:11:52 -0400
In-Reply-To: <50445150.7080804@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 09/03/2012 08:42 AM, Vladimir Bashkirtsev wrote:
> Hello devs,
>
> I have noticed that while ceph recovering from OSD failure RBD
> performance becomes dismal. Judging by load on the net ceph attempts to
> shuffle around huge amount of data leaving virtually no bandwidth for
> normal operations. Is there any way to throttle recovery process?
> Network throttling is out of question as it will slow everything down.
> So I guess ceph should have (or already has) a setting which says do not
> recover faster than X.
>

I don't know if there is a bandwidth throttle, but you could lower the 
number of recovery ops with:

osd recovery max active = 1

By default it is set to 5, by tuning this down you'll put less stress on 
the OSDs and it will probably also result in less network traffic.

Wido

> Regards,
> Vladimir
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
