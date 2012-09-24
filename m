From: peacebull <peacebull@gmail.com>
Subject: File Writing gets very slow after adding 1000 or more files in a folder
Date: Tue, 25 Sep 2012 01:09:47 +0800
Message-ID: <CAAzmXi9jVvhLoEE+GtAeE_qivboQm1JVFu64FjD8zMyQhyaPQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62853 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab2IXRJs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 13:09:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so11481800iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 10:09:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
  We installed Development release packages on our servers to use a
storage of small text files. As there are more  than ten thousand
files in one folder, we find sometimes ceph becomes very slow to add
one file to one folder. then we build a short php test.
  Appreciate if anyone can help.

  Environment:
   Machine:(cpu = Xeon E5620*2, memory = 48G)*3
   OS:Ubuntu 12.10*2 + 12.04*1
   Ceph conf:
     osd nodes: btrfs 3TB drivers mapped as osd 0-3 on server 3
     mds:server1,server2
     monitor:server1,server2,server3
     osd journal size = 10000
     test client: server1 Ubuntu 12.04

test program:

#!/usr/bin/php
<?php
$testString = 'Hello World!';
$path = '/srv/ceph/test/';

$start = microtime(true);

for($i=1;$i<=10000;$i++){
	file_put_contents($path.substr(strval($i+10000),1,4),$testString);
	
	if($i%100 ==0){
		$stop = microtime(true);
		echo substr(strval($i+10000),1,4).':'.($stop-$start)."s\n";
		$start = microtime(true);
	}
}

     output:
0100:0.097404003143311s
0200:0.095574140548706s
...
0900:0.10510206222534s
1000:0.10704207420349s
1100:46.122488021851s=========
1200:0.053461074829102s
1300:0.0539710521698s
...
1800:0.11577081680298s
1900:0.11810994148254s
2000:0.12025594711304s
2100:40.39636015892s=========
2200:0.048443078994751s
2300:0.050076007843018s
2400:0.05461597442627s
...
2900:0.059355974197388s
3000:0.063041925430298s
3100:87.312695980072s
3200:0.13697504997253s
...
3800:0.11908078193665s
3900:0.12016081809998s
4000:0.12331390380859s
4100:160.46773886681s=========
4200:0.11050891876221s
4300:0.10846281051636s
...
4600:0.11165809631348s
4700:0.21804213523865s===
4800:0.11986589431763s
4900:0.11911988258362s
5000:0.11548614501953s
5100:0.1159200668335s
5200:0.12873601913452s
5300:0.12601613998413s
5400:0.13019204139709s
5500:0.24311089515686s===
5600:0.12152814865112s
5700:0.12629795074463s
5800:0.12915205955505s
5900:0.12966799736023s
6000:0.12927007675171s
6100:0.12512397766113s
6200:0.17450404167175s
6300:0.15322089195251s
6400:56.091526031494s========
6500:0.16710710525513s
6600:0.16718292236328s
6700:0.16933989524841s
6800:0.16525483131409s
6900:0.17328906059265s
7000:0.17068290710449s
7100:0.17441511154175s
7200:0.16244316101074s
7300:0.15795588493347s
7400:58.798840045929s========
7500:0.14478087425232s
7600:0.15008687973022s
7700:0.14457392692566s
7800:0.14960598945618s
7900:0.15370583534241s
8000:0.15670108795166s
8100:0.15051817893982s
8200:0.1520562171936s
8300:0.18154978752136s
8400:63.490166902542s========
8500:0.15436792373657s
8600:0.15621995925903s
8700:0.15948700904846s
8800:0.1606719493866s
8900:0.16889405250549s
9000:0.16176605224609s
9100:0.16810297966003s
9200:0.16848587989807s
9300:0.19355988502502s
9400:34.964991807938s========
9500:0.1543390750885s
9600:0.15556597709656s
9700:0.15196895599365s
9800:0.15592002868652s
9900:0.16526699066162s
0000:0.15764379501343s

log:
2012-09-24 22:36:37.543709 osd.0 192.168.1.203:6800/1343 3048 : [WRN]
38 slow requests, 3 included below; oldest blocked for > 54.642729
secs
2012-09-24 22:36:37.543714 osd.0 192.168.1.203:6800/1343 3049 : [WRN]
slow request 54.641117 seconds old, received at 2012-09-24
22:35:42.902514: osd_op(client.4212.1:4645970 1000048a9b5.00000000
[write 0~12] 0.5d2e649b snapc 1=[]) currently waiting for sub ops
2012-09-24 22:36:37.543717 osd.0 192.168.1.203:6800/1343 3050 : [WRN]
slow request 54.641067 seconds old, received at 2012-09-24
22:35:42.902564: osd_op(client.4212.1:4645978 1000048a9bd.00000000
[write 0~12] 0.6c603b03 snapc 1=[]) currently waiting for sub ops
2012-09-24 22:36:37.543726 osd.0 192.168.1.203:6800/1343 3051 : [WRN]
slow request 54.641047 seconds old, received at 2012-09-24
22:35:42.902584: osd_op(client.4212.1:4645982 1000048a9c1.00000000
[write 0~12] 0.40595f72 snapc 1=[]) currently waiting for sub ops
2012-09-24 22:36:59.020583 mon.0 192.168.1.201:6789/0 21551 : [INF]
pgmap v269563: 768 pgs: 768 active+clean; 43016 MB data, 161 GB used,
7938 GB / 8383 GB avail


Thanks in advance!

Allen
