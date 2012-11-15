From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: problem with ceph and btrfs patch: set journal_info in async
 trans commit worker
Date: Thu, 15 Nov 2012 09:50:29 +0100
Message-ID: <50A4ACD5.9050809@profihost.ag>
References: <50A39FAF.50602@profihost.ag> <50A47B16.6040308@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <50A47B16.6040308@cn.fujitsu.com>
Sender: linux-btrfs-owner@vger.kernel.org
To: miaox@cn.fujitsu.com
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Josef Bacik <jbacik@fusionio.com>
List-Id: ceph-devel.vger.kernel.org

Hi Miao,

Am 15.11.2012 06:18, schrieb Miao Xie:
> Hi, Stefan
>
> On wed, 14 Nov 2012 14:42:07 +0100, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> i wanted to try out ceph with latest vanilla kernel 3.7-rc5. I was seeing a massive performance degration. I see around 22x btrfs-endio-write processes every 10-20 seconds and they run a long time while consuming a massive amount of CPU.
>>
>> So my performance of 23.000 iops drops to an up and down of 23.000 iops to 0 - avg is now 2500 iops instead of 23.000.
>>
>> Git bisect shows me commit: e209db7ace281ca347b1ac699bf1fb222eac03fe "Btrfs: set journal_info in async trans commit worker" as the problematic patch.
>>
>> When i revert this one everything is fine again.
>>
>> Is this known?
>
> Could you try the following patch?
>
> http://marc.info/?l=linux-btrfs&m=135175512030453&w=2
>
> I think the patch
>
>    Btrfs: set journal_info in async trans commit worker
>
> is not the real reason that caused the regression.
>
> I guess it is caused by the bug of the reservation. When we join the
> same transaction handle more than 2 times, the pointer of the reservation
> in the transaction handle would be lost, and the statistical data in the
> reservation would be corrupted. And then we would trigger the space flush,
> which may block your tasks.

i applied your whole patchset. It looks a lot better now but avg iops is 
now 5000 iops and not 23.000 like when removing the mentioned commit 
(e209db7ace281ca347b1ac699bf1fb222eac03fe).

Stefan
