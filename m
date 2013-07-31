From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Read ahead affect Ceph read performance much
Date: Wed, 31 Jul 2013 23:27:16 +0800
Message-ID: <51F92CD4.7030403@ubuntukylin.com>
References: <51F642E2.3090201@ubuntukylin.com> <51F680CF.4050903@inktank.com> <6F3FA899187F0043BA1827A69DA2F7CC01E4CF9F@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:33986 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679Ab3GaP1X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 11:27:23 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E4CF9F@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

We are tuning the prefetching window from the client side by specifying 
a different 'rasize' at mount time.

The workload we are using is iozone, just the hardware is, to some 
extent, for HPC.

We think how many OSDs is a file stored across also impact the 
performance, since that somehow determines how much optimization space 
are there. More OSDs, More performance potential to exploit, so maybe
you could try more OSDs.

Would like to hear your further test results.

Cheers,
Li Wang

On 07/31/2013 12:42 PM, Chen, Xiaoxi wrote:
> My 0.02, we have done some readahead test tuning on server(ceph osd) side, the result showing that when readahead = 0.5 * object_size(4M in default), we can get max read throughput. Readahead value larger than this generally will not help, but also not harm the performance.
>
> For your case, seems your workload(HPC) are fully sequential, so larger read ahead and prefetch should be helpful, but for RBD part, it's a bit harder to so such tuning.
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Monday, July 29, 2013 10:49 PM
> To: Li Wang
> Cc: ceph-devel@vger.kernel.org; Sage Weil
> Subject: Re: Read ahead affect Ceph read performance much
>
> On 07/29/2013 05:24 AM, Li Wang wrote:
>> We performed Iozone read test on a 32-node HPC server. Regarding the
>> hardware of each node, the CPU is very powerful, so does the network,
>> with a bandwidth > 1.5 GB/s. 64GB memory, the IO is relatively slow,
>> the throughput measured by 'dd' locally is around 70MB/s. We
>> configured a Ceph cluster with 24 OSDs on 24 nodes, one mds, one to
>> four clients, one client per node. The performance is as follows,
>>
>>       Iozone sequential read throughput (MB/s)
>> Number of clients     1          2         4
>> Default resize    180.0954   324.4836   591.5851
>> Resize: 256MB     645.3347   1022.998    1267.631
>>
>> The complete iozone parameter for one client is, iozone -t 1 -+m
>> /tmp/iozone.nodelist.50305030 -s 64G -r 4M -i 0 -+n -w -c -e -b
>> /tmp/iozone.nodelist.50305030.output, on each client node, only one
>> thread is started.
>>
>> for two clients, it is,
>> iozone -t 2 -+m /tmp/iozone.nodelist.50305030 -s 32G -r 4M -i 0 -+n -w
>> -c -e -b /tmp/iozone.nodelist.50305030.output
>>
>> As the data shown, a larger read ahead window could result in >300%
>> speedup!
>
> Very interesting!  I've done some similar tests and saw somewhat different results (I actually in some cases saw improvement with lower readahead!).  I suspect that this may be very hardware dependent.  Were you using RBD or CephFS?  In either case, was it the kernel client or userland (IE QEMU/KVM or FUSE)?  Also, where did you adjust readahead?
> Was this on the client volume or under the OSDs?
>
> I've got to prepare for the talk later this week, but I will try to get my readahead test results out soon as well.
>
>>
>> Besides, Since the backend of Ceph is not the traditional hard disk,
>> it is beneficial to capture the stride read prefetching. To prove
>> this, we tested the stride read with the following program, as we
>> know, the generic read ahead algorithm of Linux kernel will not
>> capture stride-read prefetch, so we use fadvise() to manually force pretching.
>> the record size is 4MB. The result is even more surprising,
>>
>>               Stride read throughput (MB/s)
>> Number of records prefetched  0      1      4      16      64      128
>> Throughput                  42.82  100.74 217.41  497.73  854.48  950.18
>>
>> As the data shown, with a read ahead size of 128*4MB, the speedup over
>> without read ahead could be up to 950/42 > 2000%!
>>
>> The core logic of the test program is below,
>>
>> stride = 17
>> recordsize = 4MB
>> for (;;) {
>>     for (i = 0; i < count; ++i) {
>>       long long start = pos + (i + 1) * stride * recordsize;
>>       printf("PRE READ %lld %lld\n", start, start + block);
>>       posix_fadvise(fd, start, block, POSIX_FADV_WILLNEED);
>>     }
>>     len = read(fd, buf, block);
>>     total += len;
>>     printf("READ %lld %lld\n", pos, (pos + len));
>>     pos += len;
>>     lseek(fd, (stride - 1) * block, SEEK_CUR);
>>     pos += (stride - 1) * block;
>> }
>>
>> Given the above results and some more, We plan to submit a blue print
>> to discuss the prefetching optimization of Ceph.
>
> Cool!
>
>>
>> Cheers,
>> Li Wang
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
