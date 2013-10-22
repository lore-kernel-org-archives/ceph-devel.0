From: =?GBK?B?xfQ=?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Subject: update ceph brings errors
Date: Tue, 22 Oct 2013 16:10:55 +0800 (CST)
Message-ID: <53a59bc7.25d8f.141df377649.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968808311=="
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
To: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0968808311==
Content-Type: multipart/alternative;
	boundary="----=_Part_563651_1120333455.1382429455945"

------=_Part_563651_1120333455.1382429455945
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

 
Hi all!
     I update my ceph verson form 0.56.3 to 0.62!  I install call dev pockage! and sucess build 0.62!
but  when I used 0.62 init-ceph !  all osd can not restart!

    it return   fail /use/local/bin/ceph-osd -i 0 --pid -file /var/run/osd.0.pid -c /tmp/fetched.ceph.conf.12035

  and when I run that common
   ** ERROR : unable to open OSD superblock on /data/osd.0:(2) No such file or directory

  but when I use the init-ceph, which verson is 0.56.3, It is ok to start all osds!
   but  the ceph -s
   Health HEALTH_WARN mds cluster is degeaded; mds 1 is loggy
    ....
   mdsmap e188: 1/1/1 up (0=1=up:replay(laggy or crashed))

    what is more!  I cant mount ceph !

           #mount -t ceph 192.168.22.22:6789:/ /mnt/test
          mount:192.168.22.22:/: cant read superblock

    so     , what are the diferent in init-ceph between the verson 0.62 and verson 0.56.3.
 
     and how to slove my polblem!

     think you !

    peng









------=_Part_563651_1120333455.1382429455945
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><div><div>&nbsp;<br>Hi all!<br>&nbsp;&nbsp;&nbsp;&nbsp; I update my ceph verson form 0.56.3 to 0.62!&nbsp; I install call dev pockage! and sucess build 0.62!<br>but&nbsp; when I used 0.62 init-ceph !&nbsp; all osd can not restart!<br><br>&nbsp;&nbsp;&nbsp; it return&nbsp;&nbsp; fail /use/local/bin/ceph-osd -i 0 --pid -file /var/run/osd.0.pid -c /tmp/fetched.ceph.conf.12035<br><br>&nbsp; and when I run that common<br>&nbsp;&nbsp; ** ERROR : unable to open OSD superblock on /data/osd.0:(2) No such file or directory<br><br>&nbsp; but when I use the init-ceph, which verson is 0.56.3, It is ok to start all osds!<br>&nbsp;&nbsp; but&nbsp; the ceph -s<br>&nbsp;&nbsp; Health HEALTH_WARN mds cluster is degeaded; mds 1 is lo
 ggy<br>&nbsp;&nbsp;&nbsp; ....<br>&nbsp;&nbsp; mdsmap e188: 1/1/1 up (0=1=up:replay(laggy or crashed))<br><br>&nbsp;&nbsp;&nbsp; what is more!&nbsp; I cant mount ceph !<br><br>&nbsp;&nbsp;&n
 bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #mount -t ceph 192.168.22.22:6789:/ /mnt/test<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mount:192.168.22.22:/: cant read superblock<br><br>&nbsp; &nbsp; so &nbsp;&nbsp;&nbsp; , what are the diferent in init-ceph between the verson 0.62 and verson 0.56.3.<br>&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; and how to slove my polblem!<br><br>&nbsp;&nbsp;&nbsp;&nbsp; think you !<br><br>&nbsp;&nbsp;&nbsp; peng<br><br><br><br><br><br><br><br><br></div></div></div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_563651_1120333455.1382429455945--


--===============0968808311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0968808311==--
