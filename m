From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: pgs stuck inactive
Date: Tue, 10 Apr 2012 16:40:21 -0700
Message-ID: <3154FE08568349E9B9EB0EBBCE4EDFB2@dreamhost.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54359 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297Ab2DJXkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 19:40:23 -0400
Received: by obbtb18 with SMTP id tb18so446213obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Apr 2012 16:40:23 -0700 (PDT)
In-Reply-To: <CACLRD_11ahz6h1yKhC7CVAxM8ha-BkOVztb3zBkhyo4Kd4t6aQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>, Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, April 10, 2012 at 4:00 PM, Samuel Just wrote:
> Can you send along the osd log as well for comparison?
> -Sam
> 
> On Tue, Apr 10, 2012 at 3:03 PM, Damien Churchill <damoxc@gmail.com (mailto:damoxc@gmail.com)> wrote:
> > Here are the monitor logs, they're from the monitor starts, however I
> > restarted the osd shortly afterwards and left it to run for 5 or so
> > minutes.
> > 
> > http://damoxc.net/ceph/mon.node21.log.gz
> > http://damoxc.net/ceph/mon.node22.log.gz
> > http://damoxc.net/ceph/mon.node23.log.gz
> > 
> > On 10 April 2012 22:49, Samuel Just <sam.just@dreamhost.com (mailto:sam.just@dreamhost.com)> wrote:
> > > Nothing apparent from the backtrace. I need monitor logs from when
> > > the osd is sending pg_temp requests. Can you restart the osd and post
> > > the osd and all three monitor logs from when you restarted the osd?
> > > You'll have to enable monitor logging on all three.
> > > -Sam
> > 
> 


A quick glance through these shows that all the pg_temp requests aren't actually requesting any changes from the monitor. It's either a very serious mon bug which happened a while ago (unlikely, given the restarts and ongoing map changes, etc), or an OSD bug. I think we want logs from both osd.0 and osd.3 at the same time, from what I'm seeing. :)
-Greg

