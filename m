From: Jeffrey Zhang <zhang.lei.fly-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Is there any way for ceph-osd to control the max
 fds?
Date: Thu, 20 Sep 2018 10:26:08 +0800
Message-ID: <CAATxhGcMEjbfofhW7582W87BqxDZ_xusRf=1qY=_vn7+Ng9=Rg@mail.gmail.com>
References: <CAATxhGf8Qz8NdfgAsVgaXqumRLVPtgGu=sZqcmb7ZSSUB6N4CQ@mail.gmail.com>
 <CAJ4mKGZX_XCVeFXNssJz_hFFvFWE5RWuz5CBusuc1uhoZy-CVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8009442721290713957=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGZX_XCVeFXNssJz_hFFvFWE5RWuz5CBusuc1uhoZy-CVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============8009442721290713957==
Content-Type: multipart/alternative; boundary="0000000000000daef00576444174"

--0000000000000daef00576444174
Content-Type: text/plain; charset="UTF-8"

Thanks Gregory for the explanation.

>
> files open (which mostly only applies to FileStore and there's a
> config, defaults to 1024 I think).
>
After searched the ceph doc, i do not think there is a such option[0]
I found a similar  `filestore flusher max fds=512` option, but it is
already deprecated
since v0.65

[0]
http://docs.ceph.com/docs/master/rados/configuration/filestore-config-ref/

-- 
Regards,
Jeffrey Zhang
Blog: http://xcodest.me

--0000000000000daef00576444174
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,helvetica,sans-serif;font-size:small">Thank=
s Gregory for the explanation.=C2=A0</div></div><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
files open (which mostly only applies to FileStore and there&#39;s a<br>
config, defaults to 1024 I think).<br></blockquote><div><span class=3D"gmai=
l_default" style=3D"font-family:arial,helvetica,sans-serif;font-size:small"=
>After searched the ceph doc, i do not think there is a such option[0]</spa=
n></div><div><span class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif;font-size:small">I found a similar=C2=A0 `</span><span clas=
s=3D"gmail-pre" style=3D"color:rgb(62,67,73);font-family:monospace;font-siz=
e:14px">filestore</span><span style=3D"color:rgb(62,67,73);font-family:mono=
space;font-size:14px">=C2=A0</span><span class=3D"gmail-pre" style=3D"color=
:rgb(62,67,73);font-family:monospace;font-size:14px">flusher</span><span st=
yle=3D"color:rgb(62,67,73);font-family:monospace;font-size:14px">=C2=A0</sp=
an><span class=3D"gmail-pre" style=3D"color:rgb(62,67,73);font-family:monos=
pace;font-size:14px">max</span><span style=3D"color:rgb(62,67,73);font-fami=
ly:monospace;font-size:14px">=C2=A0</span><span class=3D"gmail-pre" style=
=3D"color:rgb(62,67,73);font-family:monospace;font-size:14px">fds<span clas=
s=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif;font-si=
ze:small">=3D512` option, but it is already deprecated</span></span></div><=
div><span class=3D"gmail-pre" style=3D"color:rgb(62,67,73);font-family:mono=
space;font-size:14px"><span class=3D"gmail_default" style=3D"font-family:ar=
ial,helvetica,sans-serif;font-size:small">since v0.65</span></span></div><d=
iv><span class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif;font-size:small"><br></span></div><div><span class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif;font-size:small">[0] <a hre=
f=3D"http://docs.ceph.com/docs/master/rados/configuration/filestore-config-=
ref/">http://docs.ceph.com/docs/master/rados/configuration/filestore-config=
-ref/</a></span>=C2=A0</div></div><div><br></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><spa=
n style=3D"font-size:13px;border-collapse:collapse"><font face=3D"arial, he=
lvetica, sans-serif">Regards,</font></span></div><div><span style=3D"font-s=
ize:13px;border-collapse:collapse"><font face=3D"arial, helvetica, sans-ser=
if">Jeffrey Zhang</font></span></div><div><font face=3D"arial, helvetica, s=
ans-serif"><span style=3D"font-size:12.8px">Blog:=C2=A0</span><a href=3D"ht=
tp://xcodest.me/" style=3D"font-size:12.8px" target=3D"_blank">http://xcode=
st.me</a></font><font face=3D"monospace, monospace"><br></font></div></div>=
</div></div></div></div></div></div></div></div></div></div></div>

--0000000000000daef00576444174--

--===============8009442721290713957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8009442721290713957==--
