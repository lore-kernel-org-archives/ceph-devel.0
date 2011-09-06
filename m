From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: the messenger to send osd write ack|ondisk
Date: Tue, 6 Sep 2011 09:37:24 -0700
Message-ID: <CAORUGqAUTKnR4B9jpXx-RnMMj_ZOj8gwq3CAv2S-T7ih8yhP4A@mail.gmail.com>
References: <CABAwU-aCazA1vtpokbntNd054mL12gp5Cc3+eJ9C_6UkNp_Now@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63114 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1IFQhp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2011 12:37:45 -0400
Received: by wyh22 with SMTP id 22so4579970wyh.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Sep 2011 09:37:44 -0700 (PDT)
In-Reply-To: <CABAwU-aCazA1vtpokbntNd054mL12gp5Cc3+eJ9C_6UkNp_Now@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 2, 2011 at 19:28, huang jun <hjwsm1989@gmail.com> wrote:
> hi,all
> i'm confused by the question:
> ceph use client_messenger to send MOSDOpReply:ondisk
> but use cluster_messenger to send MOSDOpReply:ack
> are they have any difference?

client_messenger talks to RADOS clients, cluster_messenger talks to other OSDs.
