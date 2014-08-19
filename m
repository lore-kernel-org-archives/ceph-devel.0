From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD suicide after being down/in for one day as it needs to search
 large amount of objects
Date: Tue, 19 Aug 2014 15:09:25 -0700
Message-ID: <CAPYLRzh5eNVqPVWGgDKSOsQ6MaDVgxnki=1dzf9Nnw5UOO6HXw@mail.gmail.com>
References: <BLU436-SMTP1407B6BAC746323A36B7947DFD50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39758 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbaHSWJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 18:09:26 -0400
Received: by mail-vc0-f181.google.com with SMTP id lf12so8081225vcb.26
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 15:09:25 -0700 (PDT)
In-Reply-To: <BLU436-SMTP1407B6BAC746323A36B7947DFD50@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>, david.z1003@yahoo.com

On Mon, Aug 18, 2014 at 11:30 PM, Guang Yang <yguang11@outlook.com> wro=
te:
> Hi ceph-devel,
> David (cc=E2=80=99ed) reported a bug (http://tracker.ceph.com/issues/=
9128) which we came across in our test cluster during our failure testi=
ng, basically the way to reproduce it was to leave one OSD daemon down =
and in for a day, at the same time, keep giving write traffic. When the=
 OSD daemon was started again, it hit suicide timeout and kill itself.
>
> After some analysis (details in the bug), David found that the op thr=
ead was busy searching for missing objects and once the volume to searc=
h increase, the thread is expected to work that long time, please refer=
 to the bug for detailed logs.

Can you talk a little more about what's going on here? At a quick
naive glance, I'm not seeing why leaving an OSD down and in should
require work based on the amount of write traffic. Perhaps if the rest
of the cluster was changing mappings...?

>
> One simple fix is to let the op thread reset the suicide timeout peri=
odically when it is doing long-time work, other fix might be to cut the=
 work into smaller pieces?

We do both of those things throughout the OSD (although I think the
first is simpler and more common); search for the accesses to
cct->get_heartbeat_map()->reset_timeout.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
