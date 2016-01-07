From: Jevon Qiao <scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Any suggestion to deal with slow request?
Date: Thu, 7 Jan 2016 12:03:41 +0800
Message-ID: <568DE39D.6060409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0889333693=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0889333693==
Content-Type: multipart/alternative;
 boundary="------------040705000803090007020709"

This is a multi-part message in MIME format.
--------------040705000803090007020709
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cephers,

We have a Ceph cluster running 0.80.9, which consists of 36 OSDs with 3 
replicas. Recently, some OSDs keep reporting slow request and the 
cluster has a performance downgrade.

 From the log of one OSD, I observe that all the slow requests are 
resulted from waiting for the replicas to complete. And the replication 
OSDs are not always some specific ones but could be any other two OSDs.

    2016-01-06 08:17:11.887016 7f175ef25700  0 log [WRN] : slow request
    1.162776 seconds old, received at 2016-01-06 08:17:11.887092:
    osd_op(client.13302933.0:839452
    rbd_data.c2659c728b0ddb.0000000000000024 [stat,set-alloc-hint
    object_size 16777216 write_size 16777216,write 12099584~8192]
    3.abd08522 ack+ondisk+write e4661) v4 currently waiting for subops
    from 24,31

I dumped out the historic Ops of the OSD and noticed the following 
information:
1) wait about 8 seconds for the replies from the replica OSDs.
                     { "time": "2016-01-06 08:17:03.879264",
                       "event": "op_applied"},
                     { "time": "2016-01-06 08:17:11.684598",
                       "event": "sub_op_applied_rec"},
                     { "time": "2016-01-06 08:17:11.687016",
                       "event": "sub_op_commit_rec"},

2) spend more than 3 seconds in writeq and 2 seconds to write the journal.
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

--------------040705000803090007020709
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi Cephers,<br>
    <br>
    We have a Ceph cluster running 0.80.9, which consists of 36 OSDs
    with 3 replicas. Recently, some OSDs keep reporting slow request and
    the cluster has a performance downgrade. <br>
    <br>
    From the log of one OSD, I observe that all the slow requests are
    resulted from waiting for the replicas to complete. And the
    replication OSDs are not always some specific ones but could be any
    other two OSDs.<br>
    <blockquote>2016-01-06 08:17:11.887016 7f175ef25700=C2=A0 0 log [WRN]=
 :
      slow request 1.162776 seconds old, received at 2016-01-06
      08:17:11.887092: osd_op(client.13302933.0:839452
      rbd_data.c2659c728b0ddb.0000000000000024 [stat,set-alloc-hint
      object_size 16777216 write_size 16777216,write 12099584~8192]
      3.abd08522 ack+ondisk+write e4661) v4 currently waiting for subops
      from 24,31<br>
    </blockquote>
    I dumped out the historic Ops of the OSD and noticed the following
    information:<br>
    1) wait about 8 seconds for the replies from the replica OSDs.<br>
    <meta charset=3D"utf-8">
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "time": "2016-01-06 08:17=
:03.879264",<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "event": "op_ap=
plied"},<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "time": "2016-01-06 08:17=
:11.684598",<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "event": "sub_o=
p_applied_rec"},<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "time": "2016-01-06 08:17=
:11.687016",<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "event": "sub_o=
p_commit_rec"},<br>
    <br>
    2) spend more than 3 seconds in writeq and 2 seconds to write the
    journal.<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "time": "2016-01-06 08:19:16.887519",=
<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "event": "commi=
t_queued_for_journal_write"},<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "time": "2016-01-06 08:19=
:20.109339",<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "event": "write=
_thread_in_journal_buffer"},<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "time": "2016-01-06 08:19=
:22.177952",<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "event": "journ=
aled_completion_queued"},<br>
    <br>
    Any ideas or suggestions?<br>
    <br>
    BTW, I checked the underlying network with iperf, it works fine.<br>
    <br>
    Thanks,<br>
    Jevon<br>
  </body>
</html>

--------------040705000803090007020709--

--===============0889333693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0889333693==--
