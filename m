From: Mark Nelson <mnelson@redhat.com>
Subject: CBT: New RGW getput benchmark and testing diary
Date: Sun, 5 Feb 2017 23:55:20 -0600
Message-ID: <8700753c-8440-695e-d529-e83b0fb2ba90@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5840AEB503A5A34C769408C3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdBFFzW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Feb 2017 00:55:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "cbt@lists.ceph.com" <cbt@lists.ceph.com>
Cc: Mark Seger <mjseger@gmail.com>, Kyle Bader <kbader@redhat.com>, Karan Singh <karan@redhat.com>, Brent Compton <bcompton@redhat.com>

This is a multi-part message in MIME format.
--------------5840AEB503A5A34C769408C3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Over the weekend I took a stab at improving our ability to run RGW 
performance tests in CBT.  Previously the only way to do this was to use 
the cosbench plugin, which required a fair amount of additional
setup and while quite powerful can be overkill in situations where you 
want to rapidly iterate over tests looking for specific issues.  A while 
ago Mark Seger from HP told me he had created a swift benchmark called 
"getput" that is written in python and is much more convenient to run 
quickly in an automated fashion.  Normally getput is used in conjunction 
with gpsuite, a tool for coordinating benchmarking multiple getput 
processes.  This is how you would likely use getput on a typical ceph or 
swift cluster, but since CBT builds the cluster and has it's own way for 
launching multiple benchmark processes, it uses getput directly.

Thankfully it was fairly easy to implement a CBT getput wrapper. 
Several aspects of CBT's RGW support and user/key management were also 
improved to make the whole process of testing RGW completely automated 
via the CBT yaml file.  As part of the process of testing and debugging 
the new getput wrapper, I ran through a series of benchmarks and tests 
to investigate 4MB write performance anomalies previously reported in 
the field.  I wrote something of a diary while doing this and thought I 
would document it here for the community.  These were not extremely 
scientific tests, though I believe the findings are relevant and my be 
useful for folks.


Test Cluster Setup

The test cluster being used has 8 nodes, 4 of which are used for OSDs 
and 4 of which are being used for RGW and clients.  Each OSD node has 
the option to use any combination of 6 Seagate Constellation ES.2 
7200RPM HDDs and 4 Intel 800GB P3700 NVMe drives.  These machines also 
have dual Intel Xeon E5-2650v3 CPUs and Intel 40GbE ethernet adapters. 
In all of these tests, 1X replication was used to eliminate it as a 
bottleneck and put maximum pressure on RGW.  It should be noted that the 
spinning disks in this cluster are attached through motherboard SATA2 
ports, and may not be performing as well as if they were using a 
dedicated SAS controller.  A copy of the cbt yaml configuration file 
used to run the tests is attached.


Some Notes

When using getput as a benchmark for RGW, it's very important to keep 
track of the total number of getput processes and the number of RGW 
threads.  If the runtime option in getput is used, some processes may 
wait until RGW threads open up before they determine their runtime 
leading to skewed results.  I believe this can be resolved in getput by 
changing the way that donetime is calculated, however the issue can be 
avoided by paying close attention to the RGW thread and getput process 
counts.

It's easy to create the wrong pools for RGW since the defaults changed 
in Jewel.  Now we must create default.rgw.buckets.index and 
default.rgw.buckets.data.  It wasn't until I looked at disk usage via 
ceph df that I disovered that my .rgw.buckets and .rgw.buckets.index 
pools were not being used and thus resulted in some bogus initial 
performance data.


RGW with HDD backed OSDs (Filestore)

The first set of tests run were with a 4 node cluster configured with 24 
HDD backed OSDs.  Immediately the first thing I noticed is that the 
number of buckets and/or bucket hsards absolutely affects large 
sequential write performance on HDD backed OSDs.  Using a single bucket 
with no shards (ie the default) resulted in 220MB/s of write throughput 
while rados bench was able to achieve 550-600MB/s.  Both of these 
numbers are quite low, though are partially explained by the lack of SSD 
journals and lack of dedicated controller hardware.

Setting the number of bucket index shards to 8 improved the RGW write 
throughput to 400MB/s. The highest throughput for this setup was 
achieved by either setting the number of buckets or the number of bucket 
index shards substantially higher than the number of OSDs.  In this 
case, 64 appeared to be sufficient.  Three high concurrency 4MB Object 
RGW PUT tests showed results of 602MB/s, 557MB/s and 563MB/s.  3 rados 
bench runs using similar concurrency showed 580MB/s, 580MB/s, and 
564MB/s respectively.  Write IO from multiple clients appeared to cause 
a slight (~5%) performance drop vs write IO from a single client.  In 
all cases, tests were stopped prior to PG splitting.

It was observed that RGW uses high amounts of CPU, especially if low 
tcmalloc threadcache values are used.  With 32MB of threadcache, RGW 
used around 500-600% CPU to serve 500-600MB/s of 4MB writes. 
Occasionally it would spike into the 1000-1200% region.  Perf showed a 
high percentage of time in tcmalloc managing civetweb threads.  With 
128MB of thread cache, this effect was greatly diminished.  RGW appeared 
to use around 300-400% CPU to serve the same workload, though in these 
tests there was little performance impact as we were not CPU bound.


PG counts and PG splitting

Based on the bucket/shard results above, it may be inferred that a RGW 
index pool with very low PG counts could significantly hurt performance. 
  What about the case where small PG counts are used in the bucket.data 
pool?  In this case, PG splitting behavior might actually be more 
important than the effect of clumpiness in the random distribution due 
to low sample counts.  To test this, a buckets.index pool was created 
with 2048 PGs while the buckets.data pool was created with 128 PGs. 
Initial 4MB sequential writes with both rados bench and with RGW were 
about 20% slower than what was seen with 2048 PGs in the data pool, 
likely due to the worse data distribution properties.

While this is significant, I was more interested in the affects of PG 
splitting in filestore.  It has been observed in the past that PG 
splitting can have a huge performance impact, especially when SELinux is 
enabled. Selinux reads a security xattr on every file access which 
grealy impacts how quickly operations like link/unlink can be performed 
during PG splits. While SELinux is not enabled on this test cluster, PG 
splitting may still have other performance impacts due to worse dentry 
and inode caching and kernel overhead.  Rados bench was used to hit the 
thresholds by writing out a large number of 4K objects.

After approximately 1.3M objects were written, performance of 4K writes 
dropped by roughly an order of magnitude.  At this point rados bench and 
RGW were used to write out 4MB objects with high levels of concurrency 
and high numbers of bucket index shards.  In both cases, performance 
started out slightly diminished, but quickly increased to near levels 
observed on the fresh cluster.  At least in this setup, pg splitting in 
the data pool did not appear to majorly affect the performance of 4MB 
object writes, though may have affect the 4k object writes used to 
pre-fill the data pool.


RGW with OSDs using HDD Data and NVMe Journals (Filestore)

Next, 24 OSDs were configured with the filestore data partitions on HDD 
and journals on NVMe.  With minimal tuning rados bench delivered
around 1350MB/s or around 56MB/s per drive.  This is lower per drive 
than other configurations we've tested, but roughly double vs how the 
OSDs were performing wihtout NVMe journals.  Interestingly, the 
difference between using a single bucket with no shards and many 
buckets/shards appeared to be minimal.  Tests against a single bucket 
with no shards resulted in 1000-1400MB/s while a test configuration with 
128 buckets resulted in 1200-1400MB/s over several repeated tests.  It 
should be noted that the single RGW instance was using anywhere from 
1000-1600% CPU to maintain these numbers even with 128MB of TCMalloc 
threadcache!  Again a performance drop was seen when using multiple 
clients vs a single client.


RGW with NVMe data and journals (Filestore)

The test machines in this cluster have 4 Intel P3700 NVMe drives which 
are each capable of about 2GB/s each.  The cluster was again 
reconfigured with 16 OSDs backed by the NVMe drives.   In this case, a 
single client running radosbench with 128 concurrent ops could saturate 
the network and write data at about 4600MB/s.  4 clients however appear 
to be able to saturate the OSDs and achieve 11620MB/s.  A single getput 
client using 128 processes to write 4MB objects to a single bucket with 
no shards achieves 1700-1800MB/s.  Radosgw CPU usage hovered around 
1500-1700%. Using 128 buckets (1 bucket per process) yielded a variety 
of performance results ranging from 1700MB/s to 3500MB/s over multiple 
tests. Radosgw CPU usage appeared to top out around 2100%.  With 4 
clients, A single radosgw instance was able to maintain roughly 3700MB/s 
of writes over several independent tests despite using roughly the same 
amount of CPU as the single client tests.


Testing 4 gateways

CBT can stand up multiple rados gateways and launch tests against all of 
them concurrently.  4 clients were configured to drive traffic to all 4 
rados gateways and ultimately the 16 NVMe backed OSDs.  The first tests 
run resulted in 404 keynotfound errors, apparently because multiple 
copies of getput attempted to write into the same bucket.  This was 
resolved by making sure that each copy of getput being run had a 
distinct bucket (though getput processes did not require the same 
attention).  Thus, the lowest number of buckets targeted in this test 
was 16.  In this configuration, the aggregate write throughput across 
all 4 gateways was 9306MB/s.  With a bucket for every process (512 
total), the aggregate throughput increased to 9445MB/s.  This was 
roughly 2361MB/s per gateway and 81% of the rados bench throughput.


Next Steps and Conclusions

RGW is now roughly as easy to test in CBT as rados and rbd.  It should 
be far easier to examine bluestore performance with RGW now.  I hope we 
should be able to do some filestore and bluestore comparisons shortly. 
I will also note that I was quite happy with how well RGW handled large 
object writes in these tests.  Despite using a large amount of CPU 
overhead, I could achieve 3700MB/s with a single RGW instance and over 
9GB/s with 4 RGW instances.  Despite this, it's clear that performance 
is still quite dependent on bucket index update latency.  Especially on 
spinning disks, it appears to be very important to use bucket index 
sharding or spread write over many buckets.

Mark

--------------5840AEB503A5A34C769408C3
Content-Type: application/x-yaml;
 name="runtests.xfs.16.rgw.yaml"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="runtests.xfs.16.rgw.yaml"

Y2x1c3RlcjoKICB1c2VyOiAndWJ1bnR1JwogIGhlYWQ6ICJpbmNlcnRhMDEuZnJvbnQuc2Vw
aWEuY2VwaC5jb20iCiAgY2xpZW50czogWyJpbmNlcnRhMDUuZnJvbnQuc2VwaWEuY2VwaC5j
b20iLCAiaW5jZXJ0YTA2LmZyb250LnNlcGlhLmNlcGguY29tIiwgImluY2VydGEwNy5mcm9u
dC5zZXBpYS5jZXBoLmNvbSIsICJpbmNlcnRhMDguZnJvbnQuc2VwaWEuY2VwaC5jb20iXQog
IG9zZHM6IFsiaW5jZXJ0YTAxLmZyb250LnNlcGlhLmNlcGguY29tIiwgImluY2VydGEwMi5m
cm9udC5zZXBpYS5jZXBoLmNvbSIsICJpbmNlcnRhMDMuZnJvbnQuc2VwaWEuY2VwaC5jb20i
LCAiaW5jZXJ0YTA0LmZyb250LnNlcGlhLmNlcGguY29tIl0KICBtb25zOgogICAgaW5jZXJ0
YTAxLmZyb250LnNlcGlhLmNlcGguY29tOgogICAgICBhOiAiMTAuMC4xMC4xMDE6Njc4OSIK
CiAgcmd3czoKICAgIGluY2VydGEwNS5mcm9udC5zZXBpYS5jZXBoLmNvbToKICAgICAgY2xp
ZW50LnJhZG9zZ3cuZ2F0ZXdheTogCiAgICAgICAgaG9zdDogIjEwLjAuMTAuMTA1IgogICAg
aW5jZXJ0YTA2LmZyb250LnNlcGlhLmNlcGguY29tOgogICAgICBjbGllbnQucmFkb3Nndy5n
YXRld2F5OgogICAgICAgIGhvc3Q6ICIxMC4wLjEwLjEwNiIKICAgIGluY2VydGEwNy5mcm9u
dC5zZXBpYS5jZXBoLmNvbToKICAgICAgY2xpZW50LnJhZG9zZ3cuZ2F0ZXdheToKICAgICAg
ICBob3N0OiAiMTAuMC4xMC4xMDciCiAgICBpbmNlcnRhMDguZnJvbnQuc2VwaWEuY2VwaC5j
b206CiAgICAgIGNsaWVudC5yYWRvc2d3LmdhdGV3YXk6CiAgICAgICAgaG9zdDogIjEwLjAu
MTAuMTA4IgojICAgICAgICBwb3J0OiAiNzQ4MCIKIyAgICAgICAgc3NsX2NlcnRpZmljYXRl
OiAiL2V0Yy9jZXBoL3ByaXZhdGUva2V5YW5kY2VydC5wZW0iCgogIG9zZHNfcGVyX25vZGU6
IDQgCiAgZnM6ICd4ZnMnCiAgbWtmc19vcHRzOiAnLWYgLWkgc2l6ZT0yMDQ4JwogIG1vdW50
X29wdHM6ICctbyBpbm9kZTY0LG5vYXRpbWUsbG9nYnNpemU9MjU2aycKICBpdGVyYXRpb25z
OiAxCiAgdXNlX2V4aXN0aW5nOiBGYWxzZQogIGNsdXN0ZXJpZDogImNlcGgiCiAgdG1wX2Rp
cjogIi90bXAvY2J0IgogIGNlcGgtb3NkX2NtZDogImVudiAtaSBUQ01BTExPQ19NQVhfVE9U
QUxfVEhSRUFEX0NBQ0hFX0JZVEVTPTEzNDIxNzcyOCAvdXNyL2xvY2FsL2Jpbi9jZXBoLW9z
ZCIKICBjZXBoLW1vbl9jbWQ6ICIvdXNyL2xvY2FsL2Jpbi9jZXBoLW1vbiIKICBjZXBoLXJn
d19jbWQ6ICJlbnYgLWkgVENNQUxMT0NfTUFYX1RPVEFMX1RIUkVBRF9DQUNIRV9CWVRFUz0x
MzQyMTc3MjggL3Vzci9sb2NhbC9iaW4vcmFkb3NndyIKICBjZXBoLXJ1bl9jbWQ6ICIvdXNy
L2xvY2FsL2Jpbi9jZXBoLXJ1biIKICByYWRvc2d3LWFkbWluX2NtZDogIi91c3IvbG9jYWwv
YmluL3JhZG9zZ3ctYWRtaW4iCiAgcmFkb3NfY21kOiAiL3Vzci9sb2NhbC9iaW4vcmFkb3Mi
CiAgY2VwaF9jbWQ6ICIvdXNyL2xvY2FsL2Jpbi9jZXBoIgogIHJiZF9jbWQ6ICIvdXNyL2xv
Y2FsL2Jpbi9yYmQiCgojIGVyYXN1cmVfcHJvZmlsZXM6CiMgICAgZWM2MjoKIyAgICAgIGVy
YXN1cmVfazogNgojICAgICAgZXJhc3VyZV9tOiAyCgogIHBvb2xfcHJvZmlsZXM6CiAgICBy
YWRvc2JlbmNoOgogICAgICBwZ19zaXplOiAyMDQ4CiAgICAgIHBncF9zaXplOiAyMDQ4CiAg
ICAgIHJlcGxpY2F0aW9uOiAxCiMgICAgICByZXBsaWNhdGlvbjogJ2VyYXN1cmUnCiMgICAg
ICBlcmFzdXJlX3Byb2ZpbGU6ICdlYzYyJyAKCiAgICByZ3dfYnVja2V0c19kYXRhOgogICAg
ICBwZ19zaXplOiAyMDQ4IAogICAgICBwZ3Bfc2l6ZTogMjA0OAogICAgICByZXBsaWNhdGlv
bjogMQogICAgcmd3X2J1Y2tldHNfaW5kZXg6CiAgICAgIHBnX3NpemU6IDIwNDgKICAgICAg
cGdwX3NpemU6IDIwNDgKICAgICAgcmVwbGljYXRpb246IDEKICAgIHJiZDoKICAgICAgcGdf
c2l6ZTogODE5MiAKICAgICAgcGdwX3NpemU6IDgxOTIKICAgICAgcmVwbGljYXRpb246IDMK
CiAgcmd3X3Bvb2xzOgogICAgICBidWNrZXRzX2RhdGE6IHJnd19idWNrZXRzX2RhdGEKICAg
ICAgYnVja2V0c19pbmRleDogcmd3X2J1Y2tldHNfaW5kZXgKCmJlbmNobWFya3M6CiAgZ2V0
cHV0OgogICAgcnVudGltZTogMzAwCiAgICBvcF9zaXplOiBbNDE5NDMwNF0KICAgIHByb2Nz
OiAzMiAKICAgIHRlc3RzOiBbJ3AnXQogICAgY21kX3BhdGg6ICcvaG9tZS91YnVudHUvc3Jj
L21hcmtocGMvZ2V0cHV0L2dldHB1dCcKICAgIGN0eXBlOiAnYnlwcm9jJwojICAgIGxvZ29w
czogMwojICByYWRvc2JlbmNoOgojICAgIG9wX3NpemU6IFs0MTk0MzA0XQojICAgIHdyaXRl
X29ubHk6IFRydWUKIyAgICB0aW1lOiAzMDAKIyAgICBjb25jdXJyZW50X29wczogWzMyXQoj
ICAgIGNvbmN1cnJlbnRfcHJvY3M6IDQgCiMgICAgb3NkX3JhOiBbNDA5Nl0KIyAgICBwb29s
X3Byb2ZpbGU6ICdyYWRvc2JlbmNoJwo=
--------------5840AEB503A5A34C769408C3--
