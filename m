From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: New Project with Ceph
Date: Sat, 24 Nov 2012 01:41:17 +0100
Message-ID: <50B017AD.1000603@conversis.de>
References: <C4049E4484F13747B672D64B9C12C31328D93097@PWMAILM01.cscinfo.com> <89FBB32B-22B7-4769-93D4-5721631AE0D5@gmail.com> <C4049E4484F13747B672D64B9C12C31328D93332@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:42669 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431Ab2KXAlU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 19:41:20 -0500
In-Reply-To: <C4049E4484F13747B672D64B9C12C31328D93332@PWMAILM01.cscinfo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Cc: Sebastien HAN <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

While LIO knows about multipathing this is only usable on a single mach=
ine.
iSCSI is a statefull protocol so the target needs to explicitly support
clustering and that is not the case for any of the available open sourc=
e
target daemons.

Regards,
  Dennis

On 11/23/2012 07:06 PM, Holcombe, Christopher wrote:
> Hi Sebastien,
>=20
> Yes LIO knows about multipathing and shouldn't have a problem with 2 =
machines.   I'm going to test the heck out of it just to be safe!  So P=
acemaker is what I should research next to remount rbd's after a reboot=
 or a proxy crash you're saying?  I haven't done anything with Pacemake=
r so that would be new territory for me. =20
>=20
> I didn't know about RBD devices scaling better at small sizes.  Thank=
s for the tip!  I think our group would have no problem with smaller de=
vises of 250GB or 500GB.  Are you talking much smaller than that for io=
ps? =20
>=20
> Thanks!
>=20
> -----Original Message-----
> From: Sebastien HAN [mailto:han.sebastien@gmail.com]=20
> Sent: Friday, November 23, 2012 12:53 PM
> To: Holcombe, Christopher
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: New Project with Ceph
>=20
> Hi,
>=20
> Your project seems nice, nothing really new in term of integration bu=
t quite promissing. I also think it's good idea that people start to sp=
eak about their project, you can get input from the community.=20
>=20
> It's fairly easy to make an RBD device surviving a reboot. I assume t=
hat your iSCSI export will be handle by at least 2 machines for HA purp=
ose. Thus you will use Pacemaker, there is already =C3=A0 RA for that a=
nd it's part of the ceph package as well ;-). If a server crash the dev=
ice is re-mappped on the other server and can possibily failback when f=
irst node comes back online. On top of the stack you could use the RA f=
or Lio and even do multi-pathing.=20
>=20
> In term of RBD size, if you can use smaller devices. Thank to this yo=
u will get more IOPS operations. Since RBD devices are stripped over ob=
jects. My benchmarks (and I'm not the only one) showed me that multiple=
 RBD scale better.=20
>=20
> I wish you the best for your project. ;-)
>=20
> Cheers!=20
>=20
> On 23 nov. 2012, at 18:31, "Holcombe, Christopher" <cholcomb@cscinfo.=
com> wrote:
>=20
>> Hi Everyone,
>>
>> First email here to the developer Ceph mailing list.  Some of you ma=
y know me from the irc channel under the handle 'noob2' .  I hang out t=
here every once in a while to ask questions and share knowledge. Last w=
eek I discussed a project I am working on in the irc channel.  Scuttlem=
onkey suggested I send an email off to this list with the possibility o=
f a guest entry on the Ceph blog!  Let me describe what I am trying to =
accomplish:
>>
>> Background : VMware Storage using Ceph.  After discovering Ceph I th=
ought of several uses for it.  Storage is really expensive for enterpri=
se customers and it doesn't need to be.  Going back to first principles=
 results in the conclusion that storage hardware is very cheap now.  Ab=
out 5% to 10% what enterprise customers are paying.  With that in mind =
I realized there is great room for improvement.  Most of the storage we=
 use is carried over a brocade fibre network and I think Ceph is perfec=
t for this task.  What is needed is a proxy to merge the rados back end=
 to the fibre network.  I used LIO on a previous project and had a theo=
ry that I could use it to meet our storage needs with Ceph.  At some po=
int in the future we will direct mount rbd over the network but we are =
not ready for that yet.
>>
>> Design: Ceph already did most of the heavy lifting for me.  Triple r=
eplication, self-healing, interaction through the kernel as a block dev=
ice and ability to scale easily with commodity servers.  My production =
Ceph cluster which I'm still in the process of getting quotes for will =
be HP DL180G6 servers.   Each of these will house 12 3TB data drives co=
nnected to a HP410 1GB flash backed write controller.  In building some=
 previous clusters I learned that spending a little extra on the raid c=
ontroller is usually worth it.  Our network contains 2 48 port gigabit =
switches in each rack for redundancy.  My plan is to use a 4 port gigab=
it network card and split the replication traffic off from the client t=
raffic.  I plan on setting up 2 802.3ad aggregated links.  That should =
give the server about 2x 1.9Gb/s of bandwidth.  We are currently short =
on 10Gb network ports but from what I'm seeing in testing the HP raid c=
ards can't handle enough data to make it worth it.  If that changes
  after tu
ning I can always upgrade.  We are an HP shop so my hands are a little =
tied.  Next is the proxy machines.  I'm going to reuse 2 older HP dl380=
 G5 servers that we took out of service.  One will be part of the A fab=
ric for the fibre and the other will be on the B fabric.  This is neede=
d for redundancy so the fibre initiator can fail back and forth should =
it need to.  I plan on creating rbd blocks of 1TB each on the Ceph clus=
ter, mounting it on both of the proxy machines and exporting using LIO.=
  LIO has both block mode which can export any block device the kernel =
knows about or file mode which can export a file as a block device.  My=
 testing has shown that VMware can mount this storage, vmotion vm's ont=
o it and use it like any other SAN storage.  The only challenge I have =
at this point is getting the rbd devices to survive a reboot on the pro=
xy machines.  I also will have to train the other admins on how to use =
it.  It is certainly more complicated than SAN storage we are used=20
 to but th
at shouldn't stop me.  I can build a web interface on top of this using=
 django.  If I can achieve these without too much difficulty than Ceph =
is truly an enterprise storage replacement.
>> That's my project at a high level.  Ceph has many uses but I'm findi=
ng this use the most interesting at the moment.  When it is all finishe=
d it should save us over 90% on storage costs going forward.  If anyone=
 knows how I could go about getting Ubuntu to save rbd mappings after a=
 reboot that would be really helpful.  Thank you guys for your hard wor=
k!
>>
>>
>> Chris Holcombe
>> Unix Administrator
>> Corporation Service Company
>> cholcomb@cscinfo.com
>> 302-636-8667
>>
>>
>> ________________________________
>>
>> NOTICE: This e-mail and any attachments is intended only for use by =
the addressee(s) named herein and may contain legally privileged, propr=
ietary or confidential information. If you are not the intended recipie=
nt of this e-mail, you are hereby notified that any dissemination, dist=
ribution or copying of this email, and any attachments thereto, is stri=
ctly prohibited. If you receive this email in error please immediately =
notify me via reply email or at (800) 927-9800 and permanently delete t=
he original copy and any copy of any e-mail, and any printout.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=
=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!tml=3D
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
