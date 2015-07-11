From: Jiwan N <jiwan.ninglekhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Block Storage Image Creation Process
Date: Sat, 11 Jul 2015 15:44:51 -0500
Message-ID: <CAJe5gkBvJUuQQ08PtBB_dEp5bXZZHyeVw-7zCyOfLFid8vsqGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976491083=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0976491083==
Content-Type: multipart/alternative; boundary=001a113ce92466492c051a9f8f41

--001a113ce92466492c051a9f8f41
Content-Type: text/plain; charset=UTF-8

Hi  Ceph-Users,

I am quite new to Ceph Storage (storage tech in general). I have been
investigating Ceph to understand the precise process clearly.

*Q: What actually happens When I create a block image of certain size?*

The ceph documentation from  http://docs.ceph.com/docs/v0.67.9/man/8/rbd/
says, the block devices (images)
are stripped over objects and stored in a RADOS object store.

This is the process of storage allocation. So, do objects that are broken
down allocate space (themselves) where they reside? Or are these objects
(state and behavior ) information kept (scattered) into the OSDs
(eventually into the disks)? Or does the monitor server keep these info and
allocate those positions (locations) in Object storage disks so that later
on some data can be put into those locations?

Any precise documentation or explanation will help.

-- 
Sincerely,
Jiwan Ninglekhu

--001a113ce92466492c051a9f8f41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi =C2=A0Ceph-Users,<div><br></div><div>I am quite new to =
Ceph Storage (storage tech in general). I have been investigating Ceph to u=
nderstand the precise process clearly.=C2=A0</div><div><br></div><div><b>Q:=
 What actually happens When I create a block image of certain size?</b></di=
v><div><br></div><div>The ceph documentation from =C2=A0<a href=3D"http://d=
ocs.ceph.com/docs/v0.67.9/man/8/rbd/">http://docs.ceph.com/docs/v0.67.9/man=
/8/rbd/</a> says, the block devices (images)</div><div><div>are stripped ov=
er objects and stored in a RADOS object store.</div><div><br></div><div>Thi=
s is the process of storage allocation. So, do objects that are broken down=
 allocate space (themselves) where they reside? Or are these objects (state=
 and behavior ) information kept (scattered) into the OSDs (eventually into=
 the disks)? Or does the monitor server keep these info and allocate those =
positions (locations) in Object storage disks so that later on some data ca=
n be put into those locations?</div><div><br></div><div>Any precise documen=
tation or explanation will help.</div><div><br></div>-- <br><div class=3D"g=
mail_signature">Sincerely,<div>Jiwan Ninglekhu</div></div>
</div></div>

--001a113ce92466492c051a9f8f41--

--===============0976491083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0976491083==--
