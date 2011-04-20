From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: libceph API
Date: Wed, 20 Apr 2011 13:40:54 -0700
Message-ID: <FE10800E188B4D6095B24D631793F3FF@gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54548 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1DTUk6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2011 16:40:58 -0400
Received: by pvg12 with SMTP id 12so558006pvg.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2011 13:40:58 -0700 (PDT)
In-Reply-To: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org, Brian Chrisman <brchrisman@gmail.com>

On Wednesday, April 20, 2011 at 12:02 PM, Colin McCabe wrote:
Hi guys,
> 
> I pushed a branch with a revised libceph API. The main changes:
> 
> * similar appearance to librados. It should be intuitive if you've
> used librados.
> * The new API allows multiple ceph clusters to be open at once
> (although the implementation doesn't support this yet)
> * ability to pass a "root" argument to ceph_mount
> * add support for reading configuration files and choosing whether to parse argv
> * simpler ceph_getcwd
> * unmount can't fail (the library always cleans up after itself)
> 
> The branch is at
> http://ceph.newdream.net/git/?p=ceph.git;a=shortlog;h=refs/heads/libceph_api
> 
> Let me know what you think!

I didn't go over this with a fine-tooth comb but it looks good at a skim. We need to update client/hadoop/CephFSInterface and client/hypertable/CephBroker to match before we merge this, though (or else decide not to, but that's not something we should decide via inertia!).
-Greg



