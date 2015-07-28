From: Jiwan Ninglekhu <jiwan.ceph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: How is Storage Object managed in Ceph Object Storage
Date: Mon, 27 Jul 2015 20:55:43 -0500
Message-ID: <CADxPHwJ_q6Y-1DyqCcB=Tu59qXLWvdV19znnN8LFuo+2NHWwdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0628897277=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0628897277==
Content-Type: multipart/alternative; boundary=001a11c0f64c94d19f051be5c4e0

--001a11c0f64c94d19f051be5c4e0
Content-Type: text/plain; charset=UTF-8

Hi:

I am defining Objects broken down from a file to be stored in Object
Storage Cloud, as Storage Objects.

What I know: I have read documents and papers about object storage cloud.
Most of the time, the documents assume that storage objects from a file (to
be stored) have been already created and rest of the storage process is
mostly explained. A Storage Object is a container that has some fixed size
data with a numeric ID and some metadata.

what I would like to know is, In Ceph Object Storage:

   1. "How" are those storage objects actually created?
   2. What is the break down process of a file into multiple storage
   objects?
   3. What metadata and minimum metadata is saved alongside each object?
   4. What "key" is (extracted) required to later retrieve that storage
   object?
   5. Where is this "key" stored in Ceph?

Thanks
Jiwan

--001a11c0f64c94d19f051be5c4e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font=
-size:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,=
sans-serif;line-height:19.5px">Hi:</p><p style=3D"margin:0px 0px 1em;paddin=
g:0px;border:0px;font-size:15px;clear:both;font-family:&#39;Helvetica Neue&=
#39;,Helvetica,Arial,sans-serif;line-height:19.5px">I am defining Objects b=
roken down from a file to be stored in Object Storage Cloud, as Storage Obj=
ects.</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-size:15=
px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-ser=
if;line-height:19.5px">What I know: I have read documents and papers about =
object storage cloud. Most of the time, the documents assume that storage o=
bjects from a file (to be stored) have been already created and rest of the=
 storage process is mostly explained. A Storage Object is a container that =
has some fixed size data with a numeric ID and some metadata.</p><p style=
=3D"margin:0px 0px 1em;padding:0px;border:0px;font-size:15px;clear:both;fon=
t-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;line-height:19=
.5px">what I would like to know is, In Ceph Object Storage:</p><ol style=3D=
"margin:0px 0px 1em 30px;padding:0px;border:0px;font-size:15px;font-family:=
&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;line-height:19.5px"><li=
 style=3D"margin:0px 0px 0.5em;padding:0px;border:0px;word-wrap:break-word"=
>&quot;How&quot; are those storage objects actually created?</li><li style=
=3D"margin:0px 0px 0.5em;padding:0px;border:0px;word-wrap:break-word">What =
is the break down process of a file into multiple storage objects?</li><li =
style=3D"margin:0px 0px 0.5em;padding:0px;border:0px;word-wrap:break-word">=
What metadata and minimum metadata is saved alongside each object?</li><li =
style=3D"margin:0px 0px 0.5em;padding:0px;border:0px;word-wrap:break-word">=
What &quot;key&quot; is (extracted) required to later retrieve that storage=
 object?</li><li style=3D"margin:0px 0px 0.5em;padding:0px;border:0px;word-=
wrap:break-word">Where is this &quot;key&quot; stored in Ceph?=C2=A0</li></=
ol><div><font face=3D"Helvetica Neue, Helvetica, Arial, sans-serif"><span s=
tyle=3D"font-size:15px;line-height:19.5px">Thanks</span></font></div><div><=
font face=3D"Helvetica Neue, Helvetica, Arial, sans-serif"><span style=3D"f=
ont-size:15px;line-height:19.5px">Jiwan</span></font></div></div>

--001a11c0f64c94d19f051be5c4e0--

--===============0628897277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0628897277==--
