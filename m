From: Gregory Farnum <greg@inktank.com>
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new
 host to my cluster
Date: Thu, 24 Jan 2013 13:28:22 -0800
Message-ID: <4428CF82A82E485B81CB865DFBE92465@inktank.com>
References: <1359048283.79398.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41437 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945980Ab3AXV21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 16:28:27 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so5760746pad.24
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 13:28:26 -0800 (PST)
In-Reply-To: <1359048283.79398.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

What's the physical layout of your networking? This additional log may prove helpful as well, but I really need a bit more context in evaluating the messages I see from the first one. :) 
-Greg


On Thursday, January 24, 2013 at 9:24 AM, Isaac Otsiabah wrote:

> 
> 
> Gregory, i tried send the the attached debug output several times and 
> the mail server rejected them all probably becauseof the file size so i cut the log file size down and it is attached. You will see the 
> reconnection failures by the error message line below. The ceph version 
> is 0.56
> 
> 
> it appears to be a timing issue because with the flag (debug ms=1) turned on, the system ran slower and became harder to fail.
> I
> ran it several times and finally got it to fail on (osd.0) using 
> default crush map. The attached tar file contains log files for all 
> components on g8ct plus the ceph.conf. By the way, the log file contain only the last 1384 lines where the error occurs.
> 
> 
> I started with a 1-node cluster on host g8ct (osd.0, osd.1, osd.2) and then added host g13ct (osd.3, osd.4, osd.5)
> 
> 
> id weight type name up/down reweight
> -1 6 root default
> -3 6 rack unknownrack
> -2 3 host g8ct
> 0 1 osd.0 down 1
> 1 1 osd.1 up 1
> 2 1 osd.2 up 1
> -4 3 host g13ct
> 3 1 osd.3 up 1
> 4 1 osd.4 up 1
> 5 1 osd.5 up 1
> 
> 
> 
> The error messages are in ceph.log and ceph-osd.0.log:
> 
> ceph.log:2013-01-08
> 05:41:38.080470 osd.0 192.168.0.124:6801/25571 3 : [ERR] map e15 had 
> wrong cluster addr (192.168.0.124:6802/25571 != my 
> 192.168.1.124:6802/25571)
> ceph-osd.0.log:2013-01-08 05:41:38.080458 7f06757fa710 0 log [ERR] : map e15 had wrong cluster addr 
> (192.168.0.124:6802/25571 != my 192.168.1.124:6802/25571)
> 
> 
> 
> [root@g8ct ceph]# ceph -v
> ceph version 0.56 (1a32f0a0b42f169a7b55ed48ec3208f6d4edc1e8)
> 
> 
> Isaac
> 
> 
> ----- Original Message -----
> From: Gregory Farnum <greg@inktank.com (mailto:greg@inktank.com)>
> To: Isaac Otsiabah <zmoo76b@yahoo.com (mailto:zmoo76b@yahoo.com)>
> Cc: "ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)>
> Sent: Monday, January 7, 2013 1:27 PM
> Subject: Re: osd down (for 2 about 2 minutes) error after adding a new host to my cluster
> 
> On Monday, January 7, 2013 at 1:00 PM, Isaac Otsiabah wrote:
> 
> 
> When i add a new host (with osd's) to my existing cluster, 1 or 2 
> previous osd(s) goes down for about 2 minutes and then they come back 
> up. 
> > 
> > 
> > [root@h1ct ~]# ceph osd tree
> > 
> > # id weight type name up/down reweight
> > -1 
> > 3 root default
> > -3 3 rack unknownrack
> > -2 3 host h1
> > 0 1 osd.0 up 1
> > 1 1 osd.1 up 1
> > 2 
> > 1 osd.2 up 1
> 
> 
> For example, after adding host h2 (with 3 new osd) to the above cluster
> and running the "ceph osd tree" command, i see this: 
> > 
> > 
> > [root@h1 ~]# ceph osd tree
> > 
> > # id weight type name up/down reweight
> > -1 6 root default
> > -3 
> > 6 rack unknownrack
> > -2 3 host h1
> > 0 1 osd.0 up 1
> > 1 1 osd.1 down 1
> > 2 
> > 1 osd.2 up 1
> > -4 3 host h2
> > 3 1 osd.3 up 1
> > 4 1 osd.4 up 
> > 1
> > 5 1 osd.5 up 1
> 
> 
> The down osd always come back up after 2 minutes or less andi see the 
> following error message in the respective osd log file: 
> > 2013-01-07 04:40:17.613028 7fec7f092760 1 journal _open 
> > /ceph_journal/journals/journal_2 fd 26: 1073741824 bytes, block size 
> > 4096 bytes, directio = 1, aio = 0
> > 2013-01-07 04:40:17.613122 
> > 7fec7f092760 1 journal _open /ceph_journal/journals/journal_2 fd 26: 
> > 1073741824 bytes, block size 4096 bytes, directio = 1, aio = 0
> > 2013-01-07
> > 04:42:10.006533 7fec746f7710 0 -- 192.168.0.124:6808/19449 >> 
> > 192.168.1.123:6800/18287 pipe(0x7fec20000e10 sd=31 :6808 pgs=0 cs=0 
> > l=0).accept connect_seq 0 vs existing 0 state connecting
> > 2013-01-07 
> > 04:45:29.834341 7fec743f4710 0 -- 192.168.1.124:6808/19449 >> 
> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=28 :45438 pgs=7 cs=1 
> > l=0).fault, initiating reconnect
> > 2013-01-07 04:45:29.835748 
> > 7fec743f4710 0 -- 192.168.1.124:6808/19449 >> 
> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=28 :45439 pgs=15 cs=3 
> > l=0).fault, initiating reconnect
> > 2013-01-07 04:45:30.835219 7fec743f4710 0 -- 
> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072 
> > pipe(0x7fec5402f320 sd=28 :45894 pgs=482 cs=903 l=0).fault, initiating 
> > reconnect
> > 2013-01-07 04:45:30.837318 7fec743f4710 0 -- 
> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072 
> > pipe(0x7fec5402f320 sd=28 :45895 pgs=483 cs=905 l=0).fault, initiating 
> > reconnect
> > 2013-01-07 04:45:30.851984 7fec637fe710 0 log [ERR] : map 
> > e27 had wrong cluster addr (192.168.0.124:6808/19449 != my 
> > 192.168.1.124:6808/19449)
> > 
> > Also, this only happens only when the cluster ip address and the public ip address are different for example
> > ....
> > ....
> > ....
> > [osd.0]
> > host = g8ct
> > public address = 192.168.0.124
> > cluster address = 192.168.1.124
> > btrfs devs = /dev/sdb
> > 
> > ....
> > ....
> > 
> > but does not happen when they are the same. Any idea what may be the issue?
> This isn't familiar to me at first glance. What version of Ceph are you using?
> 
> If
> this is easy to reproduce, can you pastebin your ceph.conf and then add
> "debug ms = 1" to your global config and gather up the logs from each 
> daemon?
> -Greg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo
> 
> 
> Attachments: 
> - ceph-osd.0.log.tar.gz
> 



