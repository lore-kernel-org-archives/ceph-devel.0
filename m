From: =?GBK?B?xfQ=?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Subject: errors cause by update ceph version(from 0.56.3 to
	0.62)
Date: Wed, 23 Oct 2013 16:12:34 +0800 (CST)
Message-ID: <6a1302c7.834b.141e45f551d.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0992168344=="
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

--===============0992168344==
Content-Type: multipart/alternative;
	boundary="----=_Part_123092_61355759.1382515954973"

------=_Part_123092_61355759.1382515954973
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

|
 

Hi all!
  
     now my ceph version is 0.62! yesday I update it from 0.56.3!
     
     I found  the init-ceph scrip in defferent ceph version has lots devfrents!

    my ceph version is 0.62! what make me confuse is that I can not use the init-ceph,  which version is 0.62 ,  start my cluster. when I can user the init-ceph , which version is 0.52.3, start my cluster!  what is more !  the 0.62 vesion's init-ceph can break my osd map!  I should rebuild the cluter use the mkcephfs! when I run ceph osd tree , the result is break!

    by the way!  I found that  if I would not clearn the /run/ceph/    , there will some wrong can not let cluster run well!
    so , if I want to rebuilt the ceph cluster!
       # umont /data/osd.id
       # rm -rf /data/*
       #rm -rf /run/ceph/*
   
 Any pointers would be appreciated!

thinks!
peng





|
|
|   |   |
|
------=_Part_123092_61355759.1382515954973
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><table background="http://mimg.127.net/p/images/letter/201106/img1/lawn_b_bg.jpg" border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td style="color:#3C580C;line-height:1.7;font-size:14px;padding:35px 25px 11px" height="376" valign="top"><div><stationery><div>&nbsp;<br><br>Hi all!<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; now my ceph version is 0.62! yesday I update it from 0.56.3!<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <br>&nbsp;&nbsp;&nbsp;&nbsp; I found&nbsp; the init-ceph scrip in defferent ceph version has lots devfrents!<br><br>&nbsp;&nbsp;&nbsp; my ceph version is 0.62! what make me confuse is that I can not use the
 init-ceph,&nbsp; which version is 0.62 ,&nbsp; start my cluster. when I can user 
the init-ceph , which version is 0.52.3, start my cluster!&nbsp; what is more !&nbsp; the 0.62 vesion's init-ceph can break my osd map!&nbsp; I should rebuild the cluter use the mkcephfs! when I run ceph osd tree , the result is break!<br><br>&nbsp;&nbsp;&nbsp; by the way!&nbsp; I found that&nbsp; if I would not clearn the /run/ceph/ &nbsp;&nbsp; , there will some wrong can not let cluster run well!<br>&nbsp;&nbsp;&nbsp; so , if I want to rebuilt the ceph cluster! <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # umont /data/osd.id<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # rm -rf /data/*<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #rm -rf /run/ceph/*<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;Any pointers would be appreciated!<br><br>thinks!<br>peng<br><br><br><br><br></div><stationery></stationery></stationery
 ></div></td></tr><tr><td style="font-size:0;line-height:0" height="24"><table border="0" cellpadding="0" cellspacing="0" width="100%"><tbody><tr><td>&nbsp;</td><td background="http://mimg.12
 7.net/p/images/letter/201106/img1/lawn_b_cpyr.png" height="24" width="120">&nbsp;</td></tr></tbody></table></td></tr></tbody></table></div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_123092_61355759.1382515954973--


--===============0992168344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0992168344==--
