From: Damien Churchill <damoxc@gmail.com>
Subject: Re: pgs stuck inactive
Date: Wed, 18 Apr 2012 20:04:54 +0100
Message-ID: <CAFtEh-fFqNn9UswqLhPKf8PvGrAOJ7oS2wiQ8vcEN7dQaGtv2A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63112 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab2DRTEz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 15:04:55 -0400
Received: by ghrr11 with SMTP id r11so3911144ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 12:04:55 -0700 (PDT)
In-Reply-To: <D4642C5210F144238EA7E60F317364ED@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 18 April 2012 19:41, Greg Farnum <gregory.farnum@dreamhost.com> wrote:
>
> Are you building your binaries from source, and can you run a patched version of the monitors? If you can I'll give you a patch to enable a simple command that should make things work; otherwise we'll need to start editing things by hand. (Yucky)
> -Greg
>

I was using the Ubuntu packages but I can quite happily build my own
packages if you give me the patch :-)

I agree it's a waste of time if it's not obvious what's caused it,
could be some obscure cause occurred due to upgrading between older
versions.
