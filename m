From: Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
Subject: Re: CephFS Slow writes with 1MB files
Date: Mon, 30 Mar 2015 11:30:55 -0700
Message-ID: <CAC6JEv_mMbKn+=nHjQmwxAk8T7=MjpJ7bXtHTeWKda7ogJ1GPg@mail.gmail.com>
References: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
	<CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
	<CAC6JEv-G_s3gRNmn3MHPiuFP6ODiOgvhX_J02KEo=Dd0X-JLGg@mail.gmail.com>
	<CAMzumdb8S77aYqNUyhwzZDCGp6KBFc8OueZ0pCKrkSP=hDNFPg@mail.gmail.com>
	<CAC6JEv-4D2kF7rrnGMncbE-_63+hdDzecqpB+HrMOKp1YGwv_w@mail.gmail.com>
	<CAMzumda7VserizM5PEoT8mwYnTHeE4CFiUiLjnjqN2xXaeNVQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMzumda7VserizM5PEoT8mwYnTHeE4CFiUiLjnjqN2xXaeNVQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Barclay Jameson <almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Sat, Mar 28, 2015 at 10:12 AM, Barclay Jameson
<almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I redid my entire Ceph build going back to to CentOS 7 hoping to the
> get the same performance I did last time.
> The rados bench test was the best I have ever had with a time of 740
> MB wr and 1300 MB rd. This was even better than the first rados bench
> test that had performance equal to PanFS. I find that this does not
> translate to my CephFS. Even with the following tweaking it still at
> least twice as slow as PanFS and my first *Magical* build (that had
> absolutely no tweaking):
>
> OSD
>  osd_op_treads 8
>  /sys/block/sd*/queue/nr_requests 4096
>  /sys/block/sd*/queue/read_ahead_kb 4096
>
> Client
>  rsize=16777216
>  readdir_max_bytes=16777216
>  readdir_max_entries=16777216
>
> ~160 mins to copy 100000 (1MB) files for CephFS vs ~50 mins for PanFS.
> Throughput on CephFS is about 10MB/s vs PanFS 30 MB/s.
>
> Strange thing is none of the resources are taxed.
> CPU, ram, network, disks, are not even close to being taxed on either
> the client,mon/mds, or the osd nodes.
> The PanFS client node was a 10Gb network the same as the CephFS client
> but you can see the huge difference in speed.
>
> As per Gregs questions before:
> There is only one client reading and writing (time cp Small1/*
> Small2/.) but three clients have cephfs mounted, although they aren't
> doing anything on the filesystem.
>
> I have done another test where I stream data info a file as fast as
> the processor can put it there.
> (for (i=0; i < 1000000001; i++){ fprintf (out_file, "I is : %d\n",i);}
> ) and it is faster than the PanFS. CephFS 16GB in 105 seconds with the
> above tuning vs 130 seconds for PanFS. Without the tuning it takes 230
> seconds for CephFS although the first build did it in 130 seconds
> without any tuning.
>
> This leads me to believe the bottleneck is the mds. Does anybody have
> any thoughts on this?
> Are there any tuning parameters that I would need to speed up the mds?

This is pretty likely, but 10 creates/second is just impossibly slow.
The only other thing I can think of is that you might have enabled
fragmentation but aren't now, which might make an impact on a
directory with 100k entries.

Or else your hardware is just totally wonky, which we've seen in the
past but your server doesn't look quite large enough to be hitting any
of the nasty NUMA stuff...but that's something else to look at which I
can't help you with, although maybe somebody else can.

If you're interested in diving into it and depending on the Ceph
version you're running you can also examine the mds perfcounters
(http://ceph.com/docs/master/dev/perf_counters/) and the op history
(dump_ops_in_flight etc) and look for any operations which are
noticeably slow.
-Greg

>
> On Fri, Mar 27, 2015 at 4:50 PM, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org> wrote:
>> On Fri, Mar 27, 2015 at 2:46 PM, Barclay Jameson
>> <almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Yes it's the exact same hardware except for the MDS server (although I
>>> tried using the MDS on the old node).
>>> I have not tried moving the MON back to the old node.
>>>
>>> My default cache size is "mds cache size = 10000000"
>>> The OSDs (3 of them) have 16 Disks with 4 SSD Journal Disks.
>>> I created 2048 for data and metadata:
>>> ceph osd pool create cephfs_data 2048 2048
>>> ceph osd pool create cephfs_metadata 2048 2048
>>>
>>>
>>> To your point on clients competing against each other... how would I check that?
>>
>> Do you have multiple clients mounted? Are they both accessing files in
>> the directory(ies) you're testing? Were they accessing the same
>> pattern of files for the old cluster?
>>
>> If you happen to be running a hammer rc or something pretty new you
>> can use the MDS admin socket to explore a bit what client sessions
>> there are and what they have permissions on and check; otherwise
>> you'll have to figure it out from the client side.
>> -Greg
>>
>>>
>>> Thanks for the input!
>>>
>>>
>>> On Fri, Mar 27, 2015 at 3:04 PM, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> So this is exactly the same test you ran previously, but now it's on
>>>> faster hardware and the test is slower?
>>>>
>>>> Do you have more data in the test cluster? One obvious possibility is
>>>> that previously you were working entirely in the MDS' cache, but now
>>>> you've got more dentries and so it's kicking data out to RADOS and
>>>> then reading it back in.
>>>>
>>>> If you've got the memory (you appear to) you can pump up the "mds
>>>> cache size" config option quite dramatically from it's default 100000.
>>>>
>>>> Other things to check are that you've got an appropriately-sized
>>>> metadata pool, that you've not got clients competing against each
>>>> other inappropriately, etc.
>>>> -Greg
>>>>
>>>> On Fri, Mar 27, 2015 at 9:47 AM, Barclay Jameson
>>>> <almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>> Opps I should have said that I am not just writing the data but copying it :
>>>>>
>>>>> time cp Small1/* Small2/*
>>>>>
>>>>> Thanks,
>>>>>
>>>>> BJ
>>>>>
>>>>> On Fri, Mar 27, 2015 at 11:40 AM, Barclay Jameson
>>>>> <almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>> I did a Ceph cluster install 2 weeks ago where I was getting great
>>>>>> performance (~= PanFS) where I could write 100,000 1MB files in 61
>>>>>> Mins (Took PanFS 59 Mins). I thought I could increase the performance
>>>>>> by adding a better MDS server so I redid the entire build.
>>>>>>
>>>>>> Now it takes 4 times as long to write the same data as it did before.
>>>>>> The only thing that changed was the MDS server. (I even tried moving
>>>>>> the MDS back on the old slower node and the performance was the same.)
>>>>>>
>>>>>> The first install was on CentOS 7. I tried going down to CentOS 6.6
>>>>>> and it's the same results.
>>>>>> I use the same scripts to install the OSDs (which I created because I
>>>>>> can never get ceph-deploy to behave correctly. Although, I did use
>>>>>> ceph-deploy to create the MDS and MON and initial cluster creation.)
>>>>>>
>>>>>> I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
>>>>>> with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
>>>>>> -p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)
>>>>>>
>>>>>> Could anybody think of a reason as to why I am now getting a huge regression.
>>>>>>
>>>>>> Hardware Setup:
>>>>>> [OSDs]
>>>>>> 64 GB 2133 MHz
>>>>>> Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
>>>>>> 40Gb Mellanox NIC
>>>>>>
>>>>>> [MDS/MON new]
>>>>>> 128 GB 2133 MHz
>>>>>> Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
>>>>>> 40Gb Mellanox NIC
>>>>>>
>>>>>> [MDS/MON old]
>>>>>> 32 GB 800 MHz
>>>>>> Dual Proc E5472  @ 3.00GHz (8 Cores)
>>>>>> 10Gb Intel NIC
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
