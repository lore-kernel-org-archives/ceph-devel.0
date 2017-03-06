From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: problems to protect rbd from mutiple simultaneous mapping
Date: Mon, 6 Mar 2017 18:47:04 -0500
Message-ID: <CA+aFP1AO1DkYEVSfzHLk=dHSn8cSPE1c3+aWNAzQwwmsOuBsvA@mail.gmail.com>
References: <58BD6D73.6040200@xtaotech.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34184 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdCGANA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 19:13:00 -0500
Received: by mail-lf0-f47.google.com with SMTP id k202so79922443lfe.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 16:12:26 -0800 (PST)
In-Reply-To: <58BD6D73.6040200@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "peng.hse" <peng.hse@xtaotech.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 6, 2017 at 9:08 AM, peng.hse <peng.hse@xtaotech.com> wrote:
> 3. assuming the step-1 outstanding IO and step-2 IO targeted the same area
> of the fs metadata
>     on the rbd devices. step-2 successfully persist the data and reply to
> client.
>     then, the following laggy IO from step-1 might override and corrupt what
> we have written in step-2.
>
> so, how do we prevent this kind of corruption happening?

... but in step (2) you successfully blacklisted the client on node1
(i.e. it is not allowed to talk to the OSDs). Therefore, node1 cannot
overwrite any data written by node2.

-- 
Jason
