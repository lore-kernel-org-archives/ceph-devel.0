From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ceph: attempt to do async create when possible
Date: Wed, 8 Apr 2020 14:22:02 +0300
Message-ID: <20200408112201.GN2066@kadam>
References: <20200408111734.GA252918@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:49414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgDHLWL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2020 07:22:11 -0400
Content-Disposition: inline
In-Reply-To: <20200408111734.GA252918@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:17:34PM +0300, Dan Carpenter wrote:
> Hello Jeff Layton,
> 
> The patch 9a8d03ca2e2c: "ceph: attempt to do async create when
> possible" from Nov 27, 2019, leads to the following static checker
> warning:
> 
> 	fs/ceph/file.c:540 ceph_async_create_cb()
> 	error: uninitialized symbol 'base'.

Sorry, see the unlink function as well.

    fs/ceph/dir.c:1072 ceph_async_unlink_cb()
    error: uninitialized symbol 'pathlen'.

regards,
dan carpenter
