From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Prioritize Heartbeat packets
Date: Fri, 10 Apr 2015 08:49:13 -0600
Message-ID: <CAANLjFpSHs1K_0r2Z7_7iSRC_bvhm+uTMN3RcQEGffrT+WuHHw@mail.gmail.com>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>
	<alpine.DEB.2.00.1408271755160.966@cobra.newdream.net>
	<ltmnkp$tod$1@ger.gmane.org>
	<CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
	<mdg18n$gsj$1@ger.gmane.org>
	<CAANLjFpH=0ZjXm2FKNF4Qz421jcM8QsW8HTDGpLqy5=w8POXQw@mail.gmail.com>
	<CAMXzGWK+8hpv0LOp6tAGft_=f8Peb9qackcLXruQH7qVVD9chQ@mail.gmail.com>
	<CAANLjFrwqr-znyMSBw=wCgiVkwqRT69ud3n0yAnhWUH=PZRTTw@mail.gmail.com>
	<CAMXzGWJJpDbV0M0rtTkoRU=tSkgi3tM=x6Sy+wKhfZ=oPNy2hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1776915450=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMXzGWJJpDbV0M0rtTkoRU=tSkgi3tM=x6Sy+wKhfZ=oPNy2hw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jian Wen <wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Swarbrick <daniel.swarbrick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1776915450==
Content-Type: multipart/alternative; boundary=047d7bfd027a2a638f05135fde62

--047d7bfd027a2a638f05135fde62
Content-Type: text/plain; charset=UTF-8

We have had some delays. Our to be production cluster is currently on
firefly but should be on hammer next week. Once upgraded we will preform
the network saturation test and verify results.

Robert LeBlanc

Sent from a mobile device please excuse any typos.
On Apr 10, 2015 12:39 AM, "Jian Wen" <wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Robert,
>     60 days ago, we enabled this feature in our production environment.
>     It works for us.
>
>     Did you see any flapping OSDs?
>
> On Tue, Mar 10, 2015 at 1:16 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> wrote:
> > Jian,
> >
> > Thanks for the clarification. I'll mark traffic destined for the
> > monitors as well. We are getting ready to put our first cluster into
> > production. If you are interested we will be testing the heartbeat
> > priority to see if we can saturate the network (not an easy task for
> > 40 Gb) and keep the cluster from falling apart. Our network team is
> > marking COS based on the DSCP and enforcing priority. We have three
> > VLANs on bonded 40 GbE, management, storage (monitors, clients, OSDs),
> > and cluster (replication). We have three priority classes management
> > (heartbeats on all VLANs, SSH, DNS, etc), storage traffic (no
> > marking), and replication (scavenger class). We are interested to see
> > how things pan out.
> >
> > Thanks,
> > Robert
> >
> > On Mon, Mar 9, 2015 at 8:58 PM, Jian Wen <wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> Only OSD calls set_socket_priority().
> >> See  https://github.com/ceph/ceph/pull/3353
> >>
> >> On Tue, Mar 10, 2015 at 3:36 AM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> wrote:
> >>> I've found commit 9b9a682fe035c985e416ee1c112fa58f9045a27c and I see
> >>> that when 'osd heartbeat use min delay socket = true' it will mark the
> >>> packet with DSCP CS6. Based on the setting of the socket in
> >>> msg/simple/Pipe.cc is it possible that this can apply to both OSD and
> >>> monitor? I don't understand the code enough to know how the
> >>> set_socket_options() is called from the OSD and monitor.
> >>>
> >>> If this applies to both monitor and OSD, would it be better to rename
> >>> the option to a more generic name?
> >>>
> >>> Thanks,
> >>>
> >>> On Sat, Mar 7, 2015 at 4:23 PM, Daniel Swarbrick
> >>> <daniel.swarbrick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>> Judging by the commit, this ought to do the trick:
> >>>>
> >>>> osd heartbeat use min delay socket = true
> >>>>
> >>>> On 07/03/15 01:20, Robert LeBlanc wrote:
> >>>>>
> >>>>> I see that Jian Wen has done work on this for 0.94. I tried looking
> >>>>> through the code to see if I can figure out how to configure this new
> >>>>> option, but it all went over my head pretty quick.
> >>>>>
> >>>>> Can I get a brief summary on how to set the priority of heartbeat
> >>>>> packets or where to look in the code to figure it out?
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick
> >>>>> <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org
> >>>>> <mailto:daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>> wrote:
> >>>>>
> >>>>>     On 28/08/14 02:56, Sage Weil wrote:
> >>>>>     > I seem to remember someone telling me there were hooks/hints
> you
> >>>>> could
> >>>>>     > call that would tag either a socket or possibly data on that
> socket
> >>>>> with a
> >>>>>     > label for use by iptables and such.. but I forget what it was.
> >>>>>     >
> >>>>>
> >>>>>     Something like setsockopt() SO_MARK?
> >>>>>
> >>>>>             *SO_MARK *(since Linux 2.6.25)
> >>>>>                    Set the mark for each packet sent through this
> socket
> >>>>>     (similar
> >>>>>                    to the netfilter MARK target but socket-based).
> >>>>>     Changing the
> >>>>>                    mark can be used for mark-based routing without
> >>>>>     netfilter or
> >>>>>                    for packet filtering.  Setting this option
> requires the
> >>>>>                    *CAP_NET_ADMIN *capability.
> >>>>>
> >>>>>     Alternatively, directly set IP_TOS options on the socket, or
> >>>>> SO_PRIORITY
> >>>>>     which sets the IP TOS bits as well.
> >>>>>
> >>>>>
> >>>>>     _______________________________________________
> >>>>>     ceph-users mailing list
> >>>>>     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>>>     <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >>>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> ceph-users mailing list
> >>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> >>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> _______________________________________________
> >>> ceph-users mailing list
> >>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> >>
> >>
> >> --
> >> Best,
> >>
> >> Jian
>
>
>
> --
> Best,
>
> Jian
>

--047d7bfd027a2a638f05135fde62
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">We have had some delays. Our to be production cluster is cur=
rently on firefly but should be on hammer next week. Once upgraded we will =
preform the network saturation test and verify results. </p>
<p dir=3D"ltr">Robert LeBlanc</p>
<p dir=3D"ltr">Sent from a mobile device please excuse any typos.</p>
<div class=3D"gmail_quote">On Apr 10, 2015 12:39 AM, &quot;Jian Wen&quot; &=
lt;<a href=3D"mailto:wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Robert,<br>
=C2=A0 =C2=A0 60 days ago, we enabled this feature in our production enviro=
nment.<br>
=C2=A0 =C2=A0 It works for us.<br>
<br>
=C2=A0 =C2=A0 Did you see any flapping OSDs?<br>
<br>
On Tue, Mar 10, 2015 at 1:16 PM, Robert LeBlanc &lt;<a href=3D"mailto:rober=
t@leblancnet.us">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br>
&gt; Jian,<br>
&gt;<br>
&gt; Thanks for the clarification. I&#39;ll mark traffic destined for the<b=
r>
&gt; monitors as well. We are getting ready to put our first cluster into<b=
r>
&gt; production. If you are interested we will be testing the heartbeat<br>
&gt; priority to see if we can saturate the network (not an easy task for<b=
r>
&gt; 40 Gb) and keep the cluster from falling apart. Our network team is<br=
>
&gt; marking COS based on the DSCP and enforcing priority. We have three<br=
>
&gt; VLANs on bonded 40 GbE, management, storage (monitors, clients, OSDs),=
<br>
&gt; and cluster (replication). We have three priority classes management<b=
r>
&gt; (heartbeats on all VLANs, SSH, DNS, etc), storage traffic (no<br>
&gt; marking), and replication (scavenger class). We are interested to see<=
br>
&gt; how things pan out.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Robert<br>
&gt;<br>
&gt; On Mon, Mar 9, 2015 at 8:58 PM, Jian Wen &lt;<a href=3D"mailto:wenjian=
hn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; Only OSD calls set_socket_priority().<br>
&gt;&gt; See=C2=A0 <a href=3D"https://github.com/ceph/ceph/pull/3353" targe=
t=3D"_blank">https://github.com/ceph/ceph/pull/3353</a><br>
&gt;&gt;<br>
&gt;&gt; On Tue, Mar 10, 2015 at 3:36 AM, Robert LeBlanc &lt;<a href=3D"mai=
lto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt; I&#39;ve found commit 9b9a682fe035c985e416ee1c112fa58f9045a27c=
 and I see<br>
&gt;&gt;&gt; that when &#39;osd heartbeat use min delay socket =3D true&#39=
; it will mark the<br>
&gt;&gt;&gt; packet with DSCP CS6. Based on the setting of the socket in<br=
>
&gt;&gt;&gt; msg/simple/Pipe.cc is it possible that this can apply to both =
OSD and<br>
&gt;&gt;&gt; monitor? I don&#39;t understand the code enough to know how th=
e<br>
&gt;&gt;&gt; set_socket_options() is called from the OSD and monitor.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If this applies to both monitor and OSD, would it be better to=
 rename<br>
&gt;&gt;&gt; the option to a more generic name?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sat, Mar 7, 2015 at 4:23 PM, Daniel Swarbrick<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:daniel.swarbrick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">daniel.swarb=
rick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; Judging by the commit, this ought to do the trick:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; osd heartbeat use min delay socket =3D true<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 07/03/15 01:20, Robert LeBlanc wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I see that Jian Wen has done work on this for 0.94. I =
tried looking<br>
&gt;&gt;&gt;&gt;&gt; through the code to see if I can figure out how to con=
figure this new<br>
&gt;&gt;&gt;&gt;&gt; option, but it all went over my head pretty quick.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Can I get a brief summary on how to set the priority o=
f heartbeat<br>
&gt;&gt;&gt;&gt;&gt; packets or where to look in the code to figure it out?=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick<br>
&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:daniel.swarbrick-EIkl63zCoXbZz8UjPX3odA@public.gmane.org=
m">daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org</a><br>
&gt;&gt;&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:daniel.swarbrick@profitbr=
icks.com">daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0On 28/08/14 02:56, Sage Weil wrote:=
<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; I seem to remember someone tel=
ling me there were hooks/hints you<br>
&gt;&gt;&gt;&gt;&gt; could<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; call that would tag either a s=
ocket or possibly data on that socket<br>
&gt;&gt;&gt;&gt;&gt; with a<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; label for use by iptables and =
such.. but I forget what it was.<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Something like setsockopt() SO_MARK=
?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*SO_MAR=
K *(since Linux 2.6.25)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Set the mark for each packet sent through this socket<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0(similar<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 to the netfilter MARK target but socket-based).<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Changing the<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 mark can be used for mark-based routing without<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0netfilter or<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 for packet filtering.=C2=A0 Setting this option requires the=
<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 *CAP_NET_ADMIN *capability.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Alternatively, directly set IP_TOS =
options on the socket, or<br>
&gt;&gt;&gt;&gt;&gt; SO_PRIORITY<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0which sets the IP TOS bits as well.=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0___________________________________=
____________<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0ceph-users mailing list<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:ceph-users@lists.=
ceph.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ceph-u=
sers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://lists.ceph.com/li=
stinfo.cgi/ceph-users-ceph.com" target=3D"_blank">http://lists.ceph.com/lis=
tinfo.cgi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-user=
s@lists.ceph.com</a><br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-use=
rs-ceph.com" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-user=
s-ceph.com</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; To unsubscribe from this list: send the line &quot;unsubsc=
ribe ceph-devel&quot; in<br>
&gt;&gt;&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.=
kernel.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt;&gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel=
.org/majordomo-info.html" target=3D"_blank">http://vger.kernel.org/majordom=
o-info.html</a><br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists.=
ceph.com</a><br>
&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.=
com" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.c=
om</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Best,<br>
&gt;&gt;<br>
&gt;&gt; Jian<br>
<br>
<br>
<br>
--<br>
Best,<br>
<br>
Jian<br>
</blockquote></div>

--047d7bfd027a2a638f05135fde62--

--===============1776915450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1776915450==--
