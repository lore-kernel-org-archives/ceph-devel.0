From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: read performance not perfect
Date: Fri, 05 Aug 2011 09:34:54 +0300
Message-ID: <4E3B8F0E.20606@ufm.su>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>	<Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>	<CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>	<Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>	<loom.20110804T213454-854@post.gmane.org>	<Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>	<4E3B2D78.5060605@ufm.su> <Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:37451 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab1HEGe7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Aug 2011 02:34:59 -0400
In-Reply-To: <Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 08/05/2011 04:26 AM, Sage Weil wrote:
> On Fri, 5 Aug 2011, Fyodor Ustinov wrote:
>> On 08/04/2011 10:53 PM, Sage Weil wrote:
>>> The current patches are on top of v3.0, but you should be able to rebase
>>> the readahead stuff on top of anything reasonably recent.
>>>
>>> sage
>> As usual.
>> cluster - latest 0.32 from your ubuntu rep.
>> client - latest git-pulled kernel.
>>
>> dd file from cluster to /dev/null and press ctrl-c. In syslog:
>>
>> [   12.950114] libceph: mon0 10.5.51.230:6789 connection failed
>> [   19.971512] libceph: client4119 fsid af9be081-9777-e2cc-8988-ba02fff0f390
>> [   19.971845] libceph: mon0 10.5.51.230:6789 session established
>> [   92.891202] libceph: try_read bad con->in_tag = -108
>> [   92.891258] libceph: osd5 10.5.51.145:6801 protocol error, garbage tag
>> [  114.508350] libceph: try_read bad con->in_tag = 122
>> [  114.508406] libceph: osd1 10.5.51.141:6800 protocol error, garbage tag
>> [  119.077246] libceph: try_read bad con->in_tag = -39
>> [  119.077301] libceph: osd7 10.5.51.147:6801 protocol error, garbage tag
> Hmm, this is something new.  Can you confirm which commit you're running?
Well. More detailed.

1. Cluster: 8 physical servers with 14 osd servers (fs - xfs) + 1 
physical server with mon+mds. Ceph version - 0.32 from repository on all 
servers and clients.
2. Fresh ceph fs. (Really fresh - I made this fs from scratch)
3. One client via cfuse slowly fills the cluster by some data (7T). 
Really slowly (about 1G in minute).

But we are talking about another client.

Kernel for this client git pulled from 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (it's 
latest kernel).
On client ceph mounted via fstab:

10.5.51.230:/dcvolia/bacula /bacula ceph _netdev,rw 0 0

Now make show:

root@amanda:/bacula/archive/zab.servers.dcv# cd 
/bacula/archive/zab.servers.dcv
root@amanda:/bacula/archive/zab.servers.dcv# ls -alh
total 100G
drwxr-xr-x 1 bacula tape 100G 2011-07-31 00:05 .
drwxr-xr-x 1 bacula tape 253G 2011-07-18 15:21 ..
-rw-r----- 1 bacula tape  23G 2011-08-05 00:40 
zab.servers.dcv-daily-20110719-000519
-rw-r----- 1 bacula tape  28G 2011-07-25 00:39 
zab.servers.dcv-daily-20110719-003333
-rw-r----- 1 bacula tape  32G 2011-08-01 00:42 
zab.servers.dcv-daily-20110726-000515
-rw-r----- 1 bacula tape 6.2G 2011-07-18 12:29 
zab.servers.dcv-monthly-20110718-111036
-rw-r----- 1 bacula tape 6.1G 2011-07-24 01:22 
zab.servers.dcv-weekly-20110724-000518
-rw-r----- 1 bacula tape 6.1G 2011-07-31 01:22 
zab.servers.dcv-weekly-20110731-000522
root@amanda:/bacula/archive/zab.servers.dcv# dd 
if=zab.servers.dcv-daily-20110719-000519 of=/dev/null bs=8M
^C34+1 records in
34+0 records out
285212672 bytes (285 MB) copied, 5.04607 s, 56.5 MB/s

[24983.180068] libceph: get_reply unknown tid 6215 from osd6

root@amanda:/bacula/archive/zab.servers.dcv# dd 
if=zab.servers.dcv-daily-20110719-000519 of=/dev/null bs=8M
^C24+1 records in
24+0 records out
201326592 bytes (201 MB) copied, 2.4007 s, 83.9 MB/s

[25035.656266] libceph: get_reply unknown tid 7025 from osd1

root@amanda:/bacula/archive/zab.servers.dcv# dd 
if=zab.servers.dcv-daily-20110719-000519 of=/dev/null bs=8M
^C130+1 records in
130+0 records out
1090519040 bytes (1.1 GB) copied, 14.9645 s, 72.9 MB/s

root@amanda:/bacula/archive/zab.servers.dcv#

[25088.452033] libceph: try_read bad con->in_tag = 106
[25088.452087] libceph: osd13 10.5.51.146:6800 protocol error, garbage tag

root@amanda:/bacula/archive/zab.servers.dcv# dd 
if=zab.servers.dcv-daily-20110719-000519 of=/dev/null bs=8M
^C104+1 records in
104+0 records out
872415232 bytes (872 MB) copied, 10.5863 s, 82.4 MB/s

[25166.344264] libceph: try_read bad con->in_tag = 122
[25166.344317] libceph: osd4 10.5.51.144:6800 protocol error, garbage tag

and so on.


> Have you seen this before?
Never.
> It may be in the batch of stuff on top of
> 3.0.
>
May be.

BTW, dramatically increase read speed I do not see. :(

WBR,
     Fyodor.
