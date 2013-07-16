From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Capacity proplem when mount CephFS with Ubuntu 14.04
Date: Tue, 16 Jul 2013 15:35:34 +0700
Message-ID: <51E505D6.1030700@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0677128031=="
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
--===============0677128031==
Content-Type: multipart/alternative;
 boundary="------------080509010505080103070002"

This is a multi-part message in MIME format.
--------------080509010505080103070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

OSDs capacity sumary is 144TB, and *when I mount CephFS on Ubuntu 14.04 
then it only display **576GB*, (Currently, I'm using replicate 3 for 
data pools)
(using: mount -t ceph Monitor_IP:/ /ceph -o name=admin,secret=xxxxxxxxxx")

I don't think capacity is too small?, please explain this help me!!!!!

*on Ubuntu 14.04*
Filesystem                Size  Used Avail Use% Mounted on
192.168.32.90:/ 576GB  20G  556GB 1%  /tmp/ceph_mount

But when mounting on Ubuntu 12.04:
*on Ubuntu 12.04*
Filesystem                Size  Used Avail Use% Mounted on
192.168.32.90:/    144T  800G  113.6T   1%  /tmp/ceph_mount


Thanks to everyone.
--tuantaba


--------------080509010505080103070002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi everyone,<br>
    <br>
    OSDs capacity sumary is 144TB, and <b>when I mount CephFS on Ubuntu
      14.04 then it only display </b><b>576GB</b>, (Currently, I'm
    using replicate 3 for data pools)<br>
    (using: mount -t ceph Monitor_IP:/ /ceph -o
    name=admin,secret=xxxxxxxxxx")<br>
    <br>
    I don't think capacity is too small?, please explain this help me!!!!!<br>
    <br>
    <b>on Ubuntu 14.04</b><br>
    Filesystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used Avail Use% Mounted on<br>
    192.168.32.90:/ &nbsp;&nbsp; <font color="#ff0000">576GB</font>&nbsp; 20G&nbsp; 556GB&nbsp;
    1%&nbsp; /tmp/ceph_mount<br>
    <br>
    But when mounting on Ubuntu 12.04:<br>
    <b>on Ubuntu 12.04</b><br>
    Filesystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used Avail Use% Mounted on<br>
    192.168.32.90:/ &nbsp;&nbsp; 144T&nbsp; 800G&nbsp; 113.6T&nbsp;&nbsp; 1%&nbsp; /tmp/ceph_mount<br>
    <br>
    <br>
    Thanks to everyone.<br>
    --tuantaba<br>
    <br>
  </body>
</html>

--------------080509010505080103070002--

--===============0677128031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0677128031==--
