From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: still recovery issues with cuttlefish
Date: Sat, 10 Aug 2013 21:08:38 +0200
Message-ID: <52068FB6.1080209@profihost.ag>
References: <51FA1AC1.8040207@profihost.ag> <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com> <51FAAED3.3010509@cloudapt.com> <51FAB20F.3030707@profihost.ag> <CA+4uBUY079TZ7sm1EafO1pnXCpKSTkfc15KwqBLi8SyV=Z_29A@mail.gmail.com> <51FB636B.5050301@profihost.ag> <CA+4uBUbye9EOHxFgOYXah8Eg_6ZRtPY_MpgjbnNa=_ZrhFak_w@mail.gmail.com> <51FBF765.9030700@profihost.ag> <CA+4uBUZY-_jsnG+wfE4LXL-Dw2CtRkNuANwPMMJ4JyUU=4tdRQ@mail.gmail.com> <51FBFE85.5040700@profihost.ag> <5203A597.4060701@cloudapt.com> <5203DFAE.9070100@profihost.ag> <CA+4uBUYgLmP0EMv1+Gzd9ndR42o9ahTL6bnoAAD8QS+Cax7Yzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:37580 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab3HJTIh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Aug 2013 15:08:37 -0400
In-Reply-To: <CA+4uBUYgLmP0EMv1+Gzd9ndR42o9ahTL6bnoAAD8QS+Cax7Yzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi Samual,

Am 09.08.2013 23:44, schrieb Samuel Just:
> I think Stefan's problem is probably distinct from Mike's.
>
> Stefan: Can you reproduce the problem with
>
> debug osd = 20
> debug filestore = 20
> debug ms = 1
> debug optracker = 20
>
> on a few osds (including the restarted osd), and upload those osd logs
> along with the ceph.log from before killing the osd until after the
> cluster becomes clean again?

done - you'll find the logs at cephdrop folder: 
slow_requests_recovering_cuttlefish

osd.52 was the one recovering

Thanks!

Greets,
Stefan
