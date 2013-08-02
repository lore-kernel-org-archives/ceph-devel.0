From: Niklas Goerke <niklas@niklasgoerke.de>
Subject: Re: Rados Protocoll
Date: Fri, 02 Aug 2013 10:58:40 +0200
Message-ID: <51FB74C0.3060706@niklasgoerke.de>
References: <51FABE7F.90200@niklasgoerke.de> <CA+Hcz58MpW6w3-rv52orcUj+AEW-ccYhgcQAJ2GtHrn6=rDHQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from niklasgoerke.de ([46.38.232.61]:40008 "EHLO niklasgoerke.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442Ab3HBI6n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Aug 2013 04:58:43 -0400
In-Reply-To: <CA+Hcz58MpW6w3-rv52orcUj+AEW-ccYhgcQAJ2GtHrn6=rDHQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Noah

Thank you for your comments.
My companies policy states that all software needs to go through a 
security assessment to be allowed to use in production. As all our tools 
are focused on java, a native implementation would be far easier to 
handle than a java binding of librados (which uses jna, which is also 
quite large).
Also with a native java implementation there is no "technology-break" 
using three different software packages from three maintainers as 
compared to one native java implementation which only relies on the 
RADOS Protocol.

As for the documentation you referenced: I didn't find a documentation 
of the RADOS Protocol which could be used to base an implementation of 
librados upon. Does anything like this exist, or would I need to 
"translate" the c implementation?

Niklas


Am 01.08.2013 23:53, schrieb Noah Watkins:
> Hi Niklas,
>
> The RADOS reference implementation in C++ is quite large. Reproducing
> it all in another language would be interesting, but I'm curious if
> wrapping the C interface is not an option for you? There are Java
> bindings that are being worked on here:
> https://github.com/wido/rados-java.
>
> There are links on ceph.com/docs to some information about Ceph, as
> well as videos on Youtube, and academic papers linked to.
>
> -Noah
>
> On Thu, Aug 1, 2013 at 1:01 PM, Niklas Goerke <niklas@niklasgoerke.de> wrote:
>> Hi,
>>
>> I was wondering why there is no native Java implementation of librados. I'm
>> thinking about creating one and I'm thus looking for a documentation of the
>> RADOS protocol.
>> Also the way I see it librados implements the crush algorithm. Is there a
>> documentation for it?
>> Also an educated guess about whether the RADOS Protocol is due to changes
>> would be very much appreciated.
>>
>> Thank you in advance
>>
>> Niklas
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

