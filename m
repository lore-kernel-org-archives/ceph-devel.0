From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Sun, 21 Oct 2012 23:05:24 -0700
Message-ID: <5084E224.2030807@inktank.com>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36328 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab2JVGF2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 02:05:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1681352pad.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Oct 2012 23:05:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Joe Buck <jbbuck@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/21/2012 02:35 PM, Sage Weil wrote:
> On Sun, 21 Oct 2012, Joe Buck wrote:
>> It looks like vstart.sh does not work without authx enabled. Given that, I'd
>> propose to change the default to having cephx be enabled and then use the -x
>> flag to disable cephx.
>>
>> Interestingly enough, the help output for vstart.sh already states that the -x
>> flag disables authx (which is not the case at present, but is after this patch
>> is applied).
>>
>> I've attached a patch to vstart that 1) changes the mention of authx to cephx
>> for consistency and 2) defaults vstart.sh to using cephx with the -x flag now
>> serving to disable cephx.
> Sounds like a good change, but let's make -x do nothing and -X disable
> cephx, so that existing habitual typing of -x doesn't lead to failure.
>
> Also, we should fix the auth none usage at some point.  :)
>

Surely it's not hard to fix the non-cephx case?  I though slang had done 
that, actually.

