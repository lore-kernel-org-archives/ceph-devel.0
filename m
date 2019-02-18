From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IRC channels now require registered and identified
 users
Date: Mon, 18 Feb 2019 14:17:28 -0500
Message-ID: <CAN-Gep+pJ1txKXRtL6jufzP9bu0n5Sf62WGroOWUJw+6K4kO6A@mail.gmail.com>
References: <ce0a9512-e2cc-8eba-6c0e-226c8351bddf@suse.de>
 <CABZ+qqn+iR6j_kk_RsUastNvysbZzUqMRGHfa7P9x+rwCY4M1w@mail.gmail.com>
 <c1e28839-a3b5-61cf-28be-878a9e539e7e@suse.de>
 <8cdb553c-67fc-a441-aea7-890d37e978fc@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5624141464743708385=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <8cdb553c-67fc-a441-aea7-890d37e978fc-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============5624141464743708385==
Content-Type: multipart/alternative; boundary="00000000000061240605822ffa29"

--00000000000061240605822ffa29
Content-Type: text/plain; charset="UTF-8"

Is this still broken in the 1-way direction where Slack users' comments do
not show up in IRC?  That would explain why nothing I ever type (as either
helping someone or asking a question) ever have anyone respond to them.

On Tue, Dec 18, 2018 at 6:50 AM Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org> wrote:

> On 12/18/2018 11:22 AM, Joao Eduardo Luis wrote:
> > On 12/18/2018 11:18 AM, Dan van der Ster wrote:
> >> Hi Joao,
> >>
> >> Has that broken the Slack connection? I can't tell if its broken or
> >> just quiet... last message on #ceph-devel was today at 1:13am.
> >
> > Just quiet, it seems. Just tested it and the bridge is still working.
>
> Okay, turns out the ceph-ircslackbot user is not identified, and that
> makes it unable to send messages to the channel. This means the bridge
> is working in one direction only (irc to slack), and will likely break
> when/if the user leaves the channel (as it won't be able to get back in).
>
> I will figure out just how this works today. In the mean time, I've
> relaxed the requirement for registered/identified users so that the bot
> works again. It will be reactivated once this is addressed.
>
>   -Joao
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--00000000000061240605822ffa29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is this still broken in the 1-way direction where Slack us=
ers&#39; comments do not show up in IRC?=C2=A0 That would explain why nothi=
ng I ever type (as either helping someone or asking a question) ever have a=
nyone respond to them.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Dec 18, 2018 at 6:50 AM Joao Eduardo Luis &lt=
;<a href=3D"mailto:joao-l3A5Bk7waGM@public.gmane.org">joao-l3A5Bk7waGM@public.gmane.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 12/18/2018 11:22 AM, Joao E=
duardo Luis wrote:<br>
&gt; On 12/18/2018 11:18 AM, Dan van der Ster wrote:<br>
&gt;&gt; Hi Joao,<br>
&gt;&gt;<br>
&gt;&gt; Has that broken the Slack connection? I can&#39;t tell if its brok=
en or<br>
&gt;&gt; just quiet... last message on #ceph-devel was today at 1:13am.<br>
&gt; <br>
&gt; Just quiet, it seems. Just tested it and the bridge is still working.<=
br>
<br>
Okay, turns out the ceph-ircslackbot user is not identified, and that<br>
makes it unable to send messages to the channel. This means the bridge<br>
is working in one direction only (irc to slack), and will likely break<br>
when/if the user leaves the channel (as it won&#39;t be able to get back in=
).<br>
<br>
I will figure out just how this works today. In the mean time, I&#39;ve<br>
relaxed the requirement for registered/identified users so that the bot<br>
works again. It will be reactivated once this is addressed.<br>
<br>
=C2=A0 -Joao<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--00000000000061240605822ffa29--

--===============5624141464743708385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5624141464743708385==--
