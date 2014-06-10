From: Vilobh Meshram <vilobhmm-ZXvpkYn067l8UrSeD/g0lQ@public.gmane.org>
Subject: Fwd: CEPH Multitenancy and Data Isolation
Date: Tue, 10 Jun 2014 08:56:15 +0000
Message-ID: <AE4D7541-2202-4A06-BBC6-DADEC88AE89D@yahoo-inc.com>
References: <CFBB8E65.E806%vilobhmm@yahoo-inc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1960493386=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CFBB8E65.E806%vilobhmm-ZXvpkYn067l8UrSeD/g0lQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1960493386==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AE4D754122024A06BBC6DADEC88AE89Dyahooinccom_"

--_000_AE4D754122024A06BBC6DADEC88AE89Dyahooinccom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable



How does CEPH guarantee data isolation for volumes which are not meant to b=
e shared in a Openstack tenant?

When used with OpenStack the data isolation is provided by the Openstack le=
vel so that all users who are part of same tenant will be able to access/sh=
are the volumes created by users in that tenant. Consider a case where we h=
ave one pool named =93Volumes=94 for all the tenants. All the tenants use t=
he same keyring to access the volumes in the pool.

  1.  How do we guarantee that one user can=92t see the contents of the vol=
umes created by another user; if the volume is not meant to be shared.
  2.  If someone malicious user gets the access to the keyring (which we us=
ed as a authentication mechanism between the client/Openstack and CEPH) how=
 does CEPH guarantee that the malicious user can=92t access the volumes in =
that pool.
  3.  Lets say our Cinder services are running on the Openstack API node. H=
ow does the CEPH keyring information gets transferred from the API node to =
the Hypervisor node ? Does this keyring passed through message queue? If ye=
s can the malicious user have a look at the message queue and grab this key=
ring information ? If not then how does it reach from the API node to the H=
ypervisor node.

Thanks,
Vilobh

--_000_AE4D754122024A06BBC6DADEC88AE89Dyahooinccom_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body dir=3D"auto">
<div><br>
</div>
<blockquote type=3D"cite">
<div><br>
</div>
</blockquote>
<blockquote type=3D"cite">
<div>
<div><span style=3D"font-family: Consolas;">How does CEPH guarantee data is=
olation&nbsp;</span><span style=3D"font-family: Consolas;">for volumes whic=
h are not meant to be shared in a Openstack tenant?</span><span style=3D"fo=
nt-family: Consolas;">&nbsp;</span></div>
<div><span style=3D"font-family: Consolas;"><br>
</span></div>
<div><span style=3D"font-family: Consolas;">When used with OpenStack the da=
ta isolation is provided by the Openstack level so that all users who are p=
art of same tenant will be able to access/share the volumes created by user=
s in that tenant. Consider a case
 where we have one pool named =93Volumes=94 for all the tenants. All the te=
nants use the same keyring to access the volumes in the pool.&nbsp;</span><=
/div>
<ol>
<li><font face=3D"Consolas">How do we guarantee that one user can=92t see t=
he contents of the volumes created by another user; if the volume
<span style=3D"font-weight: bold;">is not</span> meant to be shared.</font>=
</li><li><font face=3D"Consolas">If someone malicious user gets the access =
to the keyring (which we used as a authentication mechanism between the cli=
ent/Openstack and CEPH) how does CEPH guarantee that the malicious user can=
=92t access the volumes in that pool.&nbsp;</font></li><li><font face=3D"Co=
nsolas">Lets say our Cinder services are running on the Openstack API node.=
 How does the CEPH keyring information gets transferred from the API node t=
o the Hypervisor node ? Does this keyring passed through message queue? If =
yes can the malicious
 user have a look at the message queue and grab this keyring information ? =
If not then how does it reach from the API node to the Hypervisor node.</fo=
nt></li></ol>
<div><font face=3D"Consolas"><br>
</font></div>
<div><font face=3D"Consolas">Thanks,</font></div>
<div><font face=3D"Consolas">Vilobh</font></div>
</div>
</blockquote>
</body>
</html>

--_000_AE4D754122024A06BBC6DADEC88AE89Dyahooinccom_--

--===============1960493386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1960493386==--
