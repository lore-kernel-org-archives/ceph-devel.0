From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.53 released
Date: Fri, 19 Oct 2012 09:34:23 +0200
Message-ID: <5081027F.5000201@filoo.de>
References: <alpine.DEB.2.00.1210161647550.5342@cobra.newdream.net> <507E95F3.10508@filoo.de> <5080E842.2030200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:41440 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab2JSHe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 03:34:26 -0400
In-Reply-To: <5080E842.2030200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Hi Josh,

On 10/19/2012 07:42 AM, Josh Durgin wrote:
> On 10/17/2012 04:26 AM, Oliver Francke wrote:
>> Hi Sage, *,
>>
>> after having some trouble with the journals - had to erase the parti=
tion
>> and redo a ceph... --mkjournal - I started my testing... Everything=20
>> fine.
>
> This would be due to the change in default osd journal size. In 0.53
> it's 1024MB, even for block devices. Previously it defaulted to
> the entire block device.
>
> I already fixed this to use the entire block device in 0.54, and
> didn't realize the fix wasn't included in 0.53.
>
> You can restore the correct behaviour for block devices by setting
> this in the [osd] section of your ceph.conf:
>
> osd journal size =3D 0

thnx for the explanation, gives me a better feeling for the next stable=
=20
to come to the stores ;)
Uhm, may it be impertinant to bring=20
http://tracker.newdream.net/issues/2573 to your attention, as it's stil=
l=20
ongoing at least in 0.48.2argonaut?

Thnx in advance,

Oliver.

>
> Josh
>
>>
>> --- 8-< ---
>> 2012-10-17 12:54:11.167782 7febab24a780  0 filestore(/data/osd0) mou=
nt:
>> enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and
>> 'filestore btrfs snap' mode is enabled
>> 2012-10-17 12:54:11.191723 7febab24a780  0 journal  kernel version i=
s=20
>> 3.5.0
>> 2012-10-17 12:54:11.191907 7febab24a780  1 journal _open /dev/sdb1 f=
d
>> 27: 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D=
 1
>> 2012-10-17 12:54:11.201764 7febab24a780  0 journal  kernel version i=
s=20
>> 3.5.0
>> 2012-10-17 12:54:11.201924 7febab24a780  1 journal _open /dev/sdb1 f=
d
>> 27: 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D=
 1
>> --- 8-< ---
>>
>> And the other minute I started my fairly destructive testing, 0.52 n=
ever
>> ever failed on that. And then a loop started with
>> --- 8-< ---
>>
>> 2012-10-17 12:59:15.403247 7feba5fed700  0 -- 10.0.0.11:6801/29042 >=
>
>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :57922 pgs=3D3 cs=3D1 l=3D=
0).fault,
>> initiating reconnect
>> 2012-10-17 12:59:17.280143 7feb950cc700  0 -- 10.0.0.11:6801/29042 >=
>
>> 10.0.0.12:6804/17972 pipe(0x17f2240 sd=3D29 :49431 pgs=3D3 cs=3D1 l=3D=
0).fault
>> with nothing to send, going to standby
>> 2012-10-17 12:59:18.288902 7feb951cd700  0 -- 10.0.0.11:6801/29042 >=
>
>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :37519 pgs=3D3 cs=3D2 l=3D=
0).connect
>> claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node=
!
>> 2012-10-17 12:59:18.297663 7feb951cd700  0 -- 10.0.0.11:6801/29042 >=
>
>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :34833 pgs=3D3 cs=3D2 l=3D=
0).connect
>> claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node=
!
>> 2012-10-17 12:59:18.303215 7feb951cd700  0 -- 10.0.0.11:6801/29042 >=
>
>> 10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :35169 pgs=3D3 cs=3D2 l=3D=
0).connect
>> claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node=
!
>> --- 8-< ---
>>
>> leading to high CPU-load on node2 ( IP 10.0.0.11). The destructive p=
art
>> happens on node3 ( IP 10.0.0.12).
>>
>> Procedure is as always just kill some OSDs and start over again...
>> Happened now twice, so I would call it reproducable ;)
>>
>> Kind regards,
>>
>> Oliver.
>>
>>
>> On 10/17/2012 01:48 AM, Sage Weil wrote:
>>> Another development release of Ceph is ready, v0.53. We are getting
>>> pretty
>>> close to what will be frozen for the next stable release (bobtail),=
=20
>>> so if
>>> you would like a preview, give this one a go. Notable changes inclu=
de:
>>>
>>>   * librbd: image locking
>>>   * rbd: fix list command when more than 1024 (format 2) images
>>>   * osd: backfill reservation framework (to avoid flooding new osds=
=20
>>> with
>>>     backfill data)
>>>   * osd, mon: honor new 'nobackfill' and 'norecover' osdmap flags
>>>   * osd: new 'deep scrub' will compare object content across replic=
as
>>> (once
>>>     per week by default)
>>>   * osd: crush performance improvements
>>>   * osd: some performance improvements related to request queuing
>>>   * osd: capability syntax improvements, bug fixes
>>>   * osd: misc recovery fixes
>>>   * osd: fix memory leak on certain error paths
>>>   * osd: default journal size to 1 GB
>>>   * crush: default root of tree type is now 'root' instead of 'pool=
'=20
>>> (to
>>>     avoid confusiong wrt rados pools)
>>>   * ceph-fuse: fix handling for .. in root directory
>>>   * librados: some locking fixes
>>>   * mon: some election bug fixes
>>>   * mon: some additional on-disk metadata to facilitate future mon
>>> changes
>>>     (post-bobtail)
>>>   * mon: throttle osd flapping based on osd history (limits osdmap
>>>     "thrashing" on overloaded or unhappy clusters)
>>>   * mon: new 'osd crush create-or-move ...' command
>>>   * radosgw: fix copy-object vs attributes
>>>   * radosgw: fix bug in bucket stat updates
>>>   * mds: fix ino release on abort session close, relative getattr
>>> path, mds
>>>     shutdown, other misc items
>>>   * upstart: stop jobs on shutdown
>>>   * common: thread pool sizes can now be adjusted at runtime
>>>   * build fixes for Fedora 18, CentOS/RHEL 6
>>>
>>> The big items are locking support in RBD, and OSD improvements like=
=20
>>> deep
>>> scrub (which verify object data across replicas) and backfill
>>> reservations
>>> (which limit load on expanding clusters). And a huge swath of bugfi=
xes
>>> and
>>> cleanups, many due to feeding the code through scan.coverity.com (t=
hey
>>> offer free static code analysis for open source projects).
>>>
>>> v0.54 is now frozen, and will include many deployment-related fixes
>>> (including a new ceph-deploy tool to replace mkcephfs), more=20
>>> bugfixes for
>>> libcephfs, ceph-fuse, and the MDS, and the fruits of some performan=
ce
>>> work
>>> on the OSD.
>>>
>>> You can get v0.53 from the usual locations:
>>>
>>>   * Git at git://github.com/ceph/ceph.git
>>>   * Tarball at http://ceph.com/download/ceph-0.53.tar.gz
>>>   * For Debian/Ubuntu packages, see
>>> http://ceph.com/docs/master/install/debian
>>>   * For RPMs, see http://ceph.com/docs/master/install/rpm
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
