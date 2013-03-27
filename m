From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Split Swift code with S3 code in Radosgw
Date: Wed, 27 Mar 2013 10:44:51 -0700
Message-ID: <CAC-hyiGzfULUrCmY4L9hf8G1giw8pES4RehCONyBTT03yLYGgA@mail.gmail.com>
References: <tencent_3C5B3A0711EDF0AE28AE2231@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38110 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab3C0Row (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 13:44:52 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so9273159ieb.28
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 10:44:52 -0700 (PDT)
In-Reply-To: <tencent_3C5B3A0711EDF0AE28AE2231@qq.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <wangli@kylinos.com.cn>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, sage <sage@inktank.com>

On Wed, Mar 27, 2013 at 8:19 AM, Li Wang <wangli@kylinos.com.cn> wrote:
> Hi there,
>     We are providing Openstack based cloud solution to customers. We have read the technical papers on Ceph, and our colleague
> also consulted the comparision between Ceph and Swift from the ceph-user mailing list. Given the advantages of Ceph over
> Swift, such as scalability, performance and the all-in-one design, we wanna replace swift with ceph in our openstack
> solution. However, since the client applications are developed based on Swift API, as far as we know, currently only a subset of
> Swift API is implemented by Ceph. And furthermore, it seems to us that the S3 compatability owns a higher priority or done
> earlier in Ceph, the Swift compatibility code is fixed with S3 code, and kind of, yield to the S3 compatibility framework
> and S3 semantics, which hamper us to add some Swift specific features into Radosgw. And with the developing of Swift as
> well as S3, we think the current framework will suffer from the code elegance and larger API divergence.  We do wanna use
> Ceph and also wanna make technical contributions to it. We are considering to revise the current framework to split the
> Swift code with the S3 code, to allow a more friendly support to Swift API and make it easier to add Swift specific
> features, such as custom metadata, expiring object, negative acl rule, so what is the Ceph community's response?

The gateway code is layered in such a way that the Swift and S3 code
both use a common infrastructure, but diverge where needed. There's a
separation between the functional layer, and the presentation layer.
Indeed S3 was where we started, so there were some choices that moved
the development a bit towards it, however, we don't consider Swift a
second grade citizen.
None of the features that you specified really require separate
frameworks. Most of the implementation work required will be done in
the functional layer, and the Swift/S3 layer will just provide the
interface. We already support custom metadata. Expiring object will
also be used in S3. Negative acl rule can be implemented with or
without needing the S3 layer to be bothered about it.
We'd be more than happy to see more community contribution. If you
bump into technical issues that you think are unsolvable within the
current framework, we can always take a second look at it, figuring
out what needs to be changed.

Thanks,
Yehuda

@ http://inktank.com | http://ceph.com
