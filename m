From: Damien Churchill <damoxc@gmail.com>
Subject: Re: pgs stuck inactive
Date: Thu, 12 Apr 2012 16:29:43 +0100
Message-ID: <CAFtEh-eEH5Hon5o2hXiEXA6FewB05Uj8=fR4L3HtkLw9zTxccA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40802 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934343Ab2DLP3n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 11:29:43 -0400
Received: by yhmm54 with SMTP id m54so1124505yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 08:29:43 -0700 (PDT)
In-Reply-To: <3154FE08568349E9B9EB0EBBCE4EDFB2@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel@vger.kernel.org

On 11 April 2012 00:40, Greg Farnum <gregory.farnum@dreamhost.com> wrote:
>
> A quick glance through these shows that all the pg_temp requests aren't actually requesting any changes from the monitor. It's either a very serious mon bug which happened a while ago (unlikely, given the restarts and ongoing map changes, etc), or an OSD bug. I think we want logs from both osd.0 and osd.3 at the same time, from what I'm seeing. :)
> -Greg
>

Just to make sure all bases are covered:

http://damoxc.net/ceph/ceph-logs-20120412142537.tar.gz

This contains all 5 osd logs and all 3 monitor logs, everything
restarted with debug logging prior to capturing the logs.
