From: Dan Mick <dan.mick-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Optimize Ceph cluster (kernel, osd, rbd)
Date: Mon, 22 Jul 2013 14:12:05 -0700
Message-ID: <51EDA025.7090202@inktank.com>
References: <51E98F62.8050800@vccloud.vn> <51EABC40.3010702@vccloud.vn>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51EABC40.3010702-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I would get the cluster up and running and do some experiments before I =

spent any time on optimization, much less all this.

On 07/20/2013 09:35 AM, Ta Ba Tuan wrote:
> Please help me!
>
>
> On 07/20/2013 02:11 AM, Ta Ba Tuan wrote:
>> Hi everyone,
>>
>> I have *3 nodes (running MON and MDS)*
>> and *6 data nodes ( 84 OSDs**)*
>> Each data nodes has configuraions:
>>   - CPU: 24 processor * Core Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
>>   - RAM: 32GB
>>   - Disk: 14*4TB
>> (14disks *4TB *6 data nodes=3D 84 OSDs)
>>
>> To optimize Ceph Cluster, *I adjusted some kernel arguments*
>> (nr_request in queue and increated read throughput):
>>
>> #Adjust nr_request in queue (staying in mem - default is 128)
>>     echo 1024 > /sys/block/sdb/queue/nr_requests
>>     echo noop > /sys/block/sda/queue/scheduler   (default=3D noop
>> deadline [cfq])
>> #Increase read throughput  (default: 128)
>>     echo "512" > /sys/block/*/queue/read_ahead_kb
>>
>> And, *tuning Ceph configuraion options below:*
>>
>> [client]
>>
>>      rbd cache =3D true
>>      rbd cache size =3D 536870912
>>      rbd cache max dirty =3D 134217728
>>      rbd cache target dirty =3D 33554432
>>      rbd cache max dirty age =3D 5
>>
>> [osd]
>>     osd data =3D /var/lib/ceph/osd/cloud-$id
>>     osd journal =3D /var/lib/ceph/osd/cloud-$id/journal
>>     osd journal size =3D 10000
>>     osd mkfs type =3D xfs
>>     osd mkfs options xfs =3D "-f -i size=3D2048"
>>     osd mount options xfs =3D "rw,noatime,inode64,logbsize=3D250k"
>>
>>     keyring =3D /var/lib/ceph/osd/cloud-$id/keyring.osd.$id
>> #increasing the number may increase the request processing rate
>>     osd op threads =3D 24
>> #The number of disk threads, which are used to perform background disk
>> intensive OSD operations such as scrubbing and snap trimming
>>     osd disk threads =3D24
>> #The number of active recovery requests per OSD at one time. More
>> requests will accelerate recovery, but the requests places an
>> increased load on the cluster.
>>     osd recovery max active =3D1
>> #writing direct to the journal.
>> #Allow use of libaio to do asynchronous writes
>>     journal dio =3D true
>>     journal aio =3D true
>> #Synchronization interval:
>> #The maximum/minimum interval in seconds for synchronizing the filestore.
>>     filestore max sync interval =3D 100
>>     filestore min sync interval =3D 50
>> #Defines the maximum number of in progress operations the file store
>> accepts before blocking on queuing new operations.
>>     filestore queue max ops =3D 2000
>> #The maximum number of bytes for an operation
>>     filestore queue max bytes =3D 536870912
>> #The maximum number of operations the filestore can commit.
>>     filestore queue committing max ops =3D 2000 (default =3D500)
>> #The maximum number of bytes the filestore can commit.
>>     filestore queue committing max bytes =3D 536870912
>> #When you add or remove Ceph OSD Daemons to a cluster, the CRUSH
>> algorithm will want to rebalance the cluster by moving placement
>> groups to or from Ceph OSD Daemons to restore the balance. The process
>> of migrating placement groups and the objects they contain can reduce
>> the cluster=92s operational performance considerably. To maintain
>> operational performance, Ceph performs this migration with
>> =91backfilling=92, which allows Ceph to set backfill operations to a low=
er
>> priority than requests to read or write data.
>>     osd max backfills =3D 1
>>
>>
>> Tomorrow, I'm going to implement Ceph Cluster,
>> I have very little experience in managing Ceph. So, I hope someone
>> give me advices about above arguments and guide me how to best
>> optimize ceph cluster?
>>
>> Thank you so much!
>> --tuantaba
>>
>>
>>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
