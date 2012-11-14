From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: problem with ceph and btrfs patch: set journal_info in async trans
 commit worker
Date: Wed, 14 Nov 2012 14:42:07 +0100
Message-ID: <50A39FAF.50602@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-btrfs-owner@vger.kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Josef Bacik <jbacik@fusionio.com>, miaox@cn.fujitsu.com
List-Id: ceph-devel.vger.kernel.org

Hello list,

i wanted to try out ceph with latest vanilla kernel 3.7-rc5. I was 
seeing a massive performance degration. I see around 22x 
btrfs-endio-write processes every 10-20 seconds and they run a long time 
while consuming a massive amount of CPU.

So my performance of 23.000 iops drops to an up and down of 23.000 iops 
to 0 - avg is now 2500 iops instead of 23.000.

Git bisect shows me commit: e209db7ace281ca347b1ac699bf1fb222eac03fe 
"Btrfs: set journal_info in async trans commit worker" as the 
problematic patch.

When i revert this one everything is fine again.

Is this known?

Greets,
Stefan
