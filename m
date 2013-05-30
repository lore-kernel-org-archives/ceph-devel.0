From: Wido den Hollander <wido@42on.com>
Subject: Re: 5GB object limit in the RADOS Gateway
Date: Thu, 30 May 2013 19:50:49 +0200
Message-ID: <51A79179.9080501@42on.com>
References: <51A78F84.1000607@42on.com> <CAPYLRzgFTgv3pPUdLny3MdiZCpFPCfSY-aj5+3sf16jBtL7T-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:57170 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966082Ab3E3Ruv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 May 2013 13:50:51 -0400
In-Reply-To: <CAPYLRzgFTgv3pPUdLny3MdiZCpFPCfSY-aj5+3sf16jBtL7T-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/30/2013 07:47 PM, Gregory Farnum wrote:
> On Thu, May 30, 2013 at 10:42 AM, Wido den Hollander <wido@42on.com> wrote:
>> Hi,
>>
>> I was checking the source code today and found this macro:
>>
>> #define RGW_MAX_PUT_SIZE        (5ULL*1024*1024*1024)
>>
>> Why is that limit in place? Was that to mimic Amazon S3? (Which is at 5T
>> now).
>>
>> I know that object size limit something that should be there, but just
>> trying to find the reasoning behind this limit.
>>
>> Couldn't we make this  configurable at least?
>
> That's the limit on an individual HTTP PUT operation. You can make
> larger objects, but they need to be placed with multi-part uploads.
> (I'm not sure what the actual limit is, if there is one.)
> -Greg

Heh? My client gave me an error today and I thought that was really 
doing multipart uploads.

Checking again I see that s3cmd doesn't do multipart. That confused me

So it doesn't seem there is an object size limitation after all, so you 
can store object as large as you like.

> Software Engineer #42 @ http://inktank.com | http://ceph.com
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
