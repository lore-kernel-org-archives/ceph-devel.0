From: =?GBK?B?xfQ=?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Subject: radosgw bucket question
Date: Tue, 17 Sep 2013 10:21:23 +0800 (CST)
Message-ID: <15706d59.2c5d.14129b8dea8.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2045124882=="
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

--===============2045124882==
Content-Type: multipart/alternative;
	boundary="----=_Part_41632_350015306.1379384483495"

------=_Part_41632_350015306.1379384483495
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

 

hi
    So what am I doing wrong? when i run commond:
radosgw-admin bucket list --uid=johdone   the return is []
and the commond
radosgw-admin bucket list --uid=wkp4666 the return is []
and the commond
radosgw-admin bucket list    the return  is [mybucket1, mybucket2]
mybucket1's owner is johdone  , and when i try create a mybucket1 for user wkp4666 the result is 409,
both two users caps is

    "caps" : [{"type": "usages", "perm":"*"}
                   {"type":"users", "perm":"*"}
                 ]
does anyone face the same question ? how can i save the question!!!

------=_Part_41632_350015306.1379384483495
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><div><div>&nbsp;<br><br>hi <br>&nbsp;&nbsp;&nbsp; So what am I doing wrong? when i run commond:<br><i>radosgw-admin bucket list --uid=johdone&nbsp;&nbsp;</i><b> the return is</b><i> []</i><br>and the commond <br><i>radosgw-admin bucket list --uid=wkp4666 <b>t</b></i><b><i>he</i> return is </b><i>[]</i><br>and the commond <br><i>radosgw-admin bucket list&nbsp;&nbsp;&nbsp; </i><b>the return&nbsp; is </b>[mybucket1, mybucket2]<br><i>mybucket1's</i> owner is <i>johdone&nbsp; , </i>and when i try create a <i>mybucket1</i> for user wkp4666 the result is 409<b>,<br>both two users caps is <br></b><pre>    "caps" : [{"type": "usages", "perm":"*"}<br>                   {"type":"users", "perm":"*"}<br>                 ]</pre>
 does anyone face the same question ? how can i save the question!!!<br></div></div></div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_41632_350015306.1379384483495--


--===============2045124882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2045124882==--
