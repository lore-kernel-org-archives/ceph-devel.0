From: Damien Churchill <damoxc@gmail.com>
Subject: Re: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 13:11:42 +0100
Message-ID: <CAFtEh-e4Umj9LGZk-YNXMjbkfWQkHcqdy-mJqyP7gDr6m1xdbA@mail.gmail.com>
References: <51920F00.406@42on.com>
	<20130514103453.GD14890@apia.perrit.net>
	<5192257C.5000104@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:48421 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3ENMLn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 08:11:43 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so459492pab.24
        for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 05:11:42 -0700 (PDT)
In-Reply-To: <5192257C.5000104@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: leen@consolejunkie.net, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 14 May 2013 12:52, Wido den Hollander <wido@42on.com> wrote:
>
> No, qemu-img can't write to stdout. Due to various formats it supports.
>

You could probably use qemu-nbd to mount the image as a nbd device and
then read from that using all the standard gear. Although I've never
actually used qemu-nbd myself...
