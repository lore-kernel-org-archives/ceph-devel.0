From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: pgs stuck inactive
Date: Fri, 13 Apr 2012 12:30:32 -0700
Message-ID: <8260F00ADA384FEDBA6AA9873273BB38@dreamhost.com>
References: <CAFtEh-dcEKQ2AzcVmu1G5i-zFHgim5SLZvEmNtDsvkHt+JnzLA@mail.gmail.com>
 <CACLRD_2yhpoUGoivHQpp-LyO82MdTz5SpD0MN5b_vEoqSGBzgg@mail.gmail.com>
 <CAFtEh-dsM_G5GCyqnnBVfAc7GmKZLZcLzkQzrCAGjDgyLC3CGg@mail.gmail.com>
 <CACLRD_1NiFHjx_PZxokVBkADG0z+A61Sj57NJFyYF_vM=ZKSbA@mail.gmail.com>
 <CAFtEh-dLfUYpSbUJamReXB2e1JHm0b55HPs-h1wjCXym-cmHyA@mail.gmail.com>
 <CACLRD_3ccxvLiHxEHMBK+Q+2Ag41a+M07NofU9+Z8Fr06vvvfA@mail.gmail.com>
 <CAFtEh-evVi0q8CZmbPJX_WaCD_y2E=RBf6nNu13106E8hopk5A@mail.gmail.com>
 <CACLRD_3hqoOqbZWnyft3B+pEaPG=pmiDt5HeQASUC=OPS-uA7Q@mail.gmail.com>
 <CAFtEh-dnR0zu=ct-gG0L+76BTYHVFimjFKNhHjnDNZWA=Scs1g@mail.gmail.com>
 <CACLRD_1pf3ezZKAvEuub5PN1=cMESvnuTOVh_45NYc4T5hcPhA@mail.gmail.com>
 <CAFtEh-cx2by6yG_xiQbq5e2fbViOWyHoaOLFPBCZgX7x-7gwFA@mail.gmail.com>
 <CACLRD_0UrwKJuELiZqrL7Q_5AjB1EvOd5gqLRzrxw_7AFMcjxg@mail.gmail.com>
 <CAFtEh-fwt9BwZ7NwZaJVnwq3hgzvkrb1XvKT0uF81vePRcu7oA@mail.gmail.com>
 <CACLRD_2hHbKFVjSDFHG-z=Sy5wgHDHz6=NWx9mEw51PMLVF7Ng@mail.gmail.com>
 <CAFtEh-c7VP1n3+9iDzXsnt4YjzVx7GiYu4BLfL4ssOa6Rq1rPA@mail.gmail.com>
 <CACLRD_11ahz6h1yKhC7CVAxM8ha-BkOVztb3zBkhyo4Kd4t6aQ@mail.gmail.com>
 <3154FE08568349E9B9EB0EBBCE4EDFB2@dreamhost.com>
 <CAFtEh-eEH5Hon5o2hXiEXA6FewB05Uj8=fR4L3HtkLw9zTxccA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44373 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2DMTah convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 15:30:37 -0400
Received: by obbta14 with SMTP id ta14so959698obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 12:30:35 -0700 (PDT)
In-Reply-To: <CAFtEh-eEH5Hon5o2hXiEXA6FewB05Uj8=fR4L3HtkLw9zTxccA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel@vger.kernel.org

On Thursday, April 12, 2012 at 8:29 AM, Damien Churchill wrote:
> On 11 April 2012 00:40, Greg Farnum <gregory.farnum@dreamhost.com (ma=
ilto:gregory.farnum@dreamhost.com)> wrote:
> > =20
> > A quick glance through these shows that all the pg_temp requests ar=
en't actually requesting any changes from the monitor. It's either a ve=
ry serious mon bug which happened a while ago (unlikely, given the rest=
arts and ongoing map changes, etc), or an OSD bug. I think we want logs=
 from both osd.0 and osd.3 at the same time, from what I'm seeing. :)
> > -Greg
> =20
> =20
> =20
> Just to make sure all bases are covered:
> =20
> http://damoxc.net/ceph/ceph-logs-20120412142537.tar.gz
> =20
> This contains all 5 osd logs and all 3 monitor logs, everything
> restarted with debug logging prior to capturing the logs.

I (and Sam) spent some time looking at this very closely. It continues =
to tell me that the OSD and the monitor are disagreeing on whether osd =
3 should be in the pg temp set for some things, but they seem to agree =
on everything else=E2=80=A6. =20
Can you zip up for me:
1) The files matching osdmap* of osd0's store from the current/meta/ di=
rectory,
2) The contents of your lead monitor's osdmap and osdmap_full directori=
es?

We can check these for differences and then run them through some of ou=
r tools and stuff to try and identify the issue.
Thanks!
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
