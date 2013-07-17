From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: ceph -w  warning "I don't have pgid 0.2c8"?
Date: Wed, 17 Jul 2013 14:59:35 +0700
Message-ID: <51E64EE7.3090902@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0260487849=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0260487849==
Content-Type: multipart/alternative;
 boundary="------------080805020507040306040205"

This is a multi-part message in MIME format.
--------------080805020507040306040205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

I converted every osds from 2TB to 4TB, and when moving complete, show 
log Ceph realtime"ceph -w":
displays error: *"I don't have pgid 0.2c8"*

after then, I run:  "ceph pg force_create_pg 0.2c8"
Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940 active+clean, 3 
stale+active+degraded

then, I can't read/write data to mounted CephFS on Client-side ==> 
notify on client side: "Operation not permitted"

now, "ceph -w" still notify "22944 pgs: 1 creating, 22940 active+clean, 
3 stale+active+degraded"
and I don't understand something occuring?
Please, help me!!!

Thanks to everyone.

--tuantaba




--------------080805020507040306040205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi everyone,<br>
    <br>
    I converted every osds from 2TB to 4TB, and when moving complete,
    show log Ceph realtime"ceph -w":<br>
    displays error: <b>"I don't have pgid 0.2c8"</b><br>
    <br>
    after then, I run:&nbsp; "ceph pg force_create_pg 0.2c8"<br>
    Ceph warning: pgmap v55175: 22944 pgs: 1 creating, 22940
    active+clean, 3 stale+active+degraded<br>
    <br>
    then, I can't read/write data to mounted CephFS on Client-side
    ==&gt; notify on client side: "Operation not permitted"<br>
    <br>
    now, "ceph -w" still notify "22944 pgs: 1 creating, 22940
    active+clean, 3 stale+active+degraded"<br>
    and I don't understand something occuring?<br>
    Please, help me!!!<br>
    <br>
    Thanks to everyone.<br>
    <br>
    --tuantaba<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------080805020507040306040205--

--===============0260487849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0260487849==--
