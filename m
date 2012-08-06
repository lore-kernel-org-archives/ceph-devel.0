From: Tommi Virtanen <tv@inktank.com>
Subject: Re: "no key for auth" when running "auth export mon. -o /tmp/monkey"?
Date: Mon, 6 Aug 2012 08:55:38 -0700
Message-ID: <CADvuQRG=3bX0L2BfTpnQkv3S8OvnZ2qo8uf0ezvta0MYZmzSiQ@mail.gmail.com>
References: <CADXA5U0m-PXRnZJhN83+HQ6uZXiM76A+ZD=q2JdrUD_8-q0Gmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44236 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396Ab2HFPz7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 11:55:59 -0400
Received: by vbbff1 with SMTP id ff1so2713288vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 08:55:58 -0700 (PDT)
In-Reply-To: <CADXA5U0m-PXRnZJhN83+HQ6uZXiM76A+ZD=q2JdrUD_8-q0Gmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Roy <imjustmatthew@gmail.com>, John Wilkins <john.wilkins@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Aug 4, 2012 at 11:13 PM, Matthew Roy <imjustmatthew@gmail.com> wrote:
> When following http://ceph.com/docs/master/ops/manage/grow/mon/#adding-a-monitor
> running the command:
>
> ceph auth export mon. -o /tmp/monkey
>
> on a working cluster gives the result:
>
> no key for auth(auid = <20 digits> key=AAAAAAAAAAAAAAAA with 0 caps)
>
> The key "mon." is in the monitors' keyrings, but not in the list of
> keys returned by "ceph auth list". Is this an indication of a problem
> with the cluster or a bug in the documentation?

I think you're encountering side effects of these commits:


commit 7830f859e0c8c317c516736343eb9f3d8d824f77
Author: Sage Weil <sage@newdream.net>
Date:   2012-05-08 16:30:26 -0700

    mon: use external keyring for mon->mon auth

    - Feed our keyring into the auth methods.
    - Do not fail to build a ticket for type MON when we don't have a cap; it
      won't be in the auth database.  Also, we don't have caps on the monitors
      that are enfoced between each other.

    Signed-off-by: Sage Weil <sage@newdream.net>

commit 7be78101da85d8db9d2cd319beee7dbef2ecd7a7
Author: Sage Weil <sage@inktank.com>
Date:   2012-05-14 20:13:40 -0700

    mon: keep mon. secret in an external keyring

    - Keep the mon. key in a separate keyring files, "keyring", in the mon
      data dir.
    - During init, if we don't find that file, copy the key from the keyserver
      database.
    - During mkfs, put the mon. key in that file, and remove it from the seed
      file that primes the auth database.

    This will allow admins to change the mon. key without bringing the cluster
    online and doing something wonky.

    Signed-off-by: Sage Weil <sage@newdream.net>

We'll need to edit the docs. Do you have the file "keyring" in your
mon data dir, and does it contain a [mon.] section? If so, that
section is what you need in /tmp/monkey. If you're going by defaults,
there should be no other section in the file, and you can use the file
as-is.

John, for the docs, Sage is probably the best person to say what those
commands really should be; I don't know if there's a good way to
extract just the [mon.] section from the file with a single
ceph-authtool command, etc.
