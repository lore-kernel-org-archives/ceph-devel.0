From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: leveldb build issues in 0.44
Date: Mon, 26 Mar 2012 10:38:49 -0600
Message-ID: <4F70473902000099000DD948@collaborate.seakr.com>
References: <4F6EDA3402000099000DD8C6@collaborate.seakr.com>
 <Pine.LNX.4.64.1203250840090.23214@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:46946 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932738Ab2CZQiy convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Mon, 26 Mar 2012 12:38:54 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q2QHZNeN010786
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 11:35:25 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 8024944C60
	for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 10:38:50 -0600 (MDT)
In-Reply-To: <Pine.LNX.4.64.1203250840090.23214@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: oliva@lsd.ic.unicamp.br, ceph-devel@vger.kernel.org

Well, I'm getting there...I'm building 0.44, so I had to back-port this patch into that tree, then I figured out that I had to run automake after applying that patch (actually, the autogen.sh script works fine).  I believe the build is now working fine, I'm just fighting some last RPM packaging issues.

-Nick

>>> On 2012/03/25 at 09:40, Sage Weil <sage@newdream.net> wrote: 
> On Sun, 25 Mar 2012, Nick Couchman wrote:
>> Well, leveldb is fine, but I'm still seeing a build error:
>> 
>>   CXX    libcommon_la-version.lo
>> In file included from ./rgw/rgw_common.h:18:0,
>>                  from ./rgw/rgw_access.h:11,
>>                  from test/encoding/types.h:87,
>>                  from test/encoding/ceph_dencoder.cc:13:
>> ./common/ceph_crypto.h:44:22: fatal error: pk11pub.h: No such file or 
> directory
>> compilation terminated.
>> 
>> I believe I'm using the NSS library for crypto support, and I can see 
>> the pk11pub.h file in my include directory, so I know it's present.
> 
> I just pushed a patch for this from Jim, 
> d3bcac241f25f681a585c2115a79befe43dd7d6c.  Can you verify things build 
> cleanly now?
> 
> Thanks!
> sage
> 
> 
> 
>>
>> -Nick
>> 
>> >>> Sage Weil  03/23/12 6:28 PM >>>
>> Hey Nick-
>> 
>> Can you confirm this fixes your problem?  If so I can apply this to the 
>> stable branch (for 0.44.1).
>> 
>> Thanks!
>> sage
>> 
>> 
>> On Thu, 22 Mar 2012, Alexandre Oliva wrote:
>> 
>> > On Mar 22, 2012, "Nick Couchman"  wrote:
>> > 
>> > > ./db/builder.h:8:28: fatal error: leveldb/status.h: No such file or 
> directory
>> > > compilation terminated.
>> > 
>> > > This is an RPM build
>> > 
>> > This patch fixed it for me.
>> > 
>> > 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
>> 
>> --------
>> This e-mail may contain confidential and privileged material for the sole use 
> of the intended recipient.  If this email is not intended for you, or you are 
> not responsible for the delivery of this message to the intended recipient, 
> please note that this message may contain SEAKR Engineering (SEAKR) 
> Privileged/Proprietary Information.  In such a case, you are strictly 
> prohibited from downloading, photocopying, distributing or otherwise using 
> this message, its contents or attachments in any way.  If you have received 
> this message in error, please notify us immediately by replying to this e-mail 
> and delete the message from your mailbox.  Information contained in this 
> message that does not relate to the business of SEAKR is neither endorsed by 
> nor attributable to SEAKR.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
