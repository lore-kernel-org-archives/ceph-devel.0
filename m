From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Max Message Size For AIO calls
Date: Wed, 26 Sep 2012 15:38:31 -0700
Message-ID: <CAPrxi5-iRoTfeOk0S9Bcfwc1cbkpE4Z+jwb0daz2Q5eeFdYNiw@mail.gmail.com>
References: <CAEVWPAXWhGBJoYN==vp_2uzuPemuVkv1Z3_VsqnYO0K0rGb7Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53902 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab2IZWib (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 18:38:31 -0400
Received: by ieak13 with SMTP id k13so2872229iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 15:38:31 -0700 (PDT)
In-Reply-To: <CAEVWPAXWhGBJoYN==vp_2uzuPemuVkv1Z3_VsqnYO0K0rGb7Fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Pye <ianpye@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Looks like this here is the relevant config option:

    osd_max_write_size which has a default value of 90 megabytes
(adjusted below with the << 20) in my tree

In osd/OSD.cc:

    // too big?
     if (g_conf->osd_max_write_size &&
         m->get_data_len() > g_conf->osd_max_write_size << 20) {
       // journal can't hold commit!
       service.reply_op_error(op, -OSD_WRITETOOBIG);
       return;
  }

- Noah

On Wed, Sep 26, 2012 at 3:28 PM, Ian Pye <ianpye@gmail.com> wrote:
> Hi,
>
> I'm periodically getting librados aio_operate() calls to fail on me
> and return a code of -90: Message too long. Does anyone know how long
> is too long of a message here?
>
> Thanks,
>
> Ian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
