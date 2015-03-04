From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
Date: Wed, 4 Mar 2015 09:56:50 -0800
Message-ID: <CAC6JEv-=m+kgE+LRH-oeGVEyoKD6HLXE9AyvLdncfa6pxOMTBA@mail.gmail.com>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>
	<54F31D28.9050103@bisect.de>
	<1011159141.22473140.1425478320272.JavaMail.zimbra@redhat.com>
	<54F7162C.1000900@bisect.de>
	<784685843.22537099.1425481405537.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37993 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155AbbCDR4v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 12:56:51 -0500
Received: by iecrd18 with SMTP id rd18so69251845iec.5
        for <ceph-devel@vger.kernel.org>; Wed, 04 Mar 2015 09:56:50 -0800 (PST)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com. [209.85.213.181])
        by mx.google.com with ESMTPSA id b1sm11113814igl.7.2015.03.04.09.56.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 09:56:50 -0800 (PST)
Received: by igbhl2 with SMTP id hl2so35496090igb.0
        for <ceph-devel@vger.kernel.org>; Wed, 04 Mar 2015 09:56:50 -0800 (PST)
In-Reply-To: <784685843.22537099.1425481405537.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Csaba Henk <chenk@redhat.com>
Cc: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>

On Wed, Mar 4, 2015 at 7:03 AM, Csaba Henk <chenk@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Danny Al-Gaaf" <danny.al-gaaf@bisect.de>
>> To: "Csaba Henk" <chenk@redhat.com>, "OpenStack Development Mailing =
List (not for usage questions)"
>> <openstack-dev@lists.openstack.org>
>> Cc: ceph-devel@vger.kernel.org
>> Sent: Wednesday, March 4, 2015 3:26:52 PM
>> Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
>>
>> Am 04.03.2015 um 15:12 schrieb Csaba Henk:
>> > ----- Original Message -----
>> >> From: "Danny Al-Gaaf" <danny.al-gaaf@bisect.de> To: "OpenStack
>> >> Development Mailing List (not for usage questions)"
>> >> <openstack-dev@lists.openstack.org>, ceph-devel@vger.kernel.org
>> >> Sent: Sunday, March 1, 2015 3:07:36 PM Subject: Re:
>> >> [openstack-dev] [Manila] Ceph native driver for manila
>> > ...
>> >> For us security is very critical, as the performance is too. The
>> >> first solution via ganesha is not what we prefer (to use CephFS
>> >> via p9 and NFS would not perform that well I guess). The second
>> >> solution, to use
>> >
>> > Can you please explain that why does the Ganesha based stack
>> > involve 9p? (Maybe I miss something basic, but I don't know.)
>>
>> Sorry, seems that I mixed it up with the p9 case. But the performanc=
e
>> is may still an issue if you use NFS on top of CephFS (incl. all the
>> VM layer involved within this setup).
>>
>> For me the question with all these NFS setups is: why should I use N=
=46S
>> on top on CephFS? What is the right to exist of CephFS in this case?=
 I
>> would like to use CephFS directly or via filesystem passthrough.
>
> That's a good question. Or indeed, two questions:
>
> 1. Why to use NFS?
> 2. Why does the NFS export of Ceph need to involve CephFS?
>
> 1.
>
> As of "why NFS" -- it's probably a good selling point that it's
> standard filesystem export technology and the tenants can remain
> backend-unaware as long as the backend provides NFS export.
>
> We are working on the Ganesha library --
>
> https://blueprints.launchpad.net/manila/+spec/gateway-mediated-with-g=
anesha
>
> with the aim to make it easy to create Ganesha based drivers. So if y=
ou have
> already an FSAL, you can get at an NFS exporting driver almost for fr=
ee (with a
> modest amount of glue code). So you could consider making such a driv=
er for
> Ceph, to satisfy customers who demand NFS access, even if there is a =
native
> driver which gets the limelight.
>
> (See commits implementing this under "Work Items" of the BP -- one is=
 the
> actual Ganesha library and the other two show how it can be hooked in=
, by the
> example of the Gluster driver. At the moment flat network (share-serv=
er-less)
> drivers are supported.)
>
> 2.
>
> As of why CephFS was the technology chosen for implementing the Ceph =
=46SAL for
> Ganesha, that's something I'd also like to know. I have the following=
 naive
> question in mind: "Would it not have been better to implement Ceph FS=
AL with
> something =C2=BBcloser to=C2=AB Ceph?", and I have three actual quest=
ions about it:
>
> - does this question make sense in this form, and if not, how to amen=
d?
> - I'm asking the question itself, or the amended version of it.
> - If the answer is yes, is there a chance someone would create an alt=
ernative
>   Ceph FSAL on that assumed closer-to-Ceph technology?

I don't understand. What "closer-to-Ceph" technology do you want than
native use of the libcephfs library? Are you saying to use raw RADOS
to provide storage instead of CephFS?

In that case, it doesn't make a lot of sense: CephFS is how you
provide a real filesystem in the Ceph ecosystem. I suppose if you
wanted to create a lighter-weight pseudo-filesystem you could do so
(somebody is building a "RadosFS", I think from CERN?) but then it's
not interoperable with other stuff.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
