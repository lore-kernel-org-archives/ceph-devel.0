From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: 0.93 fresh cluster won't create PGs
Date: Fri, 27 Mar 2015 23:57:38 -0600
Message-ID: <CAANLjFqn-V=hsp2E=Uz9W0Mz_FY3mUqGoPOhtb5u1gg7kE3zTw@mail.gmail.com>
References: <CAANLjFo8j_Xhn2x86ZdsH7dwTB+_=mfWBh9icVF+9FvK3V4Tfg@mail.gmail.com>
	<alpine.DEB.2.00.1503272057160.18934@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1993345558=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1503272057160.18934-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1993345558==
Content-Type: multipart/alternative; boundary=047d7bfd027a24c46d051252ed4b

--047d7bfd027a24c46d051252ed4b
Content-Type: text/plain; charset=UTF-8

Thanks, we'll give the gitbuilder packages a shot and report back.

Robert LeBlanc

Sent from a mobile device please excuse any typos.
On Mar 27, 2015 10:03 PM, "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Fri, 27 Mar 2015, Robert LeBlanc wrote:
> > I've built Ceph clusters a few times now and I'm completely baffled
> > about what we are seeing. We had a majority of the nodes on a new
> > cluster go down yesterday and we got PGs stuck peering. We checked
> > logs, firewalls, file descriptors, etc and nothing is pointing to what
> > the problem is. We thought we could work around the problem by
> > deleting all the pools and recreating them, but still most of the PGs
> > were in a creating+peering state. Rebooting OSDs, reformatting them,
> > adjusting the CRUSH, etc all proved fruitless. I took min_size and
> > size to 1, tried scrubbing, deep-scrubbing the PGs and OSDs. Nothing
> > seems to get the cluster to progress.
> >
> > As a last ditch effort, we wiped the whole cluster, regenerated UUID,
> > keys, etc and pushed it all through puppet again. After creating the
> > OSDs there are PGs stuck. Here is some info:
> >
> > [ulhglive-root@mon1 ~]# ceph status
> >     cluster fa158fa8-3e5d-47b1-a7bc-98a41f510ac0
> >      health HEALTH_WARN
> >             1214 pgs peering
> >             1216 pgs stuck inactive
> >             1216 pgs stuck unclean
> >      monmap e2: 3 mons at
> > {mon1=
> 10.217.72.27:6789/0,mon2=10.217.72.28:6789/0,mon3=10.217.72.29:6789/0}
> >             election epoch 6, quorum 0,1,2 mon1,mon2,mon3
> >      osdmap e161: 130 osds: 130 up, 130 in
> >       pgmap v468: 2048 pgs, 2 pools, 0 bytes data, 0 objects
> >             5514 MB used, 472 TB / 472 TB avail
> >                  965 peering
> >                  832 active+clean
> >                  249 creating+peering
> >                    2 activating
>
> Usually when we've seen something like this is has been something annoying
> with the environment, like a broken network that causes the tcp streams to
> freeze once they start sending significant traffic (e.g., affecting the
> connections that transpart data but not the ones that handle heartbeats).
>
> As you're rebuilding, perhaps the issues start once you hit a particular
> rack or host?
>
> > [ulhglive-root@mon1 ~]# ceph health detail | head -n 15
> > HEALTH_WARN 1214 pgs peering; 1216 pgs stuck inactive; 1216 pgs stuck
> unclean
> > pg 2.17f is stuck inactive since forever, current state
> > creating+peering, last acting [39,42,77]
> > pg 2.17e is stuck inactive since forever, current state
> > creating+peering, last acting [125,3,110]
> > pg 2.179 is stuck inactive since forever, current state peering, last
> acting [0]
> > pg 2.178 is stuck inactive since forever, current state
> > creating+peering, last acting [99,120,54]
> > pg 2.17b is stuck inactive since forever, current state peering, last
> acting [0]
> > pg 2.17a is stuck inactive since forever, current state
> > creating+peering, last acting [91,96,122]
> > pg 2.175 is stuck inactive since forever, current state
> > creating+peering, last acting [55,127,2]
> > pg 2.174 is stuck inactive since forever, current state peering, last
> acting [0]
> > pg 2.176 is stuck inactive since forever, current state
> > creating+peering, last acting [13,70,8]
> > pg 2.172 is stuck inactive since forever, current state peering, last
> acting [0]
> > pg 2.16c is stuck inactive for 1344.369455, current state peering,
> > last acting [99,104,85]
> > pg 2.16e is stuck inactive since forever, current state peering, last
> acting [0]
> > pg 2.169 is stuck inactive since forever, current state
> > creating+peering, last acting [125,24,65]
> > pg 2.16a is stuck inactive since forever, current state peering, last
> acting [0]
> > Traceback (most recent call last):
> >   File "/bin/ceph", line 896, in <module>
> >     retval = main()
> >   File "/bin/ceph", line 883, in main
> >     sys.stdout.write(prefix + outbuf + suffix)
> > IOError: [Errno 32] Broken pipe
> > [ulhglive-root@mon1 ~]# ceph pg dump_stuck | head -n 15
> > ok
> > pg_stat state   up      up_primary      acting  acting_primary
> > 2.17f   creating+peering        [39,42,77]      39      [39,42,77]
> 39
> > 2.17e   creating+peering        [125,3,110]     125     [125,3,110]
>  125
> > 2.179   peering [0]     0       [0]     0
> > 2.178   creating+peering        [99,120,54]     99      [99,120,54]
>  99
> > 2.17b   peering [0]     0       [0]     0
> > 2.17a   creating+peering        [91,96,122]     91      [91,96,122]
>  91
> > 2.175   creating+peering        [55,127,2]      55      [55,127,2]
> 55
> > 2.174   peering [0]     0       [0]     0
> > 2.176   creating+peering        [13,70,8]       13      [13,70,8]
>  13
> > 2.172   peering [0]     0       [0]     0
> > 2.16c   peering [99,104,85]     99      [99,104,85]     99
> > 2.16e   peering [0]     0       [0]     0
> > 2.169   creating+peering        [125,24,65]     125     [125,24,65]
>  125
> > 2.16a   peering [0]     0       [0]     0
> >
> > Focusing on 2.17f on OSD 39, I set debugging to 20/20 and am attaching
> > the logs. I've looked through the logs with 20/20 before we toasted
> > the cluster and I couldn't find anything standing out. I have another
> > cluster that is also exhibiting this problem which I'd prefer not to
> > lose the data on. If anything stands out, please let me know. We are
> > going to wipe this cluster again and take more manual steps.
> >
> > ceph-osd.39.log.xz -
> >
> https://owncloud.leblancnet.us/owncloud/public.php?service=files&t=b120a67cc6111ffcba54d2e4cc8a62b5
> > map.xz -
> https://owncloud.leblancnet.us/owncloud/public.php?service=files&t=df1eecf7d307225b7d43b5c9474561d0
>
> It looks liek this particular PG isn't getting a query response from
> osd.39 and osd.42.  The 'ceph pg 2.17f query' will likely tell you
> something similar that it is trying to get info from those OSDs.  If you
> crank up debug ms = 20 you'll be able watch it try to connect and send
> messages to those peers as well, and if you have logging on the other
> end you can see if the message arrives or not.
>
> It's also possible that this is a bug in 0.93 that we've fixed (there have
> been tons of those); before investing too much effort I would try
> installing the latest hammer branch from the gitbuilders as that's
> very very close to what will be released next week.
>
> Hope that helps!
> sage
>
>
> >
> >
> > After redoing the cluster again, we started slow. We added one OSD,
> > dropped the pools to min_size=1 and size=1, and the cluster became
> > healthy. We added a second OSD and changed the CRUSH rule to OSD and
> > it became healthy again. We change size=3 and min_size=2. We had
> > puppet add 10 OSDs on one host, and waited, the cluster became healthy
> > again. We had puppet add another host with 10 OSDs and waited for the
> > cluster to become healthy again. We had puppet add the 8 remaining
> > OSDs on the first host and the cluster became healthy again. We set
> > the CRUSH rule back to host and the cluster became healthy again.
> >
> > In order to test a theory we decided to kick off puppet on the
> > remaining 10 hosts with 10 OSDs each at the same time (similar to what
> > we did before). When about the 97th OSD was added, we started getting
> > messages in ceph -w about stuck PGs and the cluster never became
> > healthy.
> >
> > I wonder if there are too many changes in too short of an amount of
> > time causing the OSDs to overrun a journal or something (I know that
> > Ceph journals pgmap changes and such). I'm concerned that this could
> > be very detrimental in a production environment. There doesn't seem to
> > be a way to recover from this.
> >
> > Any thoughts?
> >
> > Thanks,
> > Robert LeBlanc
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
>

--047d7bfd027a24c46d051252ed4b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks, we&#39;ll give the gitbuilder packages a shot and re=
port back.=C2=A0 </p>
<p dir=3D"ltr">Robert LeBlanc</p>
<p dir=3D"ltr">Sent from a mobile device please excuse any typos.</p>
<div class=3D"gmail_quote">On Mar 27, 2015 10:03 PM, &quot;Sage Weil&quot; =
&lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<b=
r type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 27 Mar 2015, =
Robert LeBlanc wrote:<br>
&gt; I&#39;ve built Ceph clusters a few times now and I&#39;m completely ba=
ffled<br>
&gt; about what we are seeing. We had a majority of the nodes on a new<br>
&gt; cluster go down yesterday and we got PGs stuck peering. We checked<br>
&gt; logs, firewalls, file descriptors, etc and nothing is pointing to what=
<br>
&gt; the problem is. We thought we could work around the problem by<br>
&gt; deleting all the pools and recreating them, but still most of the PGs<=
br>
&gt; were in a creating+peering state. Rebooting OSDs, reformatting them,<b=
r>
&gt; adjusting the CRUSH, etc all proved fruitless. I took min_size and<br>
&gt; size to 1, tried scrubbing, deep-scrubbing the PGs and OSDs. Nothing<b=
r>
&gt; seems to get the cluster to progress.<br>
&gt;<br>
&gt; As a last ditch effort, we wiped the whole cluster, regenerated UUID,<=
br>
&gt; keys, etc and pushed it all through puppet again. After creating the<b=
r>
&gt; OSDs there are PGs stuck. Here is some info:<br>
&gt;<br>
&gt; [ulhglive-root@mon1 ~]# ceph status<br>
&gt;=C2=A0 =C2=A0 =C2=A0cluster fa158fa8-3e5d-47b1-a7bc-98a41f510ac0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 health HEALTH_WARN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01214 pgs peering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01216 pgs stuck inactive=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01216 pgs stuck unclean<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 monmap e2: 3 mons at<br>
&gt; {mon1=3D<a href=3D"http://10.217.72.27:6789/0,mon2=3D10.217.72.28:6789=
/0,mon3=3D10.217.72.29:6789/0" target=3D"_blank">10.217.72.27:6789/0,mon2=
=3D10.217.72.28:6789/0,mon3=3D10.217.72.29:6789/0</a>}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0election epoch 6, quoru=
m 0,1,2 mon1,mon2,mon3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 osdmap e161: 130 osds: 130 up, 130 in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pgmap v468: 2048 pgs, 2 pools, 0 bytes data,=
 0 objects<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05514 MB used, 472 TB / =
472 TB avail<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 965 peer=
ing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 832 acti=
ve+clean<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 249 crea=
ting+peering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2=
 activating<br>
<br>
Usually when we&#39;ve seen something like this is has been something annoy=
ing<br>
with the environment, like a broken network that causes the tcp streams to<=
br>
freeze once they start sending significant traffic (e.g., affecting the<br>
connections that transpart data but not the ones that handle heartbeats).<b=
r>
<br>
As you&#39;re rebuilding, perhaps the issues start once you hit a particula=
r<br>
rack or host?<br>
<br>
&gt; [ulhglive-root@mon1 ~]# ceph health detail | head -n 15<br>
&gt; HEALTH_WARN 1214 pgs peering; 1216 pgs stuck inactive; 1216 pgs stuck =
unclean<br>
&gt; pg 2.17f is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [39,42,77]<br>
&gt; pg 2.17e is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [125,3,110]<br>
&gt; pg 2.179 is stuck inactive since forever, current state peering, last =
acting [0]<br>
&gt; pg 2.178 is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [99,120,54]<br>
&gt; pg 2.17b is stuck inactive since forever, current state peering, last =
acting [0]<br>
&gt; pg 2.17a is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [91,96,122]<br>
&gt; pg 2.175 is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [55,127,2]<br>
&gt; pg 2.174 is stuck inactive since forever, current state peering, last =
acting [0]<br>
&gt; pg 2.176 is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [13,70,8]<br>
&gt; pg 2.172 is stuck inactive since forever, current state peering, last =
acting [0]<br>
&gt; pg 2.16c is stuck inactive for 1344.369455, current state peering,<br>
&gt; last acting [99,104,85]<br>
&gt; pg 2.16e is stuck inactive since forever, current state peering, last =
acting [0]<br>
&gt; pg 2.169 is stuck inactive since forever, current state<br>
&gt; creating+peering, last acting [125,24,65]<br>
&gt; pg 2.16a is stuck inactive since forever, current state peering, last =
acting [0]<br>
&gt; Traceback (most recent call last):<br>
&gt;=C2=A0 =C2=A0File &quot;/bin/ceph&quot;, line 896, in &lt;module&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0retval =3D main()<br>
&gt;=C2=A0 =C2=A0File &quot;/bin/ceph&quot;, line 883, in main<br>
&gt;=C2=A0 =C2=A0 =C2=A0sys.stdout.write(prefix + outbuf + suffix)<br>
&gt; IOError: [Errno 32] Broken pipe<br>
&gt; [ulhglive-root@mon1 ~]# ceph pg dump_stuck | head -n 15<br>
&gt; ok<br>
&gt; pg_stat state=C2=A0 =C2=A0up=C2=A0 =C2=A0 =C2=A0 up_primary=C2=A0 =C2=
=A0 =C2=A0 acting=C2=A0 acting_primary<br>
&gt; 2.17f=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [39,42,7=
7]=C2=A0 =C2=A0 =C2=A0 39=C2=A0 =C2=A0 =C2=A0 [39,42,77]=C2=A0 =C2=A0 =C2=
=A0 39<br>
&gt; 2.17e=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [125,3,1=
10]=C2=A0 =C2=A0 =C2=A0125=C2=A0 =C2=A0 =C2=A0[125,3,110]=C2=A0 =C2=A0 =C2=
=A0125<br>
&gt; 2.179=C2=A0 =C2=A0peering [0]=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0=
 =C2=A0[0]=C2=A0 =C2=A0 =C2=A00<br>
&gt; 2.178=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [99,120,=
54]=C2=A0 =C2=A0 =C2=A099=C2=A0 =C2=A0 =C2=A0 [99,120,54]=C2=A0 =C2=A0 =C2=
=A099<br>
&gt; 2.17b=C2=A0 =C2=A0peering [0]=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0=
 =C2=A0[0]=C2=A0 =C2=A0 =C2=A00<br>
&gt; 2.17a=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [91,96,1=
22]=C2=A0 =C2=A0 =C2=A091=C2=A0 =C2=A0 =C2=A0 [91,96,122]=C2=A0 =C2=A0 =C2=
=A091<br>
&gt; 2.175=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [55,127,=
2]=C2=A0 =C2=A0 =C2=A0 55=C2=A0 =C2=A0 =C2=A0 [55,127,2]=C2=A0 =C2=A0 =C2=
=A0 55<br>
&gt; 2.174=C2=A0 =C2=A0peering [0]=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0=
 =C2=A0[0]=C2=A0 =C2=A0 =C2=A00<br>
&gt; 2.176=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [13,70,8=
]=C2=A0 =C2=A0 =C2=A0 =C2=A013=C2=A0 =C2=A0 =C2=A0 [13,70,8]=C2=A0 =C2=A0 =
=C2=A0 =C2=A013<br>
&gt; 2.172=C2=A0 =C2=A0peering [0]=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0=
 =C2=A0[0]=C2=A0 =C2=A0 =C2=A00<br>
&gt; 2.16c=C2=A0 =C2=A0peering [99,104,85]=C2=A0 =C2=A0 =C2=A099=C2=A0 =C2=
=A0 =C2=A0 [99,104,85]=C2=A0 =C2=A0 =C2=A099<br>
&gt; 2.16e=C2=A0 =C2=A0peering [0]=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0=
 =C2=A0[0]=C2=A0 =C2=A0 =C2=A00<br>
&gt; 2.169=C2=A0 =C2=A0creating+peering=C2=A0 =C2=A0 =C2=A0 =C2=A0 [125,24,=
65]=C2=A0 =C2=A0 =C2=A0125=C2=A0 =C2=A0 =C2=A0[125,24,65]=C2=A0 =C2=A0 =C2=
=A0125<br>
&gt; 2.16a=C2=A0 =C2=A0peering [0]=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0=
 =C2=A0[0]=C2=A0 =C2=A0 =C2=A00<br>
&gt;<br>
&gt; Focusing on 2.17f on OSD 39, I set debugging to 20/20 and am attaching=
<br>
&gt; the logs. I&#39;ve looked through the logs with 20/20 before we toaste=
d<br>
&gt; the cluster and I couldn&#39;t find anything standing out. I have anot=
her<br>
&gt; cluster that is also exhibiting this problem which I&#39;d prefer not =
to<br>
&gt; lose the data on. If anything stands out, please let me know. We are<b=
r>
&gt; going to wipe this cluster again and take more manual steps.<br>
&gt;<br>
&gt; ceph-osd.39.log.xz -<br>
&gt; <a href=3D"https://owncloud.leblancnet.us/owncloud/public.php?service=
=3Dfiles&amp;t=3Db120a67cc6111ffcba54d2e4cc8a62b5" target=3D"_blank">https:=
//owncloud.leblancnet.us/owncloud/public.php?service=3Dfiles&amp;t=3Db120a6=
7cc6111ffcba54d2e4cc8a62b5</a><br>
&gt; map.xz - <a href=3D"https://owncloud.leblancnet.us/owncloud/public.php=
?service=3Dfiles&amp;t=3Ddf1eecf7d307225b7d43b5c9474561d0" target=3D"_blank=
">https://owncloud.leblancnet.us/owncloud/public.php?service=3Dfiles&amp;t=
=3Ddf1eecf7d307225b7d43b5c9474561d0</a><br>
<br>
It looks liek this particular PG isn&#39;t getting a query response from<br=
>
osd.39 and osd.42.=C2=A0 The &#39;ceph pg 2.17f query&#39; will likely tell=
 you<br>
something similar that it is trying to get info from those OSDs.=C2=A0 If y=
ou<br>
crank up debug ms =3D 20 you&#39;ll be able watch it try to connect and sen=
d<br>
messages to those peers as well, and if you have logging on the other<br>
end you can see if the message arrives or not.<br>
<br>
It&#39;s also possible that this is a bug in 0.93 that we&#39;ve fixed (the=
re have<br>
been tons of those); before investing too much effort I would try<br>
installing the latest hammer branch from the gitbuilders as that&#39;s<br>
very very close to what will be released next week.<br>
<br>
Hope that helps!<br>
sage<br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt; After redoing the cluster again, we started slow. We added one OSD,<br=
>
&gt; dropped the pools to min_size=3D1 and size=3D1, and the cluster became=
<br>
&gt; healthy. We added a second OSD and changed the CRUSH rule to OSD and<b=
r>
&gt; it became healthy again. We change size=3D3 and min_size=3D2. We had<b=
r>
&gt; puppet add 10 OSDs on one host, and waited, the cluster became healthy=
<br>
&gt; again. We had puppet add another host with 10 OSDs and waited for the<=
br>
&gt; cluster to become healthy again. We had puppet add the 8 remaining<br>
&gt; OSDs on the first host and the cluster became healthy again. We set<br=
>
&gt; the CRUSH rule back to host and the cluster became healthy again.<br>
&gt;<br>
&gt; In order to test a theory we decided to kick off puppet on the<br>
&gt; remaining 10 hosts with 10 OSDs each at the same time (similar to what=
<br>
&gt; we did before). When about the 97th OSD was added, we started getting<=
br>
&gt; messages in ceph -w about stuck PGs and the cluster never became<br>
&gt; healthy.<br>
&gt;<br>
&gt; I wonder if there are too many changes in too short of an amount of<br=
>
&gt; time causing the OSDs to overrun a journal or something (I know that<b=
r>
&gt; Ceph journals pgmap changes and such). I&#39;m concerned that this cou=
ld<br>
&gt; be very detrimental in a production environment. There doesn&#39;t see=
m to<br>
&gt; be a way to recover from this.<br>
&gt;<br>
&gt; Any thoughts?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Robert LeBlanc<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html<=
/a><br>
&gt;<br>
&gt;<br>
</blockquote></div>

--047d7bfd027a24c46d051252ed4b--

--===============1993345558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1993345558==--
