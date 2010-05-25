From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 09:03:46 -0500
Message-ID: <4BFBD8C2.1010705@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD63D.5040900@redhat.com> <4BFBD6D4.2040707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61119 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758654Ab0EYOED (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 10:04:03 -0400
In-Reply-To: <4BFBD6D4.2040707@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 05/25/2010 08:55 AM, Avi Kivity wrote:
> On 05/25/2010 04:53 PM, Kevin Wolf wrote:
>>
>> I'm still not convinced that we need either. I share Christoph's concern
>> that we would make our life harder for almost no gain. It's probably a
>> very small group of users (if it exists at all) that wants to add new
>> block drivers themselves, but at the same time can't run upstream qemu.
>>
>
> The first part of your argument may be true, but the second isn't.  No 
> user can run upstream qemu.git.  It's not tested or supported, and has 
> no backwards compatibility guarantees.

Yes, it does have backwards compatibility guarantees.

Regards,

Anthony Liguori

