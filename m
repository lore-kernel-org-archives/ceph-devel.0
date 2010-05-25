From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 18:01:11 +0300
Message-ID: <4BFBE637.8030501@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD63D.5040900@redhat.com> <4BFBD6D4.2040707@redhat.com> <4BFBDA07.7080607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBDA07.7080607@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Kevin Wolf <kwolf@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 05:09 PM, Kevin Wolf wrote:
>
>> The first part of your argument may be true, but the second isn't.  No
>> user can run upstream qemu.git.  It's not tested or supported, and has
>> no backwards compatibility guarantees.
>>      
> The second part was basically meant to say "developers don't count here".
>    

Agreed.

-- 
error compiling committee.c: too many arguments to function

