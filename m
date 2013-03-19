From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Tue, 19 Mar 2013 09:56:59 +0800
Message-ID: <CANExM-PxkgVBLyi23q1uCH74yhp70FU=ojE4VFzEDgizhDgKVw@mail.gmail.com>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com>
	<alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net>
	<F9E1A4A5-FE26-460B-A228-99033A36ECF8@intel.com>
	<alpine.DEB.2.00.1303150931160.23110@cobra.newdream.net>
	<B0E6BFC2-292E-4EB5-BE19-FD0F670EBDE3@enovance.com>
	<869D592D-E098-4EB9-8F25-FC8FBF715E03@intel.com>
	<CANExM-Oj1ctk5i0HL-7VXd8K3oP5oUTuUWMq-2F5u4i+cHz7Ww@mail.gmail.com>
	<555712E2BBAC4147BF96AE32C88A1C83@inktank.com>
	<alpine.DEB.2.00.1303181421240.28537@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:45921 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab3CSB5A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 21:57:00 -0400
Received: by mail-ve0-f172.google.com with SMTP id cz11so4962309veb.17
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 18:56:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303181421240.28537@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Greg Farnum <greg@inktank.com>, "Huang, Xiwei" <xiwei.huang@intel.com>, Sebastien Han <sebastien.han@enovance.com>, ceph-devel <ceph-devel@vger.kernel.org>

I just sent out the patch with sign-off. Thanks for testing.

2013/3/19 Sage Weil <sage@inktank.com>:
> On Mon, 18 Mar 2013, Greg Farnum wrote:
>> On Saturday, March 16, 2013 at 5:38 AM, Henry C Chang wrote:
>> > The following patch should fix the problem.
>> >
>> > -Henry
>> >
>> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> > index e51558f..4bcbcb6 100644
>> > --- a/fs/ceph/file.c
>> > +++ b/fs/ceph/file.c
>> > @@ -608,7 +608,7 @@ out:
>> > pos += len;
>> > written += len;
>> > left -= len;
>> > - data += written;
>> > + data += len;
>> > if (left)
>> > goto more;
>>
>> This looks good to me. If you'd like to submit it as a proper patch with a sign-off I'll pull it into our tree. :)
>> -Greg
>
> I just added a quick test and it fixes it up.  :)
>
> sage
