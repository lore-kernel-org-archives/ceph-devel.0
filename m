From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: rbd image mounts - issue
Date: Sat, 20 Aug 2016 19:45:12 +0530
Message-ID: <CANA9Uk4d19MnHzPi4kXQLPmmR==dHZsO_FYkWdcV_YTNE9f4GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0951092133=="
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
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0951092133==
Content-Type: multipart/alternative; boundary=94eb2c07c7a877315a053a8171a8

--94eb2c07c7a877315a053a8171a8
Content-Type: text/plain; charset=UTF-8

Hello,
I have around 6 rbd images. Mounted all 6 images to a VM.
Now all works fine. no issues with access all these 6 mount partitions.

Now, I have shared these 6 mount partions to others using NFS.
But these NFS partitions facing the issue of disconnects during the access
of these partition on NFS (dmsg says - no response from the partion)..

Is the above use case correct?

Please advise.

Thanks
Swami

--94eb2c07c7a877315a053a8171a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div>I have around 6 rbd=C2=A0images. Mounted all 6 =
images to a VM.</div><div>Now all works fine. no issues with access all the=
se 6 mount partitions.</div><div><br></div><div>Now, I have shared these 6 =
mount partions=C2=A0to others using NFS.</div><div>But these NFS partitions=
 facing the issue of disconnects during the access of these partition on NF=
S (dmsg says - no response from the=C2=A0partion)..</div><div><br></div><di=
v>Is the above use case correct?</div><div><br></div><div>Please advise.</d=
iv><div><br></div><div>Thanks</div><div>Swami</div></div>

--94eb2c07c7a877315a053a8171a8--

--===============0951092133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0951092133==--
