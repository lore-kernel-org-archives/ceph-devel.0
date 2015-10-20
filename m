From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Write performance issue under rocksdb kvstore
Date: Tue, 20 Oct 2015 21:13:05 +0800
Message-ID: <CACJqLyZ6kFY=2hMz6u_frD4uNth95F4Y8K3prF42u=WFSFtCkQ@mail.gmail.com>
References: <SNT146-W53DA6FBD57581F19D681688C390@phx.gbl>
	<alpine.DEB.2.00.1510200544430.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1510200544430.16833-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Oct 20, 2015 at 8:47 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Tue, 20 Oct 2015, Z Zhang wrote:
>> Hi Guys,
>>
>> I am trying latest ceph-9.1.0 with rocksdb 4.1 and ceph-9.0.3 with
>> rocksdb 3.11 as OSD backend. I use rbd to test performance and following
>> is my cluster info.
>>
>> [ceph@xxx ~]$ ceph -s
>>     cluster b74f3944-d77f-4401-a531-fa5282995808
>>      health HEALTH_OK
>>      monmap e1: 1 mons at {xxx=xxx.xxx.xxx.xxx:6789/0}
>>             election epoch 1, quorum 0 xxx
>>      osdmap e338: 44 osds: 44 up, 44 in
>>             flags sortbitwise
>>       pgmap v1476: 2048 pgs, 1 pools, 158 MB data, 59 objects
>>             1940 MB used, 81930 GB / 81932 GB avail
>>                 2048 active+clean
>>
>> All the disks are spinning ones with write cache turning on. Rocksdb's
>> WAL and sst files are on the same disk as every OSD.
>
> Are you using the KeyValueStore backend?
>
>> Using fio to generate following write load:
>> fio -direct=1 -rw=randwrite -ioengine=sync -size=10M -bs=4K -group_reporting -directory /mnt/rbd_test/ -name xxx.1 -numjobs=1
>>
>> Test result:
>> WAL enabled + sync: false + disk write cache: on  will get ~700 IOPS.
>> WAL enabled + sync: true (default) + disk write cache: on|off  will get only ~25 IOPS.
>>
>> I tuned some other rocksdb options, but with no lock.
>
> The wip-newstore-frags branch sets some defaults for rocksdb that I think
> look pretty reasonable (at least given how newstore is using rocksdb).
>
>> I tracked down the rocksdb code and found each writer's Sync operation
>> would take ~30ms to finish. And as shown above, it is strange that
>> performance has no much difference no matters disk write cache is on or
>> off.
>>
>> Do your guys encounter the similar issue? Or do I miss something to
>> cause rocksdb's poor write performance?
>
> Yes, I saw the same thing.  This PR addresses the problem and is nearing
> merge upstream:
>
>         https://github.com/facebook/rocksdb/pull/746
>

cool, it looks reasonable for performance degraded

> There is also an XFS performance bug that is contributing to the problem,

are you refer to
this(http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/27645)?

I think newstore also meet this situation.

> but it looks like Dave Chinner just put together a fix for that.
>
> But... we likely won't be using KeyValueStore in its current form over
> rocksdb (or any other kv backend).  It stripes object data over key/value
> pairs, which IMO is not the best approach.
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Best Regards,

Wheat
