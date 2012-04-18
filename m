From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: pgs stuck inactive
Date: Wed, 18 Apr 2012 13:41:36 -0700
Message-ID: <454EEF491D1B41C3B0382F1A101BABE0@dreamhost.com>
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
 <8260F00ADA384FEDBA6AA9873273BB38@dreamhost.com>
 <CAFtEh-cxqG_FiPiAV8QWQtJ2bUcDnN00Kv+SEu1bUi-Jg2uaxw@mail.gmail.com>
 <90B1EE3CB1C7494B9B097AD5E4BCF272@dreamhost.com>
 <CAFtEh-fCaBXCyVJ13nqtuf-t_ULETzbTUvNEMtJ7GL61s3hOUg@mail.gmail.com>
 <CA990ABA69C04ECBB750275912830DD0@dreamhost.com>
 <CAFtEh-d42ch4Oub1ArNcZd5=EYxPejRb0+N2ND4H2o5VaTpCfQ@mail.gmail.com>
 <D4642C5210F144238EA7E60F317364ED@dreamhost.com>
 <CAFtEh-fFqNn9UswqLhPKf8PvGrAOJ7oS2wiQ8vcEN7dQaGtv2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42507 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab2DRUlk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 16:41:40 -0400
Received: by obbta14 with SMTP id ta14so7075715obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 13:41:39 -0700 (PDT)
In-Reply-To: <CAFtEh-fFqNn9UswqLhPKf8PvGrAOJ7oS2wiQ8vcEN7dQaGtv2A@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, April 18, 2012 at 12:04 PM, Damien Churchill wrote:
> On 18 April 2012 19:41, Greg Farnum <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> wrote:
> > 
> > Are you building your binaries from source, and can you run a patched version of the monitors? If you can I'll give you a patch to enable a simple command that should make things work; otherwise we'll need to start editing things by hand. (Yucky)
> > -Greg
> 
> 
> 
> I was using the Ubuntu packages but I can quite happily build my own
> packages if you give me the patch :-)
> 
> I agree it's a waste of time if it's not obvious what's caused it,
> could be some obscure cause occurred due to upgrading between older
> versions.

Okay, assuming you're still on 0.41.1, can you checkout the git branch "for-damien" and build it? 
Then shut down your monitors, replace their executables with the freshly-built ones, and run
"ceph osd pool set vmimages pg_num 320 --a-dev-told-me-to"
and
"ceph osd pool set vmimages pgp_num 320"



That should get everything back up and running. The one sour note is that due to the bug in the past, your data (ie, filesystem) and vmimages pools have gotten conflated. It shouldn't cause any issues (they use very different naming schemes), but they're tied together in terms of replication and the raw pool statistics.
(If that's important you can create a new pool and move the rbd images to it.)
-Greg

