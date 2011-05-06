From: Sage Weil <sage@newdream.net>
Subject: Re: rbd and Metaserver
Date: Thu, 5 May 2011 20:54:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105052054060.14021@cobra.newdream.net>
References: <4DC2DB6E.9010500@ufm.su> <2000619B57A3492DBDFCA82B0843792D@gmail.com>
 <BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50549 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1EFDxw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 23:53:52 -0400
In-Reply-To: <BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Fri, 6 May 2011, tsk wrote:
> 2011/5/6 Gregory Farnum <gregory.farnum@dreamhost.com>:
> > Nope, the MDS is only required for the POSIX-compliant Ceph layer.
> > -Greg
> 
> May I know that who will maintain the rbd_image_info if there is no MDS?
> From where, the api int rbd_list(rados_ioctx_t io, char *names, size_t
> *size)  will get the data it want?

The rbd image header is stored as just another object in the object store.

sage
