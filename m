From: debian Only <onlydebian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.87 Giant released
Date: Wed, 12 Nov 2014 20:32:40 +0700
Message-ID: <CA+SSH2qHTuF+6HkHi62DL57CuvN5rb=c5h0vw+yceB8wm105VQ@mail.gmail.com>
References: <alpine.DEB.2.00.1410291454570.1234@cobra.newdream.net>
	<54517AF6.6030408@utas.edu.au>
	<alpine.DEB.2.00.1410292251440.27022@cobra.newdream.net>
	<5451F8DD.3020907@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1141596564=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5451F8DD.3020907-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Nigel Williams <nigel.williams-w4dW+7W4mDC6c6uEtOJ/EA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1141596564==
Content-Type: multipart/alternative; boundary=047d7bacb9dc064bf60507a96e19

--047d7bacb9dc064bf60507a96e19
Content-Type: text/plain; charset=UTF-8

Dear expert

could you help to provide some guide upgrade Ceph from firefly to giant ?

many thanks !

2014-10-30 15:37 GMT+07:00 Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:

> On 10/30/2014 05:54 AM, Sage Weil wrote:
>
>> On Thu, 30 Oct 2014, Nigel Williams wrote:
>>
>>> On 30/10/2014 8:56 AM, Sage Weil wrote:
>>>
>>>> * *Degraded vs misplaced*: the Ceph health reports from 'ceph -s' and
>>>>     related commands now make a distinction between data that is
>>>>     degraded (there are fewer than the desired number of copies) and
>>>>     data that is misplaced (stored in the wrong location in the
>>>>     cluster).
>>>>
>>>
>>> Is someone able to briefly described how/why misplaced happens please,
>>> is it
>>> repaired eventually? I've not seen misplaced (yet).
>>>
>>
>> Sure.  An easy way to get misplaced objects is to do 'ceph osd
>> out N' on an OSD.  Nothing is down, we still have as many copies
>> as we had before, but Ceph now wants to move them somewhere
>> else. Starting with giant, you will see the misplaced % in 'ceph -s' and
>> not degraded.
>>
>>        leveldb_write_buffer_size = 32*1024*1024  = 33554432  // 32MB
>>>>       leveldb_cache_size        = 512*1024*1204 = 536870912 // 512MB
>>>>
>>>
>>> I noticed the typo, wondered about the code, but I'm not seeing the same
>>> values anyway?
>>>
>>> https://github.com/ceph/ceph/blob/giant/src/common/config_opts.h
>>>
>>> OPTION(leveldb_write_buffer_size, OPT_U64, 8 *1024*1024) // leveldb
>>> write
>>> buffer size
>>> OPTION(leveldb_cache_size, OPT_U64, 128 *1024*1024) // leveldb cache size
>>>
>>
>> Hmm!  Not sure where that 32MB number came from.  I'll fix it, thanks!
>>
>
> Those just happen to be the values used on the monitors (in ceph_mon.cc).
> Maybe that's where the mix up came from. :)
>
>   -Joao
>
>
> --
> Joao Eduardo Luis
> Software Engineer | http://inktank.com | http://ceph.com
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--047d7bacb9dc064bf60507a96e19
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear expert<div><br></div><div>could you help to provide s=
ome guide upgrade Ceph from firefly to giant ?</div><div><br></div><div>man=
y thanks !</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">2014-10-30 15:37 GMT+07:00 Joao Eduardo Luis <span dir=3D"ltr">&lt;<a =
href=3D"mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">joao.luis@inktank.c=
om</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 10=
/30/2014 05:54 AM, Sage Weil wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thu, 30 Oct 2014, Nigel Williams wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 30/10/2014 8:56 AM, Sage Weil wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
* *Degraded vs misplaced*: the Ceph health reports from &#39;ceph -s&#39; a=
nd<br>
=C2=A0 =C2=A0 related commands now make a distinction between data that is<=
br>
=C2=A0 =C2=A0 degraded (there are fewer than the desired number of copies) =
and<br>
=C2=A0 =C2=A0 data that is misplaced (stored in the wrong location in the<b=
r>
=C2=A0 =C2=A0 cluster).<br>
</blockquote>
<br>
Is someone able to briefly described how/why misplaced happens please, is i=
t<br>
repaired eventually? I&#39;ve not seen misplaced (yet).<br>
</blockquote>
<br>
Sure.=C2=A0 An easy way to get misplaced objects is to do &#39;ceph osd<br>
out N&#39; on an OSD.=C2=A0 Nothing is down, we still have as many copies<b=
r>
as we had before, but Ceph now wants to move them somewhere<br>
else. Starting with giant, you will see the misplaced % in &#39;ceph -s&#39=
; and<br>
not degraded.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 leveldb_write_buffer_size =3D 32*1024*1024=C2=A0 =3D 3=
3554432=C2=A0 // 32MB<br>
=C2=A0 =C2=A0 =C2=A0 leveldb_cache_size=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 512*=
1024*1204 =3D 536870912 // 512MB<br>
</blockquote>
<br>
I noticed the typo, wondered about the code, but I&#39;m not seeing the sam=
e<br>
values anyway?<br>
<br>
<a href=3D"https://github.com/ceph/ceph/blob/giant/src/common/config_opts.h=
" target=3D"_blank">https://github.com/ceph/ceph/<u></u>blob/giant/src/comm=
on/config_<u></u>opts.h</a><br>
<br>
OPTION(leveldb_write_buffer_<u></u>size, OPT_U64, 8 *1024*1024) // leveldb =
write<br>
buffer size<br>
OPTION(leveldb_cache_size, OPT_U64, 128 *1024*1024) // leveldb cache size<b=
r>
</blockquote>
<br>
Hmm!=C2=A0 Not sure where that 32MB number came from.=C2=A0 I&#39;ll fix it=
, thanks!<br>
</blockquote>
<br></span>
Those just happen to be the values used on the monitors (in ceph_mon.cc).=
=C2=A0 Maybe that&#39;s where the mix up came from. :)<span class=3D"HOEnZb=
"><font color=3D"#888888"><br>
<br>
=C2=A0 -Joao<br>
<br>
<br>
-- <br>
Joao Eduardo Luis<br>
Software Engineer | <a href=3D"http://inktank.com" target=3D"_blank">http:/=
/inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">http://cep=
h.com</a></font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
______________________________<u></u>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/<u></u>listinfo.cgi/ceph-users-ceph.<u></=
u>com</a><br>
</div></div></blockquote></div><br></div>

--047d7bacb9dc064bf60507a96e19--

--===============1141596564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1141596564==--
