From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel power tuning - 30% throughput performance
	increase
Date: Fri, 5 May 2017 11:25:45 +1000
Message-ID: <CA+z5DsyV6RKyFYGVd9Qj_xjS4AwaJwPje-W2LdeE4A=+fwFyNQ@mail.gmail.com>
References: <CA+z5Dsx1Fwkxxk=5N3u_Ox6m+VC_vW2oexWsF29ispcm+Hf8bA@mail.gmail.com>
	<CABZ+qqk-cN25u8vf-XWoTincF5M90_JjBGnedHvnfAcL8CUDwQ@mail.gmail.com>
	<CA+z5DswHcgddrbYnwDH7o+58sASO5jZA5ZK+-NQ60Rw+bPRKkA@mail.gmail.com>
	<CABZ+qq=+1SvbPhZOBCS0Be4Z=6LXsgck2AgK+o40BOU_BwDngQ@mail.gmail.com>
	<CA+z5DsydfEGGzmKT+mf7BqpkwsD5CwL0hNMTW2OXFPeJjDWSGQ@mail.gmail.com>
	<CABZ+qqmu2C4jdu50X2u38K9cb57c0=BdfKG0BhrjJfTQYOPcjg@mail.gmail.com>
	<CA+z5DszC6EmYSPpZsj3O0Neb-qMhfmUDjjXWpfkgukrqTyZa6A@mail.gmail.com>
	<CAF-wwdF-w_nBF5HN3nwMtaSxK2KM+EsdBES=HhoCa71PH8Obbg@mail.gmail.com>
	<CACJqLyYLAo5n=Mq=nS85dVjr1aNZ0LuaQN7Rm4Du9T1L2qKkEA@mail.gmail.com>
	<CAF-wwdEF7ReHz+wjZBTcdJ=Xh3UQ8dGEjJtxhosPXra4xm2t9A@mail.gmail.com>
	<CA+z5DsyGBGZ2PyqnJtOZq3etixjx86e=WE0TCkdkRYbDvbBQaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1156786867=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DsyGBGZ2PyqnJtOZq3etixjx86e=WE0TCkdkRYbDvbBQaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1156786867==
Content-Type: multipart/alternative; boundary=94eb2c07ab22dc7742054ebcc4ed

--94eb2c07ab22dc7742054ebcc4ed
Content-Type: text/plain; charset=UTF-8

Sounds good, but could also have a config option to set it before dropping
root?

On 4 May 2017 20:28, "Brad Hubbard" <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

On Thu, May 4, 2017 at 10:58 AM, Haomai Wang <haomai-p1s0O0zx/60@public.gmane.org> wrote:
> refer to https://github.com/ceph/ceph/pull/5013

How about we issue a warning about possible performance implications
if we detect this is not set to 1 *or* 0 at startup?

>
> On Thu, May 4, 2017 at 7:56 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> +ceph-devel to get input on whether we want/need to check the value of
>> /dev/cpu_dma_latency (platform dependant) at startup and issue a
>> warning, or whether documenting this would suffice?
>>
>> Any doc contribution would be welcomed.
>>
>> On Wed, May 3, 2017 at 7:18 PM, Blair Bethwaite
>> <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On 3 May 2017 at 19:07, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
>>>> Whether cpu_dma_latency should be 0 or 1, I'm not sure yet. I assume
>>>> your 30% boost was when going from throughput-performance to
>>>> dma_latency=0, right? I'm trying to understand what is the incremental
>>>> improvement from 1 to 0.
>>>
>>> Probably minimal given that represents a state transition latency
>>> taking only 1us. Presumably the main issue is when the CPU can drop
>>> into the lower states and the compounding impact of that over time. I
>>> will do some simple characterisation of that over the next couple of
>>> weeks and report back...
>>>
>>> --
>>> Cheers,
>>> ~Blairo
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>>
>> --
>> Cheers,
>> Brad
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



--
Cheers,
Brad
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--94eb2c07ab22dc7742054ebcc4ed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sounds good, but could also have a config option to set i=
t before dropping root?</div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On 4 May 2017 20:28, &quot;Brad Hubbard&quot; &lt;<a href=3D"ma=
ilto:bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br type=3D"att=
ribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Thu, May 4, 2017 at 10:58 AM, Haomai =
Wang &lt;<a href=3D"mailto:haomai-p1s0O0zx/60@public.gmane.org">haomai-p1s0O0zx/60@public.gmane.org</a>&gt; wrote:<=
br>
&gt; refer to <a href=3D"https://github.com/ceph/ceph/pull/5013" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/ceph/ceph/<wbr>pull/5013</a><=
br>
<br>
How about we issue a warning about possible performance implications<br>
if we detect this is not set to 1 *or* 0 at startup?<br>
<div class=3D"elided-text"><br>
&gt;<br>
&gt; On Thu, May 4, 2017 at 7:56 AM, Brad Hubbard &lt;<a href=3D"mailto:bhu=
bbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; +ceph-devel to get input on whether we want/need to check the valu=
e of<br>
&gt;&gt; /dev/cpu_dma_latency (platform dependant) at startup and issue a<b=
r>
&gt;&gt; warning, or whether documenting this would suffice?<br>
&gt;&gt;<br>
&gt;&gt; Any doc contribution would be welcomed.<br>
&gt;&gt;<br>
&gt;&gt; On Wed, May 3, 2017 at 7:18 PM, Blair Bethwaite<br>
&gt;&gt; &lt;<a href=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">blair.bethwaite@g=
mail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; On 3 May 2017 at 19:07, Dan van der Ster &lt;<a href=3D"mailto=
:dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org">dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; Whether cpu_dma_latency should be 0 or 1, I&#39;m not sure=
 yet. I assume<br>
&gt;&gt;&gt;&gt; your 30% boost was when going from throughput-performance =
to<br>
&gt;&gt;&gt;&gt; dma_latency=3D0, right? I&#39;m trying to understand what =
is the incremental<br>
&gt;&gt;&gt;&gt; improvement from 1 to 0.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Probably minimal given that represents a state transition late=
ncy<br>
&gt;&gt;&gt; taking only 1us. Presumably the main issue is when the CPU can=
 drop<br>
&gt;&gt;&gt; into the lower states and the compounding impact of that over =
time. I<br>
&gt;&gt;&gt; will do some simple characterisation of that over the next cou=
ple of<br>
&gt;&gt;&gt; weeks and report back...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Cheers,<br>
&gt;&gt;&gt; ~Blairo<br>
&gt;&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists.=
ceph.com</a><br>
&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.=
com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listin=
fo.cgi/ceph-users-ceph.<wbr>com</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Cheers,<br>
&gt;&gt; Brad<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; ceph-users mailing list<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a><br>
&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
 rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.c=
gi/ceph-users-ceph.<wbr>com</a><br>
<br>
<br>
<br>
--<br>
</div>Cheers,<br>
Brad<br>
<div class=3D"elided-text">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</div></blockquote></div><br></div>

--94eb2c07ab22dc7742054ebcc4ed--

--===============1156786867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1156786867==--
