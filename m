From: Wido den Hollander <wido@42on.com>
Subject: Re: PowerDNS backend for Rados Gateway to direct bucket traffic
Date: Sat, 09 Nov 2013 16:46:00 +0100
Message-ID: <527E58B8.9050503@42on.com>
References: <52765A7E.9040306@42on.com> <CAFMfnwpa874DOywJwiwS0gYVaQ70cf4V6403KRrJUMM6NqX=wg@mail.gmail.com> <alpine.DEB.2.00.1311072036580.15297@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43952 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab3KIPqD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Nov 2013 10:46:03 -0500
In-Reply-To: <alpine.DEB.2.00.1311072036580.15297@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Kyle Bader <kyle.bader@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/08/2013 05:37 AM, Sage Weil wrote:
> I think this is a good path forward, FWIW.  Want to write up a blueprint,
> Wido?  :)
>

Done! 
http://wiki.ceph.com/01Planning/02Blueprints/Firefly/PowerDNS_backend_for_RGW

This really shouldn't be that much work. I'll try to write a small POC 
in the coming weeks.

Wido

> sage
>
>
> On Thu, 7 Nov 2013, Kyle Bader wrote:
>
>>> Does it sound reasonable what I'm thinking of or am I completely wrong about
>>> this?
>>>
>>> [0]: http://doc.powerdns.com/html/remotebackend.html
>>
>> I was considering exactly what your describe, not being a programmer
>> though it was simply an idea. I could see myself using a powerdns
>> backend for bucket mapping, all other ways I've considered seem very
>> brittle. Let me know if you write it, I'd be willing to test it out.
>>
>> --
>>
>> Kyle
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
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
