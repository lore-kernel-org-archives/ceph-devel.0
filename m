From: Wido den Hollander <wido@widodh.nl>
Subject: Re: questions about radosgw
Date: Thu, 05 Jan 2012 15:06:27 +0100
Message-ID: <4F05AE63.8080302@widodh.nl>
References: <CABAwU-ZVOzWBH1ethSuCFmNODC9bN3QPO7DMj3Y8EwP5tM3xjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48555 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab2AEOG3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 09:06:29 -0500
In-Reply-To: <CABAwU-ZVOzWBH1ethSuCFmNODC9bN3QPO7DMj3Y8EwP5tM3xjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/05/2012 12:48 PM, huang jun wrote:
> hi,all
> I'am using the s3+radosgw, there are some questions confused me very much:
> first) An object's size is 400MB, then the  whole object will stored
> in OSDs as one big single object, but not striped into 4MB objects. so
> how can we got workload banlance if we want to store big objects and
> small ones?

That is correct, RADOS nor the RADOS gateway stripes objects.

You will get workload balance if you have a (almost) even spread of 
workload over your different objects.

The dev's might shed some more light on this.

> second) Can we change the number of pgs in a pool that created by S3
> clients or just using rados commands?

As far as I know you can't do this through the S3 clients but only with 
the rados commands. I also would find it rather weird if you could do 
this as a client.

Wido

>
> thanks
>

