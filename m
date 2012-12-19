From: Ugis <ugis22@gmail.com>
Subject: rbd kernel module crashes with different kernels
Date: Thu, 20 Dec 2012 01:17:43 +0200
Message-ID: <CAE63xUPhEy96cDSjhzk+DiRQ_bijNG3Pquj_1BW2NRqbjMp9dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:54618 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab2LSXZT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 18:25:19 -0500
Received: by mail-ob0-f182.google.com with SMTP id 16so2676180obc.13
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 15:25:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I have been struggling to map ceph rbd images for last week, but
constantly get kernel crashes.

What has been done:
Previously we had v0.48 set up as test cluster(4 hosts, 5 osds, 3
mons, 3 mds, custom crushmap) on Ubuntu 12.04 and client Ubuntu
Precise for mapping rbd+iscsi export, can't remember exact kernel
version when crashes appeared. At some point it was no longer possible
to map rbd images - on command "rbd map..." machine just crashed with
lots of dumped info on screen. Same rbd map commands that worked
before started to crash kernel at some point.

I red some advices on list to use kernels 3.4.20. or 3.6.7. as those
should have all known rbd module bugs fixed. I used one of those(I
believe 3.6.7.) and managed to map rbd images again for couple of
days. Then I discovered slow disk I/O on one host and removed OSD from
it and moved that OSD to other new host(following doc.). For time of
doing this rbd images were mapped. As I was busy moving osd I didn't
notice moment when client crashed again, but I think that was some
time after cluster had already recovered from degraded state after
adding new osd.
After this point I could not map rbd images from client no more - on
command "rbd map..." system just crashed. Reboots after crash did not
help.
I installed fresh Ubuntu Precise+3.6.7. kernel on spare box, crushes
remained, then set up VM with Ubuntu Precise + tried kernels mentioned
below and still got 100% crashes on "rbd map..." command.

Well, those are blurry memories of problem history, but during last
days I tried to solve problem by updating all possible components - it
did not help neither unfortunately.

What I have tried:
I completely removed demo cluster data(dd over osd data partitions,
journal partitions, rm for rest files, purged+upgraded ceph packages
to ceph version 0.55.1(8e25c8d984f9258644389a18997ec6bdef8e056b)) as
update was planned anyway. So ceph is now 0.55.1 on Ubuntu 12.04+xfs
for osds.
Then I compiled kernels 3.4.20, 3.4.24, 3.6.7, 3.7.1 for client and
tried to map rbd image - constant crash with all versions.

Interesting part about map command itself - as I installed new rbd
client box and  VM  I copy/pasted "rbd map.." commands that worked at
very beginning to these machines.
Command was "rbd map fileserver/testimage  -k /etc/ceph/ceph.keyring",
but this command still crashes kernel even now when there is no rbd
"testimage"(I recreated pool "fileserver").
Crash happens on command "rbd map notexistantpool/testimage  -k
/etc/ceph/ceph.keyring" as well. Could that be some issue with
backward compatibility as mapping like this was done on versions ago.

Then I decided to try different mapping syntax. Some intro+results:
# rados lspools
data
metadata
rbd
fileserver

# rbd ls -l
NAME             SIZE PARENT FMT PROT LOCK
testimage1_10G 10000M          1

# rbd ls -l --pool fileserver
rbd: pool fileserver doesn't contain rbd images

well, I do not understand what in doc
(http://ceph.com/docs/master/rbd/rbd-ko/) is meant by "myimage" so I
am ommiting that part, but in no way kernel should crash if wrongly
passed command has been given.
Excerpt from doc:
sudo rbd map foo --pool rbd myimage --id admin --keyring /path/to/keyring
sudo rbd map foo --pool rbd myimage --id admin --keyfile /path/to/file

My commands:
"rbd map testimage1_10G --pool rbd --id admin --keyring
/etc/ceph/ceph.keyring" -> crash
"rbd map testimage1_10G --pool rbd --id admin --keyfile
/tmp/secret"(only key extracted from keyring and writen to
/tmp/secret) -> crash

As crashes happen in client side and are immediate - I have no logs
about it. I can post screenshots from console when crash happens, but
they all are almost the same, containing strings:
"Stack: ...
Call Trace:...
Fixing recursive fault but reboot is needed!"

Also, when VM crashes - virtualization still shows high CPU
load(probably some loop?)
I tried default and custom CRUSH maps, but crashes are the same.

If anyone could advice how to get out of this magic compile
kernel->"rbd map.."->crash cycle - I would be happy :)
Probaby someone can reproduce crashes with similar commands? If I can
send any additional valuable info to track down the problem - please
let me know what is needed.

BR,
Ugis
