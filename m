From: =?GBK?B?xfQ=?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Subject: ceph osd can not restart
Date: Wed, 23 Oct 2013 11:12:32 +0800 (CST)
Message-ID: <2fc3e984.3ce0.141e34ca36d.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1703958490=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1703958490==
Content-Type: multipart/alternative;
	boundary="----=_Part_56941_227131289.1382497952621"

------=_Part_56941_227131289.1382497952621
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

|
 hi all!
      I have 12 nodes ceph clouster ( 1 mon 2mds 9osd).  today my osd.0 osd.3 osd.4  are down and can not restart them!
osd.0 , osd.3, osd.4 are in the same host  which name is osd0!

firstly,   here is the osd log:
#tail -f /var/log/ceph/osd.0.log
ceph version 0.62(***************************) , process ceph-osd, pid 20667
**ERROR:unable to  open superblock on /data/osd.0 : (2) No such file or directory

 secondly,   /data/osd.0   is exit :
#ssh osd0 ls /data
osd.0 osd.3 osd.4

thirdly, I check the format  of osd !

#mount
...
/dev/sda3 on /data/osd.0 type btrifs(rw noatime)
/dev/sdb3 on /data/osd.3 type btrifs(rw noatime)
/dev/sdb3 on /data/osd.4 type btrifs(rw noatime)


It seems that all work is ok! but why can not resart  the osd in my cluster!
Any pointers would be much appreciated!
thanks!
peng







|
|
|   |   |
|
------=_Part_56941_227131289.1382497952621
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><table background="http://mimg.127.net/p/images/letter/201106/img1/lawn_b_bg.jpg" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td style="color:#3C580C;line-height:1.7;font-size:14px;padding:35px 25px 11px" height="376" valign="top"><div><stationery><div>&nbsp;hi all!<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have 12 nodes ceph clouster ( 1 mon 2mds 9osd).&nbsp; today my osd.0 osd.3 osd.4&nbsp; are down and can not restart them!<br>osd.0 , osd.3, osd.4 are in the same host&nbsp; which name is osd0!<br><br>firstly, &nbsp; here is the osd log:<br><i>#tail -f /var/log/ceph/osd.0.log<br>ceph version 0.62(***************************) , process ceph-osd, pid 20667<br>**ERROR:unable to&nbsp; open superbloc
 k on /data/osd.0 : (2) No such file or directory</i><br><br>&nbsp;secondly, &nbsp; <i>/data/osd.0&nbsp;&nbsp; </i>is exit :<br><i>#ssh osd0 ls /data<br>osd.0 osd.3 osd.4</i><br><br>thirdly, 
 I check the format&nbsp; of osd !<br><br><i>#mount<br>...<br>/dev/sda3 on /data/osd.0 type btrifs(rw noatime)<br>/dev/sdb3 on /data/osd.3 type btrifs(rw noatime)<br>/dev/sdb3 on /data/osd.4 type btrifs(rw noatime)</i><br><br><br>It seems that all work is ok! but why can not resart&nbsp; the osd in my cluster!<br>Any pointers would be much appreciated!<br>thanks!<br>peng<br><br><br><br><br><br><br></div><stationery></stationery></stationery></div></td></tr><tr><td style="font-size:0;line-height:0" height="24"><table border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td>&nbsp;</td><td background="http://mimg.127.net/p/images/letter/201106/img1/lawn_b_cpyr.png" height="24" width="120">&nbsp;</td></tr></tbody></table></td></tr></tbody></table></div><br><br><span title="neteas
 efooter"><span id="netease_mail_footer"></span></span>
------=_Part_56941_227131289.1382497952621--


--===============1703958490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1703958490==--
