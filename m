From: Wido den Hollander <wido@42on.com>
Subject: Re: any reason why multiple ranged-reads not currently supported
 in rados-java?
Date: Sat, 16 Aug 2014 20:12:42 +0200
Message-ID: <53EF9F1A.5090201@42on.com>
References: <CAAmmvixquAW-s5td03UpnEhFDWujAWServHgehKzrYHRs+dsBg@mail.gmail.com> <alpine.DEB.2.00.1408150839460.966@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47625 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbaHPSMp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Aug 2014 14:12:45 -0400
In-Reply-To: <alpine.DEB.2.00.1408150839460.966@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Daniel Hsueh <dchsueh@alumni.uwaterloo.ca>
Cc: ceph-devel@vger.kernel.org, wido@widodh.nl

On 08/15/2014 05:40 PM, Sage Weil wrote:
> On Fri, 15 Aug 2014, Daniel Hsueh wrote:
>> Hello,
>>
>> I'm looking at the Java librados JNA-based API, and note that ranged
>> reads (rados_create_read_op, rados_release_read_op,
>> rados_read_op_read, rados_read_op_operate) are not currently
>> accessible to a Java program.
>>
>> Are there any difficulties in implementing access to these calls?  If
>> it is straightforward, I'll implement them myself and contribute back
>> to the github repository.
>
> My guess is this was just an oversight.  A patch / pull request wiring
> this up would be awesome.
>

Indeed. I was a bit lazy and implemented what I needed at the time of 
writing rados-java.

A pull request is welcome, or just create a issue in the tracker on 
http://tracker.ceph.com/

Thanks!

> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
