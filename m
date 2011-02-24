From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: C++ api for librados 0.25
Date: Thu, 24 Feb 2011 10:02:48 -0800
Message-ID: <4D669D48.6060202@dreamhost.com>
References: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41139 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab1BXSCu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 13:02:50 -0500
In-Reply-To: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

On 02/23/2011 11:11 PM, Colin McCabe wrote:
> Here is the proposed C++ API for librados 0.25.
> The main changes are that I created class Pool, class Snap, and the
> ObjectIterator interface.

I like the idea of a more OO interface. This will allow easily
stacking librbd on top of librados, eliminating the need for a
separate librbd pool type.

I have a couple suggestions:

- The pool_t parameters in the self-managed snap methods can be
  removed, since they're part of the Pool class.

- The aio_read/write functions can be members of Pool instead of
  having a pool_t parameter.

- aio_create_completion could be moved into Pool since it's only
  used within the context of a pool. (librbd would need this unless
  Pool had a get_rados method).

Also, what is the constructor Pool(Rados *rados_, pool_t *pool_)
intended to be used for? I don't see a method to get a pool_t from
this API.

-Josh Durgin
