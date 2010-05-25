From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 3/5] ceph: remove duplicated #include
Date: Tue, 25 May 2010 09:29:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005250928570.8523@cobra.newdream.net>
References: <1274796465-3812-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58234 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab0EYQZc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 12:25:32 -0400
In-Reply-To: <1274796465-3812-1-git-send-email-weiyi.huang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 25 May 2010, Huang Weiyi wrote:
> Remove duplicated #include('s) in
>   fs/ceph/auth.c
>   fs/ceph/super.h
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Queued this up, thanks!

sage
