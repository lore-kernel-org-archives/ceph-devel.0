From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: What to do with python-ceph-compat?
Date: Mon, 22 Aug 2016 14:20:40 -0600
Message-ID: <CALqRxCwQwVfur17YUv1Q5Brx8GWbGGcAFA+v18p5q+SMn=6pxw@mail.gmail.com>
References: <46719a38-0ab0-604d-89cb-50eeb6d32d3d@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34357 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbcHVUUm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 16:20:42 -0400
Received: by mail-ua0-f176.google.com with SMTP id k90so209892157uak.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 13:20:41 -0700 (PDT)
In-Reply-To: <46719a38-0ab0-604d-89cb-50eeb6d32d3d@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Aug 22, 2016 at 3:27 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Finally, we could just keep the "python-ceph" (deb) and "python-ceph-compat"
> (rpm) packages "forever", i.e. for as long as we have tests that start by
> installing pre-hammer versions.

I'm ok with keeping the package around this long. I don't expect us to
still be testing firefly upgrades in Aug 2017, because Kraken and
Luminous will be out, and I think Hammer will probably be the baseline
for upgrade tests.

- Ken
