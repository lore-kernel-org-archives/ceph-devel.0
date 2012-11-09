From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: SSD journal suggestion / rsockets
Date: Fri, 9 Nov 2012 09:43:52 -0500
Message-ID: <B17F56C6-BD0E-4AF3-97B9-ED42E17EC205@ornl.gov>
References: <509AD42A.9060108@tuxadero.com>
 <CAJH6TXhGU2BdSgHmxm9g=xPxZnOYCN-9t8iPGEQ5TJF372Z0mw@mail.gmail.com>
 <509AE330.7070808@tuxadero.com>
 <CAJH6TXjqMc3mOU7LLPW2oPp+jTC_V_r=JtRU2bGEmtH4vdb3ag@mail.gmail.com>
 <509AEAF4.30309@inktank.com>
 <CAJH6TXgoHTNKhfRTsZ4pSZs4Qk32e-ctr1-6NkBQ=BDiVSBM+g@mail.gmail.com>
 <FB2218CC-8F8F-480A-A5E5-DEF933100612@ornl.gov>
 <509BC407.4030406@inktank.com>
 <FB2859AE-F86A-4C4A-8EF5-5878CD8ABDC7@ornl.gov>
 <CAOzFzEjjmOx2b4L1QhUoeeQOW9o_A6P3OWCFnf3M7GGz7RXUsQ@mail.gmail.com>
 <20121108212130.GA15520@oder.kd-bie.de>
 <CAOzFzEgvuRn6RK9QD9UxsX4DWhyRon4wB5Jm1MBbQsppMmSD_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.14.70]:62227 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab2KIOnz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 09:43:55 -0500
In-Reply-To: <CAOzFzEgvuRn6RK9QD9UxsX4DWhyRon4wB5Jm1MBbQsppMmSD_g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joseph Glanville <joseph.glanville@orionvm.com.au>
Cc: Dieter Kasper <d.kasper@kabelmail.de>, Mark Nelson <mark.nelson@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "martin@tuxadero.com" <martin@tuxadero.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

On Nov 8, 2012, at 5:00 PM, Joseph Glanville <joseph.glanville@orionvm.com.au> wrote:

> On 9 November 2012 08:21, Dieter Kasper <d.kasper@kabelmail.de> wrote:
>> Joseph,
>> 
>> I've downloaded and read the presentation from 'Sean Hefty / Intel Corporation'
>> about rsockets, which sounds very promising to me.
>> Can you please teach me how to get access to the rsockets source ?
>> 
>> Thanks,
>> -Dieter
>> 
>> 
> 
> rsockets is distributed as part of librdmacm. You can clone the git
> repository here:
> git://beany.openfabrics.org/~shefty/librdmacm.git
> 
> I recommend using the latest master as it features much better support
> for forking.

I would be interested in hearing about how it works at scale. I do not know if Sean uses dedicated send and receive buffers per connection or a shared receive queue or shared send queue. Scaling might be an issue or it might not.

Scott