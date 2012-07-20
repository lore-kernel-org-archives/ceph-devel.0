From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Tuning placement group
Date: Fri, 20 Jul 2012 12:33:50 -0700
Message-ID: <CAC-hyiFRE5ixjf023PZi+3RicFm7Bc3djzFc41-njx5uAqR8Cg@mail.gmail.com>
References: <20120720163311.GB17454@potjevlesh.enovance.com>
	<CAPUexz90BKESODbNMX8H=yCkxQYHx1RXd1sQ17WUpO8Amt3gvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62528 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2GTTdw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 15:33:52 -0400
Received: by bkwj10 with SMTP id j10so3731177bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 12:33:50 -0700 (PDT)
In-Reply-To: <CAPUexz90BKESODbNMX8H=yCkxQYHx1RXd1sQ17WUpO8Amt3gvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: =?ISO-8859-1?Q?Fran=E7ois_Charlier?= <francois.charlier@enovance.com>, ceph-devel@vger.kernel.org

On Fri, Jul 20, 2012 at 11:08 AM, Florian Haas <florian@hastexo.com> wr=
ote:
>
> On Fri, Jul 20, 2012 at 9:33 AM, Fran=E7ois Charlier
> <francois.charlier@enovance.com> wrote:
> > Hello,
> >
> > Reading    http://ceph.com/docs/master/ops/manage/grow/placement-gr=
oups/
> > and thinking to build a ceph cluster with potentially 1000 OSDs.
> >
> > Using the recommandations on the previously cited link, it would re=
quire
> > pg_num being set between 10,000 &  30,000. Okay with that. Let's us=
e the
> > recommended value of 16,384 ; this  is alreay about 160 placement g=
roups
> > per OSD.
> >
> > What  if, for  a start,  we choose  to reach  this number  of 1000 =
 OSDs
> > slowly, starting with 100 OSDs ? It's now 1600 placement groups per=
 OSD.
> >
> > What if  we chose 30,000 (or  32,768) placement groups to  keep roo=
m for
> > expansion ?
> >
> > My question  is : How will  behave a Ceph  pool with 1000, 5000  or=
 even
> > 10000 placement groups per OSD ?  Will this impact performance ? Ho=
w bad
> > ? Can it be worked around ? Is this a problem of RAM size ? CPU usa=
ge ?
> >
> > Any hint about this would be much appreciated.
>
> If I may, I'd like to add an additional point of consideration,
> specifically for radosgw setups:
>
> What's the recommended way to set the number of PGs for the half-doze=
n
> pools that radosgw normally creates on its own (.rgw, .rgw.users,
> .rgw.buckets and so on)? I *think* wanting to set a custom number of
> PGs would require pre-creating these pools manually, but there may be
> a way -- undocumented? -- to instruct radosgw to set a user-configure=
d
> number of PGs on pool creation. Insight on that would be much
> appreciated.
>
At the moment there's no way to tell radosgw how many pgs should be in
the pools it creates automatically. One way to get around that is to
create these pools before running the radosgw in the first time. For
the data pools, you can modify the set of pools that will be used for
data placement by using the radosgw-admin 'pool add', 'pool rm', and
'pool list' commands. Note that buckets that have already been created
will retain their original pool.
Data in pools that were automatically created can now be copied to a
different pool (rados cppool), and pools can now be renamed (ceph osd
pool rename <oldname> <newname>). So you can create new pool with the
amount of required pgs, copy old data into it, and rename old pool and
new pool. NOTE: this should not be used for the data pool
(.rgw.buckets by default)! This can only be done for the pools that
hold the different indexes and metadata. The bucket index in the data
pool relies on internal pg state, which will be broken if pool moves
around.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
