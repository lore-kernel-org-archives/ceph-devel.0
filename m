From: Tim Zhang <cofol1986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: how does ceph handle object writes?
Date: Tue, 21 Jan 2014 11:13:02 +0800
Message-ID: <CAGo8jt=-QaRtdHBCGvVtqSCSj4jFJtPjKoaY5g1UZ+bcg2Fm2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968787050=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0968787050==
Content-Type: multipart/alternative; boundary=001a11c13c5edf70e004f07262ce

--001a11c13c5edf70e004f07262ce
Content-Type: text/plain; charset=ISO-8859-1

Hi guys,
I wonder how does store objects. Consider the writing obj process,  IMO,
osd first get obj data from client, then the primary osd get the data,
store the data in journal(with sync) , after that the primary osd spray the
obj to other replica osd simultaneously, and each replica osd will write
the journal with sync and then reply to the primary osd. After recieving
all the replies from replica osd,  primary osd will report the write op is
finished. Is there anything wrong?

--001a11c13c5edf70e004f07262ce
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi guys,<div>I wonder how does store objects. Consider the=
 writing obj process, =A0IMO, osd first get obj data from client, then the =
primary osd get the data, store the data in journal(with sync)=A0, after th=
at the primary osd spray the obj to other replica osd simultaneously, and e=
ach replica osd will write the journal with sync and then reply to the prim=
ary osd. After recieving all the replies from replica osd, =A0primary osd w=
ill report the write op is finished. Is there anything wrong?</div>
<div><br></div></div>

--001a11c13c5edf70e004f07262ce--

--===============0968787050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0968787050==--
