From: Sage Weil <sage@newdream.net>
Subject: Re: Alibaba's work on recovery process
Date: Thu, 11 May 2017 17:44:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705111741450.18953@piezo.novalocal>
References: <a67e2852-8c58-aca2-cf08-f8315d00e470@corp.ovh.com> <017717D3-EE64-4BCB-A284-D066C32C8181@alibaba-inc.com> <CAE7zfpM33_7iBnoxOTq16TFh5MXmEE=xWJoTunV5=CSh24Kb+Q@mail.gmail.com> <F28FEF91-F57A-48FB-B673-817758BCAF58@alibaba-inc.com>
 <abe1e3d7-7659-f991-63d4-2dea5400e90a@corp.ovh.com> <3CF80935-8AC5-41B1-BC56-7DFB0F590172@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37514 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbdEKRoq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 13:44:46 -0400
In-Reply-To: <3CF80935-8AC5-41B1-BC56-7DFB0F590172@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ming Lin <ming.lin@alibaba-inc.com>, =?ISO-2022-JP?Q?=1B$B=3Dy1d9=3E=1B=28J?= <yanjiang.xyj@alibaba-inc.com>, Mark Nelson <mnelson@redhat.com>

On Fri, 12 May 2017, LIU, Fei wrote:
> Hi Piotr,
>    Here you go. We just uploaded the slide into slideshare for your reference. Please feel free to let us know if you have any comments.
> 
>    https://www.slideshare.net/jupiturliu/ceph-recovery-improvement-v02
> 
>    Regards,
>    James

Hi James-

This work is very promising!  Putting the write info in the log is 
probably one of the easier pieces to tackle (and Josh is already looking a 
variation of the async recovery).  If you have the time I'd love to 
resurrect that PR and get it into a mergeable state.  Is there an open PR 
with the current code?

sage
