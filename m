From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Prioritize Heartbeat packets
Date: Fri, 6 Mar 2015 17:20:42 -0700
Message-ID: <CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>
	<alpine.DEB.2.00.1408271755160.966@cobra.newdream.net>
	<ltmnkp$tod$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2088691580=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <ltmnkp$tod$1@ger.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2088691580==
Content-Type: multipart/alternative; boundary=001a11c37e3083ccb70510a7c530

--001a11c37e3083ccb70510a7c530
Content-Type: text/plain; charset=UTF-8

I see that Jian Wen has done work on this for 0.94. I tried looking through
the code to see if I can figure out how to configure this new option, but
it all went over my head pretty quick.

Can I get a brief summary on how to set the priority of heartbeat packets
or where to look in the code to figure it out?

Thanks,

On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick <
daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org> wrote:

> On 28/08/14 02:56, Sage Weil wrote:
> > I seem to remember someone telling me there were hooks/hints you could
> > call that would tag either a socket or possibly data on that socket with
> a
> > label for use by iptables and such.. but I forget what it was.
> >
>
> Something like setsockopt() SO_MARK?
>
>        *SO_MARK *(since Linux 2.6.25)
>               Set the mark for each packet sent through this socket
> (similar
>               to the netfilter MARK target but socket-based).  Changing the
>               mark can be used for mark-based routing without netfilter or
>               for packet filtering.  Setting this option requires the
>               *CAP_NET_ADMIN *capability.
>
> Alternatively, directly set IP_TOS options on the socket, or SO_PRIORITY
> which sets the IP TOS bits as well.
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11c37e3083ccb70510a7c530
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I see that=C2=A0<span style=3D"font-size:13px">Jian Wen ha=
s done work on this for 0.94. I tried looking through the code to see if I =
can figure out how to configure this new option, but it all went over my he=
ad pretty quick.</span><div><span style=3D"font-size:13px"><br></span></div=
><div>Can I get a=C2=A0brief=C2=A0summary on how to set the priority of hea=
rtbeat packets or where to look in the code to=C2=A0figure it out?</div><di=
v><span style=3D"font-size:13px"><br></span></div><div><span style=3D"font-=
size:13px">Thanks,</span></div></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org" targe=
t=3D"_blank">daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><span class=3D"">On 28/08/14 02:56, Sage Weil w=
rote:<br>
&gt; I seem to remember someone telling me there were hooks/hints you could=
<br>
&gt; call that would tag either a socket or possibly data on that socket wi=
th a<br>
&gt; label for use by iptables and such.. but I forget what it was.<br>
&gt;<br>
<br>
</span>Something like setsockopt() SO_MARK?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0*SO_MARK *(since Linux 2.6.25)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Set the mark for each pack=
et sent through this socket (similar<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to the netfilter MARK targ=
et but socket-based).=C2=A0 Changing the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mark can be used for mark-=
based routing without netfilter or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for packet filtering.=C2=
=A0 Setting this option requires the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *CAP_NET_ADMIN *capability=
.<br>
<br>
Alternatively, directly set IP_TOS options on the socket, or SO_PRIORITY<br=
>
which sets the IP TOS bits as well.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--001a11c37e3083ccb70510a7c530--

--===============2088691580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2088691580==--
