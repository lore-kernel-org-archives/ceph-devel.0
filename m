From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD hotplugging & Chef cookbook ("chef-1")
Date: Mon, 18 Jun 2012 10:33:15 -0700
Message-ID: <CADvuQRH4Fi4YsnBKu3EzPzg3Q5gnhB-4MVHVj14-F+f_z18+aQ@mail.gmail.com>
References: <CADvuQRHwR5M_bvUsSMR=9qUuoYY_qRdTA5Sac=troYNxhaFxNg@mail.gmail.com>
 <4FD9E804.3050801@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53704 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab2FRRdg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 13:33:36 -0400
Received: by dady13 with SMTP id y13so7235875dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 10:33:36 -0700 (PDT)
In-Reply-To: <4FD9E804.3050801@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On Thu, Jun 14, 2012 at 6:32 AM, Danny Kukawka <danny.kukawka@bisect.de=
> wrote:
> And where can I find this branch? I've checked the git repo at:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0https://github.com/ceph/ceph-cookbooks
>
> But couldn't find any branch called ceph-1.

Use master of ceph-cookbooks.git, and where those instructions said
"ceph-1", put in "master" (=3D use master of ceph.git).

The instructions from that email are being distilled into proper
documentation at

http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/chef/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
