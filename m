From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: ceph build error on leveldb
Date: Thu, 5 Apr 2012 11:02:20 -0700
Message-ID: <CAC-hyiHS=4oa2Nh5-F4uennHUhaqQNVieLb-ZfTQT+_8ELTuQw@mail.gmail.com>
References: <CACqFU2nJD1BgvuRBsFU_MBkGuEdUrjw=0Vir0NwbtMOhDY82Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38633 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2DESCW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 14:02:22 -0400
Received: by bkcik5 with SMTP id ik5so1585643bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 11:02:20 -0700 (PDT)
In-Reply-To: <CACqFU2nJD1BgvuRBsFU_MBkGuEdUrjw=0Vir0NwbtMOhDY82Sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Feiyi Wang <fwang2@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 5, 2012 at 10:58 AM, Feiyi Wang <fwang2@gmail.com> wrote:
> hi all
>
> I am new to ceph and is trying to give it a spin for testing:
> on both master or stable branch, the configure script gives the
> WARNING (CentOS 6)
>
>
> config.status: executing depfiles commands
> config.status: executing libtool commands
> === configuring in src/leveldb (/home/fwang2/ceph/src/leveldb)
> configure: WARNING: no configuration information is in src/leveldb
>
> and the following make fails:

After checking out the source tree, run:

 git submodule init
 git submodule update

That should update the leveldb submodule.

Yehuda
