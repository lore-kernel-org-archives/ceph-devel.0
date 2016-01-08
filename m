From: Jevon Qiao <scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Any suggestion to deal with slow request?
Date: Fri, 8 Jan 2016 12:22:04 +0800
Message-ID: <568F396C.9020700@gmail.com>
References: <568DE39D.6060409@gmail.com>
	<CAANLjFrTf1CCm=zWJSpFU78WeODhfVeqbr7RxOz3Df4ojABZug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0196118009=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFrTf1CCm=zWJSpFU78WeODhfVeqbr7RxOz3Df4ojABZug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0196118009==
Content-Type: multipart/alternative;
 boundary="------------080103060507070002030505"

This is a multi-part message in MIME format.
--------------080103060507070002030505
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Thank you for the prompt response.

The OSDs are built on XFS and the drives are Intel SSDs.  Each SSD is=20
parted into two partitions, one is for journal, the other is for data.=20
There is no alignment issue for the partitions.

When slow request msg is outputted, the workload is quite light on the=20
replication OSDs.

    Device:         rrqm/s   wrqm/s     r/s     w/s rMB/s    wMB/s
    avgrq-sz avgqu-sz   await  svctm  %util
    sda               0.00     0.00    0.50   30.00     0.00 0.18  =20
    12.33     0.00    0.08   0.08   0.25
    sdb               0.00     0.50    0.50   78.00     0.00 0.75  =20
    19.57     0.09    1.20   0.08   0.60
    sdc               0.00     0.50    0.00   28.00     0.00 0.24  =20
    17.75     0.01    0.32   0.11   0.30

I benchmarked some OSDs with 'ceph tell osd.x bench'=EF=BC=8Cand learned =
that=20
the throughput for some OSDs(the disk usage is over 60%) is 21MB/s,=20
which seems abnormal.

    $ ceph tell osd.24 bench
    { "bytes_written": 1073741824,
       "blocksize": 4194304,
       "bytes_per_sec": "22995975.000000"}

But the throughput for some newly added OSDs can reach 370MB/s. I=20
suspect if it is related to the GC of SSD. If so, it might explain why=20
it takes such long time to write journal. Any idea?

Another phenomenon that the journal_write is queued in writeq for 3=20
seconds, I checked the corresponding process logic in function=20
FileJournal::submit_entry() and FileJournal::write_thread_entry(), I did=20
not find anything suspicious point.

Thanks,
Jevon
On 8/1/16 00:43, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> What is the file system on the OSDs? Anything interesting in
> iostat/atop? What are the drives backing the OSDs? A few more details
> would be helpful.
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Wed, Jan 6, 2016 at 9:03 PM, Jevon Qiao  wrote:
>> Hi Cephers,
>>
>> We have a Ceph cluster running 0.80.9, which consists of 36 OSDs with =
3
>> replicas. Recently, some OSDs keep reporting slow request and the clus=
ter
>> has a performance downgrade.
>>
>>  From the log of one OSD, I observe that all the slow requests are res=
ulted
>> from waiting for the replicas to complete. And the replication OSDs ar=
e not
>> always some specific ones but could be any other two OSDs.
>>
>> 2016-01-06 08:17:11.887016 7f175ef25700  0 log [WRN] : slow request 1.=
162776
>> seconds old, received at 2016-01-06 08:17:11.887092:
>> osd_op(client.13302933.0:839452 rbd_data.c2659c728b0ddb.00000000000000=
24
>> [stat,set-alloc-hint object_size 16777216 write_size 16777216,write
>> 12099584~8192] 3.abd08522 ack+ondisk+write e4661) v4 currently waiting=
 for
>> subops from 24,31
>>
>> I dumped out the historic Ops of the OSD and noticed the following
>> information:
>> 1) wait about 8 seconds for the replies from the replica OSDs.
>>                      { "time": "2016-01-06 08:17:03.879264",
>>                        "event": "op_applied"},
>>                      { "time": "2016-01-06 08:17:11.684598",
>>                        "event": "sub_op_applied_rec"},
>>                      { "time": "2016-01-06 08:17:11.687016",
>>                        "event": "sub_op_commit_rec"},
>>
>> 2) spend more than 3 seconds in writeq and 2 seconds to write the jour=
nal.
>>                    { "time": "2016-01-06 08:19:16.887519",
>>                        "event": "commit_queued_for_journal_write"},
>>                      { "time": "2016-01-06 08:19:20.109339",
>>                        "event": "write_thread_in_journal_buffer"},
>>                      { "time": "2016-01-06 08:19:22.177952",
>>                        "event": "journaled_completion_queued"},
>>
>> Any ideas or suggestions?
>>
>> BTW, I checked the underlying network with iperf, it works fine.
>>
>> Thanks,
>> Jevon

--------------080103060507070002030505
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi Robert,<br>
    <br>
    Thank you for the prompt response. <br>
    <br>
    The OSDs are built on XFS and the drives are Intel SSDs.=C2=A0 Each S=
SD
    is parted into two partitions, one is for journal, the other is for
    data. There is no alignment issue for the partitions.<br>
    <br>
    When slow request msg is outputted, the workload is quite light on
    the replication OSDs.<br>
    <blockquote>Device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
rqm/s=C2=A0=C2=A0 wrqm/s=C2=A0=C2=A0=C2=A0=C2=A0 r/s=C2=A0=C2=A0=C2=A0=C2=
=A0 w/s=C2=A0=C2=A0=C2=A0
      rMB/s=C2=A0=C2=A0=C2=A0 wMB/s avgrq-sz avgqu-sz=C2=A0=C2=A0 await=C2=
=A0 svctm=C2=A0 %util<br>
      sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.=
50=C2=A0=C2=A0 30.00=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0
      0.18=C2=A0=C2=A0=C2=A0 12.33=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0 0.08=C2=A0=C2=A0 0.08=C2=A0=C2=A0 0.25<br>
      sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0 0.50=C2=A0=C2=A0=C2=A0 0.=
50=C2=A0=C2=A0 78.00=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0
      0.75=C2=A0=C2=A0=C2=A0 19.57=C2=A0=C2=A0=C2=A0=C2=A0 0.09=C2=A0=C2=A0=
=C2=A0 1.20=C2=A0=C2=A0 0.08=C2=A0=C2=A0 0.60<br>
      sdc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0 0.50=C2=A0=C2=A0=C2=A0 0.=
00=C2=A0=C2=A0 28.00=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0
      0.24=C2=A0=C2=A0=C2=A0 17.75=C2=A0=C2=A0=C2=A0=C2=A0 0.01=C2=A0=C2=A0=
=C2=A0 0.32=C2=A0=C2=A0 0.11=C2=A0=C2=A0 0.30<br>
    </blockquote>
    I benchmarked some OSDs with 'ceph tell osd.x bench'=EF=BC=8Cand lear=
ned
    that the throughput for some OSDs(the disk usage is over 60%) is
    21MB/s, which seems abnormal. <br>
    <blockquote>$ ceph tell osd.24 bench<br>
      { "bytes_written": 1073741824,<br>
      =C2=A0 "blocksize": 4194304,<br>
      =C2=A0 "bytes_per_sec": "22995975.000000"}<br>
    </blockquote>
    But the throughput for some newly added OSDs can reach 370MB/s. I
    suspect if it is related to the GC of SSD. If so, it might explain
    why it takes such long time to write journal. Any idea?<br>
    <br>
    Another phenomenon that the journal_write is queued in writeq for 3
    seconds, I checked the corresponding process logic in function
    FileJournal::submit_entry() and FileJournal::write_thread_entry(), I
    did not find anything suspicious point. <br>
    <br>
    Thanks,<br>
    Jevon<br>
    <div class=3D"moz-cite-prefix">On 8/1/16 00:43, Robert LeBlanc wrote:=
<br>
    </div>
    <blockquote
cite=3D"mid:CAANLjFrTf1CCm=3DzWJSpFU78WeODhfVeqbr7RxOz3Df4ojABZug-Rq2MYuBUFGs@public.gmane.org=
ail.com"
      type=3D"cite">
      <pre wrap=3D"">-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

What is the file system on the OSDs? Anything interesting in
iostat/atop? What are the drives backing the OSDs? A few more details
would be helpful.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Jan 6, 2016 at 9:03 PM, Jevon Qiao  wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Hi Cephers,

We have a Ceph cluster running 0.80.9, which consists of 36 OSDs with 3
replicas. Recently, some OSDs keep reporting slow request and the cluster
has a performance downgrade.

From the log of one OSD, I observe that all the slow requests are resulte=
d
from waiting for the replicas to complete. And the replication OSDs are n=
ot
always some specific ones but could be any other two OSDs.

2016-01-06 08:17:11.887016 7f175ef25700  0 log [WRN] : slow request 1.162=
776
seconds old, received at 2016-01-06 08:17:11.887092:
osd_op(client.13302933.0:839452 rbd_data.c2659c728b0ddb.0000000000000024
[stat,set-alloc-hint object_size 16777216 write_size 16777216,write
12099584~8192] 3.abd08522 ack+ondisk+write e4661) v4 currently waiting fo=
r
subops from 24,31

I dumped out the historic Ops of the OSD and noticed the following
information:
1) wait about 8 seconds for the replies from the replica OSDs.
                    { "time": "2016-01-06 08:17:03.879264",
                      "event": "op_applied"},
                    { "time": "2016-01-06 08:17:11.684598",
                      "event": "sub_op_applied_rec"},
                    { "time": "2016-01-06 08:17:11.687016",
                      "event": "sub_op_commit_rec"},

2) spend more than 3 seconds in writeq and 2 seconds to write the journal=
.
                  { "time": "2016-01-06 08:19:16.887519",
                      "event": "commit_queued_for_journal_write"},
                    { "time": "2016-01-06 08:19:20.109339",
                      "event": "write_thread_in_journal_buffer"},
                    { "time": "2016-01-06 08:19:22.177952",
                      "event": "journaled_completion_queued"},

Any ideas or suggestions?

BTW, I checked the underlying network with iperf, it works fine.

Thanks,
Jevon
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------080103060507070002030505--

--===============0196118009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0196118009==--
