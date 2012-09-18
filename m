From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: enabling cephx by default
Date: Tue, 18 Sep 2012 17:34:34 +0400
Message-ID: <CABYiri-FQfFR9rsJs4o_gbr0N7LWa4_SVGJo_4e5dLuGAXehhA@mail.gmail.com>
References: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net> <2205765.G9jEemHyT3@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33752 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab2IRNe6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 09:34:58 -0400
Received: by wgbdr13 with SMTP id dr13so6850362wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 06:34:54 -0700 (PDT)
In-Reply-To: <2205765.G9jEemHyT3@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 18, 2012 at 4:37 PM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Am Dienstag, 11. September 2012, 17:25:49 schrieben Sie:
>> The next stable release will have cephx authentication enabled by default.
>
> Hm, that could be a problem for me. I have tried multiple times to get cephx
> working in the past, without lasting success. (I cannot recall at the moment
> what the problem was the last time around, but it was probably qemu/libvirt.)

BTW, libvirt 0.10.x has a broken cephx support somehow. It forms same
string for -drive as 0.9x(at least in a log) but failing to pass
authentication same moment.

>
> IMHO, the documentation badly needs a high-level overview for cephx (or maybe
> I just haven't found it yet); what it does, what dangers it protects you from
> and how it achieves that.
>
>         Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
