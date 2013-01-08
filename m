From: Gregory Farnum <greg@inktank.com>
Subject: Re: Rados gateway init timeout with cache
Date: Tue, 8 Jan 2013 09:02:50 -0800
Message-ID: <CAPYLRzhwWYA2_DZYgtRhKKEvATNY_4ATY1KwrV-LERocxAwjhQ@mail.gmail.com>
References: <367CC0B0FC02EE47BF7482398BD623C54E0E3624@DB3PRD0311MB416.eurprd03.prod.outlook.com>
	<367CC0B0FC02EE47BF7482398BD623C54E0E3701@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33186 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab3AHRCv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 12:02:51 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so859042qca.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 09:02:50 -0800 (PST)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C54E0E3701@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

To clarify, you lost the data on half of your OSDs? And it sounds like
they weren't in separate CRUSH failure domains?

Given that, yep, you've lost some data. :(

On Tue, Jan 8, 2013 at 5:41 AM, Yann ROBIN <yann.robin@youscribe.com> wrote:
> Notify and gc objects where unfound, we marked them as lost and now the rados start.
> But this means that if some notify object are not fully available, the radosgateway stop responding.

Yes, that's the case. I'm not sure there's a way around it that makes
much sense and satisfies the necessary guarantees, though.
-Greg

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yann ROBIN
> Sent: mardi 8 janvier 2013 12:13
> To: ceph-devel@vger.kernel.org
> Subject: Rados gateway init timeout with cache
>
> Hi,
>
> We recently experienced issue with the backplane of our server, resulting in loosing half of our osd.
> During that period the rados gateway failed initializing (timeout).
> We found that the gateway was hanging in the init_watch function.
>
> We recreate our OSDs and we still have this issue, but pg are not all in an active+clean state :
>    health HEALTH_WARN 1 pgs degraded; 1 pgs recovering; 2 pgs recovery_wait; 3 pgs stuck unclean; recovery 7/10140464 degraded (0.000%); 3/5070232 unfound (0.000%); noout flag(s) set
>    monmap e2: 3 mons at {ceph-mon-1=172.20.1.13:6789/0,ceph-mon-2=172.20.2.13:6789/0,ceph-mon-3=172.17.9.20:6789/0}, election epoch 256, quorum 0,1,2 ceph-mon-1,ceph-mon-2,ceph-mon-3
>    osdmap e4439: 6 osds: 6 up, 6 in
>     pgmap v2531184: 11024 pgs: 11019 active+clean, 2 active+recovery_wait, 1 active+recovering+degraded+remapped, 2 active+clean+scrubbing+deep; 1291 GB data, 2612 GB used, 19645 GB / 22257 GB avail; 7/10140464 degraded (0.000%); 3/5070232 unfound (0.000%)
>    mdsmap e1: 0/0/1 up
>
> Should we open an ticket for this init issue with rados gateway ?
> Version is 0.56.1 upgraded from 0.55.
>
> --
> Yann ROBIN
> YouScribe
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
