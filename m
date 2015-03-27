From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: CephFS Slow writes with 1MB files
Date: Fri, 27 Mar 2015 11:50:59 -0500
Message-ID: <55158A73.5010409@redhat.com>
References: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
	<CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Barclay Jameson <almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Specifically related to BTRFS, if you have random IO to existing objects 
it will cause terrible fragmentation due to COW.  BTRFS is often faster 
than XFS initially but after it starts fragmenting can become much 
slower for sequential reads.  You may want to try XFS again and see if 
you can improve the read performance (increasing read ahead both on the 
cephfs client and on the underlying OSD block devices to something like 
4MB might help).

Mark

On 03/27/2015 11:47 AM, Barclay Jameson wrote:
> Opps I should have said that I am not just writing the data but copying it :
>
> time cp Small1/* Small2/*
>
> Thanks,
>
> BJ
>
> On Fri, Mar 27, 2015 at 11:40 AM, Barclay Jameson
> <almightybeeij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> I did a Ceph cluster install 2 weeks ago where I was getting great
>> performance (~= PanFS) where I could write 100,000 1MB files in 61
>> Mins (Took PanFS 59 Mins). I thought I could increase the performance
>> by adding a better MDS server so I redid the entire build.
>>
>> Now it takes 4 times as long to write the same data as it did before.
>> The only thing that changed was the MDS server. (I even tried moving
>> the MDS back on the old slower node and the performance was the same.)
>>
>> The first install was on CentOS 7. I tried going down to CentOS 6.6
>> and it's the same results.
>> I use the same scripts to install the OSDs (which I created because I
>> can never get ceph-deploy to behave correctly. Although, I did use
>> ceph-deploy to create the MDS and MON and initial cluster creation.)
>>
>> I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
>> with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
>> -p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)
>>
>> Could anybody think of a reason as to why I am now getting a huge regression.
>>
>> Hardware Setup:
>> [OSDs]
>> 64 GB 2133 MHz
>> Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
>> 40Gb Mellanox NIC
>>
>> [MDS/MON new]
>> 128 GB 2133 MHz
>> Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
>> 40Gb Mellanox NIC
>>
>> [MDS/MON old]
>> 32 GB 800 MHz
>> Dual Proc E5472  @ 3.00GHz (8 Cores)
>> 10Gb Intel NIC
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
