From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Fri, 01 May 2015 09:48:30 -0500
Message-ID: <5543923E.1020607@redhat.com>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>, <55422E0A.6010204@redhat.com> <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com> <554237F8.5070907@redhat.com> <alpine.DEB.2.00.1504301107310.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55256 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbbEAOsd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 May 2015 10:48:33 -0400
In-Reply-To: <alpine.DEB.2.00.1504301107310.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/30/2015 01:09 PM, Sage Weil wrote:
> On Thu, 30 Apr 2015, Mark Nelson wrote:
>> On 04/30/2015 09:02 AM, Chen, Xiaoxi wrote:
>>> I am not sure I really understand the osd code, but from the osd log,  in
>>> the sequential small write case, only one inflight op happening?
>>>
>>> and Mark, did you pre-allocate the rbd before doing sequential test? I
>>> believe you did, so both seq and random are in WAL mode.
>>
>> Yes, the RBD image is pre-allocated.  Maybe Sage can chime in regarding the
>> one inflight op.
>
> I'm not sure why that would happen.  :/  How are you generating the
> client workload?
>

So I spent some time last night and this morning looking at the blktrace 
data for the 4k writes and random writes with WAL enabled vs WAL 
disabled from the fio tests I ran.  Again, these are writing to 
pre-allocated RBD volumes using fio's librbd engine.  First, let me 
relink the fio output:

http://nhm.ceph.com/newstore/Newstore_DisableWAL.pdf

Now to the blkparse data:

1) First 4K sequential writes with WAL enabled

  65,98  23    16685   299.949350592     0  C  WS 987486832 + 8 [0]
  65,98  23    16686   299.949368012     0  C  WS 506480736 + 24 [0]
  65,98  14     2360   299.962768962     0  C  WS 0 [0]
  65,98  23    16691   299.974361401     0  C  WS 506480752 + 16 [0]
  65,98  20     3027   299.974390473     0  C  WS 987486840 + 8 [0]
  65,98   1     3024   299.987774998     0  C  WS 0 [0]
  65,98  19    14351   299.999283821     0  C  WS 987486848 + 8 [0]
  65,98  19    14355   299.999485481     0  C  WS 506480760 + 24 [0]
  65,98  11    35231   300.012809485     0  C  WS 0 [0]


In the above snippet looking just at IO completion, the following 
pattern shows up during most of the tests:

Offset1 + 8 sector write
Offset2 + 24 sector write
13.4 ms passes
sync
11.6 ms passes
(Offset2+24) + 16 sector write
(Offset1 + 8) + 8 sector write
13.4 ms passes
sync
11.5 ms passes
...

Corresponding performance from the client looks awful.  Even though each 
sequence of writes are near the previous ones (either offset1 or 
offset2) the syncs break everything up and IOs can't get coalesced. 
Seekwatcher shows that we are seek bound with low write performance:

http://nhm.ceph.com/newstore/newstore-4kcompare/write-no_overlay.png


2) Now let's look at 4k sequential writes with WAL disabled

  65,98   0   240834   106.619823415     0  C  WS 1023518280 + 336 [0]
  65,98   5   247024   106.619951276     0  C  WS 1023518672 + 8 [0]
  65,98  22    15236   106.620066459     0  C  WS 1023518616 + 8 [0]
  65,98  16    56941   106.620218013     0  C  WS 1023518624 + 8 [0]
  65,98   5   247028   106.620285799     0  C  WS 1023518632 + 8 [0]
  65,98   0   240962   106.620429464     0  C  WS 1023518640 + 8 [0]
  65,98   0   240966   106.620511011     0  C  WS 1023518648 + 8 [0]
  65,98  11   118842   106.620623999     0  C  WS 1023518656 + 8 [0]
  65,98   0   240970   106.620679708     0  C  WS 1023518664 + 8 [0]
  65,98  10   176487   106.620841586     0  C  WS 1023518680 + 8 [0]
  65,98  16    56953   106.621014772     0  C  WS 1023518688 + 8 [0]
  65,98   0   240974   106.621220848     0  C  WS 1023518696 + 8 [0]
  65,98   0   240977   106.621356662     0  C  WS 1023518704 + 8 [0]
  65,98   2   442988   106.621434274     0  C  WS 1023518712 + 8 [0]
  65,98  11   118847   106.621595007     0  C  WS 1023518720 + 8 [0]
  65,98   0   240981   106.621751495     0  C  WS 1023518728 + 8 [0]
  65,98   0   240986   106.621851059     0  C  WS 1023518736 + 8 [0]
  65,98  10   176492   106.622023419     0  C  WS 1023518744 + 8 [0]
  65,98  16    56958   106.622110615     0  C  WS 1023518752 + 8 [0]
  65,98   0   240989   106.622219993     0  C  WS 1023518760 + 8 [0]
  65,98   0   240992   106.622346208     0  C  WS 1023518768 + 8 [0]
  65,98   9    82616   106.635362498     0  C  WS 0 [0]
  65,98   9    82617   106.635375456     0  C  WS 0 [0]
  65,98   9    82618   106.635380562     0  C  WS 0 [0]
  65,98   9    82619   106.635383740     0  C  WS 0 [0]
  65,98   9    82620   106.635387332     0  C  WS 0 [0]
  65,98   9    82621   106.635390764     0  C  WS 0 [0]
  65,98   9    82622   106.635392820     0  C  WS 0 [0]
  65,98   9    82623   106.635394784     0  C  WS 0 [0]
  65,98   9    82624   106.635397124     0  C  WS 0 [0]
  65,98   9    82625   106.635399943     0  C  WS 0 [0]
  65,98   9    82626   106.635402499     0  C  WS 0 [0]
  65,98   9    82627   106.635404467     0  C  WS 0 [0]
  65,98   9    82628   106.635406529     0  C  WS 0 [0]
  65,98   9    82629   106.635408483     0  C  WS 0 [0]
  65,98   9    82630   106.635410587     0  C  WS 0 [0]
  65,98   9    82631   106.635412247     0  C  WS 0 [0]
  65,98   9    82632   106.635413967     0  C  WS 0 [0]
  65,98   9    82633   106.635415899     0  C  WS 0 [0]
  65,98   9    82634   106.635417967     0  C  WS 0 [0]
  65,98   9    82635   106.635420009     0  C  WS 0 [0]
  65,98   9    82636   106.635422023     0  C  WS 0 [0]
  65,98   9    82637   106.635424223     0  C  WS 0 [0]
  65,98   9    82638   106.635426137     0  C  WS 0 [0]
  65,98   9    82639   106.635427517     0  C  WS 0 [0]
  65,98   9    82640   106.635429917     0  C  WS 0 [0]
  65,98   9    82641   106.635431273     0  C  WS 0 [0]
  65,98   9    82642   106.635433951     0  C  WS 0 [0]
  65,98   9    82643   106.635436395     0  C  WS 0 [0]
  65,98   9    82644   106.635437899     0  C  WS 0 [0]
  65,98   9    82645   106.635439551     0  C  WS 0 [0]
  65,98   9    82646   106.635441279     0  C  WS 0 [0]
  65,98   9    82647   106.635443819     0  C  WS 0 [0]
  65,98   9    82648   106.635446153     0  C  WS 0 [0]
  65,98   9    82649   106.635448087     0  C  WS 0 [0]
  65,98   9    82650   106.635449941     0  C  WS 0 [0]
  65,98   9    82651   106.635452109     0  C  WS 0 [0]
  65,98   9    82652   106.635454277     0  C  WS 0 [0]
  65,98   9    82653   106.635455857     0  C  WS 0 [0]
  65,98   9    82654   106.635459427     0  C  WS 0 [0]
  65,98   9    82655   106.635462091     0  C  WS 0 [0]
  65,98   9    82656   106.635464085     0  C  WS 0 [0]
  65,98   9    82657   106.635465641     0  C  WS 0 [0]
  65,98   9    82658   106.635467459     0  C  WS 0 [0]
  65,98   9    82659   106.635469062     0  C  WS 0 [0]
  65,98   9    82660   106.635470756     0  C  WS 0 [0]
  65,98   9    82661   106.635472536     0  C  WS 0 [0]
  65,98   9    82662   106.635474170     0  C  WS 0 [0]
  65,98   9    82663   106.635476042     0  C  WS 0 [0]
  65,98   9    82664   106.635478350     0  C  WS 0 [0]
  65,98   9    82665   106.635479712     0  C  WS 0 [0]
  65,98   9    82666   106.635481426     0  C  WS 0 [0]

One big IO with lots of small IOs all very close to each other, followed 
by a bunch of syncs.  So obviously when we have the WAL disabled we see 
better behavior with writes coalesced and all happening to near sectors 
(maybe disk cache can further improve things).  We see much higher 
throughput for 4K writes from fio and better looking seekwatcher graphs 
despite similar seek counts:

http://nhm.ceph.com/newstore/newstore-4kcompare/write-disableWAL.png



3) The fio data shows that even 4k random writes were faster than 4k 
sequential writes, so let's look at that example too

  65,98  10    39620   300.555953354 27232  C  WS 988714792 + 8 [0]
  65,98  21    33866   300.556215582     0  C  WS 998965304 + 8 [0]
  65,98   8    39399   300.556270604     0  C  WS 1003622152 + 8 [0]
  65,98  11    42850   300.556405280     0  C  WS 1001728168 + 8 [0]
  65,98  19    49049   300.556470467     0  C  WS 1013797432 + 8 [0]
  65,98  20    32309   300.556576481     0  C  WS 1014721088 + 8 [0]
  65,98  19    49053   300.556654659     0  C  WS 1009844896 + 8 [0]
  65,98   8    39403   300.556781158     0  C  WS 996936976 + 8 [0]
  65,98  11    42854   300.556869300     0  C  WS 1019774584 + 8 [0]
  65,98  23    67877   300.611701072     0  C  WS 0 [0]
  65,98  23    67878   300.612084266     0  C  WS 507447792 + 104 [0]
  65,98  14    11820   300.621380910     0  C  WS 0 [0]
  65,98  14    11821   300.621388810     0  C  WS 0 [0]
  65,98  14    11822   300.621392050     0  C  WS 0 [0]
  65,98  14    11823   300.621395373     0  C  WS 0 [0]
  65,98  14    11824   300.621399047     0  C  WS 0 [0]
  65,98  14    11825   300.621402197     0  C  WS 0 [0]
  65,98  14    11826   300.621406650     0  C  WS 0 [0]
  65,98  14    11827   300.621409130     0  C  WS 0 [0]

So we have 1 big write (WAL?) with lots of random little writes and the 
syncs get grouped up and delayed.  Seekwatcher data confirms higher 
throughput than in the sequential 4k write case:

http://nhm.ceph.com/newstore/newstore-4kcompare/randwrite-no_overlay.png


So my take away from this is that I think Xiaoxi is right.  With 4k 
sequential writes we see presumably 1 WAL IO and 1 write followed by 
fsync and this all happens synchronously.  When we disable WAL we get 
lots of concurrency, at least some of the writes coalesced, and over all 
better behavior.  When we perform random IO even with WAL enabled, we 
see lots of random IOs before fsyncs and a nice big coalesced IO (WAL?).

Mark
