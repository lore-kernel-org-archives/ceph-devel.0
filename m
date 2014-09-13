From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Cache tier unable to auto flush data to storage tier
Date: Sun, 14 Sep 2014 01:23:19 +0300
Message-ID: <6F0091EE-47F9-49CC-9C34-13A873C01F43@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============2110517351=="
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
To: Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============2110517351==
Content-Type: multipart/alternative; boundary="Apple-Mail=_AA3ECCF7-C70E-4D6C-A1CB-932D9E8DC4C8"


--Apple-Mail=_AA3ECCF7-C70E-4D6C-A1CB-932D9E8DC4C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Cephers

I have created a Cache pool and looks like cache tiering agent is not =
able to flush/evict data as per defined policy. However when i manually =
evict / flush data , it migrates data from cache-tier to storage-tier

Kindly advice if there is something wrong with policy or anything else i =
am missing.

Ceph Version: 0.80.5
OS : Cent OS 6.4

Cache pool created using the following commands :

ceph osd tier add data cache-pool=20
ceph osd tier cache-mode cache-pool writeback
ceph osd tier set-overlay data cache-pool
ceph osd pool set cache-pool hit_set_type bloom
ceph osd pool set cache-pool hit_set_count 1
ceph osd pool set cache-pool hit_set_period 300
ceph osd pool set cache-pool target_max_bytes 10000
ceph osd pool set cache-pool target_max_objects 100
ceph osd pool set cache-pool cache_min_flush_age 60
ceph osd pool set cache-pool cache_min_evict_age 60


[root@ceph-node1 ~]# date
Sun Sep 14 00:49:59 EEST 2014
[root@ceph-node1 ~]# rados -p data  put file1 /etc/hosts
[root@ceph-node1 ~]# rados -p data ls
[root@ceph-node1 ~]# rados -p cache-pool ls
file1
[root@ceph-node1 ~]#


[root@ceph-node1 ~]# date
Sun Sep 14 00:59:33 EEST 2014
[root@ceph-node1 ~]# rados -p data ls
[root@ceph-node1 ~]#=20
[root@ceph-node1 ~]# rados -p cache-pool ls
file1
[root@ceph-node1 ~]#


[root@ceph-node1 ~]# date
Sun Sep 14 01:08:02 EEST 2014
[root@ceph-node1 ~]# rados -p data ls
[root@ceph-node1 ~]# rados -p cache-pool ls
file1
[root@ceph-node1 ~]#



[root@ceph-node1 ~]# rados -p cache-pool  cache-flush-evict-all
file1
[root@ceph-node1 ~]#
[root@ceph-node1 ~]# rados -p data ls
file1
[root@ceph-node1 ~]# rados -p cache-pool ls
[root@ceph-node1 ~]#


Regards
Karan Singh


--Apple-Mail=_AA3ECCF7-C70E-4D6C-A1CB-932D9E8DC4C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
style=3D"font-size: 17px;">Hello Cephers</div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 17px;">I have created a Cache =
pool and looks like cache tiering agent is not able to flush/evict data =
as per defined policy. However when i manually evict / flush data , it =
migrates data from cache-tier to storage-tier</div><div =
style=3D"font-size: 17px;"><br></div><div style=3D"font-size: =
17px;">Kindly advice if there is something wrong with policy or anything =
else i am missing.</div><div style=3D"font-size: 17px;"><br></div><div =
style=3D"font-size: 17px;">Ceph Version: 0.80.5</div><div =
style=3D"font-size: 17px;">OS : Cent OS 6.4</div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 17px;">Cache pool created =
using the following commands :</div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 8px;"><div style=3D"font-size: =
8px;"><span style=3D"font-size: 17px;">ceph osd tier add data =
cache-pool&nbsp;</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">ceph osd tier cache-mode cache-pool =
writeback</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">ceph osd tier set-overlay data =
cache-pool</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">ceph osd pool set cache-pool hit_set_type =
bloom</span></div><div style=3D"font-size: 8px;"><span style=3D"font-size:=
 17px;">ceph osd pool set cache-pool hit_set_count 1</span></div><div =
style=3D"font-size: 8px;"><span style=3D"font-size: 17px;">ceph osd pool =
set cache-pool hit_set_period 300</span></div><div style=3D"font-size: =
8px;"><span style=3D"font-size: 17px;">ceph osd pool set cache-pool =
target_max_bytes 10000</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">ceph osd pool set cache-pool =
target_max_objects 100</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">ceph osd pool set cache-pool =
cache_min_flush_age 60</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">ceph osd pool set cache-pool =
cache_min_evict_age 60</span></div></div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 17px;"><br></div><div =
style=3D"font-size: 17px;"><div>[root@ceph-node1 ~]# =
date</div><div><b>Sun Sep 14 00:49:59 EEST 2014</b></div></div><div =
style=3D"font-size: 17px;">[root@ceph-node1 ~]# rados -p data &nbsp;put =
file1 /etc/hosts</div><div style=3D"font-size: 17px;">[root@ceph-node1 =
~]# rados -p data ls</div><div style=3D"font-size: =
17px;">[root@ceph-node1 ~]# rados -p cache-pool ls</div><div =
style=3D"font-size: 17px;">file1</div><div style=3D"font-size: =
17px;">[root@ceph-node1 ~]#</div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 17px;"><br></div><div =
style=3D"font-size: 17px;"><div>[root@ceph-node1 ~]# =
date</div><div><b>Sun Sep 14 00:59:33 EEST =
2014</b></div><div><div>[root@ceph-node1 ~]# rados -p data =
ls</div><div>[root@ceph-node1 =
~]#&nbsp;</div></div><div><div>[root@ceph-node1 ~]# rados -p cache-pool =
ls</div><div>file1</div></div></div><div style=3D"font-size: =
17px;">[root@ceph-node1 ~]#</div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 17px;"><br></div><div =
style=3D"font-size: 8px;"><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">[root@ceph-node1 ~]# date</span></div><div =
style=3D"font-size: 8px;"><span style=3D"font-size: 17px;"><b>Sun Sep 14 =
01:08:02 EEST 2014</b></span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">[root@ceph-node1 ~]# rados -p data =
ls</span></div><div style=3D"font-size: 8px;"><span style=3D"font-size: =
17px;">[root@ceph-node1 ~]# rados -p cache-pool ls</span></div><div =
style=3D"font-size: 8px;"><span style=3D"font-size: =
17px;">file1</span></div><div style=3D"font-size: 8px;"><span =
style=3D"font-size: 17px;">[root@ceph-node1 ~]#</span></div></div><div =
style=3D"font-size: 17px;"><br></div><div style=3D"font-size: =
17px;"><br></div><div style=3D"font-size: 17px;"><br></div><div =
apple-content-edited=3D"true" style=3D"font-size: 8px;">
<div style=3D"orphans: auto; text-align: start; text-indent: 0px; =
widows: auto; word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; font-size: 8px;"><div =
style=3D"orphans: auto; text-align: start; text-indent: 0px; widows: =
auto; word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; font-size: 8px;"><div =
style=3D"orphans: auto; text-align: start; text-indent: 0px; widows: =
auto; word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; font-size: 8px;"><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; font-size: 8px;"><span =
style=3D"font-size: 17px;">[root@ceph-node1 ~]# <b>rados -p cache-pool =
&nbsp;cache-flush-evict-all</b></span></div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; font-size: 8px;"><span style=3D"font-size: =
17px;">file1</span></div><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
font-size: 8px;"><span style=3D"font-size: 17px;">[root@ceph-node1 =
~]#</span></div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space; font-size: 8px;"><span =
style=3D"font-size: 17px;">[root@ceph-node1 ~]# rados -p data =
ls</span></div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space; font-size: 8px;"><span =
style=3D"font-size: 17px;">file1</span></div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; font-size: 8px;"><span style=3D"font-size: =
17px;">[root@ceph-node1 ~]# rados -p cache-pool ls</span></div><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; font-size: 8px;"><span =
style=3D"font-size: 17px;">[root@ceph-node1 ~]#</span></div></div><div =
style=3D"color: rgb(0, 0, 0); font-size: 17px; letter-spacing: normal; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; font-family: Helvetica; font-style: =
normal; font-variant: normal; font-weight: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; widows: auto; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br></div><div style=3D"color: rgb(0, 0, 0); =
font-size: 17px; letter-spacing: normal; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
font-family: Helvetica; font-style: normal; font-variant: normal; =
font-weight: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; widows: auto; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br></div><div style=3D"color: rgb(0, 0, 0); =
font-size: 17px; letter-spacing: normal; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
font-family: Helvetica; font-style: normal; font-variant: normal; =
font-weight: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; widows: auto; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Regards</div><div style=3D"color: rgb(0, 0, 0); =
font-size: 17px; letter-spacing: normal; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
font-family: Helvetica; font-style: normal; font-variant: normal; =
font-weight: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; widows: auto; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Karan =
Singh</div></div></div>
</div>
<br></body></html>=

--Apple-Mail=_AA3ECCF7-C70E-4D6C-A1CB-932D9E8DC4C8--

--===============2110517351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2110517351==--
