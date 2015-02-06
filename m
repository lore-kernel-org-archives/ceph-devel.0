From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: new dev cluster - using giant or hammer git?
Date: Fri, 6 Feb 2015 16:52:44 +0100
Message-ID: <7A196558-87C3-44B8-8019-5596112CCD81@profihost.ag>
References: <54D4C7F2.1090505@profihost.ag> <alpine.DEB.2.00.1502060606281.27042@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:48680 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbBFPwq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 10:52:46 -0500
In-Reply-To: <alpine.DEB.2.00.1502060606281.27042@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> Am 06.02.2015 um 15:06 schrieb Sage Weil <sage@newdream.net>:
> 
>> On Fri, 6 Feb 2015, Stefan Priebe - Profihost AG wrote:
>> Hi,
>> 
>> for deploying a new ceph dev cluster can anybody recommand which git
>> branch to use? hammer or giant-backport?
> 
> Hi Stefan!
> 
> If it's dev I'd recommend hammer.  If all of your clients will be new I'd 
> also recommand 'ceph osd crush tunables hammer' as there is a new and 
> improve crush bucket type.  

Hi sage,

thanks that's good for a test cluster too?

What would you recommand for something which can Crash but i don't want to loose data?

Stefan


> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
