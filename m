From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 16:55:32 +0300
Message-ID: <4BFBD6D4.2040707@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD63D.5040900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBD63D.5040900@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Kevin Wolf <kwolf@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 04:53 PM, Kevin Wolf wrote:
>
> I'm still not convinced that we need either. I share Christoph's concern
> that we would make our life harder for almost no gain. It's probably a
> very small group of users (if it exists at all) that wants to add new
> block drivers themselves, but at the same time can't run upstream qemu.
>
>    

The first part of your argument may be true, but the second isn't.  No 
user can run upstream qemu.git.  It's not tested or supported, and has 
no backwards compatibility guarantees.

-- 
error compiling committee.c: too many arguments to function

