From: Marios-Evaggelos Kogias <marioskogias-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?utf-8?q?=CE=99nstrumenting_RADOS_with_Zipkin_+_LTT?=
	=?utf-8?q?ng?=
Date: Fri, 1 Aug 2014 19:14:16 +0300
Message-ID: <CACDi=KokBUhxkFQqnTKdU1t8qLUXtF-wvhm5x2nMxHAR=9nEKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1878368566=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
Cc: Filippos Giannakos <philipgian-Sqt7GMbKoOQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1878368566==
Content-Type: multipart/alternative; boundary=001a11c2ab4e4916e304ff93ae40

--001a11c2ab4e4916e304ff93ae40
Content-Type: text/plain; charset=UTF-8

Hello all,

my name is Marios Kogias and I am a student at the National Technical
University of Athens. As part of my diploma thesis and my participation in
Google Summer of Code 2014 (in the LTTng organization) I am working on a
low-overhead tracing infrastructure for distributed systems. I am also
collaborating with the Synnefo team (https://www.synnefo.org/) and
especially
with Vangelis Koukis, Constantinos Venetsanopoulos and Filippos Giannakos
(cc)

Some time ago, we started experimenting with RADOS instrumentation using
LTTng and
we noticed that there are similar endeavours in the Ceph github repository
[1].

However, unlike your approach, we are following an annotation-based tracing
schema, which enables us to track a specific request from the time it enters
the system at higher levels till it is finally served by RADOS.

In general, we try to implement the tracing semantics described in the
Dapper
paper [2] in order to trace the causal relationships between the different
processing phases that an IO request may trigger. Our target is an
end-to-end
visualisation of the request's route in the system, accompanied by
information
concerning latencies in each processing phase. Thanks to LTTng this can
happen
with a minimal overhead and in realtime. In order to visualize the results
we
have integrated Twitter's Zipkin [3], (which is a tracing system entirely
based on
Dapper) with LTTng.

You can find a proof of concept of what we've done so far here:

http://snf-551656.vm.okeanos.grnet.gr:8080/traces/0b554b8a48cb3e84?serviceName=MOSDOp

In the above link you can see the trace of a write request served by a RADOS
pool with replication level set to 3 (two replicas).

We'd love to have early feedback and comments from you guys too,
so that we can incorporate useful recommendations. You can find all the
relevant code
here[5][6]. If you have any questions or you wish to experiment with the
project please do not hesitate to contact us.

Kind regards,
Marios

[1]https://github.com/ceph/ceph/tree/wip-lttng
[2]
http://static.googleusercontent.com/media/research.google.com/el//pubs/archive/36356.pdf
[3]http://twitter.github.io/zipkin/
[4] https://github.com/marioskogias/blkin
[5] https://github.com/marioskogias/babeltrace-plugins

--001a11c2ab4e4916e304ff93ae40
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-family:arial,sans-serif;font-size:13px"=
>Hello all,<br><br>my name is Marios Kogias and I am a student at the Natio=
nal Technical<br>University of Athens. As part of my diploma thesis and my =
participation in<br>
Google Summer of Code 2014 (in the LTTng organization) I am working on a<br=
>low-overhead tracing infrastructure for distributed systems. I am also<br>=
collaborating with the Synnefo team (<a href=3D"https://www.synnefo.org/" t=
arget=3D"_blank">https://www.synnefo.org/</a>) and especially<br>
with Vangelis Koukis, Constantinos Venetsanopoulos and Filippos Giannakos (=
cc)<br><br>Some time ago, we started experimenting with RADOS instrumentati=
on using LTTng and<br>we noticed that there are similar endeavours in the C=
eph github repository [1].<br>
</div><br style=3D"font-family:arial,sans-serif;font-size:13px"><div style=
=3D"font-family:arial,sans-serif;font-size:13px"><div>However, unlike your =
approach, we are following an annotation-based tracing<br>schema, which ena=
bles us to track a specific request from the time it enters<br>
the system at higher levels till it is finally served by RADOS.<br><br>In g=
eneral, we try to implement the tracing semantics described in the Dapper<b=
r>paper [2] in order to trace the causal relationships between the differen=
t<br>
processing phases that an IO request may trigger. Our target is an end-to-e=
nd<br>visualisation of the request&#39;s route in the system, accompanied b=
y information<br>concerning latencies in each processing phase. Thanks to L=
TTng this can happen<br>
with a minimal overhead and in realtime. In order to visualize the results =
we<br>have integrated Twitter&#39;s Zipkin [3], (which is a tracing system =
entirely based on<br>Dapper) with LTTng.<br></div><br>You can find a proof =
of concept of what we&#39;ve done so far here:</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px"><a href=3D"http://snf-=
551656.vm.okeanos.grnet.gr:8080/traces/0b554b8a48cb3e84?serviceName=3DMOSDO=
p" target=3D"_blank">http://snf-551656.vm.okeanos.grnet.gr:8080/traces/0b55=
4b8a48cb3e84?serviceName=3DMOSDOp</a><br>
<br>In the above link you can see the trace of a write request served by a =
RADOS<br>pool with replication level set to 3 (two replicas).<br><br>We&#39=
;d love to have early feedback and comments from you guys too,<br>so that w=
e can incorporate useful recommendations.=C2=A0You can find all the relevan=
t code<br>
here[5][6]. If you have any questions or you wish to experiment with the<br=
>project please do not hesitate to contact us.<br><br>Kind regards,</div><d=
iv style=3D"font-family:arial,sans-serif;font-size:13px">Marios<br><br>[1]<=
a href=3D"https://github.com/ceph/ceph/tree/wip-lttng" target=3D"_blank">ht=
tps://github.com/ceph/ceph/tree/wip-lttng</a><br>
[2]<a href=3D"http://static.googleusercontent.com/media/research.google.com=
/el//pubs/archive/36356.pdf" target=3D"_blank">http://static.googleusercont=
ent.com/media/research.google.com/el//pubs/archive/36356.pdf</a><br>[3]<a h=
ref=3D"http://twitter.github.io/zipkin/" target=3D"_blank">http://twitter.g=
ithub.io/zipkin/</a><br>
[4]=C2=A0<a href=3D"https://github.com/marioskogias/blkin" target=3D"_blank=
">https://github.com/marioskogias/blkin</a><br>[5]=C2=A0<a href=3D"https://=
github.com/marioskogias/babeltrace-plugins" target=3D"_blank">https://githu=
b.com/marioskogias/babeltrace-plugins</a><br>
<div><img src=3D"https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.g=
if"></div></div></div>

--001a11c2ab4e4916e304ff93ae40--

--===============1878368566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1878368566==--
