From: Florian Haas <florian@hastexo.com>
Subject: Re: Tuning placement group
Date: Fri, 20 Jul 2012 11:08:01 -0700
Message-ID: <CAPUexz90BKESODbNMX8H=yCkxQYHx1RXd1sQ17WUpO8Amt3gvQ@mail.gmail.com>
References: <20120720163311.GB17454@potjevlesh.enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49826 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab2GTSID convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 14:08:03 -0400
Received: by qcro28 with SMTP id o28so2453757qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 11:08:01 -0700 (PDT)
In-Reply-To: <20120720163311.GB17454@potjevlesh.enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 20, 2012 at 9:33 AM, Fran=C3=A7ois Charlier
<francois.charlier@enovance.com> wrote:
> Hello,
>
> Reading    http://ceph.com/docs/master/ops/manage/grow/placement-grou=
ps/
> and thinking to build a ceph cluster with potentially 1000 OSDs.
>
> Using the recommandations on the previously cited link, it would requ=
ire
> pg_num being set between 10,000 &  30,000. Okay with that. Let's use =
the
> recommended value of 16,384 ; this  is alreay about 160 placement gro=
ups
> per OSD.
>
> What  if, for  a start,  we choose  to reach  this number  of 1000  O=
SDs
> slowly, starting with 100 OSDs ? It's now 1600 placement groups per O=
SD.
>
> What if  we chose 30,000 (or  32,768) placement groups to  keep room =
for
> expansion ?
>
> My question  is : How will  behave a Ceph  pool with 1000, 5000  or e=
ven
> 10000 placement groups per OSD ?  Will this impact performance ? How =
bad
> ? Can it be worked around ? Is this a problem of RAM size ? CPU usage=
 ?
>
> Any hint about this would be much appreciated.

If I may, I'd like to add an additional point of consideration,
specifically for radosgw setups:

What's the recommended way to set the number of PGs for the half-dozen
pools that radosgw normally creates on its own (.rgw, .rgw.users,
=2Ergw.buckets and so on)? I *think* wanting to set a custom number of
PGs would require pre-creating these pools manually, but there may be
a way -- undocumented? -- to instruct radosgw to set a user-configured
number of PGs on pool creation. Insight on that would be much
appreciated.

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
