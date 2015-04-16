From: Chris Armstrong <carmstrong-NLltGlunAUd/unjJdyJNww@public.gmane.org>
Subject: Re: Ceph.com
Date: Thu, 16 Apr 2015 12:34:27 -0400
Message-ID: <CAF9-8kmjM4JixNCEGv8haebnWvOLkJG=pEeEWyTrj0iqN6o8dw@mail.gmail.com>
References: <CAAZbbf3dnrjC3Y=vODZAsX=K6fhKC9OjOS051s5BnW_gbC67yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1793584999=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAZbbf3dnrjC3Y=vODZAsX=K6fhKC9OjOS051s5BnW_gbC67yw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1793584999==
Content-Type: multipart/alternative; boundary=20cf3026662a8539400513da093a

--20cf3026662a8539400513da093a
Content-Type: text/plain; charset=UTF-8

Thanks for the update, Patrick. Our Docker builds were failing due to the
mirror being down. I appreciate being able to check the mailing list and
quickly see what's going on!

Chris

On Thu, Apr 16, 2015 at 11:28 AM, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
wrote:

> Hey cephers,
>
> As most of you have no doubt noticed, ceph.com has been having
> some...er..."issues" lately. Unfortunately this is some of the
> holdover infrastructure stuff from being a startup without a big-boy
> ops plan.
>
> The current setup has ceph.com sharing a host with some of the nightly
> build stuff to make it easier for gitbuilder tasks (that also build
> the website doc) to coexist. Was this smart? No, probably not. Was is
> the quick-and-dirty way for us to get stuff rolling when we were tiny?
> Yep.
>
> So, now that things are continuing to grow (website traffic load,
> ceph-deploy key requests, number of simultaneous builds) we are
> hitting the end of what one hard-working box can handle. I am in the
> process of moving ceph.com to a new host so that build explosions wont
> slag things like Ceph Day pages and the blog, but the doc may lag
> behind a bit.
>
> Hopefully since I'm starting with the website it wont hose up too many
> of the other tasks, but bear with us while we split routing for a bit.
> If you have any questions please feel free to poke me. Thanks.
>
> --
>
> Best Regards,
>
> Patrick McGarry
> Director Ceph Community || Red Hat
> http://ceph.com  ||  http://community.redhat.com
> @scuttlemonkey || @ceph
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
*Chris Armstrong* | Deis Team Lead | Engine Yard

Deis is now part of Engine Yard! http://deis.io/deis-meet-engine-yard/

--20cf3026662a8539400513da093a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the update, Patrick. Our Docker builds were fai=
ling due to the mirror being down. I appreciate being able to check the mai=
ling list and quickly see what&#39;s going on!<div><br></div><div>Chris</di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, A=
pr 16, 2015 at 11:28 AM, Patrick McGarry <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Hey cephers,<br>
<br>
As most of you have no doubt noticed, <a href=3D"http://ceph.com" target=3D=
"_blank">ceph.com</a> has been having<br>
some...er...&quot;issues&quot; lately. Unfortunately this is some of the<br=
>
holdover infrastructure stuff from being a startup without a big-boy<br>
ops plan.<br>
<br>
The current setup has <a href=3D"http://ceph.com" target=3D"_blank">ceph.co=
m</a> sharing a host with some of the nightly<br>
build stuff to make it easier for gitbuilder tasks (that also build<br>
the website doc) to coexist. Was this smart? No, probably not. Was is<br>
the quick-and-dirty way for us to get stuff rolling when we were tiny?<br>
Yep.<br>
<br>
So, now that things are continuing to grow (website traffic load,<br>
ceph-deploy key requests, number of simultaneous builds) we are<br>
hitting the end of what one hard-working box can handle. I am in the<br>
process of moving <a href=3D"http://ceph.com" target=3D"_blank">ceph.com</a=
> to a new host so that build explosions wont<br>
slag things like Ceph Day pages and the blog, but the doc may lag<br>
behind a bit.<br>
<br>
Hopefully since I&#39;m starting with the website it wont hose up too many<=
br>
of the other tasks, but bear with us while we split routing for a bit.<br>
If you have any questions please feel free to poke me. Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
<br>
Best Regards,<br>
<br>
Patrick McGarry<br>
Director Ceph Community || Red Hat<br>
<a href=3D"http://ceph.com" target=3D"_blank">http://ceph.com</a>=C2=A0 ||=
=C2=A0 <a href=3D"http://community.redhat.com" target=3D"_blank">http://com=
munity.redhat.com</a><br>
@scuttlemonkey || @ceph<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div><div dir=3D"ltr"><span style=3D"color:rgb(136,1=
36,136);font-size:12.8000001907349px"><b>Chris Armstrong</b> | Deis Team Le=
ad |=C2=A0</span><font color=3D"red" style=3D"font-size:12.8000001907349px"=
>Engine Yard</font><br></div><div dir=3D"ltr"><font color=3D"red" style=3D"=
font-size:12.8000001907349px"><br></font></div><div><font color=3D"#000000"=
>Deis is now part of Engine Yard! <a href=3D"http://deis.io/deis-meet-engin=
e-yard/" target=3D"_blank">http://deis.io/deis-meet-engine-yard/</a></font>=
</div></div></div></div></div></div>
</div>

--20cf3026662a8539400513da093a--

--===============1793584999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1793584999==--
