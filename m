From: =?utf-8?Q?Steffen_W_S=C3=B8rensen?= <stefws-BUHhN+a2lJ4@public.gmane.org>
Subject: Re: New Calamari server
Date: Wed, 13 May 2015 09:11:01 +0200
Message-ID: <23F55462-77B9-4C46-A99B-62C8640B9B06@me.com>
References: <D1766F6E.30C8E%mk7193@yp.com>
	<1308156878.221639216.1431419724991.JavaMail.zimbra@oxygem.tv>
	<D177704C.31735%mk7193@yp.com>
	<7E8CF9C16F722345A89076330719CB1F4A824EDF@EXMAIL1.taec.toshiba.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: multipart/mixed; boundary="===============1354318264=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-reply-to: <7E8CF9C16F722345A89076330719CB1F4A824EDF-S73WLWeSKkaudDcc988YZay9ae4OIm1A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Bruce McFarland <Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1354318264==
Content-type: multipart/alternative;
 boundary="Apple-Mail=_55E91FAD-1C38-45FC-A2A9-669A5B2E68BE"


--Apple-Mail=_55E91FAD-1C38-45FC-A2A9-669A5B2E68BE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 12/05/2015, at 19.51, Bruce McFarland =
<Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org> wrote:
>=20
> I am having a similar issue. The cluster is up and salt is running on =
and has accepted keys from all nodes, including the monitor. I can issue =
salt and salt/ceph.py commands from the Calamari including 'salt \* =
ceph.get_heartbeats' which returns from all nodes including the monitor =
with the monmap epoch etc. Calamari reports that it sees all of the Ceph =
servers, but not a Ceph cluster. Is there a salt event besides =
ceph.get-heartbeats that the Calamari master requires to recognize the =
cluster?
~ +1, I can get boot time but not the heartbeats, so I would still say =
salt is working:

root@node1:/# salt node2 ceph.get_boot_time
node2:
    1431002208
root@node1:/# salt node2 ceph.get_heartbeats
node2:
    The minion function caused an exception: Traceback (most recent call =
last):
      File "/usr/lib/python2.7/dist-packages/salt/minion.py", line 1020, =
in _thread_return
        return_data =3D func(*args, **kwargs)
      File "/var/cache/salt/minion/extmods/modules/ceph.py", line 467, =
in get_heartbeats
        service_data =3D service_status(filename)
      File "/var/cache/salt/minion/extmods/modules/ceph.py", line 526, =
in service_status
        fsid =3D json.loads(admin_socket(socket_path, ['status'], =
'json'))['cluster_fsid']
    KeyError: 'cluster_fsid'


/Steffen=

--Apple-Mail=_55E91FAD-1C38-45FC-A2A9-669A5B2E68BE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 12/05/2015, at 19.51, Bruce McFarland &lt;<a =
href=3D"mailto:Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org" =
class=3D"">Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">I am having a similar issue. The cluster is up =
and salt is running on and has accepted keys from all nodes, including =
the monitor. I can issue salt and salt/ceph.py commands from the =
Calamari including 'salt \* ceph.get_heartbeats' which returns from all =
nodes including the monitor with the monmap epoch etc. Calamari reports =
that it sees all of the Ceph servers, but not a Ceph cluster. Is there a =
salt event besides ceph.get-heartbeats that the Calamari master requires =
to recognize the cluster?</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""></div></blockquote></div>~ +1, I can get boot time but =
not the heartbeats, so I would still say salt is working:<div =
class=3D""><br class=3D""></div><div class=3D""><div =
class=3D"">root@node1:/# salt node2 ceph.get_boot_time</div><div =
class=3D"">node2:</div><div class=3D"">&nbsp; &nbsp; =
1431002208</div><div class=3D"">root@node1:/# salt node2 =
ceph.get_heartbeats</div><div class=3D"">node2:</div><div =
class=3D"">&nbsp; &nbsp; The minion function caused an exception: =
Traceback (most recent call last):</div><div class=3D"">&nbsp; &nbsp; =
&nbsp; File "/usr/lib/python2.7/dist-packages/salt/minion.py", line =
1020, in _thread_return</div><div class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
return_data =3D func(*args, **kwargs)</div><div class=3D"">&nbsp; &nbsp; =
&nbsp; File "/var/cache/salt/minion/extmods/modules/ceph.py", line 467, =
in get_heartbeats</div><div class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
service_data =3D service_status(filename)</div><div class=3D"">&nbsp; =
&nbsp; &nbsp; File "/var/cache/salt/minion/extmods/modules/ceph.py", =
line 526, in service_status</div><div class=3D"">&nbsp; &nbsp; &nbsp; =
&nbsp; fsid =3D json.loads(admin_socket(socket_path, ['status'], =
'json'))['cluster_fsid']</div><div class=3D"">&nbsp; &nbsp; KeyError: =
'cluster_fsid'</div></div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div><div =
class=3D"">/Steffen</div></body></html>=

--Apple-Mail=_55E91FAD-1C38-45FC-A2A9-669A5B2E68BE--

--===============1354318264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1354318264==--
