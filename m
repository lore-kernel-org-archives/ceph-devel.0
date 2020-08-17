Return-Path: <SRS0=0t9i=B3=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C4BC433E1
	for <ceph-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B5D2075B
	for <ceph-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgHQOPO (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:15:14 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:39432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbgHQOPM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:15:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B25F118026136;
        Mon, 17 Aug 2020 14:15:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: able03_0f15ed127017
X-Filterd-Recvd-Size: 1732
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 14:15:09 +0000 (UTC)
Message-ID: <0e130d4398b3e4a7e826a16b6726f0f0bce74900.camel@perches.com>
Subject: Re: [PATCH V2 6/6] ceph_debug: Remove now unused dout macro
 definitions
From:   Joe Perches <joe@perches.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Aug 2020 07:15:08 -0700
In-Reply-To: <CAOi1vP8rL6R8LqFnz10O=N4gfC2zYiZdfZbg3NkcePRvOKu7xA@mail.gmail.com>
References: <cover.1597626802.git.joe@perches.com>
         <fe4e9e2a544af4d00aa5c97d9288d9b4d67db1ed.1597626802.git.joe@perches.com>
         <CAOi1vP8rL6R8LqFnz10O=N4gfC2zYiZdfZbg3NkcePRvOKu7xA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2020-08-17 at 11:24 +0200, Ilya Dryomov wrote:
> On Mon, Aug 17, 2020 at 3:34 AM Joe Perches <joe@perches.com> wrote:
> > All the uses have be converted to pr_debug, so remove these.
[]
> Hi Joe,

Hi Ilya.

> Yeah, roughly the same thing can be achieved with +flmp instead
> of just +p with PRETTYDEBUG, but PRETTYDEBUG formatting actually
> predates those flags and some of us still use bash scripts from
> back then.  We also have a few guides and blog entries with just
> +p, but that's not a big deal.

btw: I sent a patch adding a +F flag to emit
the kbasename(FILE) to dynamic debug output.

https://lore.kernel.org/lkml/3e4a895e7c25e37c0f4727b960b7abdcf0752cbb.camel@perches.com/



