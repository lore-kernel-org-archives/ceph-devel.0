From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 08:28:09 -0500
Message-ID: <4FCCB7E9.9080100@inktank.com>
References: <09037cad-1a2a-4adb-bedb-91fbdeb5ad79@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54990 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2FDN2L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 09:28:11 -0400
Received: by obbtb18 with SMTP id tb18so7200921obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 06:28:11 -0700 (PDT)
In-Reply-To: <09037cad-1a2a-4adb-bedb-91fbdeb5ad79@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

Hi Alexandre,

A lot of our testing is on Ubuntu right now.  I'm using the ceph and=20
kernel debs from ceph.gitbuilder.com for my tests.  Post some results t=
o=20
the list once you get your cluster setup!

Thanks,
Mark


On 6/4/12 8:07 AM, Alexandre DERUMIER wrote:
> Thanks Mark,
> I'll rebuild my cluster with ubuntu precise tomorrow. (Don't have tim=
e to backport/maintain libc6 ;)
>
>
> BTW, do you use mainly ubuntu at intank for your tests ?
>
> I'd like to have a setup as close as possible of intank setup.
>
>
> ----- Mail original -----
>
> De: "Mark Nelson"<mark.nelson@inktank.com>
> =C3=80: "Alexandre DERUMIER"<aderumier@odiso.com>
> Cc: "Amon Ott"<a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, "Yann=
 Dupont"<Yann.Dupont@univ-nantes.fr>
> Envoy=C3=A9: Lundi 4 Juin 2012 14:59:58
> Objet: Re: Infiniband 40GB
>
> On 6/4/12 6:40 AM, Alexandre DERUMIER wrote:
>> Hi,
>>
>> I'm currently doing some tests with xfs, debian wheezy with standard=
 libc6 (2.11.3-3) and 3.2 kernel.
>>
>> I'm doing some iostats(3 nodes with 5 osd), and I see constant write=
s to disks.(as the datas are flushed each second from journal to disk).
>>
>> Journal is big enough (20GB tmpfs) to handle 30s of write.
>>
>> Do you think it's related to the missing syncfs() support ?
>>
>> -Alexandre
>
> Hi Alexandre,
>
> I've included some seekwatcher results for rados bench tests using 16
> concurrent 4MB writes on XFS OSD. One shows ubuntu oneiric and the
> other precise (ie no syncfs support vs syncfs support in libc).
> Unfortunately the original test was on 0.46 and the second test was o=
n
> 0.47.2, so multiple things changed between the tests. Both were teste=
d
> with kernel 3.4. Interestingly the seeks/second don't seem to drop mu=
ch
> but the overall performance has about doubled. This was using a singl=
e
> 7200rpm disk for the OSD data disk and a seperate 7200rpm disk for th=
e
> journal in both cases. I'd definitely try 0.47.2 with a new libc thou=
gh
> and see how that works for you.
>
> ceph 0.46/oneiric:
> http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-oneiric-3.4.mpg
>
> ceph 0.47.2/precise:
> http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-precise-3.4.mpg
>
> Mark
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
