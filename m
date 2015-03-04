From: Csaba Henk <chenk@redhat.com>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
Date: Wed, 4 Mar 2015 10:03:25 -0500 (EST)
Message-ID: <784685843.22537099.1425481405537.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net> <54F31D28.9050103@bisect.de> <1011159141.22473140.1425478320272.JavaMail.zimbra@redhat.com> <54F7162C.1000900@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:46069 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbbCDPDc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 10:03:32 -0500
In-Reply-To: <54F7162C.1000900@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <danny.al-gaaf@bisect.de>



----- Original Message -----
> From: "Danny Al-Gaaf" <danny.al-gaaf@bisect.de>
> To: "Csaba Henk" <chenk@redhat.com>, "OpenStack Development Mailing L=
ist (not for usage questions)"
> <openstack-dev@lists.openstack.org>
> Cc: ceph-devel@vger.kernel.org
> Sent: Wednesday, March 4, 2015 3:26:52 PM
> Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
>=20
> Am 04.03.2015 um 15:12 schrieb Csaba Henk:
> > ----- Original Message -----
> >> From: "Danny Al-Gaaf" <danny.al-gaaf@bisect.de> To: "OpenStack
> >> Development Mailing List (not for usage questions)"
> >> <openstack-dev@lists.openstack.org>, ceph-devel@vger.kernel.org
> >> Sent: Sunday, March 1, 2015 3:07:36 PM Subject: Re:
> >> [openstack-dev] [Manila] Ceph native driver for manila
> > ...
> >> For us security is very critical, as the performance is too. The
> >> first solution via ganesha is not what we prefer (to use CephFS
> >> via p9 and NFS would not perform that well I guess). The second
> >> solution, to use
> >=20
> > Can you please explain that why does the Ganesha based stack
> > involve 9p? (Maybe I miss something basic, but I don't know.)
>=20
> Sorry, seems that I mixed it up with the p9 case. But the performance
> is may still an issue if you use NFS on top of CephFS (incl. all the
> VM layer involved within this setup).
>=20
> For me the question with all these NFS setups is: why should I use NF=
S
> on top on CephFS? What is the right to exist of CephFS in this case? =
I
> would like to use CephFS directly or via filesystem passthrough.

That's a good question. Or indeed, two questions:

1. Why to use NFS?
2. Why does the NFS export of Ceph need to involve CephFS?

1.

As of "why NFS" -- it's probably a good selling point that it's
standard filesystem export technology and the tenants can remain
backend-unaware as long as the backend provides NFS export.

We are working on the Ganesha library --

https://blueprints.launchpad.net/manila/+spec/gateway-mediated-with-gan=
esha

with the aim to make it easy to create Ganesha based drivers. So if you=
 have
already an FSAL, you can get at an NFS exporting driver almost for free=
 (with a
modest amount of glue code). So you could consider making such a driver=
 for
Ceph, to satisfy customers who demand NFS access, even if there is a na=
tive
driver which gets the limelight.=20

(See commits implementing this under "Work Items" of the BP -- one is t=
he
actual Ganesha library and the other two show how it can be hooked in, =
by the
example of the Gluster driver. At the moment flat network (share-server=
-less)
drivers are supported.)

2.

As of why CephFS was the technology chosen for implementing the Ceph FS=
AL for
Ganesha, that's something I'd also like to know. I have the following n=
aive
question in mind: "Would it not have been better to implement Ceph FSAL=
 with
something =C2=BBcloser to=C2=AB Ceph?", and I have three actual questio=
ns about it:

- does this question make sense in this form, and if not, how to amend?
- I'm asking the question itself, or the amended version of it.
- If the answer is yes, is there a chance someone would create an alter=
native
  Ceph FSAL on that assumed closer-to-Ceph technology?


Cheers
Csaba






--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
