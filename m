From: Ketor D <d.ketor@gmail.com>
Subject: Re: rados_dll: A Windows port of librados
Date: Tue, 24 Mar 2015 23:59:06 +0800
Message-ID: <CAM9_UU9vG=5wwXm17fRqav2QBW5wqiB8c3rWhLR2n+xHe-g_Gw@mail.gmail.com>
References: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
 <alpine.DEB.2.00.1503190822150.9418@cobra.newdream.net> <CAM9_UU_O=ntf+pZodFwMo1qS7R7Y4S1eNFiXx-x5G2TpOEGf2g@mail.gmail.com>
 <CAHJ4zomuAPG_nyoOo95Q1sLhyjaN43Vi1mxTuzhE+waRopdQig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33645 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbCXP7h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 11:59:37 -0400
Received: by oifl3 with SMTP id l3so141563771oif.0
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2015 08:59:37 -0700 (PDT)
In-Reply-To: <CAHJ4zomuAPG_nyoOo95Q1sLhyjaN43Vi1mxTuzhE+waRopdQig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alistair Israel <aisrael@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Alistair,
     I think you just import my code from ceph-dokan and don't know
where is the most difficulties in merging upstream ceph.
     File structure is not problem, the difficulties is the code in
include/common/msg/osd/mon/mds is very different from upstream.
     If I try to merge ceph-dokan into upstream, the merge work will
affect the upstream developing a lot.

     So now I just update the ceph-dokan with upstream ceph, and add
most of the client-side code in ceph-dokan. With this work, I will
also try to refactor the code modifed for mingw and make it more
similar to upstream.
     Also mingw is on developing, in the latest relase ceph-dokan can
reduce many ugly mod for mingw. So we can wait for mingw to be more
stable for a while.
     And after these work, it will be the timing for merging into upstream.

Ketor


On Tue, Mar 24, 2015 at 8:14 PM, Alistair Israel <aisrael@gmail.com> wrote:
> On Fri, Mar 20, 2015 at 10:45 AM, Ketor D <d.ketor@gmail.com> wrote:
>
>> And also Alistair, would you like to help port your librados code
>> to ceph-dokan project with a clean pull request?
>
> Hi, Ketor!
>
> At this point we figured it'd easier in both the short term (and
> better long-term) to just start merging changes into "/ceph/src" (as a
> submodule, of a fork of ceph/ceph) rather than maintaining a copy of
> the files under "/src".
>
> One of the difficulties we had with making changes with ceph-dokan was
> how different the file structure alone was from upstream ceph. I
> actually have a fork of ceph-dokan that mirrors the directory
> structure of rados_dll and ceph/ceph, I can issue a PR for that (it
> allows for clean merge).
>
> From there, we can continue collaborating on both projects separately
> for now, until we have enough overlap and commonality that it makes
> sense to merge the two.
>
> What do you think?
>
> Alistair
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
