From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Adding Data-At-Rest compression support to Ceph
Date: Tue, 22 Sep 2015 20:04:05 +0300
Message-ID: <56018A05.6090100@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:32973 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbIVREI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 13:04:08 -0400
Received: by lamp12 with SMTP id p12so19990968lam.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 10:04:06 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id ku11sm320795lac.8.2015.09.22.10.04.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2015 10:04:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi guys,

I can find some talks about adding compression support to Ceph. Let me=20
share some thoughts and proposals on that too.

=46irst of all I=E2=80=99d like to consider several major implementatio=
n options=20
separately. IMHO this makes sense since they have different=20
applicability, value and implementation specifics. Besides that less=20
parts are easier for both understanding and implementation.

   * Data-At-Rest Compression. This is about compressing basic data=20
volume kept by the Ceph backing tier. The main reason for that is data=20
store costs reduction. One can find similar approach introduced by=20
Erasure Coding Pool implementation - cluster capacity increases (i.e.=20
storage cost reduces) at the expense of additional computations. This i=
s=20
especially effective when combined with the high-performance cache tier=
=2E
   *  Intermediate Data Compression. This case is about applying=20
compression for intermediate data like system journals, caches etc. The=
=20
intention is to improve expensive storage resource  utilization (e.g.=20
solid state drives or RAM ). At the same time the idea to apply=20
compression ( feature that undoubtedly introduces additional overhead )=
=20
to the crucial heavy-duty components probably looks contradictory.
   *  Exchange Data =D0=A1ompression. This one to be applied to message=
s=20
transported between client and storage cluster components as well as=20
internal cluster traffic. The rationale for that might be the desire to=
=20
improve cluster run-time characteristics, e.g. limited data bandwidth=20
caused by the network or storage devices throughput. The potential=20
drawback is client overburdening - client computation resources might=20
become a bottleneck since they take most of compression/decompression t=
asks.

Obviously it would be great to have support for all the above cases,=20
e.g. object compression takes place at the client and cluster component=
s=20
handle that naturally during the object life-cycle. Unfortunately=20
significant  complexities arise on this way. Most of them are related t=
o=20
partial object access, both reading and writing. It looks like huge=20
development ( redesigning, refactoring and new code development ) and=20
testing efforts are required on this way. It=E2=80=99s hard to estimate=
 the=20
value of such aggregated support at the current moment too.
Thus the approach I=E2=80=99m suggesting is to drive the progress event=
ually and=20
consider cases separately. At the moment my proposal is to add=20
Data-At-Rest compression to Erasure Coded pools as the most definite on=
e=20
from both implementation and value points of view.

How we can do that.

Ceph Cluster Architecture suggests two-tier storage model for productio=
n=20
usage. Cache tier built on high-performance expensive storage devices=20
provides performance. Storage tier with low-cost less-efficient devices=
=20
provides cost-effectiveness and capacity. Cache tier is supposed to use=
=20
ordinary data replication while storage one can use erasure coding (EC)=
=20
for effective and reliable data keeping. EC provides less store costs=20
with the same reliability comparing to data replication approach at the=
=20
expenses of additional computations. Thus Ceph already has some trade=20
off between capacity and computation efforts. Actually Data-At-Rest=20
compression is exactly about the same. Moreover one can tie EC and=20
Data-At-Rest compression together to achieve even better storage=20
effectiveness.
There are two possible ways on adding Data-At-Rest compression:
   *  Use data compression built into a file system beyond the Ceph.
   *  Add compression to Ceph OSD.

At first glance Option 1. looks pretty attractive but there are some=20
drawbacks for this approach. Here they are:
   *  File System lock-in. BTRFS is the only file system supporting=20
transparent compression among ones recommended for Ceph usage.        =20
          Moreover AFAIK it=E2=80=99s still not recommended for product=
ion=20
usage, see:
http://ceph.com/docs/master/rados/configuration/filesystem-recommendati=
ons/
    *  Limited flexibility - one can use compression methods and=20
policies supported by FS only.
    *  Data compression depends on volume or mount point properties (an=
d=20
is bound to OSD). Without additional support Ceph lacks the ability to=20
have different compression policies for different pools residing at the=
=20
same OSD.
    *  File Compression Control isn=E2=80=99t standardized among file s=
ystems.=20
If (or when) new compression-equipped File System appears Ceph might=20
require corresponding changes to handle that properly.

Having compression at OSD helps to eliminate these drawbacks.
As mentioned above Data-At-Rest compression purposes are pretty the sam=
e=20
as for Erasure Coding. It looks quite easy to add compression support t=
o=20
EC pools. This way one can have even more storage space for higher CPU =
load.
Additional Pros for combining compression and erasure coding are:
   *  Both EC and compression have complexities in partial writing. EC=20
pools don=E2=80=99t have partial write support (data append only) and t=
he=20
solution for that is cache tier insertion.  Thus we can transparently=20
reuse the same approach in case of compression.
   *  Compression becomes a pool property thus Ceph users will have=20
direct control what pools to apply compression with.
   *  Original write performance isn=E2=80=99t impacted by the compress=
ion for=20
two-tier model - write data goes to the cache uncompressed and there is=
=20
no corresponding compression latency. Actual compression happens in=20
background when backing storage filling takes place.
   *  There is an additional benefit in network bandwidth saving when=20
primary OSD performs a compression as resulting object shards for=20
replication are less.
   *  Data-at-rest compression can also bring an additional performance=
=20
improvement for HDD-based storage. Reducing the amount of data written=20
to slow media can provide a net performance improvement even taking int=
o=20
account the compression overhead.

Some implementation notes:

The suggested approach is to perform data compression prior to Erasure=20
Coding to reduce data portion passed to coding and avoid the need to=20
introduce additional means to disable EC-generated chunks compression.
Data-At-Rest compression should support plugin architecture to enable=20
multiple compression backends.
Compression engine should mark stored objects with some tags to indicat=
e=20
if compression took place and what algorithm was used.
To avoid (reduce) backing storage CPU overload caused by=20
compression/decompression ( e.g. this can happen during massive reads )=
=20
we can introduce additional means to detect such situations and=20
temporary disable compression for current write requests. Since there i=
s=20
way to mark objects as compressed/uncompressed this produces almost no=20
issues for future handling. Hardware compression support usage, e.g.=20
Intel QuickAssist can be an additional helper for this issue.

Any thoughts?

Thanks,
Igor.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
