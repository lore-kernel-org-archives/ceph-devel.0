From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: How are you using Ceph?
Date: Mon, 17 Sep 2012 17:18:55 -0700
Message-ID: <CANLRBox_=RgEq=wOS9S8B-WxUtKvST1biyQu_8+-vXcc5kSw-A@mail.gmail.com>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
	<5057BAD0.8080201@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42970 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab2IRAS4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 20:18:56 -0400
Received: by ieak13 with SMTP id k13so1391804iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 17:18:55 -0700 (PDT)
In-Reply-To: <5057BAD0.8080201@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
>
> Hi,
>
> i use ceph to provide storage via rbd for our virtualization cluster delivering
> KVM based high availability Virtual Machines to my customers. I also use it
> as rbd device with ocfs2 on top of it for a 4 node webserver cluster as shared
> storage - i do this, because unfortunatelly cephfs is not ready yet ;)
>
Hi Florian;

When you say "cephfs is not ready yet", what parts about it are not
ready? There are vague rumblings about that in general, but I'd love
to see specific issues. I understand multiple *active* mds's are not
supported, but what other issues are you aware of?

And if there's a page documenting this already, I apologize...and
would appreciate a link :)

t.
