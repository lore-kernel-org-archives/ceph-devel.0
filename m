From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: A VM with 6 volumes - hangs
Date: Mon, 14 Nov 2016 20:34:25 +0530
Message-ID: <CANA9Uk5XPHyE41QuTNz-Q-hcM0n8a_DoVWcYixR-genHcLLZ5Q@mail.gmail.com>
References: <CANA9Uk7ZZzWZe7PdYaCd8r5B3bp+5grKrWcPRVH2sMNX2P5cmQ@mail.gmail.com>
	<CANA9Uk62k74k5g3PcpxoL3cGARafQ9LvzH5Gj_FqtNm2RyuFqg@mail.gmail.com>
	<CALKA-0Jr67ZVnoo4zn6sH65oA36xt30_TcQz52dDELAnQr6M9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0908244227=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALKA-0Jr67ZVnoo4zn6sH65oA36xt30_TcQz52dDELAnQr6M9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: German Anders <ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0908244227==
Content-Type: multipart/alternative; boundary=001a114a8282d4ea540541442786

--001a114a8282d4ea540541442786
Content-Type: text/plain; charset=UTF-8

When this issue seen, ceph logs shows "slow requests to OSD"

But Ceph status is in OK state.

Thanks
Swami

On Mon, Nov 14, 2016 at 8:27 PM, German Anders <ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org> wrote:

> Could you share some info about the ceph cluster? logs? did you see
> anything different from normal op on the logs?
>
> Best,
>
>
> *German*
>
> 2016-11-14 11:46 GMT-03:00 M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
>> +ceph-devel
>>
>> On Fri, Nov 11, 2016 at 5:09 PM, M Ranga Swami Reddy <
>> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>> Hello,
>>> I am using the ceph volumes with a VM. Details are below:
>>>
>>> VM:
>>>   OS: Ubuntu 14.0.4
>>>    CPU: 12 Cores
>>>    RAM: 40 GB
>>>
>>> Volumes:
>>>    Size: 1 TB
>>>     No:   6 Volumes
>>>
>>>
>>> With above, VM got hung without any read/write operation.
>>>
>>> Any suggestions..
>>>
>>> Thanks
>>> Swami
>>>
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>

--001a114a8282d4ea540541442786
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">When this issue seen, ceph logs shows &quot;slow requests =
to OSD&quot;<div><br></div><div>But Ceph status is in OK state.</div><div><=
br></div><div>Thanks</div><div>Swami</div></div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Mon, Nov 14, 2016 at 8:27 PM, German Ande=
rs <span dir=3D"ltr">&lt;<a href=3D"mailto:ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org" target=3D"=
_blank">ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace;font-size:small;color:#0b5394">Could you share some i=
nfo about the ceph cluster? logs? did you see anything different from norma=
l op on the logs?</div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace;font-size:small;color:#0b5394"><br></div><div class=3D"gm=
ail_default" style=3D"font-family:monospace,monospace;font-size:small;color=
:#0b5394">Best,</div><div class=3D"gmail_default" style=3D"font-family:mono=
space,monospace;font-size:small;color:#0b5394"><br></div><div class=3D"gmai=
l_extra"><br clear=3D"all"><div><div class=3D"m_-448028674464972942gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><span><div><div dir=3D"ltr"><p><b><span styl=
e=3D"font-size:10.0pt;font-family:Trebuchet MS,sans-serif;color:#444444"></=
span></b></p><span style=3D"color:rgb(68,68,68)"><span style=3D"font-family=
:trebuchet ms,sans-serif"><font size=3D"2"><b>German</b></font></span></spa=
n><span style=3D"color:rgb(68,68,68)"><span style=3D"font-family:trebuchet =
ms,sans-serif"><font size=3D"2"><font size=3D"1"></font></font></span></spa=
n></div></div></span></div></div></div></div></div></div></div>
<br><div class=3D"gmail_quote"><div><div class=3D"h5">2016-11-14 11:46 GMT-=
03:00 M Ranga Swami Reddy <span dir=3D"ltr">&lt;<a href=3D"mailto:swamiredd=
y@gmail.com" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>:<br></di=
v></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div dir=3D"l=
tr">+ceph-devel<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Fri, Nov 11, 2016 at 5:09 PM, M Ranga Swami Reddy <span dir=3D"ltr">&l=
t;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">swamireddy@gmai=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"l=
tr">Hello,<div>I am using the ceph=C2=A0volumes with a VM. Details are belo=
w:</div><div><br></div><div>VM:</div><div>=C2=A0 OS: Ubuntu 14.0.4</div><di=
v>=C2=A0 =C2=A0CPU: 12 Cores</div><div>=C2=A0 =C2=A0RAM: 40 GB</div><div><b=
r></div><div>Volumes:</div><div>=C2=A0 =C2=A0Size: 1 TB</div><div>=C2=A0 =
=C2=A0 No: =C2=A0 6 Volumes</div><div><br></div><div><br></div><div>With ab=
ove, VM got hung without any read/write operation.</div><div><br></div><div=
>Any suggestions..</div><div><br></div><div>Thanks</div><span class=3D"m_-4=
48028674464972942m_-207200821480262968HOEnZb"><font color=3D"#888888"><div>=
Swami</div></font></span></div>
</blockquote></div><br></div></div>
<br></div></div>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
<br></blockquote></div><br></div></div>
</blockquote></div><br></div>

--001a114a8282d4ea540541442786--

--===============0908244227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0908244227==--
