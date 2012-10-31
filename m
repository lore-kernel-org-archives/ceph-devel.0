From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD sizes
Date: Thu, 1 Nov 2012 00:04:10 +0100
Message-ID: <CAOLwVUkwEe3q_C2=6aN_PfhojHzYWqPcvRDcJ9hZ5pSgTSAQDA@mail.gmail.com>
References: <CAJH6TXhoJ9hGokHW3TCo9e1aob=X-=K6d7sdtmgR37xcLNuXXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59181 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759362Ab2JaXEc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 19:04:32 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1481448lbo.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 16:04:31 -0700 (PDT)
In-Reply-To: <CAJH6TXhoJ9hGokHW3TCo9e1aob=X-=K6d7sdtmgR37xcLNuXXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

As far I'm concerned I think that 12 disks per servers is way too much.
--
Bien cordialement.
S=E9bastien HAN.


On Wed, Oct 31, 2012 at 11:13 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> I'll run a testbed environment made with 3 or 5 DELL R515 servers (12
> disks each).
> I have no 10gb ethernet but only multiple LACP (2 or 4 gigabit nic)
> I'll have two different networks, one for sync, one for client access=
=2E
>
> In this case, i think that smaller disks are better, because in case
> of failure of a single osd/disk the sync time will be less than a
> bigger disk.
>
> For example 12 500GB disks instead 12 3TB disks (the space is not an
> issue, actually)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
