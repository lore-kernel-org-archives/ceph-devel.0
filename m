From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: pgs stuck inactive
Date: Tue, 17 Apr 2012 09:49:03 -0700
Message-ID: <CA990ABA69C04ECBB750275912830DD0@dreamhost.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36565 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab2DQQtH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Apr 2012 12:49:07 -0400
Received: by obbta14 with SMTP id ta14so5343388obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Apr 2012 09:49:07 -0700 (PDT)
In-Reply-To: <CAFtEh-fCaBXCyVJ13nqtuf-t_ULETzbTUvNEMtJ7GL61s3hOUg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel@vger.kernel.org

On Monday, April 16, 2012 at 10:32 PM, Damien Churchill wrote:
> On 17 April 2012 01:06, Greg Farnum <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> wrote:
> > Yep!
> > We looked into this more today and have discovered some definite oddness. Have you by any chance tried to change the number of PGs in your pools?
> 
> 
> 
> I haven't no (at least certainly not on purpose!). All I've really
> done is copy a bit of stuff onto the unix fs and create a few rbd
> volumes, as well as upgrade it when a new version comes out.

Drat, that means there's actually a problem to track down somewhere. 
Do you know what version this was created with, and what upgrades you've been through? My best guess right now is that there's a problem with the encoding and decoding that I'm going to have to track down, and more context will make it a lot easier. :)
-Greg

