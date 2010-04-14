From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] qemu-kvm/rbd: small fixes and cosmetics
Date: Wed, 14 Apr 2010 14:12:23 -0700
Message-ID: <u2ma37615151004141412ke1a45789rdaf132265506c0f9@mail.gmail.com>
References: <20100414204907.GA976@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57921 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872Ab0DNVMX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Apr 2010 17:12:23 -0400
Received: by pwj9 with SMTP id 9so605648pwj.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Apr 2010 14:12:23 -0700 (PDT)
In-Reply-To: <20100414204907.GA976@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 14, 2010 at 1:49 PM, Christian Brunner <chb@muc.de> wrote:
>
> Attached is a patch with small fixes and cosmetics for the qemu-kvm/rbd
> driver:
>
> - conditional linking of librados
> - reduced header size
> - followed the variable names of the kernel driver
>
> Could you put it in the git repository, please?

Pushed, thanks!
Yehuda
