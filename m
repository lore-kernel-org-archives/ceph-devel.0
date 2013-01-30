From: Joseph Glanville <joseph.glanville@orionvm.com.au>
Subject: Re: flashcache
Date: Thu, 31 Jan 2013 07:10:10 +1100
Message-ID: <CAOzFzEjLSZ7JYEONBpMyfjgqfO3+KenBY5r2cD_CR81dWBbe8Q@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
	<CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
	<50F7FE9B.6050908@inktank.com>
	<44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
	<CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
	<F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov>
	<CABYiri8DDSdGj90geThMRygO7jNhuDS5nK5TRxwLsv0FgKV2gw@mail.gmail.com>
	<74BABD37-71E8-4D69-871E-93F40EBD15BC@ornl.gov>
	<CABYiri9jwpdw6d39NiSg30PYUs2mK6Gkhety4pQohwjJGMnPxQ@mail.gmail.com>
	<CAOzFzEiC7ZUQ5wgF9pTOFm7XN__fjweGOaNg89mLnY0-JFDFzQ@mail.gmail.com>
	<22C8AA02-CE80-4449-AC0E-0AF04DFD4F8C@jnielsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55465 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3A3UKL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 15:10:11 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so451278iea.38
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 12:10:11 -0800 (PST)
In-Reply-To: <22C8AA02-CE80-4449-AC0E-0AF04DFD4F8C@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>
Cc: Andrey Korolyov <andrey@xdel.ru>, "Atchley, Scott" <atchleyes@ornl.gov>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 22 January 2013 10:57, John Nielsen <lists@jnielsen.net> wrote:
> On Jan 19, 2013, at 7:56 PM, Joseph Glanville <joseph.glanville@orionvm.com.au> wrote:
>
>>>> I assume it is now an EoIB driver. Does it replace the IPoIB driver?
>>>>
>>> Nope, it is upper-layer thing: https://lwn.net/Articles/509448/
>>
>> Aye, its effectively a NAT translation layer that strips Ethernet
>> headers and grafts on IPoIB headers, thus using the same wire protocol
>> and allowing communication from EoIB to IPoIB.
>>
>> However this approach is a little dirty and has been nacked by the
>> netdev community so we aren't likely to see it in the mainline
>> kernel.. basically ever.
>
> Just to clarify:
>
> EoIB has been around for a while (at least in the Mellanox software, not sure about mainline). It uses the mlx4_vnic module and is a true Ethernet encapsulation over InfiniBand. Unfortunately the newer Mellanox switches won't support it any more and the ones that to have entered "Limited Support." (Not to be confused with mlx4_en, which just turns a ConnectX card into a 10G Ethernet NIC.)
>
> IPoIB is IP over InfiniBand without Ethernet (the data link layer is straight InfiniBand).
>
> eIPoIB is (or will be, maybe) Ethernet over IP over InfiniBand. It is intended to work with both Linux bridging and regular IB switches that support IPoIB. (Allowing e.g. unmodified KVM guests on hypervisors connected to an IPoIB fabric.) Both Joseph's comments and the LWN link above are referring to eIPoIB. Last I heard (from a pretty direct source in the last couple of weeks) Mellanox is still working on this but doesn't have anything generally available yet. Here's hoping.. but the feedback on netdev was quite negative, to put it mildly.
>
> JN
>

Apolgies, I misread EoIB as eIPoIB as others were discussing IPoIB
appearing as an Ethernet device.

Personally I would like to see a pure software implementation of EoIB
ala IPoIB, using the subnet manager to manage addressing etc rather
than trying to implement a NAT style solution.
The usefulness of communicating to IPoIB devices via the same
interface as IPoIB doesn't sufficiently offset the dirtiness of NAT
IMO.

-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
