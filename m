From: Alistair Israel <aisrael@gmail.com>
Subject: Re: rados_dll: A Windows port of librados
Date: Tue, 24 Mar 2015 20:14:30 +0800
Message-ID: <CAHJ4zomuAPG_nyoOo95Q1sLhyjaN43Vi1mxTuzhE+waRopdQig@mail.gmail.com>
References: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
 <alpine.DEB.2.00.1503190822150.9418@cobra.newdream.net> <CAM9_UU_O=ntf+pZodFwMo1qS7R7Y4S1eNFiXx-x5G2TpOEGf2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33901 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbCXMPB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 08:15:01 -0400
Received: by obbgg8 with SMTP id gg8so145485474obb.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2015 05:15:00 -0700 (PDT)
In-Reply-To: <CAM9_UU_O=ntf+pZodFwMo1qS7R7Y4S1eNFiXx-x5G2TpOEGf2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 20, 2015 at 10:45 AM, Ketor D <d.ketor@gmail.com> wrote:

> And also Alistair, would you like to help port your librados code
> to ceph-dokan project with a clean pull request?

Hi, Ketor!

At this point we figured it'd easier in both the short term (and
better long-term) to just start merging changes into "/ceph/src" (as a
submodule, of a fork of ceph/ceph) rather than maintaining a copy of
the files under "/src".

One of the difficulties we had with making changes with ceph-dokan was
how different the file structure alone was from upstream ceph. I
actually have a fork of ceph-dokan that mirrors the directory
structure of rados_dll and ceph/ceph, I can issue a PR for that (it
allows for clean merge).

From there, we can continue collaborating on both projects separately
for now, until we have enough overlap and commonality that it makes
sense to merge the two.

What do you think?

Alistair
