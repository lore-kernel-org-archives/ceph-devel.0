From: Brady Deetz <bdeetz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Does anyone use interactive CLI mode?
Date: Wed, 10 Oct 2018 13:20:19 -0500
Message-ID: <CADU_9qVhwm3N6ukLu-osdAfc5JAmp5zbQfi2Pga3L48PQ01Ryg@mail.gmail.com>
References: <CALe9h7c5kJudfsQ6Vf_vczUG0CeoN8=dxznC=92RamBvxD9u0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7579744435038705764=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7c5kJudfsQ6Vf_vczUG0CeoN8=dxznC=92RamBvxD9u0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============7579744435038705764==
Content-Type: multipart/alternative; boundary="000000000000ad0a0e0577e3ea66"

--000000000000ad0a0e0577e3ea66
Content-Type: text/plain; charset="UTF-8"

I run 2 clusters and have never purposely executed the interactive cli. I
save remove the code bloat.

On Wed, Oct 10, 2018 at 9:20 AM John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi all,
>
> Since time immemorial, the Ceph CLI has had a mode where when run with
> no arguments, you just get an interactive prompt that lets you run
> commands without "ceph" at the start.
>
> I recently discovered that we actually broke this in Mimic[1], and it
> seems that nobody noticed!
>
> So the question is: does anyone actually use this feature?  It's not
> particularly expensive to maintain, but it might be nice to have one
> less path through the code if this is entirely unused.
>
> Cheers,
> John
>
> 1. https://github.com/ceph/ceph/pull/24521
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000ad0a0e0577e3ea66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I run 2 clusters and have never purposely executed the int=
eractive cli. I save remove the code bloat.</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr">On Wed, Oct 10, 2018 at 9:20 AM John Spray &lt;<a hre=
f=3D"mailto:jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Hi all,<br>
<br>
Since time immemorial, the Ceph CLI has had a mode where when run with<br>
no arguments, you just get an interactive prompt that lets you run<br>
commands without &quot;ceph&quot; at the start.<br>
<br>
I recently discovered that we actually broke this in Mimic[1], and it<br>
seems that nobody noticed!<br>
<br>
So the question is: does anyone actually use this feature?=C2=A0 It&#39;s n=
ot<br>
particularly expensive to maintain, but it might be nice to have one<br>
less path through the code if this is entirely unused.<br>
<br>
Cheers,<br>
John<br>
<br>
1. <a href=3D"https://github.com/ceph/ceph/pull/24521" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/ceph/ceph/pull/24521</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--000000000000ad0a0e0577e3ea66--

--===============7579744435038705764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7579744435038705764==--
