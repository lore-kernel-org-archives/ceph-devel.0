From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 08:35:10 -0500
Message-ID: <4BFBD20E.5060207@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD13C.60605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:54154 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab0EYNlq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 09:41:46 -0400
In-Reply-To: <4BFBD13C.60605@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 05/25/2010 08:31 AM, Avi Kivity wrote:
>> A protocol based mechanism has the advantage of being more robust in 
>> the face of poorly written block backends so if it's possible to make 
>> it perform as well as a plugin, it's a preferable approach.
>
> May be hard due to difficulty of exposing guest memory.

If someone did a series to add plugins, I would expect a very strong 
argument as to why a shared memory mechanism was not possible or at 
least plausible.

I'm not sure I understand why shared memory is such a bad thing wrt 
KVM.  Can you elaborate?  Is it simply a matter of fork()?

>>
>> Plugins that just expose chunks of QEMU internal state directly (like 
>> BlockDriver) are a really bad idea IMHO.
>
> Also, we don't want to expose all of the qemu API.  We should default 
> the visibility attribute to "hidden" and expose only select functions, 
> perhaps under their own interface.  And no inlines.

Yeah, if we did plugins, this would be a key requirement.

Regards,

Anthony Liguori
