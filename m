From: Patrick McGarry <pmcgarry@gmail.com>
Subject: Re: Ceph in a box
Date: Mon, 20 Apr 2015 11:01:56 -0400
Message-ID: <CAP8Oy=LnPmFF=D6s4hXEmaqGxESLrKCLSYad5vz3iW-vQOe3+Q@mail.gmail.com>
References: <CAKKTCLXG-+3J19Vetb0o_WNyiRyFgu=kwwvtt9K25QX2K8oetw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34271 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbbDTPB5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2015 11:01:57 -0400
Received: by qgfi89 with SMTP id i89so53757672qgf.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2015 08:01:57 -0700 (PDT)
In-Reply-To: <CAKKTCLXG-+3J19Vetb0o_WNyiRyFgu=kwwvtt9K25QX2K8oetw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hey there,

The easiest ways would probably be to either use the qemu image [0]
that we made for the advent calendar or the docker work [1] that has
been going on. If you would prefer to build it yourself using
directories you can take a look at the quick start guide [2] in the
Ceph installation doc [3].

[0] http://www.qemu-advent-calendar.org/#day-18
[1] https://github.com/ceph/ceph-docker
[2] http://ceph.com/docs/master/start/quick-ceph-deploy/
[3] http://ceph.com/docs/master/start/

Hope that helps.

Best Regards,


Patrick McGarry
pmcgarry@gmail.com


On Fri, Apr 17, 2015 at 5:56 PM, Venkateswara Rao Jujjuri
<jujjuri@gmail.com> wrote:
> Is it possible and do we have any instructions on how to setup ceph on a box?
> - Single IP with different ports instead of different machines?
> - Use disk partitions ? /dev/sdb1 /dev/sdb2 .. etc instead of full disk access?
>
> If it is not possible, are there any instructions running on virtual
> machines? Preferred Ubuntu 12.04 LTS.
>
> Thanks for your help.
>
> --
> Jvrao
> ---
> First they ignore you, then they laugh at you, then they fight you,
> then you win. - Mahatma Gandhi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
