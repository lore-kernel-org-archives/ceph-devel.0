From: Gregory Farnum <gfarnum@redhat.com>
Subject: CephFS development since Firefly
Date: Mon, 20 Apr 2015 17:26:25 -0700
Message-ID: <D2C06317-F79A-49E9-B40E-2AEF76E834F0@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbbDUA01 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2015 20:26:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

We=E2=80=99ve been hard at work on CephFS over the last year since Fire=
fly was released, and with Hammer coming out it seemed like a good time=
 to go over some of the big developments users will find interesting. M=
uch of this is cribbed from John=E2=80=99s Linux Vault talk (http://eve=
nts.linuxfoundation.org/sites/events/files/slides/CephFS-Vault.pdf), in=
 addition to the release notes (http://ceph.com/docs/master/release-not=
es/).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
New Filesystem features & improvements:

ceph-fuse has gained support for fcntl and flock locking. (Yan, Zheng) =
This has been in the kernel for a while but nobody had done the work to=
 implement tracking structures and wire it up in userspace.

ceph-fuse has gained support for soft quotas, enforced on the client si=
de. (Yunchuan Wen) The Ubuntu Kylin guys worked on this for quite a whi=
le and we thank them for their work and their patience. You can now spe=
cify soft quotas on a directory and ceph-fuse will behave as you=E2=80=99=
d expect from that.

Hadoop support has been generally improved and updated. (Noah Watkins, =
Huamin Chen) It now works against the 2.0 API, the tests we run in our =
lab are more sophisticated, and it=E2=80=99s a lot friendlier to instal=
l with Maven and other Java tools. Noah=E2=80=99s still doing work on t=
his to make it as turnkey as possible, but soon you=E2=80=99ll just nee=
d to drop a single JAR on the system (this will include the libcephfs s=
tuff, so you don=E2=80=99t even need to worry about those packages and =
compatibility!) and change a few config options.

ceph-fuse and CephFS as a whole now have much-improved full space handl=
ing. If you run out of space at the RADOS layer you will get ENOSPC err=
ors in the client (instead of it retrying indefinitely), and these erro=
rs (and others) are now propagated out to fsync and fclose calls.

We are now much more consistent in our handling of timestamps. Previous=
ly we attempted to take the time from whichever process was responsible=
 for making a change, which could be either a client or the MDS. But th=
is was troublesome if their times weren=E2=80=99t synced =E2=80=94 made=
 worse by trying not to let the time move backwards =E2=80=94 and some =
applications which relied on sharing mtime and ctime values as versions=
 (Hadoop and rsync both did this in certain configurations) were unhapp=
y. We now use a timestamp provided by the client for all operations, wh=
ich has been more stable.

Certain internal data structures are now much more scalable on a per-cl=
ient level. We had issues when certain =E2=80=9CMDSTables=E2=80=9D got =
too large, but John Spray sorted them out.

The reconnect phase, when an MDS is restarted or dies and the clients h=
ave to connect to a different daemon, has been made much faster in the =
typical case. (Yan, Zheng)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Administrator features & improvements:

The MDS has gained an OpTracker, with functionality similar to that in =
the OSD. You can dump in-flight requests and notably slow ones from the=
 recent past. The changes to enable this also made working with many co=
de paths a lot easier.

We=E2=80=99ve changed how you create and manage CephFS file systems in =
a cluster. (John Spray) The =E2=80=9Cdata=E2=80=9D and =E2=80=9Cmetadat=
a=E2=80=9D pools are no longer created by default, and the management i=
s done via monitor commands that start with =E2=80=9Cceph fs=E2=80=9D (=
eg, =E2=80=9Cceph fs new=E2=80=9D). These have been designed with futur=
e extensions in mind, but for now they mostly replicate existing featur=
es with more consistency and improved repeatability/idempotency.

The MDS now reports on a variety of health metrics to the monitor, join=
ing the existing OSD and monitor health reports. These include informat=
ion on misbehaving clients and MDS data structures. (John Spray)

The MDS admin socket now includes a bunch of new commands. You can exam=
ine and evict client sessions, plus do things around filesystem repair =
(see below).

The MDS now gathers metadata from the clients about who they are and sh=
ares that with users via a variety of helpful interfaces and warning me=
ssages. (John Spray)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Recovery tools

We have a new MDS journal format and a new cephfs-journal-tool. (John S=
pray) This eliminates the days of needing to hexedit a journal dump in =
order to let your MDS start back up =E2=80=94 you can inspect the journ=
al state (human-readable or json, great for our testing!) and make chan=
ges on a per-event level. It also includes the ability to scan through =
hopelessly broken journals and parse out whatever data is available for=
 flushing to the backing RADOS objects.
Similarly, there=E2=80=99s a cephfs-table-tool for working with the Ses=
sionTable, InoTable, and SnapTable. (John Spray)

We=E2=80=99ve added new =E2=80=9Cscrub_path=E2=80=9D and =E2=80=9Cflush=
_path=E2=80=9D commands to the admin socket. These are fairly limited r=
ight now but will check that both directories and files are self-consis=
tent. It=E2=80=99s a building block for the "forward scrub" and fsck fe=
atures that I=E2=80=99ve been working on, and includes a lot of code-le=
vel work to enable those.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Performance improvements

Both the kernel and userspace clients are a lot more efficient with som=
e of their =E2=80=9Ccapability=E2=80=9D and directory content handling.=
 This lets them serve a lot more out of local cache, a lot more often, =
than they were able to previously. This is particularly noticeable in w=
orkloads where a single client =E2=80=9Cowned=E2=80=9D a directory but =
another client periodically peeked in on it.
There are also a bunch of extra improvements in this area that have gon=
e in since Hammer and will be released in Infernalis. ;)

The code in the MDS that handles the journaling has been split into a s=
eparate thread. (Yan, Zheng) This has increased maximum throughput a fa=
ir bit and is the first major improvement enabled by John=E2=80=99s wor=
k to start breaking down the big MDS lock. (We still have a big MDS loc=
k, but in addition to the journal it no longer covers the Objecter. Set=
ting up the interfaces to make that manageable should make future lock =
sharding and changes a lot simpler than they would have been previously=
=2E)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Developer & test improvements

In addition to a slightly expanded set of black-box tests, we are now t=
esting FS behaviors to make sure everything behaves as expected in spec=
ific scenarios (failure and otherwise). This is largely thanks to John,=
 but we=E2=80=99re doing more with it in general as we add features tha=
t can be tested this way.

As alluded to in previous sections, we=E2=80=99ve done a lot of work th=
at makes the MDS codebase a lot easier to work with. Interfaces, if not=
 exactly bright and shining, are a lot cleaner than they used to be. Lo=
cking is a lot more explicit and easier to reason about in many places.=
 There are fewer special paths for specific kinds of operations, and a =
lot more shared paths that everything goes through =E2=80=94 which mean=
s we have more invariants we can assume on every operation.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Notable bug reductions

Although we continue to leave snapshots disabled by default and don=E2=80=
=99t recommend multi-MDS systems, both of these have been *dramatically=
* improved by Zheng=E2=80=99s hard work. Our multimds suite now passes =
almost all of the existing tests, whereas it previously failed most of =
them (http://pulpito.ceph.com/?suite=3Dmultimds). Our snapshot tests pa=
ss reliably and using them is no longer a shortcut to breaking your sys=
tem, and bugs are less likely to leave your entire filesystem inaccessi=
ble.


There=E2=80=99s a lot more I haven=E2=80=99t discussed above, like how =
the entire stack is a lot more tolerant of failures elsewhere than it u=
sed to be and so bugs are less likely to make your entire filesystem in=
accessible. But those are some of the biggest features and improvements=
 that users are likely to notice or might have been waiting on before t=
hey decided to test it out. It=E2=80=99s nice to reflect occasionally =E2=
=80=94 I knew we were getting a lot done, but this list is much longer =
than I=E2=80=99d initially thought it would be!
-Greg--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
