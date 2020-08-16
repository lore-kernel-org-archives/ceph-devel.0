Return-Path: <SRS0=GXXA=B2=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCFCC433DF
	for <ceph-devel@archiver.kernel.org>; Sun, 16 Aug 2020 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D7320704
	for <ceph-devel@archiver.kernel.org>; Sun, 16 Aug 2020 23:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHPXpR (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:45:17 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:47348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725967AbgHPXpR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 16 Aug 2020 19:45:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 271DA1801BE2F;
        Sun, 16 Aug 2020 23:45:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dress37_0516df027012
X-Filterd-Recvd-Size: 1419
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Aug 2020 23:45:14 +0000 (UTC)
Message-ID: <b1c625528af035cc74a8f17b903e17e5f15f4a23.camel@perches.com>
Subject: Re: [PATCH 1/2] ceph: Use generic debugging facility
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     kbuild-all@lists.01.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Aug 2020 16:45:13 -0700
In-Reply-To: <202008170710.BoRBUoeo%lkp@intel.com>
References: <d67377660a317c826a7899e6ffcb5bf686733ddb.1597615399.git.joe@perches.com>
         <202008170710.BoRBUoeo%lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2020-08-17 at 07:03 +0800, kernel test robot wrote:
> I love your patch! Yet something to improve:
[]
> All errors (new ones prefixed by >>):
> 
>    net/ceph/ceph_common.c: In function 'parse_fsid':
> > > net/ceph/ceph_common.c:227:2: error: implicit declaration of function 'dout'; did you mean 'dput'? [-Werror=implicit-function-declaration]
>      227 |  dout("parse_fsid '%s'\n", str);
>          |  ^~~~
>          |  dput

Right, thanks, I didn't update net/.


