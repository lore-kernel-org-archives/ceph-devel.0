From: Jason Dillaman <dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD command crash & can't delete volume!
Date: Fri, 7 Nov 2014 10:14:31 -0500 (EST)
Message-ID: <806905535.9129865.1415373271909.JavaMail.zimbra@redhat.com>
References: <CAGP-ymOvFNSahwcDLWWnb4+OErX2kGPLUkQ0SWQrJN7wVSBU9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1481717216=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGP-ymOvFNSahwcDLWWnb4+OErX2kGPLUkQ0SWQrJN7wVSBU9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Chu Duc Minh <chu.ducminh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1481717216==
Content-Type: multipart/alternative;
	boundary="----=_Part_9129864_662551890.1415373271908"

------=_Part_9129864_662551890.1415373271908
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

It appears you have discovered a bug in librbd that occurs when a child's parent image is missing or corrupt. I have opened the following ticket for this issue: http://tracker.ceph.com/issues/10030 . 

For the OSD failure, can you start a new email thread with the supporting details of that issue? 

-- 

Jason Dillaman 
Red Hat 
dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org 
http://www.redhat.com 


----- Original Message -----

From: "Chu Duc Minh" <chu.ducminh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> 
Sent: Friday, November 7, 2014 7:05:58 AM 
Subject: [ceph-users] RBD command crash & can't delete volume! 

Hi folks, some volumes in my ceph cluster have problem and I can NOT delete it by rbd command. When i show info or try to delete it, rbd comand crash. 

Command i used: 
# rbd -p volumes info volume-e110b0a5-5116-46f2-99c7-84bb546f15c2 
# rbd -p volumes rm volume-e110b0a5-5116-46f2-99c7-84bb546f15c2 

I attach crash-dump log in this email, pls help me investigate it. 

PS: This problem makes me unable to start an osd too. (If i star this osd, it die few minutes after that. I retried many times but got the same result.) 

Thank you! 


_______________________________________________ 
ceph-users mailing list 
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com 


------=_Part_9129864_662551890.1415373271908
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: Arial; font-size: 10pt; color: #0000=
00"><div>It appears you have discovered a bug in librbd that occurs when a =
child's parent image is missing or corrupt. &nbsp;I have opened the followi=
ng ticket for this issue:&nbsp;<a href=3D"http://tracker.ceph.com/issues/10=
030">http://tracker.ceph.com/issues/10030</a>.<br></div><div><span style=3D=
"font-size: 10pt;"><br></span></div><div><span style=3D"font-size: 10pt;">F=
or the OSD failure, can you start a new email thread with the supporting de=
tails of that issue?</span></div><div><br></div><div><span name=3D"x"></spa=
n><span style=3D"font-size: small;">--</span><p><span size=3D"2" data-mce-s=
tyle=3D"font-size: small;" style=3D"font-size: small;"><span face=3D"arial,=
 helvetica, sans-serif" data-mce-style=3D"font-family: arial, helvetica, sa=
ns-serif;" style=3D"font-family: arial, helvetica, sans-serif;"><span style=
=3D"font-weight: bold;">Jason Dillaman<br></span></span></span><span size=
=3D"2" data-mce-style=3D"font-size: small;" style=3D"font-size: small;"><sp=
an face=3D"arial, helvetica, sans-serif" data-mce-style=3D"font-family: ari=
al, helvetica, sans-serif;" style=3D"font-family: arial, helvetica, sans-se=
rif;"><span size=3D"2" data-mce-style=3D"font-size: small;" style=3D"font-s=
ize: small;"></span></span></span><span face=3D"arial, helvetica, sans-seri=
f" size=3D"2" data-mce-style=3D"font-family: arial, helvetica, sans-serif; =
font-size: small;" style=3D"font-family: arial, helvetica, sans-serif; font=
-size: small;">Red Hat<br></span><span face=3D"arial, helvetica, sans-serif=
" size=3D"2" data-mce-style=3D"font-family: arial, helvetica, sans-serif; f=
ont-size: small;" style=3D"font-family: arial, helvetica, sans-serif; font-=
size: small;"></span><span size=3D"2" face=3D"arial, helvetica, sans-serif"=
 data-mce-style=3D"font-family: arial, helvetica, sans-serif; font-size: sm=
all;" style=3D"font-family: arial, helvetica, sans-serif; font-size: small;=
"><a href=3D"mailto:dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org<br></a></span>=
<span size=3D"2" face=3D"arial, helvetica, sans-serif" data-mce-style=3D"fo=
nt-family: arial, helvetica, sans-serif; font-size: small;" style=3D"font-f=
amily: arial, helvetica, sans-serif; font-size: small;"><a href=3D"http://w=
ww.redhat.com">http://www.redhat.com</a></span></p><div style=3D"font-size:=
 10pt; font-family: arial, helvetica, sans-serif;"><span style=3D"font-size=
: 10pt;"><br></span></div><span name=3D"x"></span><br></div><hr id=3D"zwchr=
"><div style=3D"color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: =
</b>"Chu Duc Minh" &lt;chu.ducminh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br><b>To: </b>ceph-devel@v=
ger.kernel.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org &gt;&gt; ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om" &lt;ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt;<br><b>Sent: </b>Friday, November 7, 2=
014 7:05:58 AM<br><b>Subject: </b>[ceph-users] RBD command crash &amp; can'=
t delete volume!<br><div><br></div><div dir=3D"ltr"><div><div><div>Hi folks=
, some volumes in my ceph cluster have problem and I can NOT delete it by r=
bd command. When i show info or try to delete it, rbd comand crash.<br><div=
><br></div></div>Command i used:<br><b># rbd -p volumes info volume-e110b0a=
5-5116-46f2-99c7-84bb546f15c2<br># rbd -p volumes rm volume-e110b0a5-5116-4=
6f2-99c7-84bb546f15c2</b><br><div><br></div></div><div>I attach crash-dump =
log in this email, pls help me investigate it.<br></div><div><br></div>PS: =
This problem makes me unable to start an osd too. (If i star this osd, it d=
ie few minutes after that. I retried many times but got the same result.)<b=
r><div><br></div></div>Thank you!<br><div><div><br></div></div></div>
<br>_______________________________________________<br>ceph-users mailing l=
ist<br>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>http://lists.ceph.com/listinfo.cgi/ceph=
-users-ceph.com<br></div><div><br></div></div></body></html>
------=_Part_9129864_662551890.1415373271908--

--===============1481717216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1481717216==--
