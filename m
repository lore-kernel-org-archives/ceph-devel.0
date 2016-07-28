From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: where to get the cls log?
Date: Thu, 28 Jul 2016 07:51:08 -0400
Message-ID: <CA+aFP1Bc5fY4af=Xx=Ssqn11RcoYUFV9LGOj9y8OukEOv75BvA@mail.gmail.com>
References: <CAEv+sP5rNHAa=fQjb+-Tc=JZ-pk8CeufrV5ki--9HXxNE08zag@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33106 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748AbcG1LvK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2016 07:51:10 -0400
Received: by mail-pf0-f180.google.com with SMTP id y134so21512854pfg.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2016 04:51:10 -0700 (PDT)
In-Reply-To: <CAEv+sP5rNHAa=fQjb+-Tc=JZ-pk8CeufrV5ki--9HXxNE08zag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tianshan Qu <qutianshan@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

CLS_LOG uses the "objclass" subsystem, so debug logging is configured
via "debug_objclass".

On Thu, Jul 28, 2016 at 7:17 AM, Tianshan Qu <qutianshan@gmail.com> wrote:
> Hi,
>
> where can I find the CLS_LOG content, and how to config the level, it
> seems no debug_cls option.
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
