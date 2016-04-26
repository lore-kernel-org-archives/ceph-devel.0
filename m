From: Stephen Lord <steve.p.lord@gmail.com>
Subject: Re: [ceph-users] On-going Bluestore Performance Testing Results
Date: Tue, 26 Apr 2016 14:48:29 -0500
Message-ID: <F0E26E06-42ED-4948-A13C-C0AC4B73762E@gmail.com>
References: <571A44D0.80704@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36056 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcDZTsc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2016 15:48:32 -0400
Received: by mail-ig0-f195.google.com with SMTP id c3so3336609igl.3
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2016 12:48:31 -0700 (PDT)
In-Reply-To: <571A44D0.80704@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "cbt@lists.ceph.com" <cbt@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

I have been looking at OSD performance using Bluestore from a different angle. This is all focused around latency of individual requests, not aggregate throughput.

Using a micro benchmark which writes a 4 Mbyte object to an OSD and then reads it repeatedly. This test is repeatedly reading the same device content, so in theory, places minimal load on the device (at least in terms of using internal device caches).  I am running this on an Intel P3700 and over Mellanox 40Gb ethernet. The OSD system is running RHEL with this kernel:

3.10.0-327.13.1.el7.x86_64

and the ceph code is rpms downloaded from download.ceph.org:

ceph version 10.2.0 (3a9fba20ec743699b69bd0181dd6c54dc01c64b9)

Looking at the network traffic, I see about one request served per 8.5ms, this represents an aggregate data rate of 490 Mbytes/sec. Looking at network packets with tcpdump though, I see the complete response message being sent and acknowledged over tcp in about 2.5ms, the time from the last packet leaving the OSD host to the next request coming in is about 800 micro seconds, so the client is taking a little long to turn around when asking for more data. The network transmission rate is about 1.6 Gbytes/sec when data is moving. There is a stall of about 500us where no data is moving, so it looks like the tcp window is getting full at some point in there. I can push about 2.2 Gbytes/sec between these two hosts over netperf.

Looking at OSD stats for one of these operations:

        {
            "description": "osd_op(client.4508.0:869 2.797e510b 2598\/object_0 [] snapc 0=[] ack+read+known_if_redirected e213)",
            "initiated_at": "2016-04-26 08:54:38.938585",
            "age": 34.420012,
            "duration": 0.007323,
            "type_data": [
                "started",
                {
                    "client": "client.4508",
                    "tid": 869
                },
                [
                    {
                        "time": "2016-04-26 08:54:38.938585",
                        "event": "initiated"
                    },
                    {
                        "time": "2016-04-26 08:54:38.938632",
                        "event": "queued_for_pg"
                    },
                    {
                        "time": "2016-04-26 08:54:38.938662",
                        "event": "reached_pg"
                    },
                    {
                        "time": "2016-04-26 08:54:38.938754",
                        "event": "started"
                    },
                    {
                        "time": "2016-04-26 08:54:38.945907",
                        "event": "done"
                    }
                ]
            ]
        }

And the operation latency:

        "op_process_latency": {
            "avgcount": 1003,
            "sum": 5.259994928
        },
        "op_prepare_latency": {
            "avgcount": 1003,
            "sum": 5.270855977
        },
        "op_r": 1001,
        "op_r_out_bytes": 4198498304,
        "op_r_latency": {
            "avgcount": 1001,
            "sum": 5.321547421
        },
        "op_r_process_latency": {
            "avgcount": 1001,
            "sum": 5.243349956
        },
        "op_r_prepare_latency": {
            "avgcount": 1001,
            "sum": 5.269612380
        },

It appears that the network send time is not actually measured in operation latency - these counters are updated for an op before the network send happens. So the elapsed time of this operation, plus the elapsed time seen on the network, plus the time to get  new request in accounts for all of the time.

So, why does it take this long to read 4 Mbytes from a device which can run significantly faster?

Looking with blktrace, we can see that all the I/O for this data is coming from the device itself, there is no data caching in the OSD. So with bluestore, reading an object is going to hit physical media. This means OSD read speed is device limited, architecturally this somewhat makes sense in that ceph wants to cache on the edge close to clients. 

The OSD I/O starts out by queuing all the requests, in 32 128Kbyte pieces (actually alignment is slightly off in my case and there is a short head and tail request), this takes 1.7ms, then the requests are issued and dispatched, this takes 61us, so not long at all. The requests then takes another 2.5ms to complete. So we have 4.2ms spent reading the data and a little less than 1G byte/sec.

Looking at blktrace for the direct I/O read case, it takes 312 micro seconds to queue and dispatch all the requests, the first one comes back from the device in 400 micro seconds and we are completely done in 2.8 milliseconds total for a data rate of 1.5 Gbytes/sec which is about right.

Observations here:

1. Device I/O is not the most efficient here when observed in isolation from other requests. It would take several requests hitting an OSD in parallel to saturate the device and then the latency of individual operations is going to get longer still. Really hard to do predictive readahead here, in fact it is explicitly disabled. Seems to be a cost of the hash based placement of data.

2. Reads requests are half duplex, no network data is moving when data is moving from disk, and no disk data is moving when data comes off the network. Writes are probably half duplex too. Probably would add considerably complexity to overlap these, and there are probably hard cases where a client gets half an object and then an error because the device failed. Also, dealing with multiplexing multiple overlapping replies over the same socket would be painful - is that something that has to be handled? I presume it is. 

3. As a cache tier for reads this may not be a wonderful idea, you really want to get some cache memory into the stack there. 

4. There is a bunch of handshaking involved in getting a request serviced. Using the kerneldevice module in bluestore it submits an I/O using aio and the completion handler thread has to run to discover it is done. This then has to wake up another thread to have it dispatch the reply message. I got lost in there, does that send the data directly, or use yet another thread to actually send the data?

If I look at small requests, then a single client thread can get about 2000 read ops per second to an OSD. Object stat calls run about 3000 per second for objects known to be in memory. That could be faster but the data wrangling is where the bulk of the time is going.

Seems like aio_read is a weak spot once devices are fast though.

Higher CPU clock speed would help me here, but I never get more than 50% load on a single core running this test.

Steve


> On Apr 22, 2016, at 10:35 AM, Mark Nelson <mnelson@redhat.com> wrote:
> 
> Hi Guys,
> 
> Now that folks are starting to dig into bluestore with the Jewel release, I wanted to share some of our on-going performance test data. These are from 10.1.0, so almost, but not quite, Jewel.  Generally bluestore is looking very good on HDDs, but there are a couple of strange things to watch out for, especially with NVMe devices.  Mainly:
> 
> 1) in HDD+NVMe configurations performance increases dramatically when replacing the stock CentOS7 kernel with Kernel 4.5.1.
> 
> 2) In NVMe only configurations performance is often lower at middle-sized IOs.  Kernel 4.5.1 doesn't really help here.  In fact it seems to amplify both the cases where bluestore is faster and where it is slower.
> 
> 3) Medium sized sequential reads are where bluestore consistently tends to be slower than filestore.  It's not clear yet if this is simply due to Bluestore not doing read ahead at the OSD (ie being entirely dependent on client read ahead) or something else as well.
> 
> I wanted to post this so other folks have some ideas of what to look for as they do their own bluestore testing.  This data is shown as percentage differences vs filestore, but I can also release the raw throughput values if people are interested in those as well.
> 
> 


