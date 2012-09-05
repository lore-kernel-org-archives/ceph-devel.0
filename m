From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Wed, 05 Sep 2012 19:05:47 +0200
Message-ID: <5047866B.80102@widodh.nl>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl> <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com> <50476FAE.8030107@widodh.nl> <CADvuQRGsRQ2AYM7ceaQiR-F+7J1P1TR-_AXfPLWHznYetkhoog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:41437 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2IERGA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 13:06:00 -0400
In-Reply-To: <CADvuQRGsRQ2AYM7ceaQiR-F+7J1P1TR-_AXfPLWHznYetkhoog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Calvin Morrow <calvin.morrow@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 09/05/2012 06:14 PM, Tommi Virtanen wrote:
> On Wed, Sep 5, 2012 at 8:28 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> You can only specify one monitor in CloudStack, but your cluster can have
>> multiple.
>>
>> This is due to the internals of CloudStack. It stores storage pools in a URI
>> format, like: rbd://admin:secret@1.2.3.4/rbd
>
> You know, for a custom scheme like "rbd:", any generic URI parser has
> no business dictating what's allowed and what's not. Just don't use
> "//" and you're not forced to follow those rules.
>
> For example, rbd:?id=admin&secret=s3kr1t&mon=1.2.3.4&mon=5.6.7.8&pool=rbd
> is perfectly legal.
>
> Whether some Java library fails to implement generic URIs is another concern..
>

It is indeed a Java library in this case: 
http://docs.oracle.com/javase/6/docs/api/java/net/URI.html

But Sage's suggestion about using Round-Robin DNS seems great as well. 
Didn't know that was supported.

Wido

> http://tools.ietf.org/html/rfc3986#section-3
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
