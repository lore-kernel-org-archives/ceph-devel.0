From: German Anders <ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org>
Subject: Re: A VM with 6 volumes - hangs
Date: Mon, 14 Nov 2016 12:16:48 -0300
Message-ID: <CALKA-0JbB_t7jgQSsFgMC1NZAeuwO2RyVd8bkrKCgX6YzgjVKQ@mail.gmail.com>
References: <CANA9Uk7ZZzWZe7PdYaCd8r5B3bp+5grKrWcPRVH2sMNX2P5cmQ@mail.gmail.com>
	<CANA9Uk62k74k5g3PcpxoL3cGARafQ9LvzH5Gj_FqtNm2RyuFqg@mail.gmail.com>
	<CALKA-0Jr67ZVnoo4zn6sH65oA36xt30_TcQz52dDELAnQr6M9g@mail.gmail.com>
	<CANA9Uk5XPHyE41QuTNz-Q-hcM0n8a_DoVWcYixR-genHcLLZ5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0274872750=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5XPHyE41QuTNz-Q-hcM0n8a_DoVWcYixR-genHcLLZ5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0274872750==
Content-Type: multipart/alternative; boundary=94eb2c0579fe221ba7054144548b

--94eb2c0579fe221ba7054144548b
Content-Type: text/plain; charset=UTF-8

try to see the specific logs for those particularly osd's, and see if
something is there, also take a deep close to the pg's that hold those osds

Best,


*German*

2016-11-14 12:04 GMT-03:00 M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> When this issue seen, ceph logs shows "slow requests to OSD"
>
> But Ceph status is in OK state.
>
> Thanks
> Swami
>
> On Mon, Nov 14, 2016 at 8:27 PM, German Anders <ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org>
> wrote:
>
>> Could you share some info about the ceph cluster? logs? did you see
>> anything different from normal op on the logs?
>>
>> Best,
>>
>>
>> *German*
>>
>> 2016-11-14 11:46 GMT-03:00 M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>
>>> +ceph-devel
>>>
>>> On Fri, Nov 11, 2016 at 5:09 PM, M Ranga Swami Reddy <
>>> swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>>> Hello,
>>>> I am using the ceph volumes with a VM. Details are below:
>>>>
>>>> VM:
>>>>   OS: Ubuntu 14.0.4
>>>>    CPU: 12 Cores
>>>>    RAM: 40 GB
>>>>
>>>> Volumes:
>>>>    Size: 1 TB
>>>>     No:   6 Volumes
>>>>
>>>>
>>>> With above, VM got hung without any read/write operation.
>>>>
>>>> Any suggestions..
>>>>
>>>> Thanks
>>>> Swami
>>>>
>>>
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>>
>

--94eb2c0579fe221ba7054144548b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace;font-size:small;color:#0b5394">try to see the specific logs for=
 those particularly osd&#39;s, and see if something is there, also take a d=
eep close to the pg&#39;s that hold those osds</div><div class=3D"gmail_def=
ault" style=3D"font-family:monospace,monospace;font-size:small;color:#0b539=
4"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace;font-size:small;color:#0b5394">Best,</div><div class=3D"gmail_defau=
lt" style=3D"font-family:monospace,monospace;font-size:small;color:#0b5394"=
><br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><=
div dir=3D"ltr"><div><div dir=3D"ltr"><span><div><div dir=3D"ltr"><p><b><sp=
an style=3D"font-size:10.0pt;font-family:Trebuchet MS,sans-serif;color:#444=
444"></span></b></p><span style=3D"color:rgb(68,68,68)"><span style=3D"font=
-family:trebuchet ms,sans-serif"><font size=3D"2"><b>German</b></font></spa=
n></span><span style=3D"color:rgb(68,68,68)"><span style=3D"font-family:tre=
buchet ms,sans-serif"><font size=3D"2"><font size=3D"1"></font></font></spa=
n></span></div></div></span></div></div></div></div></div></div></div>
<br><div class=3D"gmail_quote">2016-11-14 12:04 GMT-03:00 M Ranga Swami Red=
dy <span dir=3D"ltr">&lt;<a href=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">When this issue seen, ceph logs shows &quot;slow reque=
sts to OSD&quot;<div><br></div><div>But Ceph status is in OK state.</div><d=
iv><br></div><div>Thanks</div><span class=3D"HOEnZb"><font color=3D"#888888=
"><div>Swami</div></font></span></div><div class=3D"HOEnZb"><div class=3D"h=
5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Nov 14=
, 2016 at 8:27 PM, German Anders <span dir=3D"ltr">&lt;<a href=3D"mailto:ga=
nders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org" target=3D"_blank">ganders-LWDKa8F8PCdWk0Htik3J/w@public.gmane.org</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div style=3D"font=
-family:monospace,monospace;font-size:small;color:#0b5394">Could you share =
some info about the ceph cluster? logs? did you see anything different from=
 normal op on the logs?</div><div style=3D"font-family:monospace,monospace;=
font-size:small;color:#0b5394"><br></div><div style=3D"font-family:monospac=
e,monospace;font-size:small;color:#0b5394">Best,</div><div style=3D"font-fa=
mily:monospace,monospace;font-size:small;color:#0b5394"><br></div><div clas=
s=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"m_-17371183190226644=
3m_-448028674464972942gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><span><div><div=
 dir=3D"ltr"><p><b><span style=3D"font-size:10.0pt;font-family:Trebuchet MS=
,sans-serif;color:#444444"></span></b></p><span style=3D"color:rgb(68,68,68=
)"><span style=3D"font-family:trebuchet ms,sans-serif"><font size=3D"2"><b>=
German</b></font></span></span><span style=3D"color:rgb(68,68,68)"><span st=
yle=3D"font-family:trebuchet ms,sans-serif"><font size=3D"2"><font size=3D"=
1"></font></font></span></span></div></div></span></div></div></div></div><=
/div></div></div>
<br><div class=3D"gmail_quote"><div><div class=3D"m_-173711831902266443h5">=
2016-11-14 11:46 GMT-03:00 M Ranga Swami Reddy <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a=
>&gt;</span>:<br></div></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div class=
=3D"m_-173711831902266443h5"><div dir=3D"ltr">+ceph-devel<br><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Fri, Nov 11, 2016 at 5:09 PM=
, M Ranga Swami Reddy <span dir=3D"ltr">&lt;<a href=3D"mailto:swamireddy@gm=
ail.com" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div dir=3D"ltr">Hello,<div>I am using the cep=
h=C2=A0volumes with a VM. Details are below:</div><div><br></div><div>VM:</=
div><div>=C2=A0 OS: Ubuntu 14.0.4</div><div>=C2=A0 =C2=A0CPU: 12 Cores</div=
><div>=C2=A0 =C2=A0RAM: 40 GB</div><div><br></div><div>Volumes:</div><div>=
=C2=A0 =C2=A0Size: 1 TB</div><div>=C2=A0 =C2=A0 No: =C2=A0 6 Volumes</div><=
div><br></div><div><br></div><div>With above, VM got hung without any read/=
write operation.</div><div><br></div><div>Any suggestions..</div><div><br><=
/div><div>Thanks</div><span class=3D"m_-173711831902266443m_-44802867446497=
2942m_-207200821480262968HOEnZb"><font color=3D"#888888"><div>Swami</div></=
font></span></div>
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
</div></div></blockquote></div><br></div></div>

--94eb2c0579fe221ba7054144548b--

--===============0274872750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0274872750==--
