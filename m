From: Wido den Hollander <wido@widodh.nl>
Subject: Re: syslog problems
Date: Wed, 15 Jun 2011 16:50:36 +0200
Message-ID: <1308149436.2611.17.camel@wido-laptop.pcextreme.nl>
References: <4DF8C122.5050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57127 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab1FOOuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2011 10:50:39 -0400
In-Reply-To: <4DF8C122.5050506@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <samlang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-06-15 at 09:26 -0500, Sam Lang wrote:
> In my ceph setup, I had logs being written to the default location 
> (/var/log/ceph/) and eventually would get monitor or osd crashes because 
> the disk would fill up with logs.  So I started writing the logs to 
> syslog, and now the local disk doesn't fill up, but I still get similar 
> errors to those of before.  For example:

How did you configure your syslogging? I'm using syslog as well with my
OSD's and that is working fine.

[global]
    auth supported = cephx
    debug ms = 0
    debug auth = 0
    debug rados = 0
    ms bind ipv6 = true
    keyring = /etc/ceph/keyring.bin
    log to syslog = true
    clog to syslog = true
    log file =
    log dir =

> 
> Also, I've seen a monitor process get killed by the OOM killer (see 
> below).  Are these known issues?  In practice, do folks just disable all 
> logging right now and hope for the best?

Now that is interesting! See: http://tracker.newdream.net/issues/1152

I've got the same issue, my MON keeps eating memory until the OOM-killer
kills it. I'm using syslog as well with high debugging set on the
monitor.

Btw, what syslogging daemon are you using? I'm using rsyslogd, had to
switch to TCP though, since with high debugging turned on, UDP would
loose messages.

root@atom0:~# cat /etc/rsyslog.d/30-ceph.conf 
# Sent all message to the remote syslog machine, then discard them to
prevent local logging
# Use TCP (@@) for transmission to prevent packet loss
:rawmsg,contains,"osd." @@noisy.ceph.widodh.nl
& ~
:rawmsg,contains,"mon." @@noisy.ceph.widodh.nl
& ~
:rawmsg,contains,"mds." @@noisy.ceph.widodh.nl
& ~
root@atom0:~#

Wido

> 
> Thanks,
> -sam
> 
> OOM killer messages:
> 
> [364540.080818] Node 0 DMA free:7992kB min:348kB low:432kB high:520kB 
> active_anon:3632kB inactive
> _anon:3744kB active_file:0kB inactive_file:0kB unevictable:0kB 
> isolated(anon):0kB isolated(file):
> 0kB present:15664kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB 
> shmem:0kB slab_reclaimable:56k
> B slab_unreclaimable:384kB kernel_stack:64kB pagetables:16kB 
> unstable:0kB bounce:0kB writeback_tm
> p:0kB pages_scanned:0 all_unreclaimable? yes
> [364540.080831] lowmem_reserve[]: 0 1963 1963 1963
> [364540.080837] Node 0 DMA32 free:44672kB min:44704kB low:55880kB 
> high:67056kB active_anon:138704
> 4kB inactive_anon:462364kB active_file:520kB inactive_file:2780kB 
> unevictable:0kB isolated(anon):
> 0kB isolated(file):0kB present:2010592kB mlocked:0kB dirty:4kB 
> writeback:8kB mapped:396kB shmem:5
> 920kB slab_reclaimable:7928kB slab_unreclaimable:18600kB 
> kernel_stack:7560kB pagetables:11992kB u
> nstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:2860 
> all_unreclaimable? yes
> [364540.080850] lowmem_reserve[]: 0 0 0 0
> [364540.080856] Node 0 DMA: 14*4kB 14*8kB 7*16kB 3*32kB 3*64kB 2*128kB 
> 4*256kB 4*512kB 2*1024kB 1
> *2048kB 0*4096kB = 7992kB
> [364540.080869] Node 0 DMA32: 9632*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
> 0*128kB 0*256kB 0*512kB 0*1024k
> B 1*2048kB 1*4096kB = 44672kB
> [364540.080882] 4870 total pagecache pages
> [364540.080884] 2596 pages in swap cache
> [364540.080887] Swap cache stats: add 501808, delete 499212, find 6734/8216
> [364540.080889] Free swap  = 0kB
> [364540.080891] Total swap = 1953040kB
> [364540.087324] 513696 pages RAM
> [364540.087327] 10085 pages reserved
> [364540.087329] 1907 pages shared
> [364540.087330] 487503 pages non-shared
> ...
> [364540.087475] [ 5998]     0  5975   851179   444043   0       
> 0             0 cmon
> [364540.087480] [ 6188]     0  6188    49938      145   1       
> 0             0 cmds
> [364540.087484] [ 6396]     0  6396   150647     1359   1       
> 0             0 cosd
> [364540.087489] [ 6485]     0  6485   176420     7324   0       
> 0             0 cosd
> [364540.087494] [ 7076]     0  7076   168333     1561   1       
> 0             0 cosd
> [364540.087499] [ 7660]     0  7660   167456     1571   1       
> 0             0 cosd
> [364540.087503] [ 7747]     0  7747   149214     1497   0       
> 0             0 cosd
> [364540.087515] Out of memory: Kill process 5998 (cmon) score 776 or 
> sacrifice child
> [364540.087570] Killed process 5998 (cmon) total-vm:3404716kB, 
> anon-rss:1776172kB, file-rss:0kB
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


