From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: class exec test
Date: Sun, 10 Jun 2012 23:50:33 -0700
Message-ID: <4FD59539.6000902@inktank.com>
References: <Pine.LNX.4.64.1206102200490.3347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56640 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab2FKGud (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 02:50:33 -0400
Received: by obbtb18 with SMTP id tb18so6328465obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 10 Jun 2012 23:50:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206102200490.3347@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/10/2012 10:03 PM, Sage Weil wrote:
> Hey-
>
> The librados api tests were calling a dummy "test_exec" method in cls_rbd
> that apparently got removed.  We probably want to replace the test with
> *something*, though...  maybe a "version" or similar command that just
> returns the version of the class?  Or an OSD built-in dummy class with
> no-op methods?

I replaced this with a get_all_features method in the wip-rados-test
branch. With this, the rbd tool can report the features that can be used
to create a new image.

Josh
