Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E19C433E0
	for <ceph-devel@archiver.kernel.org>; Thu,  4 Feb 2021 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB18064F41
	for <ceph-devel@archiver.kernel.org>; Thu,  4 Feb 2021 07:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhBDHo1 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 4 Feb 2021 02:44:27 -0500
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:46230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232941AbhBDHoY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2021 02:44:24 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2021 02:44:24 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 098F41801495E
        for <ceph-devel@vger.kernel.org>; Thu,  4 Feb 2021 07:34:57 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 98740180A7FC7;
        Thu,  4 Feb 2021 07:34:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: game57_2706cde275da
X-Filterd-Recvd-Size: 1955
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Feb 2021 07:34:06 +0000 (UTC)
Message-ID: <599ba2c6cebb8d8079d6af61d5987b958b2732f8.camel@perches.com>
Subject: Re: [PATCH] ceph: minor coding style tweaks
From:   Joe Perches <joe@perches.com>
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>, jlayton@kernel.org,
        idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Feb 2021 23:34:05 -0800
In-Reply-To: <1612420334-1112-1-git-send-email-daizhiyuan@phytium.com.cn>
References: <1612420334-1112-1-git-send-email-daizhiyuan@phytium.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Thu, 2021-02-04 at 14:32 +0800, Zhiyuan Dai wrote:
> Fixed some coding style issues, improve code reading.

Might describe the patch does 3 things:

o Move the pointer location
	struct foo* bar; -> struct foo *bar;
o Move brace position
  from
	struct foo
	{
  to
	struct foo {
o Alignment to open parenthesis

And one more comment:

> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
[]
> @@ -309,8 +309,8 @@ static int ceph_fill_dirfrag(struct inode *inode,
>  
>  static int frag_tree_split_cmp(const void *l, const void *r)
>  {
> -	struct ceph_frag_tree_split *ls = (struct ceph_frag_tree_split*)l;
> -	struct ceph_frag_tree_split *rs = (struct ceph_frag_tree_split*)r;
> +	struct ceph_frag_tree_split *ls = (struct ceph_frag_tree_split *)l;
> +	struct ceph_frag_tree_split *rs = (struct ceph_frag_tree_split *)r;

It's unnecessary to cast void pointers and it's bad form to lose
the const qualifier.

	const struct ceph_frag_tree_split *ls = l;
	const struct ceph_frag_tree_split *rs = r;

>  	return ceph_frag_compare(le32_to_cpu(ls->frag),
>  				 le32_to_cpu(rs->frag));
>  }


