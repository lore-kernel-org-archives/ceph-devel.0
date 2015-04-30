From: Luis Pabon <lpabon@redhat.com>
Subject: Pblio - Enterprise OLTP workload generator
Date: Thu, 30 Apr 2015 14:49:07 -0400 (EDT)
Message-ID: <449267284.9324911.1430419747132.JavaMail.zimbra@redhat.com>
References: <1619860483.9322601.1430419037360.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:49296 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbD3StI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 14:49:08 -0400
In-Reply-To: <1619860483.9322601.1430419037360.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "gluster-devel@gluster.org >> Gluster Devel" <gluster-devel@gluster.org>

Hi all,
   A while back I sent a message describing my investigation of NetApp's
a SPC-1-like workload generator.  I wanted to let you know that pblio,
an enterprise OLTP workload generator, is now available for use.

Documentation:  https://github.com/pblcache/pblcache/wiki/Pblio
Download:   https://github.com/pblcache/pblcache/releases
Presentation:  http://redhat.slides.com/lpabon/deck-4#/20

I used pblio to understand the behavior of client side caching and 
presented these finding at Vault.

Currently, pblio does not have direct support for librbd, so to use with Ceph,
you would need to create a VM with RBD volumes attached and run pblio inside it.

Let me know if you have any questions.

- Luis

------------------------------------------------------------------------


 From the wiki:

# Pblio

## Introduction
Pblio is a synthetic OLTP enterprise workload used to stress storage 
systems. This benchmark will stress a storage
system to determine the maximum number of IOPS it can manage before
having a mean response latency of 30 milliseconds or greater.

Pblio uses the open source NetApp workload generator described in their 
published paper. The workload generator from NetApp only describes 
where, when, and how much data should be written, but it needs
pblio to actually send and receive data from the storage devices.

### Application Storage Units
Pblio requires the storage system to be logically divided into three
application storage units (ASUs). Each ASU has different I/O 
characteristics and
requirements. ASU1, called _Data Store_, must be 45% of the total 
storage and
will be used for read and write I/O. ASU2, called the _User Store_, must 
also be
45% of the total storage and will be used for read and write I/O. ASU3, 
called
_Log_, must be 10% of the total storage and will only be used for sequential
writes. Each ASU can be composed of a single or multiple files or raw 
devices.
For simplicity, if any of the objects are larger than needed, pblio will
automatically adjust the usable storage size of each object so as to comply
with the ASU size requirements.

### Business Scaling Units
Business scaling units (BSUs), where every BSU equals 50 IOPS, are used by
pblio to determine how many IOPS to expect from the storage system. 
Pblio will
use this value to test if the storage system can handle the requested 
number of
IOPS with a total latency of less than 30 ms.

## Usage Guide

### Quick Start

Sometimes the best way to learn is by trying it out. First you need to 
download
pblio from [Pblcache 
Releases](https://github.com/pblcache/pblcache/releases). There are no 
dependencies (thanks to Go!).

First you will be using pblio without using pblcache.  Pblio can be run 
with or without pblcache.

Create a file for each ASU. In the example below, you will create 
`file1` and`file2` to
be 45MB as they are 45% of the total storage. `file3` is set to 10MB or 
10% of
total size.

```
$ fallocate -l 45MiB file1
$ fallocate -l 45MiB file2
$ fallocate -l 10MiB file3
```

Once the files are created, you can then run pblio:

```
$ ./pblio -asu1=file1 -asu2=file2 -asu3=file3 \
           -runlen=30 -bsu=2
-----
pblio
-----
Cache   : None
ASU1    : 0.04 GB
ASU2    : 0.04 GB
ASU3    : 0.01 GB
BSUs    : 2
Contexts: 1
Run time: 30 s
-----
Avg IOPS:98.63  Avg Latency:0.2895 ms
```

 From the output above, the benchmark will run for 30 seconds. The value 
of BSU was
set to 2, therefore 100 IOPS will be requested from the storage system, 
and the average total latency for
was found to be 289.5 microseconds.

Pblio also supports multiple devices per ASU.  Here is an example of 
using pblio with 12 raw disks:

```
$ ./pblio -asu1=/dev/sdb,/dev/sdc,/dev/sdd,/dev/sde \
           -asu2=/dev/sdf,/dev/sdg,/dev/sdh,/dev/sdi \
           -asu3=/dev/sdj,/dev/sdk,/dev/sdl,/dev/sdm \
           -runlen=30 -bsu=2
...
```

 > NOTE: pblio will write to the devices given which will overwrite any 
saved data on the device.

#### Enabling pblcache in pblio
Now, we can create another example run, but this time with the pblcache 
enabled.

```
$ fallocate -l 10MiB mycache
$ ./pblio -asu1=file1 -asu2=file2 -asu3=file3 \
           -runlen=30 -bsu=2 -cache=mycache
-----
pblio
-----
Cache   : mycache (New)
C Size  : 0.01 GB
ASU1    : 0.04 GB
ASU2    : 0.04 GB
ASU3    : 0.01 GB
BSUs    : 2
Contexts: 1
Run time: 30 s
-----
Avg IOPS:98.63  Avg Latency:0.2573 ms

Read Hit Rate: 0.4457
Invalidate Hit Rate: 0.6764
Read hits: 1120
Invalidate hits: 347
Reads: 2513
Insertions: 1906
Evictions: 0
Invalidations: 513
== Log Information ==
Ram Hit Rate: 1.0000
Ram Hits: 1120
Buffer Hit Rate: 0.0000
Buffer Hits: 0
Storage Hits: 0
Wraps: 1
Segments Skipped: 0
Mean Read Latency: 0.00 usec
Mean Segment Read Latency: 4396.77 usec
Mean Write Latency: 1162.58 usec
```

When the run finishes, it the final statistics are shown. A file called (by
default) `cache.pbl` is created which holds the cache metadata. Running 
pblio
again will notice that `cache.pbl` is there and load it:

```
$ ./pblio.go -asu1=file1 -asu2=file2 -asu3=file3 \
              -runlen=30 -bsu=2 -cache=mycache
-----
pblio
-----
Cache   : mycache (Loaded)
C Size  : 0.01 GB
ASU1    : 0.04 GB
ASU2    : 0.04 GB
ASU3    : 0.01 GB
BSUs    : 2
Contexts: 1
Run time: 30 s
-----
Avg IOPS:98.64  Avg Latency:3.6283 ms

Read Hit Rate: 1.0000
Invalidate Hit Rate: 1.0000
Read hits: 2513
Invalidate hits: 513
Reads: 2513
Insertions: 513
Evictions: 0
Invalidations: 513
== Log Information ==
Ram Hit Rate: 1.0000
Ram Hits: 2513
Buffer Hit Rate: 0.0000
Buffer Hits: 0
Storage Hits: 0
Wraps: 1
Segments Skipped: 0
Mean Read Latency: 0.00 usec
Mean Segment Read Latency: 24755.33 usec
Mean Write Latency: 1174.28 usec
```

#### Statistics
Pblio saves benchmark data in a file (default `pblio.data`) as JSON 
format. You can use the file `pblioplot.py` located in `apps/pblio` to 
create graphs using [RRDtool](http://oss.oetiker.ch/rrdtool/) as follows:

 > NOTE: You will need to install `rrdtool` to use `pblioplot.py`

```
$ ./pblioplot.py pblio.data
```

Where `pblio.data` is the statistics file created by the pblio 
benchmark.  You may need to adjust `pblioplot.py` if you have changed 
the _dataperiod_ time in `pblio`.

Here are some sample graphs for a 24-hour benchmark run:

https://github.com/pblcache/pblcache/wiki/images/sample_tlat.png


## Running The Benchmark
To run pblio you will need to plan out how you will be benchmarking your 
storage system.  It is normally a good idea to set each of the ASUs be 
on different devices, especially ASU3, since it will only be receiving 
writes.

Once you have configured your storage system and are ready to run pblio, 
you should run pblio against your storage system as long as needed to 
warmup the storage cache.  You may want to use a BSU value of 10 and 
adjust accordingly. In my runs, I needed to run pblio for 24 hours to 
warmup pblcache before starting to test for IOPS capacity.

After you are satisfied that the system has been warmed up, you can now 
start testing.  Starting at BSU=1, run pblio against your system for 10 
minutes.  Repeat, increasing BSU by one each time, until the latency is 
greater than 30 ms.  The value of BSU which causes the storage system to 
have a total latency larger than 30 ms is the maximum number of IOPS 
maintained for your system for this workload.

## Help Screen

```
$ ./pblio -help
Usage of pblio:
   -asu1="":
     ASU1 - Data Store. Comma separated list of devices
   -asu2="":
     ASU2 - User Store. Comma separated list of devices
   -asu3="":
     ASU3 - Log. Comma separated list of devices
   -bsu=50:
     Number of BSUs (Business Scaling Units).
     Each BSU requires 50 IOPs from the back end storage
   -cache="":
     Cache device
   -cachemeta="cache.pbl":
     Persistent cache metadata location
   -cpuprofile=false:
     Create a Go cpu profile for analysis
   -data="pblio.data":
     Stats file
   -dataperiod=60:
     Number of seconds per data collected and saved in the stats file
   -directio=true:
     Use O_DIRECT on ASU files
   -runlen=300:
     Benchmark run time length in seconds
exit status 2

```

- Luis
