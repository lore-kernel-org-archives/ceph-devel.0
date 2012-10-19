From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.53 released
Date: Fri, 19 Oct 2012 18:10:19 +0200
Message-ID: <55D9C5F1-9B04-40CF-A10A-C2263F71FC3D@filoo.de>
References: <alpine.DEB.2.00.1210161647550.5342@cobra.newdream.net> <507E95F3.10508@filoo.de> <5080E842.2030200@inktank.com> <5081027F.5000201@filoo.de> <alpine.DEB.2.00.1210190844450.27042@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:39985 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab2JSQKW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 12:10:22 -0400
In-Reply-To: <alpine.DEB.2.00.1210190844450.27042@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Hi Sage,

Am 19.10.2012 um 17:48 schrieb Sage Weil <sage@inktank.com>:

> On Fri, 19 Oct 2012, Oliver Francke wrote:
>> Hi Josh,
>> 
>> On 10/19/2012 07:42 AM, Josh Durgin wrote:
>>> On 10/17/2012 04:26 AM, Oliver Francke wrote:
>>>> Hi Sage, *,
>>>> 
>>>> after having some trouble with the journals - had to erase the partition
>>>> and redo a ceph... --mkjournal - I started my testing... Everything fine.
>>> 
>>> This would be due to the change in default osd journal size. In 0.53
>>> it's 1024MB, even for block devices. Previously it defaulted to
>>> the entire block device.
>>> 
>>> I already fixed this to use the entire block device in 0.54, and
>>> didn't realize the fix wasn't included in 0.53.
>>> 
>>> You can restore the correct behaviour for block devices by setting
>>> this in the [osd] section of your ceph.conf:
>>> 
>>> osd journal size = 0
>> 
>> thnx for the explanation, gives me a better feeling for the next stable to
>> come to the stores ;)
>> Uhm, may it be impertinant to bring http://tracker.newdream.net/issues/2573 to
>> your attention, as it's still ongoing at least in 0.48.2argonaut?
> 
> Do you mean these messages?
> 
> 2012-10-11 10:51:25.879084 7f25d08dc700 0 osd.13 1353 pg[6.5( v 
> 1353'2567562 (1353'2566561,1353'2567562] n=1857 ec=390 les/c 1347/1349 
> 1340/1347/1333) [13,33] r=0 lpr=1347 mlcod 1353'2567561 active+clean] 
> watch: ctx->obc=0x6381000 cookie=1 oi.version=2301953 
> ctx->at_version=1353'2567563
> 2012-10-11 10:51:25.879133 7f25d08dc700 0 osd.13 1353 pg[6.5( v 
> 1353'2567562 (1353'2566561,1353'2567562] n=1857 ec=390 les/c 1347/1349 
> 1340/1347/1333) [13,33] r=0 lpr=1347 mlcod 1353'2567561 active+clean] 
> watch: oi.user_version=2301951
> 
> They're fixed in master; I'll backport the cleanup to stable.  It's 
> useless noise.
> 

uhm, more into the following:

Oct 19 15:28:13 fcmsnode1 kernel: [1483536.141269] libceph: osd13 10.10.10.22:6812 socket closed
Oct 19 15:43:13 fcmsnode1 kernel: [1484435.176280] libceph: osd13 10.10.10.22:6812 socket closed
Oct 19 15:58:13 fcmsnode1 kernel: [1485334.382798] libceph: osd13 10.10.10.22:6812 socket closed

It's kind of "new", cause I would have got aware before. And we have 4 ODS's on every node, so why only from one OSD?
Same picture on two other nodes, If I read the ticket, no data is lost, just closing a socket? But then a kern.log entry is far too much? ;)

Oliver.


> sage
> 
> 
> 
>> 
>> Thnx in advance,
>> 
>> Oliver.
>> 
>>> 
>>> Josh
>>> 
>>>> 
>>>> --- 8-< ---
>>>> 2012-10-17 12:54:11.167782 7febab24a780  0 filestore(/data/osd0) mount:
>>>> enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and
>>>> 'filestore btrfs snap' mode is enabled
>>>> 2012-10-17 12:54:11.191723 7febab24a780  0 journal  kernel version is
>>>> 3.5.0
>>>> 2012-10-17 12:54:11.191907 7febab24a780  1 journal _open /dev/sdb1 fd
>>>> 27: 1073741824 bytes, block size 4096 bytes, directio = 1, aio = 1
>>>> 2012-10-17 12:54:11.201764 7febab24a780  0 journal  kernel version is
>>>> 3.5.0
>>>> 2012-10-17 12:54:11.201924 7febab24a780  1 journal _open /dev/sdb1 fd
>>>> 27: 1073741824 bytes, block size 4096 bytes, directio = 1, aio = 1
>>>> --- 8-< ---
>>>> 
>>>> And the other minute I started my fairly destructive testing, 0.52 never
>>>> ever failed on that. And then a loop started with
>>>> --- 8-< ---
>>>> 
>>>> 2012-10-17 12:59:15.403247 7feba5fed700  0 -- 10.0.0.11:6801/29042 >>
>>>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=34 :57922 pgs=3 cs=1 l=0).fault,
>>>> initiating reconnect
>>>> 2012-10-17 12:59:17.280143 7feb950cc700  0 -- 10.0.0.11:6801/29042 >>
>>>> 10.0.0.12:6804/17972 pipe(0x17f2240 sd=29 :49431 pgs=3 cs=1 l=0).fault
>>>> with nothing to send, going to standby
>>>> 2012-10-17 12:59:18.288902 7feb951cd700  0 -- 10.0.0.11:6801/29042 >>
>>>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=34 :37519 pgs=3 cs=2 l=0).connect
>>>> claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node!
>>>> 2012-10-17 12:59:18.297663 7feb951cd700  0 -- 10.0.0.11:6801/29042 >>
>>>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=34 :34833 pgs=3 cs=2 l=0).connect
>>>> claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node!
>>>> 2012-10-17 12:59:18.303215 7feb951cd700  0 -- 10.0.0.11:6801/29042 >>
>>>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=34 :35169 pgs=3 cs=2 l=0).connect
>>>> claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node!
>>>> --- 8-< ---
>>>> 
>>>> leading to high CPU-load on node2 ( IP 10.0.0.11). The destructive part
>>>> happens on node3 ( IP 10.0.0.12).
>>>> 
>>>> Procedure is as always just kill some OSDs and start over again...
>>>> Happened now twice, so I would call it reproducable ;)
>>>> 
>>>> Kind regards,
>>>> 
>>>> Oliver.
>>>> 
>>>> 
>>>> On 10/17/2012 01:48 AM, Sage Weil wrote:
>>>>> Another development release of Ceph is ready, v0.53. We are getting
>>>>> pretty
>>>>> close to what will be frozen for the next stable release (bobtail), so
>>>>> if
>>>>> you would like a preview, give this one a go. Notable changes include:
>>>>> 
>>>>>  * librbd: image locking
>>>>>  * rbd: fix list command when more than 1024 (format 2) images
>>>>>  * osd: backfill reservation framework (to avoid flooding new osds with
>>>>>    backfill data)
>>>>>  * osd, mon: honor new 'nobackfill' and 'norecover' osdmap flags
>>>>>  * osd: new 'deep scrub' will compare object content across replicas
>>>>> (once
>>>>>    per week by default)
>>>>>  * osd: crush performance improvements
>>>>>  * osd: some performance improvements related to request queuing
>>>>>  * osd: capability syntax improvements, bug fixes
>>>>>  * osd: misc recovery fixes
>>>>>  * osd: fix memory leak on certain error paths
>>>>>  * osd: default journal size to 1 GB
>>>>>  * crush: default root of tree type is now 'root' instead of 'pool' (to
>>>>>    avoid confusiong wrt rados pools)
>>>>>  * ceph-fuse: fix handling for .. in root directory
>>>>>  * librados: some locking fixes
>>>>>  * mon: some election bug fixes
>>>>>  * mon: some additional on-disk metadata to facilitate future mon
>>>>> changes
>>>>>    (post-bobtail)
>>>>>  * mon: throttle osd flapping based on osd history (limits osdmap
>>>>>    "thrashing" on overloaded or unhappy clusters)
>>>>>  * mon: new 'osd crush create-or-move ...' command
>>>>>  * radosgw: fix copy-object vs attributes
>>>>>  * radosgw: fix bug in bucket stat updates
>>>>>  * mds: fix ino release on abort session close, relative getattr
>>>>> path, mds
>>>>>    shutdown, other misc items
>>>>>  * upstart: stop jobs on shutdown
>>>>>  * common: thread pool sizes can now be adjusted at runtime
>>>>>  * build fixes for Fedora 18, CentOS/RHEL 6
>>>>> 
>>>>> The big items are locking support in RBD, and OSD improvements like deep
>>>>> scrub (which verify object data across replicas) and backfill
>>>>> reservations
>>>>> (which limit load on expanding clusters). And a huge swath of bugfixes
>>>>> and
>>>>> cleanups, many due to feeding the code through scan.coverity.com (they
>>>>> offer free static code analysis for open source projects).
>>>>> 
>>>>> v0.54 is now frozen, and will include many deployment-related fixes
>>>>> (including a new ceph-deploy tool to replace mkcephfs), more bugfixes
>>>>> for
>>>>> libcephfs, ceph-fuse, and the MDS, and the fruits of some performance
>>>>> work
>>>>> on the OSD.
>>>>> 
>>>>> You can get v0.53 from the usual locations:
>>>>> 
>>>>>  * Git at git://github.com/ceph/ceph.git
>>>>>  * Tarball at http://ceph.com/download/ceph-0.53.tar.gz
>>>>>  * For Debian/Ubuntu packages, see
>>>>> http://ceph.com/docs/master/install/debian
>>>>>  * For RPMs, see http://ceph.com/docs/master/install/rpm
>>>>> -- 
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>> 
>>>> 
>>> 
>> 
>> 
>> -- 
>> 
>> Oliver Francke
>> 
>> filoo GmbH
>> Moltkestra?e 25a
>> 33330 G?tersloh
>> HRB4355 AG G?tersloh
>> 
>> Gesch?ftsf?hrer: S.Grewing | J.Rehp?hler | C.Kunz
>> 
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

