From: Joseph Glanville <joseph.glanville@orionvm.com.au>
Subject: Re: SSD journal suggestion / rsockets
Date: Sat, 10 Nov 2012 10:41:06 +1100
Message-ID: <CAOzFzEh45Rup5wBdst7K+PjyUmSJvVfPfvquUjeKaeodngM5nw@mail.gmail.com>
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
	<B17F56C6-BD0E-4AF3-97B9-ED42E17EC205@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44484 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab2KIXlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 18:41:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6742943iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 15:41:06 -0800 (PST)
In-Reply-To: <B17F56C6-BD0E-4AF3-97B9-ED42E17EC205@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Dieter Kasper <d.kasper@kabelmail.de>, Mark Nelson <mark.nelson@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "martin@tuxadero.com" <martin@tuxadero.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

On 10 November 2012 01:43, Atchley, Scott <atchleyes@ornl.gov> wrote:
> On Nov 8, 2012, at 5:00 PM, Joseph Glanville <joseph.glanville@orionvm.com.au> wrote:
>
>> On 9 November 2012 08:21, Dieter Kasper <d.kasper@kabelmail.de> wrote:
>>> Joseph,
>>>
>>> I've downloaded and read the presentation from 'Sean Hefty / Intel Corporation'
>>> about rsockets, which sounds very promising to me.
>>> Can you please teach me how to get access to the rsockets source ?
>>>
>>> Thanks,
>>> -Dieter
>>>
>>>
>>
>> rsockets is distributed as part of librdmacm. You can clone the git
>> repository here:
>> git://beany.openfabrics.org/~shefty/librdmacm.git
>>
>> I recommend using the latest master as it features much better support
>> for forking.
>
> I would be interested in hearing about how it works at scale. I do not know if Sean uses dedicated send and receive buffers per connection or a shared receive queue or shared send queue. Scaling might be an issue or it might not.
>
> Scott

Hi Scott,

It uses RC QPs so it's scalability is as good as any other large scale
app with similar HCA resource requirements.

As an aside:
As I understand it Mellanox is working on a new piece of hardware
called Connect-IB (somewhat of a successor to Connext-X 3) that will
use a temporary/virtual resource mapping for RC QPs that should make
this a non-issue.
Press release is here:
http://www.mellanox.com/content/pages.php?pg=press_release_item&rec_id=814
The HCA is just in general much beefier in terms of available
resources for QPs and MRs so it's a big boon for big clusters than
need to use all-to-all RC QPs.

That being said I don't have a computer with enough nodes for it to
make a difference. :(

Joseph.

-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
