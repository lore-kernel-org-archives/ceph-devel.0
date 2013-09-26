From: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Scaling radosgw module
Date: Thu, 26 Sep 2013 16:47:56 -0700
Message-ID: <CABBk=J9a_kFFJOnJpOHS+0RGXXQ5y7JPFYGguXVdP2NsKd1J4w@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A8A7@SACMBXIP01.sdcorp.global.sandisk.com>
	<523CC62E.3070407@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A8C9@SACMBXIP01.sdcorp.global.sandisk.com>
	<523CD3FC.9010603@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F1992368C@SACMBXIP01.sdcorp.global.sandisk.com>
	<5244B605.5020002@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F199236AA@SACMBXIP01.sdcorp.global.sandisk.com>
	<5244BA04.2070702@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F199236CF@SACMBXIP01.sdcorp.global.sandisk.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F199236E3@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F199236E3-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

You specify the relative performance, but what the actual numbers that
you're seeing? How many GETs per second, and how many PUTs per second
do you see?

On Thu, Sep 26, 2013 at 4:00 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
> Mark,
> One more thing, all my test is with rgw cache enabled , disabling the cache the performance is around 3x slower.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Somnath Roy
> Sent: Thursday, September 26, 2013 3:59 PM
> To: Mark Nelson
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anirban Ray
> Subject: RE: [ceph-users] Scaling radosgw module
>
> Nope...With one client hitting the radaosgw , the daemon cpu usage is going up till 400-450% i.e taking in avg 4 core..In one client scenario, the server node (having radosgw + osds) cpu usage is ~80% idle and out of the 20% usage bulk is consumed by radosgw.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org]
> Sent: Thursday, September 26, 2013 3:50 PM
> To: Somnath Roy
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anirban Ray
> Subject: Re: [ceph-users] Scaling radosgw module
>
> Ah, that's very good to know!
>
> And RGW CPU usage you said was low?
>
> Mark
>
> On 09/26/2013 05:40 PM, Somnath Roy wrote:
>> Mark,
>> I did set up 3 radosgw servers in 3 server nodes and the tested with 3 swift-bench client hitting 3 radosgw in the same time. I saw the aggregated throughput is linearly scaling. But, as an individual radosgw performance is very low we need to put lots of radosgw/apache server combination to get very high throughput. I guess that will be a problem.
>> I will try to do some profiling and share the data.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Mark Nelson
>> Sent: Thursday, September 26, 2013 3:33 PM
>> To: Somnath Roy
>> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anirban Ray
>> Subject: Re: [ceph-users] Scaling radosgw module
>>
>> It's kind of annoying, but it may be worth setting up a 2nd RGW server and seeing if having two copies of the benchmark going at the same time on two separate RGW servers increases aggregate throughput.
>>
>> Also, it may be worth tracking down latencies with messenger debugging
>> enabled, but I'm afraid I'm pretty bogged down right now and probably
>> wouldn't be able to look at it for a while. :(
>>
>> Mark
>>
>> On 09/26/2013 05:15 PM, Somnath Roy wrote:
>>> Hi Mark,
>>> FYI, I tried with wip-6286-dumpling release and the results are the same for me. The radosgw throughput is around ~6x slower than the single rados bench output!
>>>    Any other suggestion ?
>>>
>>> Thanks & Regards
>>> Somnath
>>> -----Original Message-----
>>> From: Somnath Roy
>>> Sent: Friday, September 20, 2013 4:08 PM
>>> To: 'Mark Nelson'
>>> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> Subject: RE: [ceph-users] Scaling radosgw module
>>>
>>> Hi Mark,
>>> It's a test cluster and I will try with the new release.
>>> As I mentioned in the mail, I think number of rados client instance is the limitation. Could you please let me know how many rados client instance the radosgw daemon is instantiating ? Is it configurable somehow ?
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Mark Nelson [mailto:mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org]
>>> Sent: Friday, September 20, 2013 4:02 PM
>>> To: Somnath Roy
>>> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> Subject: Re: [ceph-users] Scaling radosgw module
>>>
>>> On 09/20/2013 05:49 PM, Somnath Roy wrote:
>>>> Hi Mark,
>>>> Thanks for your quick response.
>>>> I tried adding the 'num_container = 100' in the job file and found that the performance actually decreasing with that option. I am getting around 1K less iops after putting this. Another observation is that in order to get back the earlier iops I need to restart the radosgw service. Just removing the num_container option from the job file and running swift-bench again is not helping. It seems something radosgw service is caching here.
>>>
>>> Interesting, that means you aren't being limited by a single container index only residing on 1 OSD.  Eventually that might be a limitation, but not here apparently.
>>>
>>>>
>>>> Regarding object size, I have tried with larger object size as well but iops are much lower in those cases.
>>>
>>> Yeah, the larger the object size the lower the iops, but potentially the higher the MB/s throughput.
>>>
>>>>
>>>> Regarding moving it to the ceph wip branch, can I just upgrade from dumpling ?
>>>
>>> Yes, it's actually just dumpling with a minor code change, however given that it's development code I would not recommend doing this if the cluster is in production.
>>>
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>>
>>>> -----Original Message-----
>>>> From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Mark Nelson
>>>> Sent: Friday, September 20, 2013 3:03 PM
>>>> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> Subject: Re: [ceph-users] Scaling radosgw module
>>>>
>>>> Hi,
>>>>
>>>> A couple of things that might be worth trying:
>>>>
>>>> use multiple containers in swift-bench.  Newer versions should
>>>> support this.  Also, if this is a test cluster, you may want to try
>>>> the ceph
>>>> wip-6286 branch as we have a rather major performance improvement in it when dealing with small objects.
>>>>
>>>> Beyond that, we are currently investigating performance slowdowns due to OSD directory splitting behavior that can crop up with many (millions) of objects.  This we think has potentially been hitting a couple of folks that have very large object collections.
>>>>
>>>> Thanks,
>>>> Mark
>>>>
>>>> On 09/20/2013 04:57 PM, Somnath Roy wrote:
>>>>> Hi,
>>>>> I am running Ceph on a 3 node cluster and each of my server node is running 10 OSDs, one for each disk. I have one admin node and all the nodes are connected with 2 X 10G network. One network is for cluster and other one configured as public network.
>
>
>>>>>
>>>>> All the OSD journals are on SSDs.
>>>>>
>>>>> I started with rados bench command to benchmark the read performance of this Cluster on a large pool (~10K PGs) and found that each rados client has a limitation. Each client can only drive up to a certain mark. Each server  node cpu utilization shows it is  around 85-90% idle and the admin node (from where rados client is running) is around ~80-85% idle. I am trying with 4K object size.
>>>>>
>>>>> I started running more clients on the admin node and the performance is scaling till it hits the client cpu limit. Server still has the cpu of 30-35% idle.
>>>>>
>>>>> Now, I am behind radosgw and in one of the server node I installed the required modules like apache, fastcgi, radosgw etc.  I configured swift bench and started benchmarking. Here is my swift-bench job script.
>>>>>
>>>>> [bench]
>>>>> auth = http://<my-server>/auth
>>>>> user = somroy:swift
>>>>> key = UbJl9o+OPnzGaRbgqkS9OtPQ01TkAXAeA9RmVzVt
>>>>> concurrency = 64
>>>>> object_size = 4096
>>>>> num_objects = 1000
>>>>> num_gets = 200000
>>>>> delete = yes
>>>>> auth_version = 1.0
>>>>>
>>>>>
>>>>> First of all,  the read performance I am getting with one radosgw is more than 5x slower than what I am getting with one rbd client or one rados bench client. Is this expected ? Here is my ceph.conf radosgw config option.
>>>>>
>>>>> [client.radosgw.gateway]
>>>>> host = emsserver1
>>>>> keyring = /etc/ceph/keyring.radosgw.gateway rgw_socket_path =
>>>>> /tmp/radosgw.sock log_file = /var/log/ceph/radosgw.log rgw_dns_name
>>>>> = <ip> rgw_ops_log_rados = false debug_rgw = 0 rgw_thread_pool_size
>>>>> =
>>>>> 300
>>>>>
>>>>> The server node (where radosgw is also present) avg cpu utilization is very low (~75-80% idle). Out of the ~20% consumption, I saw radosgw is consuming bulk of the cpu in the node and ceph-osds are not much. The other two server node is ~95% idle ; 10 ceph-osds are consuming this of total 5% of cpu !!
>>>>>
>>>>> So, clearly, I am not able to generate much load on the cluster.
>>>>> So, I tried to run multiple swift-bench instances with the same job , all hitting the single radosgw instance. I saw no improvement on the performance, each instance iops is almost now = (single instance iop/number of swift-bench instance). The aggregated iops is remaining almost same as of single instance.
>>>>>
>>>>> This means we are hitting the single client instance limit here too.
>>>>> My question is, for all the requests radosgw is opening only single client connection to the object store ?
>>>>> If so, is there any configuration like 'noshare' option in case of rbd that Josh pointed out in my earlier mail ?
>>>>>
>>>>> If not, how a single radosgw instance will scale ?
>>>>>
>>>>> Appreciate, if anybody can help me on this.
>>>>>
>>>>> Thanks & Regards
>>>>> Somnath
>>>>>
>>>>> ________________________________
>>>>>
>>>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>>
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
