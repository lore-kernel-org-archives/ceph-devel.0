From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 19:21:26 +0300
Message-ID: <4BFBF906.7010809@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>		<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>		<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>		<87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>		<4BFA5D96.3030603@redhat.com>		<lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>		<4BFA696D.2060606@redhat.com>		<lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp>	<AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com>	<4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com>	<4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com> <4BFBD833.1030503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBD833.1030503@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Kevin Wolf <kwolf@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 05:01 PM, Kevin Wolf wrote:
>
>> The current situation is that those block format drivers only exist in
>> qemu.git or as patches.  Surely that's even more unhappiness.
>>      
> The difference is that in the current situation these drivers will be
> part of the next qemu release, so the patch may be obsolete, but you
> don't even need it any more.
>    

The next qemu release may be six months in the future.  So if you're not 
happy with running qemu.git master or with patching a stable release, 
you have to wait.

> If you start keeping block drivers outside qemu and not even try
> integrating them, they'll stay external.
>    

Which may or may not be a problem.

>> Confusion could be mitigated:
>>
>>     $ qemu -module my-fancy-block-format-driver.so
>>     my-fancy-block-format-driver.so does not support this version of qemu
>> (0.19.2).  Please contact my-fancy-block-format-driver-devel@example.org.
>>
>> The question is how many such block format drivers we expect.  We now
>> have two in the pipeline (ceph, sheepdog), it's reasonable to assume
>> we'll want an lvm2 driver and btrfs driver.  This is an area with a lot
>> of activity and a relatively simply interface.
>>      
> What's the reason for not having these drivers upstream? Do we gain
> anything by hiding them from our users and requiring them to install the
> drivers separately from somewhere else?
>    

Six months.

-- 
error compiling committee.c: too many arguments to function

