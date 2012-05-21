From: Wido den Hollander <wido@widodh.nl>
Subject: Re: availability of the 0.47 release tarballs at http://ceph.com/download/
Date: Mon, 21 May 2012 18:24:39 +0200
Message-ID: <4FBA6C47.3010704@widodh.nl>
References: <FA9234AF-2E18-4CD1-A2C3-300F4B813DAB@tchpc.tcd.ie> <Pine.LNX.4.64.1205210915170.5496@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:55340 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2EUQYn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 12:24:43 -0400
In-Reply-To: <Pine.LNX.4.64.1205210915170.5496@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Jimmy Tang <jtang@tchpc.tcd.ie>, ceph-devel@vger.kernel.org

Hi,

On 05/21/2012 06:15 PM, Sage Weil wrote:
> On Mon, 21 May 2012, Jimmy Tang wrote:
>> Hi All
>>
>> Could I ask if the url http://ceph.com/download/ will continue to have
>> release tarballs or will the download location change? I ask this as I
>> am interested in updating my own personal fork of the archlinux package
>> for ceph.
>
> It will.  I forgot to push the tarballs (and debs) last night, but just
> pushed them this morning.

Talking about the tarballs: Wouldn't it be useful for such automated 
scripts to be able to pull "ceph-latest.tar.gz|bz2" ?

That way you can always have your scripts pointing to the latest version 
of Ceph.

Wido

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
