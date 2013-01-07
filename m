From: Gregory Farnum <greg@inktank.com>
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new
 host to my cluster
Date: Mon, 7 Jan 2013 13:27:04 -0800
Message-ID: <D5D52DC203EC4D6BBD7A2DF4753B2C2C@inktank.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
 <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
 <CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com>
 <50B80600.1000304@inktank.com>
 <1354237947.86472.YahooMailNeo@web121901.mail.ne1.yahoo.com>
 <1354238575.90788.YahooMailNeo@web121904.mail.ne1.yahoo.com>
 <1357591756.80653.YahooMailNeo@web121903.mail.ne1.yahoo.com>
 <1357592421.16299.YahooMailNeo@web121902.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:65320 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab3AGV1J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 16:27:09 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so10831922pbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 13:27:09 -0800 (PST)
In-Reply-To: <1357592421.16299.YahooMailNeo@web121902.mail.ne1.yahoo.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Monday, January 7, 2013 at 1:00 PM, Isaac Otsiabah wrote:
> 
> 
> When i add a new host (with osd's) to my existing cluster, 1 or 2 previous osd(s) goes down for about 2 minutes and then they come back up. 
> 
> 
> [root@h1ct ~]# ceph osd tree
> 
> # id weight type name up/down reweight
> -1 
> 3 root default
> -3 3 rack unknownrack
> -2 3 host h1
> 0 1 osd.0 up 1
> 1 1 osd.1 up 1
> 2 
> 1 osd.2 up 1
> 
> 
> For example, after adding host h2 (with 3 new osd) to the above cluster and running the "ceph osd tree" command, i see this: 
> 
> 
> [root@h1 ~]# ceph osd tree
> 
> # id weight type name up/down reweight
> -1 6 root default
> -3 
> 6 rack unknownrack
> -2 3 host h1
> 0 1 osd.0 up 1
> 1 1 osd.1 down 1
> 2 
> 1 osd.2 up 1
> -4 3 host h2
> 3 1 osd.3 up 1
> 4 1 osd.4 up 
> 1
> 5 1 osd.5 up 1
> 
> 
> The down osd always come back up after 2 minutes or less andi see the following error message in the respective osd log file: 
> 2013-01-07 04:40:17.613028 7fec7f092760 1 journal _open 
> /ceph_journal/journals/journal_2 fd 26: 1073741824 bytes, block size 
> 4096 bytes, directio = 1, aio = 0
> 2013-01-07 04:40:17.613122 
> 7fec7f092760 1 journal _open /ceph_journal/journals/journal_2 fd 26: 
> 1073741824 bytes, block size 4096 bytes, directio = 1, aio = 0
> 2013-01-07
> 04:42:10.006533 7fec746f7710 0 -- 192.168.0.124:6808/19449 >> 
> 192.168.1.123:6800/18287 pipe(0x7fec20000e10 sd=31 :6808 pgs=0 cs=0 
> l=0).accept connect_seq 0 vs existing 0 state connecting
> 2013-01-07 
> 04:45:29.834341 7fec743f4710 0 -- 192.168.1.124:6808/19449 >> 
> 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=28 :45438 pgs=7 cs=1 
> l=0).fault, initiating reconnect
> 2013-01-07 04:45:29.835748 
> 7fec743f4710 0 -- 192.168.1.124:6808/19449 >> 
> 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=28 :45439 pgs=15 cs=3 
> l=0).fault, initiating reconnect
> 2013-01-07 04:45:30.835219 7fec743f4710 0 -- 
> 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072 
> pipe(0x7fec5402f320 sd=28 :45894 pgs=482 cs=903 l=0).fault, initiating 
> reconnect
> 2013-01-07 04:45:30.837318 7fec743f4710 0 -- 
> 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072 
> pipe(0x7fec5402f320 sd=28 :45895 pgs=483 cs=905 l=0).fault, initiating 
> reconnect
> 2013-01-07 04:45:30.851984 7fec637fe710 0 log [ERR] : map 
> e27 had wrong cluster addr (192.168.0.124:6808/19449 != my 
> 192.168.1.124:6808/19449)
> 
> Also, this only happens only when the cluster ip address and the public ip address are different for example
> ....
> ....
> ....
> [osd.0]
> host = g8ct
> public address = 192.168.0.124
> cluster address = 192.168.1.124
> btrfs devs = /dev/sdb
> 
> ....
> ....
> 
> but does not happen when they are the same. Any idea what may be the issue?
> 
This isn't familiar to me at first glance. What version of Ceph are you using?

If this is easy to reproduce, can you pastebin your ceph.conf and then add "debug ms = 1" to your global config and gather up the logs from each daemon?
-Greg

