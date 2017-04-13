From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: fsping, why you no work no mo?
Date: Thu, 13 Apr 2017 19:41:13 +0200
Message-ID: <CABZ+qqnUUxq-OVTs6MFYVqnDZdmWqPzq0TjCePAjZtnKGD0E-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0653461122=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0653461122==
Content-Type: multipart/alternative; boundary=001a113d2dfe2fa3be054d0fd7af

--001a113d2dfe2fa3be054d0fd7af
Content-Type: text/plain; charset=UTF-8

Dear ceph-*,

A couple weeks ago I wrote this simple tool to measure the round-trip
latency of a shared filesystem.

   https://github.com/dvanders/fsping

In our case, the tool is to be run from two clients who mount the same
CephFS.

First, start the server (a.k.a. the ping reflector) on one machine in a
CephFS directory:

   ./fsping --server

Then, from another client machine and in the same directory, start the
fsping client (aka the ping emitter):

    ./fsping --prefix <prefix from the server above>

The idea is that the "client" writes a syn file, the reflector notices it,
and writes an ack file. The time for the client to notice the ack file is
what I call the rtt.

And the output looks like normal ping, so that's neat. (The README.md shows
a working example)


Anyway, two weeks ago when I wrote this, it was working very well on my
CephFS clusters (running 10.2.5, IIRC). I was seeing ~20ms rtt for small
files, which is more or less what I was expecting on my test cluster.

But when I run fsping today, it does one of two misbehaviours:

  1. Most of the time it just hangs, both on the reflector and on the
emitter. The fsping processes are stuck in some uninterruptible state --
only an MDS failover breaks them out. I tried with and without
fuse_disable_pagecache -- no big difference.

  2. When I increase the fsping --size to 512kB, it works a bit more
reliably. But there is a weird bimodal distribution with most "packets"
having 20-30ms rtt, some ~20% having ~5-6 seconds rtt, and some ~5% taking
~10-11s. I suspected the mds_tick_interval -- but decreasing that didn't
help.


In summary, if someone is curious, please give this tool a try on your
CephFS cluster -- let me know if its working or not (and what rtt you can
achieve with which configuration).
And perhaps a dev would understand why it is not working with latest jewel
ceph-fuse / ceph MDS's?

Best Regards,

Dan

--001a113d2dfe2fa3be054d0fd7af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear ceph-*,<br><br>A couple weeks ago I wrote this simple=
 tool to measure the round-trip latency of a shared filesystem.<br><br>=C2=
=A0 =C2=A0<a href=3D"https://github.com/dvanders/fsping">https://github.com=
/dvanders/fsping</a><br><br>In our case, the tool is to be run from two cli=
ents who mount the same CephFS.<br><br>First, start the server (a.k.a. the =
ping reflector) on one machine in a CephFS directory:<br><br>=C2=A0 =C2=A0.=
/fsping --server<br><br>Then, from another client machine and in the same d=
irectory, start the fsping client (aka the ping emitter):<br><br>=C2=A0 =C2=
=A0 ./fsping --prefix &lt;prefix from the server above&gt;<br><br>The idea =
is that the &quot;client&quot; writes a syn file, the reflector notices it,=
 and writes an ack file. The time for the client to notice the ack file is =
what I call the rtt.<br><br>And the output looks like normal ping, so that&=
#39;s neat. (The README.md shows a working example)<br><br><br>Anyway, two =
weeks ago when I wrote this, it was working very well on my CephFS clusters=
 (running 10.2.5, IIRC). I was seeing ~20ms rtt for small files, which is m=
ore or less what I was expecting on my test cluster.<br><br>But when I run =
fsping today, it does one of two misbehaviours:<br><br>=C2=A0 1. Most of th=
e time it just hangs, both on the reflector and on the emitter. The fsping =
processes are stuck in some uninterruptible state -- only an MDS failover b=
reaks them out. I tried with and without fuse_disable_pagecache -- no big d=
ifference.<br><br>=C2=A0 2. When I increase the fsping --size to 512kB, it =
works a bit more reliably. But there is a weird bimodal distribution with m=
ost &quot;packets&quot; having 20-30ms rtt, some ~20% having ~5-6 seconds r=
tt, and some ~5% taking ~10-11s. I suspected the mds_tick_interval -- but d=
ecreasing that didn&#39;t help.<br><br><br>In summary, if someone is curiou=
s, please give this tool a try on your CephFS cluster -- let me know if its=
 working or not (and what rtt you can achieve with which configuration).<br=
>And perhaps a dev would understand why it is not working with latest jewel=
 ceph-fuse / ceph MDS&#39;s?<div><br></div><div>Best Regards,</div><div><br=
></div><div>Dan</div><div><br></div><div><br></div></div>

--001a113d2dfe2fa3be054d0fd7af--

--===============0653461122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0653461122==--
