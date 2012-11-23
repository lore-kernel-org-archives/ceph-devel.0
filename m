From: Sebastien HAN <han.sebastien@gmail.com>
Subject: Re: New Project with Ceph
Date: Fri, 23 Nov 2012 18:53:25 +0100
Message-ID: <89FBB32B-22B7-4769-93D4-5721631AE0D5@gmail.com>
References: <C4049E4484F13747B672D64B9C12C31328D93097@PWMAILM01.cscinfo.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:59879 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2KWRxe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 12:53:34 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so3657274eaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 09:53:32 -0800 (PST)
In-Reply-To: <C4049E4484F13747B672D64B9C12C31328D93097@PWMAILM01.cscinfo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Your project seems nice, nothing really new in term of integration but =
quite promissing. I also think it's good idea that people start to spea=
k about their project, you can get input from the community.=20

It's fairly easy to make an RBD device surviving a reboot. I assume tha=
t your iSCSI export will be handle by at least 2 machines for HA purpos=
e. Thus you will use Pacemaker, there is already =C3=A0 RA for that and=
 it's part of the ceph package as well ;-). If a server crash the devic=
e is re-mappped on the other server and can possibily failback when fir=
st node comes back online. On top of the stack you could use the RA for=
 Lio and even do multi-pathing.=20

In term of RBD size, if you can use smaller devices. Thank to this you =
will get more IOPS operations. Since RBD devices are stripped over obje=
cts. My benchmarks (and I'm not the only one) showed me that multiple R=
BD scale better.=20

I wish you the best for your project. ;-)

Cheers!=20

On 23 nov. 2012, at 18:31, "Holcombe, Christopher" <cholcomb@cscinfo.co=
m> wrote:

> Hi Everyone,
>=20
> First email here to the developer Ceph mailing list.  Some of you may=
 know me from the irc channel under the handle 'noob2' .  I hang out th=
ere every once in a while to ask questions and share knowledge. Last we=
ek I discussed a project I am working on in the irc channel.  Scuttlemo=
nkey suggested I send an email off to this list with the possibility of=
 a guest entry on the Ceph blog!  Let me describe what I am trying to a=
ccomplish:
>=20
> Background : VMware Storage using Ceph.  After discovering Ceph I tho=
ught of several uses for it.  Storage is really expensive for enterpris=
e customers and it doesn't need to be.  Going back to first principles =
results in the conclusion that storage hardware is very cheap now.  Abo=
ut 5% to 10% what enterprise customers are paying.  With that in mind I=
 realized there is great room for improvement.  Most of the storage we =
use is carried over a brocade fibre network and I think Ceph is perfect=
 for this task.  What is needed is a proxy to merge the rados back end =
to the fibre network.  I used LIO on a previous project and had a theor=
y that I could use it to meet our storage needs with Ceph.  At some poi=
nt in the future we will direct mount rbd over the network but we are n=
ot ready for that yet.
>=20
> Design: Ceph already did most of the heavy lifting for me.  Triple re=
plication, self-healing, interaction through the kernel as a block devi=
ce and ability to scale easily with commodity servers.  My production C=
eph cluster which I'm still in the process of getting quotes for will b=
e HP DL180G6 servers.   Each of these will house 12 3TB data drives con=
nected to a HP410 1GB flash backed write controller.  In building some =
previous clusters I learned that spending a little extra on the raid co=
ntroller is usually worth it.  Our network contains 2 48 port gigabit s=
witches in each rack for redundancy.  My plan is to use a 4 port gigabi=
t network card and split the replication traffic off from the client tr=
affic.  I plan on setting up 2 802.3ad aggregated links.  That should g=
ive the server about 2x 1.9Gb/s of bandwidth.  We are currently short o=
n 10Gb network ports but from what I'm seeing in testing the HP raid ca=
rds can't handle enough data to make it worth it.  If that changes afte=
r tuning I can always upgrade.  We are an HP shop so my hands are a lit=
tle tied.  Next is the proxy machines.  I'm going to reuse 2 older HP d=
l380 G5 servers that we took out of service.  One will be part of the A=
 fabric for the fibre and the other will be on the B fabric.  This is n=
eeded for redundancy so the fibre initiator can fail back and forth sho=
uld it need to.  I plan on creating rbd blocks of 1TB each on the Ceph =
cluster, mounting it on both of the proxy machines and exporting using =
LIO.  LIO has both block mode which can export any block device the ker=
nel knows about or file mode which can export a file as a block device.=
  My testing has shown that VMware can mount this storage, vmotion vm's=
 onto it and use it like any other SAN storage.  The only challenge I h=
ave at this point is getting the rbd devices to survive a reboot on the=
 proxy machines.  I also will have to train the other admins on how to =
use it.  It is certainly more complicated than SAN storage we are used =
to but that shouldn't stop me.  I can build a web interface on top of t=
his using django.  If I can achieve these without too much difficulty t=
han Ceph is truly an enterprise storage replacement.
> That's my project at a high level.  Ceph has many uses but I'm findin=
g this use the most interesting at the moment.  When it is all finished=
 it should save us over 90% on storage costs going forward.  If anyone =
knows how I could go about getting Ubuntu to save rbd mappings after a =
reboot that would be really helpful.  Thank you guys for your hard work=
!
>=20
>=20
> Chris Holcombe
> Unix Administrator
> Corporation Service Company
> cholcomb@cscinfo.com
> 302-636-8667
>=20
>=20
> ________________________________
>=20
> NOTICE: This e-mail and any attachments is intended only for use by t=
he addressee(s) named herein and may contain legally privileged, propri=
etary or confidential information. If you are not the intended recipien=
t of this e-mail, you are hereby notified that any dissemination, distr=
ibution or copying of this email, and any attachments thereto, is stric=
tly prohibited. If you receive this email in error please immediately n=
otify me via reply email or at (800) 927-9800 and permanently delete th=
e original copy and any copy of any e-mail, and any printout.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
