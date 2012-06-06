From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Wed, 06 Jun 2012 11:43:50 -0500
Message-ID: <4FCF88C6.1000606@inktank.com>
References: <98f9ad93-7b3b-4d07-90d8-ca5a3b5e319b@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58977 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab2FFQnw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:43:52 -0400
Received: by obbtb18 with SMTP id tb18so10500123obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 09:43:52 -0700 (PDT)
In-Reply-To: <98f9ad93-7b3b-4d07-90d8-ca5a3b5e319b@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

Hi Alexandre,

If you can run blktrace during your test on one of the OSD data disks=20
and send me the results I can take a look at them.  Also, the rados=20
bench settings and output would be useful too.

Thanks,
Mark

On 6/6/12 11:05 AM, Alexandre DERUMIER wrote:
> Hi, I have rebuild my cluster with ubuntu precise,
>
> -kernel 3.2
> -ceph 0.47.2
> -libc6 2.15
> -3 nodes - 5 osd (xfs) by node and 1 tmpfs with 5 journal file.
>
> I had launch rados bench,
> and I see again constant writes to xfs....
>
> Maybe this is related to tmpfs ?
>
>
> I'll retry with kernel 3.4 from intank tomorrow.
> I'll also try with journal on a physical disk with xfs partition.
>
> I'll keep you in touch.
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
