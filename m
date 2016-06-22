From: Yang X <yx888sd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Use of legacy bobtail tunables and potential
	performance impact to "jewel"?
Date: Wed, 22 Jun 2016 10:37:04 -0700
Message-ID: <CADhmVNWnew7TxUK1DYYRwnj+QNbRs=wQrUC_2x7+DR0cUU3U9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1538456873=="
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
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1538456873==
Content-Type: multipart/alternative; boundary=001a113951b0c83c0a0535e16260

--001a113951b0c83c0a0535e16260
Content-Type: text/plain; charset=UTF-8

Our ceph client is using bobtail legacy tunable and in particular,
"chooseleaf_vary_r" is set to 0.

My question is how it would impact CRUSH and hence performance in deploying
"jewel" on the server side and also the experimental "bluestore" backend.

Does it only affect data placement or does it actually would not find
mapping for certain objects and thus cause error?

Thanks in advance,

Yang

--001a113951b0c83c0a0535e16260
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Our ceph client is using bobtail legacy tunable and in par=
ticular, &quot;chooseleaf_vary_r&quot; is set to 0.<div><br></div><div>My q=
uestion is how it would impact CRUSH and hence performance in deploying &qu=
ot;jewel&quot; on the server side and also the experimental &quot;bluestore=
&quot; backend.</div><div><br></div><div>Does it only affect data placement=
 or does it actually would not find mapping for certain objects and thus ca=
use error?=C2=A0</div><div><br></div><div>Thanks in advance,</div><div><br>=
</div><div>Yang</div><div><br></div></div>

--001a113951b0c83c0a0535e16260--

--===============1538456873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1538456873==--
