From: Jake Young <jak3kaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph + VMWare
Date: Fri, 7 Oct 2016 18:39:10 -0400
Message-ID: <CAMnske1a7QWOcwMQtUiSKxKC+ExrvAzw9d5_GXOyfOizvAniHQ@mail.gmail.com>
References: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0269382380=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0269382380==
Content-Type: multipart/alternative; boundary=001a11432e0a3a7f07053e4e14e8

--001a11432e0a3a7f07053e4e14e8
Content-Type: text/plain; charset=UTF-8

Hey Patrick,

I work for Cisco.

We have a 200TB cluster (108 OSDs on 12 OSD Nodes) and use the cluster for
both OpenStack and VMware deployments.

We are using iSCSI now, but it really would be much better if VMware did
support RBD natively.

We present a 1-2TB Volume that is shared between 4-8 ESXi hosts.

I have been looking for an optimal solution for a few years now, and I have
finally found something that works pretty well:

We are installing FreeNAS on a KVM hypervisor and passing through rbd
volumes as disks on a SCSI bus. We are able to add volumes dynamically (no
need to reboot FreeNAS to recognize new drives).  In FreeNAS, we are
passing the disks through directly as iscsi targets, we are not putting the
disks into a ZFS volume.

The biggest benefit to this is that VMware really likes the FreeBSD target
and all VAAI stuff works reliably. We also get the benefit of the stability
of rbd in QEMU client.

My next step is to create a redundant KVM host with a redundant FreeNAS VM
and see how iscsi multipath works with the ESXi hosts.

We have tried many different things and have run into all the same issues
as others have posted on this list. The general theme seems to be that most
(all?) Linux iSCSI Target software and Linux NFS solutions are not very
good. The BSD OS's (FreeBSD, Solaris derivatives, etc.) do these things a
lot better, but typically lack Ceph support as well as having poor HW
compatibility (compared to Linux).

Our goal has always been to replace FC SAN with something comparable in
performance, reliability and redundancy.

Again, the best thing in the world would be for ESXi to mount rbd volumes
natively using librbd. I'm not sure if VMware is interested in this though.

Jake


On Wednesday, October 5, 2016, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hey guys,
>
> Starting to buckle down a bit in looking at how we can better set up
> Ceph for VMWare integration, but I need a little info/help from you
> folks.
>
> If you currently are using Ceph+VMWare, or are exploring the option,
> I'd like some simple info from you:
>
> 1) Company
> 2) Current deployment size
> 3) Expected deployment growth
> 4) Integration method (or desired method) ex: iscsi, native, etc
>
> Just casting the net so we know who is interested and might want to
> help us shape and/or test things in the future if we can make it
> better. Thanks.
>
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
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <javascript:;>
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11432e0a3a7f07053e4e14e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Patrick,<div><br></div><div>I work for=C2=A0Cisco.=C2=A0</div><div><br>=
</div><div>We have a 200TB cluster (108 OSDs on 12 OSD Nodes)=C2=A0and use =
the cluster for both OpenStack and VMware deployments.=C2=A0</div><div><br>=
</div><div>We are using iSCSI now, but it really would be much better if VM=
ware did support RBD natively.=C2=A0</div><div><br></div><div>We present a =
1-2TB Volume that is shared between 4-8 ESXi=C2=A0<span></span>hosts.=C2=A0=
</div><div><br></div><div>I have been looking for an optimal solution for a=
 few years now, and I have finally found something that works pretty well:=
=C2=A0</div><div><br></div><div>We are installing FreeNAS on a KVM hypervis=
or and passing through rbd volumes as disks on a SCSI bus. We are able to a=
dd volumes dynamically (no need to reboot FreeNAS to recognize new drives).=
=C2=A0 In FreeNAS, we are passing the disks through directly as iscsi targe=
ts, we are not putting the disks into a ZFS volume.=C2=A0</div><div><br></d=
iv><div>The biggest benefit to this is that VMware really likes the FreeBSD=
 target and all VAAI stuff works reliably. We also get the benefit of the s=
tability of rbd in QEMU client.=C2=A0</div><div><br></div><div>My next step=
 is to create a redundant KVM host with a redundant FreeNAS VM and see how =
iscsi multipath works with the ESXi hosts.=C2=A0</div><div><br></div><div>W=
e have tried many different things and have run into all the same issues as=
 others have posted on this list. The general theme seems to be that most (=
all?) Linux iSCSI Target software and Linux NFS solutions are not very good=
. The BSD OS&#39;s (FreeBSD, Solaris derivatives, etc.)=C2=A0do these thing=
s a lot better, but typically lack Ceph support as well as having poor HW c=
ompatibility (compared to Linux).=C2=A0</div><div><br></div><div>Our goal h=
as always been to replace FC SAN with something comparable in performance, =
reliability and redundancy.=C2=A0</div><div><br></div><div>Again, the best =
thing in the world would be for ESXi to mount rbd volumes natively using li=
brbd. I&#39;m not sure if VMware is interested in this though.=C2=A0</div><=
div><br></div><div>Jake</div><div><br><br>On Wednesday, October 5, 2016, Pa=
trick McGarry &lt;<a href=3D"mailto:pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">pmcgarry-H+wXaHxf7aJhl2p70BpVqQ@public.gmane.org=
m</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hey guys,<br>
<br>
Starting to buckle down a bit in looking at how we can better set up<br>
Ceph for VMWare integration, but I need a little info/help from you<br>
folks.<br>
<br>
If you currently are using Ceph+VMWare, or are exploring the option,<br>
I&#39;d like some simple info from you:<br>
<br>
1) Company<br>
2) Current deployment size<br>
3) Expected deployment growth<br>
4) Integration method (or desired method) ex: iscsi, native, etc<br>
<br>
Just casting the net so we know who is interested and might want to<br>
help us shape and/or test things in the future if we can make it<br>
better. Thanks.<br>
<br>
<br>
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
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&#39;)">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-users-ceph.<wbr>co=
m</a><br>
</blockquote></div>

--001a11432e0a3a7f07053e4e14e8--

--===============0269382380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0269382380==--
